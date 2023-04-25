require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?


ActiveRecord::Base.transaction do
  categories = 5.times.map { Category.create!(name: Faker::Fantasy::Tolkien.unique.location ) }

  subcategories = categories.flat_map do |category|
    3.times.map { Subcategory.create!(category: category, name: Faker::Fantasy::Tolkien.unique.location) }
  end

  tags = subcategories.flat_map do |subcategory|
    3.times.map { Tag.create!(subcategory: subcategory, name: Faker::Music.unique.band) }
  end

  items = subcategories.flat_map do |subcategory|
    5.times.map do
      Item.create!(
        subcategory: subcategory,
        name: Faker::Fantasy::Tolkien.unique.character,
        tags: 2.times.map { tags.sample }
      )
    end
  end
end
