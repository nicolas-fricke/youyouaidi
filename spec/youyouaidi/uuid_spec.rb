require 'spec_helper'

describe Youyouaidi::UUID do
  describe '.new' do
    let(:param) { '' }
    let(:action) { Youyouaidi::UUID.new param }
    subject { -> { action } }

    context 'with valid uuid string' do
      let(:param) { '550e8400-e29b-41d4-a716-446655440000' }
      subject { action }

      it { should be_a Youyouaidi::UUID }
      its(:to_s) { should eq param }
    end

    context 'with uuid in short format' do
      let(:param) { '_oGOAbD9fsFFEHWSMal1v' }
      it { should raise_error Youyouaidi::InvalidUUIDError }
    end

    context 'with invalid uuid string' do
      let(:param) { 'Kekse' }
      it { should raise_error Youyouaidi::InvalidUUIDError }
    end

    context 'with non-uuid-string input' do
      let(:param) { 1234 }
      it { should raise_error Youyouaidi::InvalidUUIDError }
    end
  end

  describe '.parse' do
    let(:param) { '' }
    let(:action) { Youyouaidi::UUID.parse param }
    subject { action }

    context 'with valid uuid string' do
      let(:param) { '550e8400-e29b-41d4-a716-446655440000' }

      it { should be_a Youyouaidi::UUID }
    end

    context 'with uuid in short format' do
        let(:param) { '_oGOAbD9fsFFEHWSMal1v' }
        let(:decoded_uuid) { '550e8400-e29b-41d4-a716-446655440000' }

        it { should be_a Youyouaidi::UUID }
        its(:to_s) { should eq decoded_uuid }
    end

    context 'with invalid uuid string' do
      let(:param) { 'Kekse' }

      it 'raises error' do
        expect { Youyouaidi::UUID.parse param }.to raise_error Youyouaidi::InvalidUUIDError
      end
    end

    context 'with non-string input' do
      let(:param) { 1234 }

      it 'raises error' do
        expect { Youyouaidi::UUID.parse param }.to raise_error Youyouaidi::InvalidUUIDError
      end
    end
  end

  describe '#to_s' do
    let(:uuid_string) { '550e8400-e29b-41d4-a716-446655440000' }
    let(:uuid) { Youyouaidi::UUID.new uuid_string }
    subject { uuid.to_s }

    it { should be_a String }
    it { should eq uuid_string }
  end

  describe '#to_i' do
    let(:uuid_string) { '550e8400-e29b-41d4-a716-446655440000' }
    let(:uuid) { Youyouaidi::UUID.new uuid_string }
    subject { uuid.to_i }

    it { should be_a Bignum }
    it { should eq 113059749145936325402354257176981405696 }
  end

  shared_examples_for 'method for short format' do
    let(:uuid_string) { '550e8400-e29b-41d4-a716-446655440000' }
    let(:encoded_uuid) { '_oGOAbD9fsFFEHWSMal1v' }
    let(:uuid) { Youyouaidi::UUID.new uuid_string }

    let(:action) { uuid.send method }
    subject { action }

    it { should be_a String }
    it { should eq encoded_uuid }
  end
  describe '#to_short_string' do
    let(:method) { :to_short_string }
    it_behaves_like 'method for short format'
  end
  describe '#to_param' do
    let(:method) { :to_param }
    it_behaves_like 'method for short format'
  end

  describe '.valid?' do
    let(:param) { '' }
    subject { Youyouaidi::UUID.valid? param }

    context 'with valid uuid' do
      let(:param) { '550e8400-e29b-41d4-a716-446655440000' }

      it { should be_true }
    end

    context 'with invalid uuid' do
      uuid_string   = '550e8400-e29b-41d4-a716-446655440000'
      encoded_uuid  = '_oGOAbD9fsFFEHWSMal1v'
      invalid_uuids = ['Kekse', "aa#{uuid_string}", "#{uuid_string}bb",
        "#{encoded_uuid}" ]

      invalid_uuids.each do |invalid_uuid|
        it "should return false for `#{invalid_uuid}`" do
          expect(Youyouaidi::UUID.valid? invalid_uuid).to eq false
        end
      end
    end
  end
end
