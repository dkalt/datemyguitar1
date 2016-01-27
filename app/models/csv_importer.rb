# CsvImporter.import("some_file")
#
# importer = CsvImporter.new("some_file")
# importer.import
#
# CsvImporter.new("some_file").import

class CsvImporter
  def initialize(filename)
    @filename = filename
  end

  def import
    SmarterCSV.process(@filename).each do |row|
      Guitar.create(row)
    end
  end
end
