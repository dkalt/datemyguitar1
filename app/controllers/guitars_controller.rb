class GuitarsController < ApplicationController

    PER_PAGE = 60


      before_filter :authenticate

      def authenticate
        authenticate_or_request_with_http_basic('Administration') do |username, password|
          username == 'admin' && password == '123'
        end
      end

    def index
      page_number = params[:page] ? params[:page].to_i : 1
      guitars_offset = PER_PAGE * (page_number - 1)
      @guitars   = Guitar.limit(PER_PAGE).offset(guitars_offset)
      @next_page  = page_number + 1 if @guitars.count == PER_PAGE
    end
  # [END index]

    # [START new_and_edit]
    def new
      @guitar = Guitar.new
      # render template: "new"
    end

    def edit
      @guitar = Guitar.find params[:id]
      @listings = get_reverb_listings(@guitar)
    end
    # [END new_and_edit]

    # [START show]
    def show
      @guitar = Guitar.find params[:id]
    end
    # [END show]

    # [START destroy]
    def destroy
      @guitar = Guitar.find params[:id]
      @guitar.destroy
      redirect_to guitars_path
    end
    # [END destroy]

    # [START update]
    def update
      @guitar = Guitar.find params[:id]

      if @guitar.update guitar_params
        flash[:success] = "Updated guitar"
        redirect_to guitars_path(@guitar)
      else
        render :edit
      end
    end
    # [END update]

    # [START create]
    def create
      @guitar = Guitar.new guitar_params

      if @guitar.save
        flash[:success] = "Added guitar"
        redirect_to guitars_path(@guitar)
      else
        render :new
      end
    end

    def search
      @guitar = Guitar.search(params[:make], params[:query]).first
      @listings = get_reverb_listings(@guitar)
    end

    private

    def guitar_params
      params.require(:guitar).permit(:make, :model, :description, :serial_range_start, :serial_range_end, :month,:year)
    end

    def get_reverb_listings(guitar)
      return [] unless guitar.present?
      # Fuzzy way
      # query = "#{@guitar.make} #{@guitar.model} #{@guitar.year}"
      # url = URI.escape("https://reverb.com/api/listings?query=#{query}&per_page=20")
      # Sturcutred way
      url = URI.escape("https://reverb.com/api/listings?make=#{guitar.make}&model=#{guitar.model}&year=#{guitar.year}&per_page=15")
      response = HTTParty.get(url)
      parsed_json = JSON.parse(response)
      parsed_json["listings"]
    end
    # [END create]
end
