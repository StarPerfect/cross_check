require './test/test_helper'


class TestInfoTest < Minitest::Test

  def setup
    @teams_data = CSV.read('./test/dummy_data/dummy_team_info.csv',
      headers: true,
      header_converters: :symbol)

    @team_info = @teams_data.map {|row| TeamInfo.new(row)}

    @row_1 = @team_info[0]
  end

  def test_it_exists
    assert_instance_of TeamInfo, @row_1
  end

  def test_it_reads_all_data
    assert_equal 33, @team_info.length
  end

  def test_attributes
    assert_equal "NJD", @row_1.abbreviation
    assert_equal '23', @row_1.franchise_id
    assert_equal "/api/v1/teams/1", @row_1.link
    assert_equal "New Jersey", @row_1.short_name
    assert_equal '1', @row_1.team_id
    assert_equal "Devils", @row_1.team_name
  end

end
