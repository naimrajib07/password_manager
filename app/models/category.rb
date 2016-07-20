class Category < ActiveRecord::Base
  has_many :accounts

  before_destroy :account_look_up?

  def account_look_up?
    !accounts.exists?
  end
end
