class Youyouaidi::URLify
  class << self
    def encode(uuid)
      base_encode uuid.gsub('-', '').hex
    end

    def decode(encoded_uuid)
      uuid = base_decode(encoded_uuid).to_i.to_s(16)
      "#{uuid[0,8]}-#{uuid[8,4]}-#{uuid[12,4]}-#{uuid[16,4]}-#{uuid[20,12]}"
    end

  private
    BASE = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a + %w(_ - + =)

    def base_encode( numeric )
      raise ArgumentError unless Numeric === numeric

      return '0' if numeric == 0
      s = ''

      while numeric > 0
        s << BASE[numeric.modulo(BASE.size)]
        numeric /= BASE.size
      end
      s.reverse
    end

    def base_decode( base62 )
      s = base62.to_s.reverse.split('')

      total = 0
      s.each_with_index do |char, index|
        if ord = BASE.index(char)
          total += ord * (BASE.size ** index)
        else
          raise ArgumentError, "#{base62} has #{char} which is not valid"
        end
      end
      total.to_s
    end
  end
end