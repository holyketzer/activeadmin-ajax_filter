module SelectizeHelpers
  # Input text to selectize field
  def fill_in_selectize(text, selector = selectize_selector)
    find("#{selector} .selectize-input input").native.send_keys(text)
    wait_for_ajax
  end

  # Get current selectize items
  def selectize_items_in_dropdown(selector = selectize_selector)
    # Wait until selectize renders with blocking find
    select_tag = find("#{selector} select", visible: false)
    select_option = first("#{selector} .selectize-dropdown-content .item", visible: false)

    all("#{selector} .selectize-dropdown-content .item", visible: false).map do |div|
      {
        value: div[:'data-value'],
        text: div.text,
        selected: div[:class].include?('selected')
      }
    end
  end

  def selectize_items_in_field(selector = selectize_selector)
    # Wait until selectize renders with blocking find
    select_tag = find("#{selector} select", visible: false)
    select_option = first("#{selector} .selectize-input.items div", visible: false)

    all("#{selector} .selectize-input.items div", visible: false).map do |div|
      {
        value: div[:'data-value'],
        text: div.text,
        selected: true,
      }
    end
  end

  def wait_item(timeout = 15, &block)
    started_at = Time.current

    while !(res = block.call) do
      sleep(1)

      if Time.current - started_at > timeout
        raise RuntimeError, "timeout #{timeout} sec."
      end
    end

    res
  end
end
