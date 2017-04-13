class Brand < ApplicationRecord

  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  has_many :products

  validates :title, :slug, presence: true, length: { minimum: 2 }

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://placehold.it/200x120/fff/777&amp;text=нет+фото"
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\z/ }, size: { in: 0..8.megabytes }


  private

    def slug_candidates
      [:title, [:title, rand(100)]]
    end

    rails_admin do
      parent 'Product'
      create do
        exclude_fields :slug
      end
      list do
        exclude_fields :description, :products
      end
      edit do
        exclude_fields :products
      end
      show do
        include_all_fields
        field :description do
          pretty_value do value.html_safe end
        end
        # field :products do
        #   pretty_value do
        #     out = ""
        #     value.each{ |product| out += bindings[:view].tag(:p) << product.title }
        #     out.html_safe
        #   end
        # end
      end
    end

end
