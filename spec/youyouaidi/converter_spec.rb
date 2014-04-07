require 'spec_helper'

describe Youyouaidi::Converter do
  let(:uuid) { Youyouaidi::UUID.new uuid_string }
  let(:uuid_string) { '550e8400-e29b-41d4-a716-446655440000' }
  let(:encoded_uuid) { '_oGOAbD9fsFFEHWSMal1v' }

  describe 'use case' do
    subject { described_class.decode described_class.encode(uuid) }

    it { should be_a Youyouaidi::UUID }
    its(:to_s) { should eq uuid_string }
  end

  describe 'methods' do

    describe '.encode' do
      subject { described_class.encode uuid }

      it { should eq encoded_uuid }
    end

    describe '.decode' do
      let(:action) { described_class.decode encoded_param }

      context 'with valid param' do
        let(:encoded_param) { encoded_uuid }
        subject { action }
        it { should be_a Youyouaidi::UUID }
        its(:to_s) { should eq uuid_string }
      end

      context 'with invalid param' do
        subject { -> { action } }
        context 'with invalid characters' do
          let(:encoded_param) { ' ' }
          it { should raise_error Youyouaidi::InvalidUUIDError }
        end

        context 'with too long encoded param' do
          let(:encoded_param) { "#{encoded_uuid}abc" }
          it { should raise_error Youyouaidi::InvalidUUIDError }
        end
      end
    end
  end
end
