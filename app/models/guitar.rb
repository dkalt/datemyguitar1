class Guitar < ActiveRecord::Base

  def self.search(make, query)
    where("make like :make AND :query >= serial_range_start AND :query <= serial_range_end", make: make, query: query)
  end

end
