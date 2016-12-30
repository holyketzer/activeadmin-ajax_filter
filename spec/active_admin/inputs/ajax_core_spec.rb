require 'active_admin/inputs/ajax_core'

RSpec.describe ActiveAdmin::Inputs::AjaxCore do
  before(:each) do
    Temping.create(:record) do
      with_columns do |t|
        t.string :name
        t.string :email
      end
    end
  end

  class StubFilter < ActiveAdmin::Inputs::Filters::SelectInput
    include ActiveAdmin::Inputs::AjaxCore
  end

  let(:builder) { nil }
  let(:template) { nil }
  let(:object) { nil }
  let(:object_name) { nil }
  let(:method) { :device }
  let(:options) { { data: data } }
  let(:data) { nil }

  let(:filter) { StubFilter.new(builder, template, object, object_name, method, options) }

  describe '#ajax_data' do
    subject { filter.ajax_data }

    context 'no data in options' do
      it 'should use empty hash' do
        is_expected.to eq Hash.new
      end
    end

    context 'data in options' do
      let(:data) { { x: 1 } }

      it 'should use data from options' do
        is_expected.to eq data
      end
    end
  end

  describe '#collection_limit' do
    subject { filter.collection_limit }

    context 'no limit in data' do
      it 'should use default value' do
        is_expected.to eq described_class::DEFAULT_LIMIT
      end
    end

    context 'limit in data' do
      let(:data) { { limit: 11 } }

      it 'should use explicit value' do
        is_expected.to eq 11
      end
    end
  end

  describe '#value_field' do
    subject { filter.value_field }

    context 'no value_field in data' do
      it 'should use default value' do
        is_expected.to eq :id
      end
    end

    context 'value_field in data' do
      let(:data) { { value_field: :name } }

      it 'should use explicit value' do
        is_expected.to eq :name
      end
    end
  end

  describe '#search_fields' do
    subject { filter.search_fields }

    context 'no search_fields in data' do
      it 'should raise error' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'search_fields in data' do
      let(:data) { { search_fields: [:name, :email] } }

      it 'should use explicit value' do
        is_expected.to eq [:name, :email]
      end
    end
  end

  describe '#ordering' do
    subject { filter.ordering }

    context 'no ordering in data' do
      let(:data) { { search_fields: [:name, :email] }}

      it 'should use first value from search_fields' do
        is_expected.to eq 'name ASC'
      end
    end

    context 'ordering in data' do
      let(:data) { { ordering: 'email DESC' } }

      it 'should use explicit value' do
        is_expected.to eq 'email DESC'
      end
    end
  end

  describe '#ransack' do
    subject { filter.ransack }

    context 'no ransack in data' do
      let(:data) { { search_fields: [:name, :email] } }

      it 'should build ransack from search_fields' do
        is_expected.to eq 'name_or_email_cont'
      end
    end

    context 'ransack in data' do
      let(:data) { { ransack: :uid_eq } }

      it 'should use explicit value' do
        is_expected.to eq :uid_eq
      end
    end
  end

  describe '#url' do
    subject { filter.url }

    context 'no ransack in data' do
      it 'should build url from filter name' do
        is_expected.to eq 'devices/filter'
      end
    end

    context 'url is a string' do
      let(:data) { { url: '/admin/invoices/filter' } }

      it 'should use explicit value' do
        is_expected.to eq '/admin/invoices/filter'
      end
    end

    context 'url is a symbol' do

      let(:data) { { url: :path_helper } }
      let(:path) { 'some_path' }

      before do
        allow(Rails.application.routes).to receive(:url_helpers).and_return(double(path_helper: path))
      end

      it 'should eval lambda' do
        is_expected.to eq path
      end
    end
  end

  describe '#selected_value' do
    subject { filter.selected_value }

    let(:input_name) { :user_id }
    let(:value) { 12 }

    before do
      allow(filter).to receive(:input_name).and_return(input_name)
      filter.instance_variable_set('@object', double(input_name => value))
    end

    it { expect(subject).to eq value }
  end

  describe '#input_html_options' do
    subject { filter.input_html_options }

    before do
      allow_any_instance_of(ActiveAdmin::Inputs::Filters::SelectInput).to receive(:input_html_options).and_return(base_options)
    end

    let(:base_options) { { base_option: 1 } }
    let(:data) { { search_fields: [:name, :email] } }

    it do
      expect(subject).to include(base_options)
      expect(subject).to include('data-limit' => filter.collection_limit)
      expect(subject).to include('data-value-field' => filter.value_field)
      expect(subject).to include('data-search-fields' => filter.search_fields)
      expect(subject).to include('data-ordering' => filter.ordering)
      expect(subject).to include('data-ransack' => filter.ransack)
      expect(subject).to include('data-selected-value' => filter.selected_value)
      expect(subject).to include('data-url' => filter.url)
    end
  end

  context 'recrods in DB more than limit' do
    let(:limit) { described_class::DEFAULT_LIMIT }
    let!(:records) { (limit + 1).times { |i| Record.create!(name: "name-#{i}",  email: "email-#{i}") } }

    describe '#pluck_column' do
      subject { filter.pluck_column }

      before do
        allow(filter).to receive(:klass).and_return(Record)
      end

      let(:method) { :name }

      it { expect(subject.count).to eq limit }
    end

    describe '#collection_from_association' do
      subject { filter.collection_from_association }

      before do
        allow_any_instance_of(ActiveAdmin::Inputs::Filters::SelectInput).to receive(:collection_from_association).and_return(Record.all)
      end

      it { expect(subject.count).to eq limit }
    end
  end
end