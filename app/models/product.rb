class Product < ApplicationRecord

  enum gender: { female: 0, male: 1 }

  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  belongs_to :category
  belongs_to :brand
  has_many :images, dependent: :destroy

  validates :title, :slug, presence: true, length: { minimum: 2 }
  validates :price, presence: true

  def image
    unless self.provider_images.blank?
      imgs = JSON.parse self.provider_images
      "https://app.subtotal.ru#{imgs.first}" if imgs.try(:first)
    end
  end

  # возвращаем массив урлов или nil (только первые 2)
  def remote_images(limit = 2)
    unless self.provider_images.blank?
      urls = JSON.parse self.provider_images
      urls.first(limit).map{|url| "https://app.subtotal.ru#{url}"}
    end
  end

  # прибавляем discount процентов к цене
  def old_price
    unless self.discount.blank?
      price + price * discount / 100
    end
  end


  private

    def slug_candidates
      [:title, [:title, rand(100)]]
    end

    rails_admin do
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
