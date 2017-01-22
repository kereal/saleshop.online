class Page < ApplicationRecord

  extend FriendlyId

  friendly_id :title, use: :slugged

  validates :title, :slug, presence: true, length: { minimum: 2 }


  private
  
  rails_admin do
    create do
      exclude_fields :slug
    end
    list do
      exclude_fields :content
    end
  end 

end
