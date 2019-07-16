require 'csv'
require './module/total_score'

class StatTracker

  include TotalScore

  def self.from_csv(files)
    data = {}
    files.each { |key, val| data[key] = CSV.table(val) }
    data
  end

end
