class Brand < ApplicationRecord

  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  has_many :products

  validates :title, :slug, presence: true, length: { minimum: 2 }

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/brand-missing.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  private

  def slug_candidates
    [:title, [:title, rand(100)]]
  end

  rails_admin do
    create do
      exclude_fields :slug
    end
    list do
      exclude_fields :description, :products
    end
  end

end
