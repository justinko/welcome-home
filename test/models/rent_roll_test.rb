require "test_helper"

class RentRollTest < ActiveSupport::TestCase
  test "report" do
    assert_includes RentRoll.new.report.to_s, "John Smith"
  end

  test "statistics" do
    assert_equal({vacant: 5, occupied: 3, leased: 2}, RentRoll.new.statistics)
  end

  test "units with the current date" do
    units = RentRoll.new.units

    assert_equal Unit.count, units.count("*")
    assert_equal 1, units.first.number
    assert_equal "John Smith", units.first.resident_name
    assert_equal "current", units.first.resident_status
    assert_equal "Sarah", units.second.resident_name
    assert_equal "current", units.second.resident_status
    assert_equal "Teddy", units.fifth.resident_name
    assert_nil units.fifth.resident_status
    assert_equal 12, units.last.number
    assert_nil units.last.resident_name
  end

  test "units with a date between a resident's move" do
    units = RentRoll.new("2020-01-01").units

    assert_equal "Sally Carol", units.first.resident_name
    assert_equal "Sarah", units.second.resident_name
    assert_equal "future", units.second.resident_status
    assert_equal "Teddy", units.fifth.resident_name
    assert_nil units.fifth.resident_status
  end

  test "units with a date before all resident moves" do
    units = RentRoll.new("2000-01-01").units

    assert_equal "Sally Carol", units.first.resident_name
    assert_equal "Sarah", units.second.resident_name
    assert_equal "future", units.second.resident_status
    assert_equal "Teddy", units.fifth.resident_name
    assert_nil units.fifth.resident_status
  end
end
