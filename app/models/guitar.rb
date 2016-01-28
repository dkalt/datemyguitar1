class Guitar < ActiveRecord::Base

  def self.search(query)
    # FIXME 
    where("serial_range_start LIKE '%#{query}%'")
  end

end
