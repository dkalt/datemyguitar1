class MakersController < ApplicationController

  PER_PAGE = 20
  def index
    page_number = params[:page] ? params[:page].to_i : 1
    guitars_offset = PER_PAGE * (page_number - 1)
    @makers  = Guitar.limit(PER_PAGE).offset(guitars_offset)
    @next_page  = page_number + 1 if @makers.count == PER_PAGE
  end
  # [END index]

  # [START new_and_edit]
  def new
    @maker = Maker.new
    # render template: "new"
  end

  def edit
    @maker = Maker.find params[:id]
  end
  # [END new_and_edit]

  # [START show]
  def show
    @maker = Maker.find params[:id]
  end
  # [END show]

  # [START destroy]
  def destroy
    @maker = Maker.find params[:id]
    @maker.destroy
    redirect_to makers_path
  end
  # [END destroy]

  # [START update]
  def update
    @maker = Maker.find params[:id]

    if @maker.update guitar_params
      flash[:success] = "Updated guitar"
      redirect_to makers_path(@maker)
    else
      render :edit
    end
  end
  # [END update]

  # [START create]
  def create
    @maker = Maker.new guitar_params

    if @maker.save
      flash[:success] = "Added Maker"
      redirect_to guitars_path(@maker)
    else
      render :new
    end
  end

  private

  def maker_params
    params.require(:maker).permit(:maker_name, :maker_url, :maker_description)
  end



end
