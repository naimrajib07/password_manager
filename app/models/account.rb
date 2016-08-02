class Account < ActiveRecord::Base
  belongs_to :category

  PASSWORD_FORMAT = /\A
                      (?=.{10,})         # Must contain 8 or more characters
                      (?=.*\d{3,})       # Must contain a digit
                      (?=.*[a-z])        # Must contain a lower case character
                      (?=.*[A-Z])        # Must contain an upper case character
                      (?=.*[[$]])        # Must contain a dollar
                   /x
  validates_presence_of :title, :username, :url, :category_id
  validates :url,
            format: {message: 'url must be with http/https', with: URI.regexp}, if: Proc.new { |a| a.url.present? }
  validates :password,
            presence: true,
            length: {in: 10..15},
            format: {message: 'at least 10 letters (with at least one capital letter),
                         3 numbers and one special character($)',
                     with: PASSWORD_FORMAT
            }

  scope :sort_by_category, -> { order(category_id: :asc) }

  delegate :name , to: :category

  validate :custom_password

  def custom_password
    password.split('')
  end
end
