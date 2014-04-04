# Based on Base62 module by sinefunc
# => https://github.com/sinefunc/base62
class Youyouaidi::Converter
  class << self
    def encode(uuid)
      base_encode uuid.to_i
    end

    def decode(encoded_uuid)
      base_decode encoded_uuid
    end

    private
      BASE = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a + %w(_ - +)

      def base_encode(numeric)
        raise ArgumentError, "`#{numeric}' needs to be a Numeric" unless numeric.is_a? Numeric

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
            raise ArgumentError, "`#{encoded_numeric}' has `#{char}' which is not valid"
          end
        end
        total
      end
  end
end