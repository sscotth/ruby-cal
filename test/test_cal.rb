require 'minitest/autorun'
require_relative '../cal'

class TestCal < MiniTest::Unit::TestCase
  def test_ability_to_interpret_unix_cal
    shell_output = `cal 2 2014`
    shell_output = shell_output.chomp
    expected_output = <<-EOS.gsub(/^\s+\|/,'')
      |   February 2014
      |Su Mo Tu We Th Fr Sa
      |                   1
      | 2  3  4  5  6  7  8
      | 9 10 11 12 13 14 15
      |16 17 18 19 20 21 22
      |23 24 25 26 27 28
      EOS
    assert_equal expected_output, shell_output
  end

  def test_month_in_a_non_leap_year
    shell_output = `ruby cal.rb 2 2014`
    expected_output = `cal 2 2014`
    assert_equal expected_output, shell_output
  end

  def test_month_in_a_leap_year
    shell_output = `ruby cal.rb 2 2004`
    expected_output = `cal 2 2004`
    assert_equal expected_output, shell_output
  end

  def test_month_in_a_century_leap_year
    shell_output = `ruby cal.rb 2 2000`
    expected_output = `cal 2 2000`
    assert_equal expected_output, shell_output
  end

  def test_month_in_a_century_non_leap_year
    shell_output = `ruby cal.rb 2 2100`
    expected_output = `cal 2 2100`
    assert_equal expected_output, shell_output
  end

  def test_month_with_six_weeks
    shell_output = `ruby cal.rb 3 2014`
    expected_output = `cal 3 2014`
    assert_equal expected_output, shell_output
  end

  def test_month_with_four_weeks
    shell_output = `ruby cal.rb 2 2015`
    expected_output = `cal 2 2015`
    assert_equal expected_output, shell_output
  end

  def test_current_month
    shell_output = `ruby cal.rb`
    expected_output = `cal`
    assert_equal expected_output, shell_output
  end

  def test_full_year
    shell_output = `ruby cal.rb 2014`
    expected_output = `cal 2014`
    assert_equal expected_output, shell_output
  end
end
