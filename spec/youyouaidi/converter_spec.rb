require 'spec_helper'

describe Youyouaidi::Converter do
  shared_examples_for 'a call that raises a Youyouaidi::InvalidUUIDError with a meaningful error message' do
  describe 'raises error' do
    subject { -> { action } }
    it { should raise_error Youyouaidi::InvalidUUIDError }
    describe 'error message' do
      let(:caught_error) do
        begin
          action
          return nil
        rescue Youyouaidi::InvalidUUIDError => error
          return error
        end
      end
      subject { caught_error }
      it { should_not be_nil}
      its(:message) { should include(*error_message_includes) }
    end
  end
end

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
        context 'looking correct but converting to a non-valid UUID' do
          let(:encoded_param) { 'qEsRTcgdJFVugbBqtaEoNf' }
          let(:decoded_invalid_uuid) { '36bb9153-3a5a-1570-de9d-6faed4f1ceb0' }
          let(:error_message_includes) { ["`#{encoded_param}'", "`#{decoded_invalid_uuid}'"] }
          it_behaves_like 'a call that raises a Youyouaidi::InvalidUUIDError with a meaningful error message'
        end

        context 'with invalid characters' do
          let(:invalid_char) { '_' }
          let(:encoded_param) { "#{invalid_char}#{encoded_uuid[1..-1]}" }
          let(:error_message_includes) { ["`#{encoded_param}'", "`#{invalid_char}'"] }
          it_behaves_like 'a call that raises a Youyouaidi::InvalidUUIDError with a meaningful error message'
        end

        shared_examples_for 'a call with incorrect param string length' do
          let(:error_message_includes) { ["`#{encoded_param}'", '22', "#{encoded_param.length}"] }
          it_behaves_like 'a call that raises a Youyouaidi::InvalidUUIDError with a meaningful error message'
        end

        context 'with too long encoded param' do
          let(:encoded_param) { "#{encoded_uuid}abc" }
          it_behaves_like 'a call with incorrect param string length'
        end

        context 'with too short encoded param' do
          let(:encoded_param) { "#{encoded_uuid[0..-3]}" }
          it_behaves_like 'a call with incorrect param string length'
        end
      end
    end
  end
end
