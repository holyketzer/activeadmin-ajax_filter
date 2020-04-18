class Tag < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :subcategory
end
