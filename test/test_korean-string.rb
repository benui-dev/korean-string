require 'helper'

class TestKoreanString < Test::Unit::TestCase

  def test_split
    assert_equal(
      [["ㅇ", "ㅏ", "ㄴ"],
       ["ㄴ", "ㅕ", "ㅇ"],
       ["ㅎ", "ㅏ"],
       ["ㅅ", "ㅔ"],
       ["ㅇ", "ㅛ"]],
      '안녕하세요'.split_ko
    )

    assert_equal(
      [["ㅇ", "ㅣ", "ㄺ"], ["ㅇ", "ㅓ"], ["ㅅ", "ㅣ", "ㅍ"]],
      '읽어싶'.split_ko
    )

    assert_equal(
      [["ㄱ", "ㅙ", "ㄴ"], ["ㅊ", "ㅏ", "ㄶ"], ["ㅇ", "ㅏ"]],
      '괜찮아'.split_ko
    )
  end

  def test_join
    assert_equal(
      "아",
      %w(ㅇ ㅏ).join_ko
    )

    assert_equal(
      "일",
      %w(ㅇ ㅣ ㄹ).join_ko
    )
  end
end

