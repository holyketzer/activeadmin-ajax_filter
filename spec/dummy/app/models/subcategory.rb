class Subcategory < ActiveRecord::Base
  AJAX_LIMIT = 3

  validates :name, presence: true

  belongs_to :category
  has_many :items
end