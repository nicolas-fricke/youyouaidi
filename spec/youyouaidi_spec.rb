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

    describe '#uuid' do
      let(:param) { '550e8400-e29b-41d4-a716-446655440000' }
      let(:uuid) { Youyouaidi::UUID.new param }
      subject { uuid.uuid }

      it { should eq param }
    end

    describe '#to_s' do
      let(:param) { '550e8400-e29b-41d4-a716-446655440000' }
      let(:uuid) { Youyouaidi::UUID.new param }
      subject { uuid.to_s }

      it { should eq param }
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