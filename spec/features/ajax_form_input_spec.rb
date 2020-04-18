RSpec.describe ActiveAdmin::Inputs::AjaxSelectInput, type: :feature, js: true do
  let!(:subcategories) { create_list(:subcategory, Subcategory::AJAX_LIMIT + 1) }
  let(:subcategory) { subcategories.last }

  describe 'new item creation' do
    before do
      visit new_admin_item_path
    end

    let(:selectize_selector) { '#item_subcategory_input' }

    it 'should limit items' do
      fill_in('Name', with: 'Some item')
      fill_in_selectize('Subcategory')

      expect(selectize_items.size).to eq Subcategory::AJAX_LIMIT
    end

    it 'should filter items' do
      fill_in('Name', with: 'Some item')
      fill_in_selectize(subcategory.name)

      expect(selectize_items.size).to eq 1
      expect(selectize_items[0][:text]).to eq subcategory.name
    end
  end

  describe 'new tag creation' do
    before do
      visit new_admin_tag_path
    end

    let(:selectize_selector) { '#tag_subcategory_input' }

    it 'should limit items' do
      fill_in('Name', with: 'Some item')
      fill_in_selectize('Category')

      expect(selectize_items.size).to eq Subcategory::AJAX_LIMIT
    end

    it 'should filter items' do
      fill_in('Name', with: 'Some item')
      fill_in_selectize(subcategory.category.name)

      expect(selectize_items.size).to eq 1
      expect(selectize_items[0][:text]).to eq subcategory.category.name
    end
  end
end
