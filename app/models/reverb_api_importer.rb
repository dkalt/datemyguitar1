class ReverbApiImporter
  def initialize(query)
    @query = query
  end

  def import
    # This response is a page of 24 listings along with total, links, etc
    response = HTTParty.get("https://reverb.com/api/listings?query=#{@query}")
    parsed_json = JSON.parse(response)

    # This is an array of hashes (each hash represents a listing)
    listings = parsed_json["listings"]

    listings.each do |listing|
      Guitar.create(
        brand: listing["make"],
        model: listing["model"],
        description: listing["description"]
      )
    end
  end
end
