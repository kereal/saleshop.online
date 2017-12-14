namespace :app do


  desc "Import all goods from subtotal"
  task :import_all_goods => :environment do

    require File.join(Rails.root, "lib", "subtotal", "subtotal_integration.rb")
    SubtotalIntegration.new.import_all_goods

  end


  desc "Export all goods to csv"
  task :export_all_goods => :environment do

    attributes = %w{Название Артикул Производство Сезон Состав Цвет Уход Размер Бренд
      Цена Описание Название_раздела_уровень_1 Название_раздела_уровень_2 Картинки}

    CSV.open(File.join(Rails.root, '/public/product_export.csv'), "wb") do |csv|
      csv << attributes
      Product.find_each do |product|
        props = JSON.parse(product.properties)
        production = props.find{ |p| p['Производство'] }.try(:[], 'Производство')
        sostav = props.find{ |p| p['Состав'] }.try(:[], 'Состав')
        uhod = props.find{ |p| p['Уход'] }.try(:[], 'Уход')
        season = props.find{ |p| p['Сезон'] }.try(:[], 'Сезон').try(:mb_chars).try(:downcase).try(:split, ',').try(:map, &:strip).try(:join, ',')
        color = props.find{ |p| p['Цвет'] }.try(:[], 'Цвет').try(:mb_chars).try(:downcase).try(:to_s)
        measure = props.find{ |p| p['Размер'] }.try(:[], 'Размер')
        images = product.images.map{|i|i.image.url}.map{|url|'http://saleshop.online'+url.split("?").first}.join("#")
        csv << [
          product.title, product.article, production, season, sostav, color, uhod, measure, product.brand.try(:title),
          product.price, product.description, product.category.try(:parent).try(:title), product.category.try(:title), images
        ]
      end
    end

    

  end


end
