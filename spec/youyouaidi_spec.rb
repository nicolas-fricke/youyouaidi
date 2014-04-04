require 'spec_helper'

describe Youyouaidi do
  describe Youyouaidi::UUID do
    describe '.new' do
      let(:param) { '' }
      subject { Youyouaidi::UUID.new param }

      context 'with valid uuid' do
        let(:param) { '550e8400-e29b-41d4-a716-446655440000' }

        it { should be_a Youyouaidi::UUID }
      end

      context 'with invalid uuid' do
        let(:param) { 'Kekse' }

        it 'raises error' do
          expect { Youyouaidi::UUID.new param }.to raise_error
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

    describe '.valid_uuid?' do
      let(:param) { '' }
      subject { Youyouaidi::UUID.valid_uuid? param }

      context 'with valid uuid' do
        let(:param) { '550e8400-e29b-41d4-a716-446655440000' }

        it { should be_true }
      end

      context 'with invalid uuid' do
        invalid_uuids = ['Kekse', 'aa550e8400-e29b-41d4-a716-446655440000']

        invalid_uuids.each do |invalid_uuid|
          it "should return false for `#{invalid_uuid}`" do
            expect(Youyouaidi::UUID.valid_uuid? invalid_uuid).to eq false
          end
        end
      end
    end
  end
end