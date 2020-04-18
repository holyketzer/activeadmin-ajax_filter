RSpec.describe ActiveAdmin::Inputs::AjaxSelectInput, type: :feature, js: true do
  let!(:subcategories) { create_list(:subcategory, Subcategory::AJAX_LIMIT + 1) }
  let(:subcategory) { subcategories.last }

  context 'items' do
    let(:selectize_selector) { '#item_subcategory_input' }

    describe 'new item creation' do
      before do
        visit new_admin_item_path
      end

      it 'should limit items' do
        fill_in('Name', with: 'Some item')
        fill_in_selectize('Subcategory')

        expect(selectize_items_in_dropdown.size).to eq Subcategory::AJAX_LIMIT
      end

      it 'should filter items' do
        fill_in('Name', with: 'Some item')
        fill_in_selectize(subcategory.name)

        expect(selectize_items_in_dropdown.size).to eq 1
        expect(selectize_items_in_dropdown[0][:text]).to eq subcategory.name
      end
    end

    describe 'edit item' do
      let!(:item) { create(:item, subcategory: subcategory) }
      let!(:tags) { create_list(:tag, 10, subcategory: subcategory) }

      before do
        item.update!(tags: tags[6..9])
        visit edit_admin_item_path(item)
      end

      it 'should select current item on edit' do
        selected_item = wait_item { selectize_items_in_dropdown.find { |i| i[:selected] } }

        expect(selected_item).to_not eq nil
        expect(selected_item[:value]).to eq subcategory.id.to_s

        tags_selectize_items = selectize_items_in_field('#item_tags_input')
        expect(tags_selectize_items.map { |i| i[:value] }.sort).to eq item.tags.map(&:id).map(&:to_s).sort
      end
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

      expect(selectize_items_in_dropdown.size).to eq Subcategory::AJAX_LIMIT
    end

    it 'should filter items' do
      fill_in('Name', with: 'Some item')
      fill_in_selectize(subcategory.category.name)

      expect(selectize_items_in_dropdown.size).to eq 1
      expect(selectize_items_in_dropdown[0][:text]).to eq subcategory.category.name
    end
  end
end
