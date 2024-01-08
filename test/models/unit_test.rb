require "test_helper"

class UnitTest < ActiveSupport::TestCase
  test "rent_roll with the current date" do
    rent_roll = Unit.rent_roll

    assert_equal units.count, rent_roll.count("*")
    assert_equal 1, rent_roll.first.number
    assert_equal "John Smith", rent_roll.first.resident_name
    assert_equal "current", rent_roll.first.resident_status
    assert_equal "Sarah", rent_roll.second.resident_name
    assert_equal "current", rent_roll.second.resident_status
    assert_equal "Teddy", rent_roll.fifth.resident_name
    assert_equal "current", rent_roll.fifth.resident_status
    assert_equal 12, rent_roll.last.number
    assert_nil rent_roll.last.resident_name
  end

  test "rent_roll with a date between a resident's move" do
    rent_roll = Unit.rent_roll("2020-01-01")

    assert_equal "Sally Carol", rent_roll.first.resident_name
    assert_equal "Sarah", rent_roll.second.resident_name
    assert_equal "future", rent_roll.second.resident_status
    assert_equal "Teddy", rent_roll.fifth.resident_name
    assert_equal "current", rent_roll.fifth.resident_status
  end

  test "rent_roll with a date before all resident moves" do
    rent_roll = Unit.rent_roll("2000-01-01")

    assert_equal "Sally Carol", rent_roll.first.resident_name
    assert_equal "Sarah", rent_roll.second.resident_name
    assert_equal "future", rent_roll.second.resident_status
    assert_equal "Teddy", rent_roll.fifth.resident_name
    assert_equal "current", rent_roll.fifth.resident_status
  end
end
