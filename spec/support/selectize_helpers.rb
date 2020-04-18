module SelectizeHelpers
  # Input text to selectize field
  def fill_in_selectize(text, selector = selectize_selector)
    find("#{selector} .selectize-input input").native.send_keys(text)
    wait_for_ajax
  end

  # Get current selectize items
  def selectize_items(selector = selectize_selector)
    # Wait until selectize renders with blocking find
    select_tag = find("#{selector} select", visible: false)

    all("#{selector} .selectize-dropdown-content .item", visible: false).map do |div|
      {
        value: div[:'data-value'],
        text: div.text,
        selected: div[:class].include?('selected')
      }
    end
  end
end
