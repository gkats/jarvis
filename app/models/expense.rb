class Expense < ActiveRecord::Base
  validates_numericality_of :price
  validates_presence_of :date
end