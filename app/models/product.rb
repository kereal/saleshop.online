class Product < ApplicationRecord

  enum gender: { female: 0, male: 1 }

  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  belongs_to :category
  belongs_to :brand
  has_many :images, -> { order(:id) }, dependent: :destroy

  validates :title, :slug, presence: true, length: { minimum: 2 }
  validates :price, presence: true

  searchkick language: "russian", settings: { number_of_shards: 1 }, batch_size: 200
  scope :search_import, -> { includes(:brand, :category, :images) }
  def search_data
    props = JSON.parse(properties)
    measure = props.find{ |p| p['Размер'] }.try(:[], 'Размер')
    new_item = props.find{ |p| p['Новинка'] }.try(:[], 'Новинка')
    color = props.find{ |p| p['Цвет'] }.try(:[], 'Цвет').try(:mb_chars).try(:downcase)
    season = props.find{ |p| p['Сезон'] }.try(:[], 'Сезон').try(:mb_chars).try(:downcase).try(:split, ',').try(:map, &:strip)
    {
      id: id,
      title: title,
      brand: "#{brand.try(:title)}|#{brand.try(:slug)}",
      brand_slug: brand.try(:slug),
      category: category.try(:title),
      category_id: category.try(:id),
      description: description,
      price: price,
      discount_price: discount_price,
      gender: gender,
      discount: discount,
      country: country,
      article: article,
      slug: slug,
      measure: measure == '-' ? nil : measure,   # size зарезервировано
      color: color == '-' ? nil : color,
      season: season,
      sale: discount.present?,
      new: new_item.blank? ? false : true,
      image: image(:medium),
      updated_at: updated_at
    }
  end

  # возвращаем Image || nil
  def image(args = {})
    self.images.first.try(:image, args) || nil
  end

  # считаем цену со скидкой. price - цена без скидки
  def discount_price
    discount.blank? ? price : price - price * discount / 100
  end


  private

    def slug_candidates
      [:title, [:title, rand(100)]]
    end

    rails_admin do
      parent 'Category'
      create do
        exclude_fields :slug
      end
      list do
        exclude_fields :description, :images, :provider_images, :properties
      end
      edit do
        exclude_fields :products
      end
    end

end
