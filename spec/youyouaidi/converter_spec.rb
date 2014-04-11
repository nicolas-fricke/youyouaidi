require 'spec_helper'

describe Youyouaidi::Converter do
  let(:uuid) { Youyouaidi::UUID.new uuid_string }
  let(:uuid_string) { '550e8400-e29b-41d4-a716-446655440000' }
  let(:encoded_uuid) { '2AuYQJcZeiIeCymkJ7tzTW' }

  uuids_with_encoding = {
    '550e8400-e29b-41d4-a716-446655440000' => '2AuYQJcZeiIeCymkJ7tzTW',
    '00000000-bbbb-2222-8888-000000000000' => '000001dyObGywDRlcScExy'
  }

  describe 'use case' do
    subject { described_class.decode described_class.encode(uuid) }

    it { should be_a Youyouaidi::UUID }
    its(:to_s) { should eq uuid_string }
  end

  describe 'methods' do

    describe '.encode' do
      subject { described_class.encode uuid }

      uuids_with_encoding.each do |valid_uuid, encoded_uuid|
        context "for uuid `#{valid_uuid}'" do
          let(:uuid_string) { valid_uuid }
          it { should have(22).characters }
          it { should eq encoded_uuid }
        end
      end
    end

    describe '.decode' do
      let(:action) { described_class.decode encoded_param }

      context 'with valid param' do
        subject { action }

        uuids_with_encoding.each do |valid_uuid, encoded_uuid|
          context "for encoded uuid `#{encoded_uuid}'" do
            let(:encoded_param) { encoded_uuid }
            it { should be_a Youyouaidi::UUID }
            its(:to_s) { should eq valid_uuid }
          end
        end
      end

      context 'with invalid param' do
        subject { -> { action } }
        context 'with invalid characters' do
          let(:encoded_param) { "_#{encoded_uuid[1..-1]}" }
          it { should raise_error Youyouaidi::InvalidUUIDError }
        end

        context 'with too long encoded param' do
          let(:encoded_param) { "#{encoded_uuid}abc" }
          it { should raise_error Youyouaidi::InvalidUUIDError }
        end

        context 'with too short encoded param' do
          let(:encoded_param) { "#{encoded_uuid[0..-3]}" }
          it { should raise_error Youyouaidi::InvalidUUIDError }
        end
      end
    end
  end
end
