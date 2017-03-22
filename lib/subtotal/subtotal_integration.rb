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

  def get_goods(page_size = 100, page_num = 1)
    get_response_data URI.join(SERVER, CLIENT_ID+'/', 'webapi/', 'goods').to_s, { good_type_id: 2, page_size: page_size, page_num: page_num }
  end

  def get_good(good_id)
    get_response_data(URI.join(SERVER, CLIENT_ID+'/', 'webapi/', 'goods/', good_id.to_i.to_s).to_s)
  end

  def import_all_goods
    created = 0
    page_size = 100
    goods_batch = get_goods(page_size)
    len = goods_batch.try(:[], "length")
    if len
      batch_count = (len.to_f / page_size).ceil
      created += import_goods(goods_batch)
      (2..batch_count).each do |page_number|
        created += import_goods get_goods(page_size, page_number)
      end
    end
    puts "Created: #{created}"
  end

  def import_goods(goods_batch)
    created = 0
    goods_batch.try(:[], "goods").each do |product|
      provider_product_id = product.try(:[], "id")
      provider_updated_at = DateTime.parse(product.try(:[], "ch_date"))
      # поищем этот товар у нас у базе
      db_product = Product.find_by_provider_product_id(provider_product_id)
      # если товар есть и дата его обновления меньше, то удаляем и создаем заново, иначе оставляем и пропускаем этот товар
      if db_product.provider_updated_at < provider_updated_at then db_product.destroy else next end if db_product
      # получаем полную информацию о продукте
      product_data = get_good(provider_product_id)
      if product_data.try(:[], "good")
        discount = product_data["good"]["discounts"].try(:[], 0)["discounts"][0]["value"]
        description = product_data["good"]["description"].blank? ? nil : product_data["good"]["description"]
        # ищем или создаем бренд
        brand = Brand.select(:id).where("title LIKE ?", product_data["good"]["tags"].try(:[], 0)).take || Brand.new(title: product_data["good"]["tags"].try(:[], 0))
        properties = product_data["good"]["properties"].map{ |p| {p.try(:[], "name") => p.try(:[], "values").try(:[], 0).try(:[], "value")} if p.try(:[], "name") }
        # ищем категорию среди свойств
        category_title = properties.find{|h| h.keys[0]=="Категория товара"}.try(:values).try(:[], 0)
        category = category_title.blank? ? nil : Category.select(:id).find_by_provider_title(category_title)
        properties.delete_if{|h| h.keys[0]=="Категория товара"}
        # ищем пол среди свойств
        gender_title = properties.find{|h| h.keys[0]=="Пол"}.try(:values).try(:[], 0)
        gender = if gender_title == "жен" then :female elsif gender_title == "муж" then :male else nil end
        properties.delete_if{|h| h.keys[0]=="Пол"}
      end
      if Product.create(
        title: product.try(:[], "name"),
        description: description,
        price: product.try(:[], "price2"),
        discount: discount,
        category: category,
        brand: brand,
        gender: gender,
        country: product.try(:[], "country"),
        provider_images: product.try(:[], "images").blank? ? nil : product["images"].to_json,
        provider_product_id: provider_product_id,
        provider_updated_at: provider_updated_at,
        properties: properties.to_json
        ) then created += 1 end;
    end
    return created
  end


  private

    # wrapper
    def get_response_data(url, params = {})
      auth if @cookies.nil?
      begin
        response = RestClient.get(url, { cookies: @cookies, content_type: 'application/json; charset=utf-8' }.merge(params: params))
      rescue RestClient::ExceptionWithResponse => error
        return error.response
      else
        return JSON.parse response.body
      end
    end

end