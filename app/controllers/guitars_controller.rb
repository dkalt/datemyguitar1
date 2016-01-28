class GuitarsController < ApplicationController

    PER_PAGE = 20

    def index
      page_number = params[:page] ? params[:page].to_i : 1
      guitars_offset = PER_PAGE * (page_number - 1)
      @guitars   = Guitar.limit(PER_PAGE).offset(guitars_offset)
      @next_page  = page_number + 1 if @guitars.count == PER_PAGE
      render :index
    end
  # [END index]

    # [START new_and_edit]
    def new
      @guitar = Guitar.new
      # render template: "new"
    end

    def edit
      @guitar = Guitar.find params[:id]
      # Fuzzy way
      # query = "#{@guitar.make} #{@guitar.model} #{@guitar.year}"
      # url = URI.escape("https://reverb.com/api/listings?query=#{query}&per_page=20")
      # Sturcutred way
      url = URI.escape("https://reverb.com/api/listings?make=#{@guitar.make}&model=#{@guitar.model}&per_page=20")
      response = HTTParty.get(url)
      parsed_json = JSON.parse(response)
      @listings = parsed_json["listings"]
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
    @guitars = Guitar.search params[:query]
    render 'index'
  end

    private

    def guitar_params
      params.require(:guitar).permit(:make, :model, :description, :serial_range_start, :serial_range_end, :month,:year)
    end
    # [END create]



end
