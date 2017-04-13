class Image < ApplicationRecord

  belongs_to :product

  validates :image, presence: true

  has_attached_file :image,
      styles: { original: "1024>", medium: "230>", thumb: "70x70#" },
      url: "/system/:class/:id_partition/:hash.:extension",
      hash_secret: "u8asnAs7sAd0adg6aAah",
      default_url: "http://placehold.it/208x248/f9f9f9/777?text=нет+фото",
      convert_options: { all: "-strip", original: "-quality 82" }
      validates_attachment :image, content_type: { content_type: /\Aimage\/.*\z/ }, size: { in: 0..8.megabytes }


  private

    rails_admin do
      parent 'Product'      
    end

end
