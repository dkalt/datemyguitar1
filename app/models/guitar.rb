class Guitar < ActiveRecord::Base

  def self.search(query)
    where("serial_num LIKE '%#{query}%'")
  end
  
end
