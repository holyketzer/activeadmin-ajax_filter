module SelectizeHelpers
  # Input text to selectize field
  def fill_in_selectize(text, selector = selectize_selector)
    find("#{selector} .selectize-input input").native.send_keys(text)
  end

  # Get current selectize items
  def selectize_items(selector = selectize_selector)
    all("#{selector} .selectize-dropdown-content .item").map do |div|
      {
        value: div[:'data-value'],
        text: div.text,
      }
    end
  end
end