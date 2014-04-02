class Youyouaidi::UUID
  attr_reader :uuid

  def initialize(uuid_param)
    raise ArgumentError unless self.class.valid_uuid? uuid_param
    @uuid = uuid_param.to_s
  end

  def to_s
    @uuid
  end

  def self.valid_uuid? (uuid_canidate)
    (uuid_canidate.to_s =~ /[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}/i) == 0
  end
end