class SubtotalIntegration

  SERVER = 'https://app.subtotal.ru'
  LOGIN = 'kereal@gmail.com'
  PASSWORD = '12345'
  CLIENT_ID = 'id11542'
  # require File.join(Rails.root, "lib", "subtotal", "subtotal_integration.rb")
  # Rails.application.secrets.some_api_key  # secrets.yml
  # response = RestClient.get('https://app.subtotal.ru/id11542/webapi/goods', { good_type_id: 2 })

  def auth
    response = RestClient.post(URI.join(SERVER, 'webapi/', 'login').to_s, { login: LOGIN, password: PASSWORD }.to_json, { content_type: 'application/json; charset=utf-8' })
    if response.code == 200
      @cookies = response.cookies
      puts "Auth successful"
    end
  end

  def goods
    get_response_data URI.join(SERVER, CLIENT_ID+'/', 'webapi/', 'goods').to_s, { good_type_id: 2 }
  end

  def good(good_id)
    get_response_data(URI.join(SERVER, CLIENT_ID+'/', 'webapi/', 'goods/', good_id.to_i.to_s).to_s)
  end

  def import_goods
    goods.try(:[], "goods").each do |product|
      p product.try(:[], "name") || product
      product_data = good(product.try(:[], "id"))
      if product_data.try(:[], "good")
        # discount = product_data["good"]["discounts"].try(:[], 0)["discounts"][0]["value"]
        # description = product_data["good"]["description"]
        # properties = product_data["good"]["properties"].map{ |p| {p.try(:[], "name") => p.try(:[], "values").try(:[], 0).try(:[], "value")} if p.try(:[], "name") }
        # category_title = properties.find{|h| h.keys[0]=="Категория товара"}.try(:[], "values").try(:[], 0)
        # properties.delete_if{|h| h.keys[0]=="Категория товара"}
        brand = Brand.select(:id).find_by_title product_data["good"]["tags"].try(:[], 0)
        category = Category.select(:id).find_by_provider_title category_title
      end
      if false
        Product.create
          title: product.try(:[], "name"),
          price: product.try(:[], "price2"),
          country: product.try(:[], "country"),
          provider_images: product.try(:[], "images").to_json,
          provider_product_id: product.try(:[], "id"),
          provider_updated_at: product.try(:[], "ch_date"),
          category_id: "",
          brand: brand,
          size: "",
          old_price: 0,

      end
      # 2add: country, provider_updated_at(ch_date), provider_images
      # DateTime.parse(product.try(:[], "ch_date"))
    end
    return
  end


  private

    # wrapper
    def get_response_data(url, payload = {})
      auth if @cookies.nil?
      begin
        response = RestClient.get(url, { cookies: @cookies, content_type: 'application/json; charset=utf-8' }.merge(payload))
      rescue RestClient::ExceptionWithResponse => error
        return error.response
      else
        return JSON.parse response.body
      end
    end

end