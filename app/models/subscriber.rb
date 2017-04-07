class Subscriber < ApplicationRecord

  has_secure_token :token

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, uniqueness: true, presence: true

  scope :confirmed, -> { where(confirmed: true) }
  scope :subscribed, -> { where(subscribed: true) }
  scope :active, -> { where(subscribed: true).where(confirmed: true) }


  def active?
    subscribed && confirmed
  end


  private

    rails_admin do
      exclude_fields :token
    end

end
