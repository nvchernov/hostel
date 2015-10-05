class HotelsController < ApplicationController
  before_action :set_hotel, only: [:show, :edit, :update, :destroy, :index_form]

  # GET /hotels
  # GET /hotels.json
  def index
    @countries = Country.all
    @regions = @countries.length == 0 ? Region.all : Region.where(:country_id => @countries.first.id)
    @cities = @regions.length == 0 ? City.all : City.where(:region_id => @regions.first.id)
    @hotels = Hotel.all
  end

  # GET /hotels/1
  # GET /hotels/1.json
  def show
  end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
    @regions = Region.all
    @cities = @regions.length == 0 ? City.all : City.where(:region_id => @regions.first.id)
  end

  # GET /hotels/1/edit
  def edit
    @regions = Region.all
    @cities = @regions.length == 0 ? City.all : City.where(:region_id => @regions.first.id)
  end

  # POST /hotels
  # POST /hotels.json
  def create
    @hotel = Hotel.new(hotel_params)

    respond_to do |format|
      if @hotel.save
        format.html { redirect_to @hotel, notice: 'Hotel was successfully created.' }
        format.json { render :show, status: :created, location: @hotel }
      else
        format.html { render :new }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hotels/1
  # PATCH/PUT /hotels/1.json
  def update
    respond_to do |format|
      if @hotel.update(hotel_params)
        format.html { redirect_to @hotel, notice: 'Hotel was successfully updated.' }
        format.json { render :show, status: :ok, location: @hotel }
      else
        format.html { render :edit }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def destroy
    @hotel.destroy
    respond_to do |format|
      format.html { redirect_to hotels_url, notice: 'Hotel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def index_form
    if !params[:hotel_country_id].nil? && params[:hotel_region_id].nil? && params[:hotel_city_id].nil?
      @regions = Region.where(:country_id => params[:hotel_country_id]).select(:id, :name)
      @cities = City.where(:region_id => @regions.collect { |p| p.id }).select(:id, :name)
      @hotels = Hotel.where(:city_id => @cities.collect { |p| p.id }).select(:id, :name)
      render json:{
                 :regions => ['id' => '-', 'name' => '-'] + @regions,
                 :cities  => ['id' => '-', 'name' => '-'] + @cities,
                 :hotels => @hotels
             }
    elsif !params[:hotel_country_id].nil? && !params[:hotel_region_id].nil? && params[:hotel_city_id].nil?
      @cities = City.where(:region_id => params[:hotel_region_id])
      @hotels = Hotel.where(:city_id => @cities.collect { |p| p.id }).select(:id, :name)
      render json:{
                 :cities  => ['id' => '-', 'name' => '-'] + @cities,
                 :hotels => @hotels}
    elsif params[:hotel_country_id].nil? && params[:hotel_region_id].nil? && params[:hotel_city_id].nil?
      @regions = Region.all
      @cities = City.all
      @hotels = Hotel.all
      render json:{
                 :regions => ['id' => '-', 'name' => '-'] + @regions,
                 :cities  => ['id' => '-', 'name' => '-'] + @cities,
                 :hotels => @hotels
             }
    elsif !params[:hotel_city_id].nil?
      @hotels = Hotel.where(:city_id => params[:hotel_city_id])
      render json:{:hotels => @hotels}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hotel
      if !params[:id].nil?
        @hotel = Hotel.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hotel_params
      params.require(:hotel).permit(:name, :region_id, :city_id)
    end
end
