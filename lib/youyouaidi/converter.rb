# Based on Base62 module by sinefunc
# => https://github.com/sinefunc/base62
class Youyouaidi::Converter
  class << self
    def encode(uuid)
      base_encode uuid.to_i
    end

    def decode(encoded_uuid)
      Youyouaidi::UUID.new convert_bignum_to_uuid_string base_decode encoded_uuid
    end

    private
      BASE = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a + %w(_ - +)

      def base_encode(numeric)
        raise Youyouaidi::InvalidUUIDError.new "`#{numeric}' needs to be a Numeric" unless numeric.is_a? Numeric

        return '0' if numeric == 0
        s = ''

        while numeric > 0
          s << BASE[numeric.modulo(BASE.size)]
          numeric /= BASE.size
        end
        s.reverse
      end

      def base_decode(encoded_numeric)
        s = encoded_numeric.to_s.reverse.split('')

        total = 0
        s.each_with_index do |char, index|
          if ord = BASE.index(char)
            total += ord * (BASE.size ** index)
          else
            raise Youyouaidi::InvalidUUIDError.new "`#{encoded_numeric}' has `#{char}' which is not valid"
          end
        end
        total
      end

      def convert_bignum_to_uuid_string(decoded_uuid_bignum)
        decoded_uuid = decoded_uuid_bignum.to_i.to_s(16)
        parsed_uuid  = "#{decoded_uuid[0,8]}-#{decoded_uuid[8,4]}-#{decoded_uuid[12,4]}-#{decoded_uuid[16,4]}-#{decoded_uuid[20,12]}"
        raise Youyouaidi::InvalidUUIDError.new "Converted string `#{parsed_uuid}' has too many characters" if decoded_uuid.length > 32
        parsed_uuid
      end
  end
end
