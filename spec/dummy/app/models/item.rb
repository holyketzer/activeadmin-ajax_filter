class Item < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :subcategory
  has_and_belongs_to_many :tags
end
