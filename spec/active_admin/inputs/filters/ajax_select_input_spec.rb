require 'spec_helper'
require 'active_admin/inputs/ajax_core'
require 'active_admin/inputs/filters/ajax_select_input'

describe ActiveAdmin::Inputs::Filters::AjaxSelectInput do
  before(:each) do
    Temping.create(:record) do
      with_columns do |t|
        t.string :name
        t.string :email
      end
    end
  end

  let(:builder) { nil }
  let(:template) { nil }
  let(:object) { nil }
  let(:object_name) { nil }
  let(:method) { :device }
  let(:options) { { data: data } }
  let(:data) { nil }

  let(:filter) { described_class.new(builder, template, object, object_name, method, options) }

  context 'recrods in DB more than limit' do
    let(:limit) { described_class::DEFAULT_LIMIT }
    let!(:records) { (limit + 1).times { |i| Record.create!(name: "name-#{i}",  email: "email-#{i}") } }

    describe '#collection_from_association' do
      subject { filter.collection_from_association }

      before do
        allow_any_instance_of(ActiveAdmin::Inputs::Filters::SelectInput).to receive(:collection_from_association).and_return(Record.all)
      end

      it { expect(subject.count).to eq limit }
    end
  end
end