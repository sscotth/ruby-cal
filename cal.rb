#!/usr/bin/env ruby

class Month
  attr_accessor :month
  attr_accessor :year

  MONTHNAMES = %w(nil January February March April May June July August September October November December)
  ABBR_DAYNAMES = %w(Su Mo Tu We Th Fr Sa)
  COMMON_YEAR_DAYS_IN_MONTH = [nil,31,28,31,30,31,30,31,31,30,31,30,31]

  def initialize(*args)
    @year = args[0] ||= Time.now.year
    @month = args[1] ||= 1
  end

  def leap?
    year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  end

  def first_day
    z_year = (month == 1 || month == 2) ? (year - 1) : year
    z_month = (month == 1 || month == 2) ? (month + 12) : month
    day_of_week = (1 + ((z_month+1) * 26/10).floor + z_year + (z_year/4).floor + 6 * (z_year/100).floor + (z_year/400).floor) % 7
    day_of_week == 0 ? 7 : day_of_week
  end

  def days_in_month
     return 29 if month == 2 && leap?
     COMMON_YEAR_DAYS_IN_MONTH[month]
  end

  def to_a(number_format = '%02s')
    array = Array.new(42,'  ')
    index = first_day - 1
    array[index..index+days_in_month-1] = (1..days_in_month).map{|num| sprintf(number_format, num)}
    array.each_slice(7).to_a.map{|w| w.join(' ')}
  end

  def to_s(format = 'month')
    if format == 'year'
      calendars = []
      (1..12).step(3).each do |m|
        calendars << Month.new(year,m).to_cal.zip(Month.new(year,m+1).to_cal,Month.new(year,m+2).to_cal).map{|line| line.join('  ')}
      end
      [
        "#{year}".center(63),
        '',
        calendars
      ].flatten.map(&:rstrip).map.with_index{|line,i| i < 3 ? line : sprintf('%0-44s', line)}
    else
      to_cal('with_year').map(&:rstrip)
    end
  end

  def to_cal(format = 'default')
    add_year = " #{year}" if format == 'with_year'
    [
      "#{MONTHNAMES[month]}#{add_year}".center(20),
        ABBR_DAYNAMES.join(' '),
        to_a
    ].flatten
  end
end

if ARGV.length == 1
  year = ARGV[0].to_i
  puts Month.new(year).to_s('year')
elsif ARGV.length == 2
  month = ARGV[0].to_i
  year = ARGV[1].to_i
  puts Month.new(year,month).to_s
else
  month = Time.now.month
  year = Time.now.year
  puts Month.new(year,month).to_s
end
