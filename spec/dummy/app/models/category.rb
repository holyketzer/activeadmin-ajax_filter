class Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :subcategories
  has_many :items, through: :subcategories
end