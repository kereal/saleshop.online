class Category < ApplicationRecord

  has_closure_tree
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  has_many :products

  validates :title, :slug, presence: true, length: { minimum: 2 }


  private

    def slug_candidates
      [:title, [:title, rand(100)]]
    end

    rails_admin do
      list do
        exclude_fields :children, :self_and_ancestors, :self_and_descendants, :products
      end
      create do
        exclude_fields :slug, :children, :self_and_ancestors, :self_and_descendants, :products
      end
    end

end
