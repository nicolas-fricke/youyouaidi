require 'spec_helper'

describe Youyouaidi::Converter do
  let(:uuid_string) { '550e8400-e29b-41d4-a716-446655440000' }
  let(:uuid_bignum) { 113059749145936325402354257176981405696 }
  let(:encoded_uuid) { '_oGOAbD9fsFFEHWSMal1v' }

  describe 'use case' do
    subject { described_class.decode described_class.encode(uuid_bignum) }

    it { should eq uuid_bignum }
  end

  describe 'methods' do
    let(:uuid) { Youyouaidi::UUID.new uuid_string }

    describe '.encode' do
      subject { described_class.encode uuid }

      it { should eq encoded_uuid }
    end

    describe '.decode' do
      subject { described_class.decode encoded_uuid }

      it { should eq uuid_bignum }
    end
  end
end