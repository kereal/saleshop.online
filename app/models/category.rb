class Category < ApplicationRecord

  has_ancestry
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  enum gender: { female: 0, male: 1 }

  has_many :products

  validates :title, :slug, presence: true, length: { minimum: 2 }


  def parent_enum
    Category.where.not(id: id).map { |c| [ c.title, c.id ] }
  end

  private

    def slug_candidates
      [:title, [:title, self.gender == "male" ? "muzhskie" : "zhenskie"], [:title, rand(100)]]
    end

    def should_generate_new_friendly_id?
      gender_changed? || super
    end

    rails_admin do
      nestable_tree true
      include_all_fields
      field :parent_id, :enum do
        enum_method do
          :parent_enum
        end
      end
      list do
        exclude_fields :products, :ancestry, :parent_id
      end
      create do
        exclude_fields :products, :slug, :ancestry
      end
      edit do
        exclude_fields :products, :ancestry
      end
    end

end