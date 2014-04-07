class Youyouaidi::UUID
  attr_reader :uuid

  def initialize(uuid_string, options = {})
    @converter = options[:converter] || Youyouaidi::Converter
    raise Youyouaidi::InvalidUUIDError.new "`#{uuid_string}' could not be converted to valid UUID" unless self.class.valid? uuid_string
    @uuid = uuid_string.to_s
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
    def parse(uuid_param, options = {})
      @converter = options[:converter] || Youyouaidi::Converter
      if valid? uuid_param
        self.new uuid_param.to_s, options
      else
        uuid_obj = @converter.decode uuid_param
        raise Youyouaidi::InvalidUUIDError.new "`#{uuid_param}' could not be converted to valid UUID" unless valid? uuid_obj.to_s
        uuid_obj
      end
    end

    def valid?(uuid_canidate)
      (uuid_canidate.to_s =~ /^[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}$/i) == 0
    end
  end
end
