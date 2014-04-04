class Youyouaidi::UUID
  attr_reader :uuid

  def initialize(uuid_param, options = {})
    raise ArgumentError unless self.class.valid_uuid? uuid_param
    @uuid = uuid_param.to_s
    @converter = options[:converter] || Youyouaidi::Converter
  end

  def to_i
    @uuid.gsub('-', '').hex
  end

  def to_s
    @uuid
  end

  def to_short_string
    @converter.encode self
  end
  alias_method :to_param, :to_short_string

  class << self
    def valid_uuid? (uuid_canidate)
      (uuid_canidate.to_s =~ /[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}/i) == 0
    end
  end
end