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
