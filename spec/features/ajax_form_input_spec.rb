RSpec.describe ActiveAdmin::Inputs::AjaxSelectInput, type: :feature, js: true do
  let!(:subcategories) { create_list(:subcategory, Subcategory::AJAX_LIMIT + 1) }

  before do
    visit new_admin_item_path
  end

  let(:selectize_selector) { '#item_subcategory_input' }

  it 'should limit items' do
    fill_in('Name', with: 'Some item')
    fill_in_selectize('Subcategory')

    expect(selectize_items.size).to eq Subcategory::AJAX_LIMIT
  end
end