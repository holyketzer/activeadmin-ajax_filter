class Item < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :subcategory
end