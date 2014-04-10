require 'securerandom'

class Youyouaidi::UUID
  attr_reader :uuid

  def initialize(uuid_string = nil, options = {})
    @converter = options[:converter] || Youyouaidi::Converter
    if uuid_string
      initialize_with_uuid_string uuid_string
    else
      initialize_without_param
    end
  end

  def ==(other_object)
    return false unless other_object.is_a? self.class
    self.to_s == other_object.to_s
  end

  def ===(other_object)
    return true if self == other_object
    self.to_s == other_object.to_s.downcase
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

    def initialize_without_param
      @uuid = SecureRandom.uuid
    end

    def initialize_with_uuid_string(uuid_string)
      raise Youyouaidi::InvalidUUIDError.new "`#{uuid_string}' could not be converted to valid UUID" unless self.class.valid? uuid_string
      @uuid = uuid_string.to_s.downcase
    end

  class << self
    def parse(uuid_param = nil, options = {})
      @converter = options[:converter] || Youyouaidi::Converter
      if valid? uuid_param
        self.new uuid_param.to_s, options
      elsif uuid_param.nil?
        self.new nil, options
      else
        uuid_obj = @converter.decode uuid_param
        raise Youyouaidi::InvalidUUIDError.new "`#{uuid_param}' could not be converted to valid UUID" unless valid? uuid_obj.to_s
        uuid_obj
      end
    end

    def valid?(uuid_canidate)
      (uuid_canidate.to_s =~ /^[\da-f]{8}(-[\da-f]{4}){2}-[89ab][\da-f]{3}-[\da-f]{12}$/i) == 0
    end
  end
end
