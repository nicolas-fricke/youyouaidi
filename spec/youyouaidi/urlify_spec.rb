require 'spec_helper'

describe Youyouaidi::URLify do
  describe 'use case' do
    let(:uuid_string) { '550e8400-e29b-41d4-a716-446655440000' }

    subject { described_class.decode described_class.encode(uuid_string) }

    it { should eq uuid_string }
  end
end