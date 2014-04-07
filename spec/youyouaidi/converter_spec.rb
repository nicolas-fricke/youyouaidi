require 'spec_helper'

describe Youyouaidi::Converter do
  let(:uuid) { Youyouaidi::UUID.new uuid_string }
  let(:uuid_string) { '550e8400-e29b-41d4-a716-446655440000' }
  let(:encoded_uuid) { '_oGOAbD9fsFFEHWSMal1v' }

  describe 'use case' do
    subject { described_class.decode described_class.encode(uuid) }

    it { should eq uuid_string }
  end

  describe 'methods' do

    describe '.encode' do
      subject { described_class.encode uuid }

      it { should eq encoded_uuid }
    end

    describe '.decode' do
      subject { described_class.decode encoded_uuid }

      it { should eq uuid_string }

      context 'with invalid characters' do
        let(:encoded_uuid) { ' '}

        it 'raises error' do
          expect { subject }.to raise_error Youyouaidi::InvalidUUIDError
        end
      end
    end
  end
end
