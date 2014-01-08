require 'minitest/autorun'
require_relative '../lib/cal'

class TestZellersFirstDay < MiniTest::Unit::TestCase
  def test_early_month
    first_day = Month.new(2014).first_day
    expected_output = 4
    assert_equal expected_output, first_day
  end

  def test_march_with_leap_year
    first_day = Month.new(2016,3).first_day
    expected_output = 3
    assert_equal expected_output, first_day
  end

  def test_march_without_leap_year
    first_day = Month.new(2017,3).first_day
    expected_output = 4
    assert_equal expected_output, first_day
  end

  def test_month_starting_on_saturday
    first_day = Month.new(2014,11).first_day
    expected_output = 7
    assert_equal expected_output, first_day
  end
end
