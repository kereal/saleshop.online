class Image < ApplicationRecord

  belongs_to :product

  validates :image, :product, presence: true

  has_attached_file :image, styles: { medium: "200x300>" }, default_url: "/assets/image-missing.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end
