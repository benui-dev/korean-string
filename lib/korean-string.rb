# Originally transliterate-hacked from Perl from
# http://blog.naver.com/PostView.nhn?blogId=mokomoji&logNo=130013133481
#
# For the theory of why this works, check out the W3C spec on Korean encoding
# http://www.w3c.or.kr/i18n/hangul-i18n/ko-code.html
# (Thanks to @ntrolls for this)

$KCODE = 'UTF8'

         # ㄱ      ㄲ      ㄴ      ㄷ      ㄸ      ㄹ      ㅁ      ㅂ      
CHOSUNG = [0x3131, 0x3132, 0x3134, 0x3137, 0x3138, 0x3139, 0x3141, 0x3142,
         # ㅃ      ㅅ      ㅆ      ㅇ      ㅈ      ㅉ      ㅊ      ㅋ      
           0x3143, 0x3145, 0x3146, 0x3147, 0x3148, 0x3149, 0x314a, 0x314b,
         # ㅌ      ㅍ      ㅎ
           0x314c, 0x314d, 0x314e]

           # ㅏ      ㅐ      ㅑ      ㅒ      ㅓ      ㅔ      ㅕ      ㅖ
JWUNGSUNG = [0x314f, 0x3150, 0x3151, 0x3152, 0x3153, 0x3154, 0x3155, 0x3156,
           # ㅗ      ㅘ      ㅙ      ㅚ      ㅛ      ㅜ      ㅝ      ㅞ      
             0x3157, 0x3158, 0x3159, 0x315a, 0x315b, 0x315c, 0x315d, 0x315e,
           # ㅟ      ㅠ      ㅡ      ㅢ      ㅣ
             0x315f, 0x3160, 0x3161, 0x3162, 0x3163]

            # ㄱ      ㄲ      ㄳ      ㄴ      ㄵ      ㄶ      ㄷ      ㄹ
JONGSUNG  = [ 0,      0x3131, 0x3132, 0x3133, 0x3134, 0x3135, 0x3136, 0x3137,
            # ㄺ      ㄻ      ㄼ      ㄽ      ㄾ      ㄿ      ㅀ      ㅁ
              0x3139, 0x313a, 0x313b, 0x313c, 0x313d, 0x313e, 0x313f, 0x3140,
            # ㅂ      ㅄ      ㅅ      ㅆ      ㅇ      ㅈ      ㅊ      ㅋ      
              0x3141, 0x3142, 0x3144, 0x3145, 0x3146, 0x3147, 0x3148, 0x314a,
            # ㅌ      ㅍ      ㅎ      ?whoops
              0x314b, 0x314c, 0x314d, 0x314e ]


# Not wrapping this in a module... not sure if that's a terrible idea

class String
  def split_ko

    raw_chars = self.unpack("U*")

    final_result = Array.new

    raw_chars.each do |char|
      result = Array.new
      if (char >= 0xAC00 && char <= 0xD7A3)
        # Move it down in the range
        c = char - 0xAC00;

        # Here be dragons
        a = c.to_f / (21 * 28)
        c = c      % (21 * 28)
        b = c.to_f / 28
        c = c      % 28

        a = a.to_i
        b = b.to_i
        c = c.to_i

        result.push( CHOSUNG[a], JWUNGSUNG[b] )

        if c != 0
          result.push( JONGSUNG[c] )
        end
      else
        result.push(char)
      end

      final_result.push(result.pack("U*").split(''))
    end

    return final_result

  end
end


class Array
  # We've got our sploded array of korean bits
  # need to put them back into Real Words
  def join_ko
    # http://www.w3c.or.kr/i18n/hangul-i18n/ko-code.html
    # Leading, middle, following (optional)
    a = self[0].unpack("U*").first
    b = self[1].unpack("U*").first
    c = self[2].unpack("U*").first if self[2]

    offset_a = CHOSUNG.index(a)
    if offset_a.nil?
      raise
    end
    offset_b = JWUNGSUNG.index(b)
    if offset_b.nil?
      raise
    end

    offset_c = 0
    if c
      offset_c = JONGSUNG.index(c)
      if offset_c.nil?
        raise
      end
    end

    raw = 0xAC00 +
      offset_a * (21 * 28) +
      offset_b * 28 +
      offset_c

    [ raw ].pack("U*")
  end
end

