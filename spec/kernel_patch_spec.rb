require 'spec_helper'

describe Kernel do
  describe '.UUID' do
    let(:valid_uuid) { '550e8400-e29b-41d4-a716-446655440000' }
    let(:encoded_uuid) { '2AuYQJcZeiIeCymkJ7tzTW' }
    let(:action) { UUID param }

    subject { action }


    shared_examples_for 'a valid UUID object' do
      it { should be_a Youyouaidi::UUID }
      its(:to_s) { should eq valid_uuid }
    end

    context 'initialized without a param' do
      let(:action) { UUID() }
      it { should be_a Youyouaidi::UUID }
    end

    context 'initialized via valid uuid' do
      let(:param) { valid_uuid }
      it_behaves_like 'a valid UUID object'
    end

    context 'initialized via vaild encoded uuid' do
      let(:param) { encoded_uuid }
      it_behaves_like 'a valid UUID object'
    end

    context 'initialized with invalid param' do
      let(:param) { 'KEKSE' }
      subject { -> { action } }
      it { should raise_error Youyouaidi::InvalidUUIDError }
    end
  end
end
