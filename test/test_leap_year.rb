require 'minitest/autorun'
require_relative '../cal'

class TestLeapYear < MiniTest::Unit::TestCase
  def test_basic_leap_year
    leap = Month.new(2016).leap?
    expected_output = true
    assert_equal expected_output, leap
  end

  def test_leap_century
    leap = Month.new(2000).leap?
    expected_output = true
    assert_equal expected_output, leap
  end

  def test_nonleap_century
    leap = Month.new(1900).leap?
    expected_output = false
    assert_equal expected_output, leap
  end

end
