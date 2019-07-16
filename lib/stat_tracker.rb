require 'csv'

class StatTracker
  def self.from_csv(files)
    data = {}
    files.each { |key, val| data[key] = CSV.table(val) }
    data
  end
end
