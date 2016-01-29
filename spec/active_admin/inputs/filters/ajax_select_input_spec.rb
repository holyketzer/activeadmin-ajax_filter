require 'spec_helper'
# require 'active_admin'
require 'active_admin/inputs/filters/ajax_select_input'

describe ActiveAdmin::Inputs::Filters::AjaxSelectInput do
  let(:builder) { nil }
  let(:template) { nil }
  let(:object) { nil }
  let(:object_name) { nil }
  let(:method) { nil }
  let(:options) { {} }

  let(:filter) { described_class.new(builder, template, object, object_name, method, options) }

  describe '#ajax_data' do
    subject { filter.ajax_data }

    context 'no data in options' do
      it 'use empty hash' do
        is_expected.to eq {}
      end
    end

    context 'data in options' do
      let(:data) { { x: 1 } }
      let(:options) { { data: data } }

      it 'use data from options' do
        is_expected.to eq data
      end
    end
  end
end

