class Category < ActiveRecord::Base
  has_many :accounts

  validates_presence_of :name

  before_destroy :account_look_up?

  def self.list
    all.collect { |cat| [ cat.name, cat.id ] }
  end

  private
  def account_look_up?
    !accounts.exists?
  end
end
