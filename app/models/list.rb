class List < ActiveRecord::Base
  has_many :bills, dependent: :destroy
  has_many :groups
  has_many :users, through: :groups
  has_many :settlements

  validates :name, presence: true

  # failing message: divided by 0
  # /Users/zmontesd/Projects/DevBootCamp/SplitAmongUs/app/models/list.rb:20:in `/'
  monetize :total_amount_cents
  monetize :person_share_cents

  def total_amount_cents
    total_cents = 0
    bills.each do |bill|
      total_cents += bill.amount_cents
    end
    total_cents
  end

  def person_share_cents
    total_amount_cents == 0 ? 0 : total_amount_cents / self.users.count
  end
end


