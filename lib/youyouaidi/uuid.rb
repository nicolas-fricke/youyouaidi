class Youyouaidi::UUID
  attr_reader :uuid

  def initialize(uuid_param, options = {})
    @converter = options[:converter] || Youyouaidi::Converter
    if self.class.valid? uuid_param
      @uuid = uuid_param.to_s
    else
      @uuid = @converter.decode uuid_param
      raise ArgumentError.new "`#{uuid_param}' could not be converted to valid UUID" unless self.class.valid? @uuid
    end
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

  private

  class << self
    def valid?(uuid_canidate)
      (uuid_canidate.to_s =~ /[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}/i) == 0
    end
  end
end
