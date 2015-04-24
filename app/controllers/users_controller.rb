class UsersController < ApplicationController
 before_action :set_user, only: [:show, :edit, :update, :destroy]
 before_action :change_user, only: [:edit, :update, :destroy]

 # GET /users
 # GET /users.json
 def index
   @users = User.all
   @hash = Gmaps4rails.build_markers(@users) do |user, marker|
     marker.lat(current_user.latitude)
     marker.lng(current_user.longitude)
   end
 end

 # GET /users/1
 # GET /users/1.json
 def show
   @corrals = Corral.near([current_user.current_latitude, current_user.current_longitude], 1, units: :km)
   @corrals_to_view = @corrals.limit(50).page(params[:page]).per_page(10)

   @hash = Gmaps4rails.build_markers(@user) do |user, marker|
     marker.lat(current_user.current_latitude)
     marker.lng(current_user.current_longitude)
   end
   @hash_two = Gmaps4rails.build_markers(@corrals) do |corral, marker|
     marker.lat(corral.latitude)
     marker.lng(corral.longitude)
     marker.infowindow corral.location
     marker.picture({
       "url" => "http://www.edmonton.ca/activities_parks_recreation/documents/Logos/icon_bike_32x32.png",
       "width" => 50,
       "height" => 50
       })
   end
 end

 def edit
 end

 # GET /users/new
 def new
 end

 # POST /users
 # POST /users.json
 def create
   @user = User.new(user_params)
   respond_to do |format|
     if @user.save
       session[:user_id] = user.id
       user.update!(user_location_params)
       flash[:success] = 'Your profile was created successfully!'
       flash[:success] = 'Welcome to Rackit!'
       format.html { redirect_to root_url }
       format.json { render :show, status: :created, location: @user }
     else
       format.html { render :new }
       format.json { render json: @user.errors, status: :unprocessable_entity }
     end
   end
 end

 # PATCH/PUT /users/1
 # PATCH/PUT /users/1.json
 def update
   respond_to do |format|
     if @user.update(user_params)
       flash[:success] = "Your profile was successfully updated."
       format.html { redirect_to @user}
       format.json { render :show, status: :ok, location: @user }
     else
       format.html { render :edit }
       format.json { render json: @user.errors, status: :unprocessable_entity }
     end
   end
 end

 # DELETE /users/1
 # DELETE /users/1.json
 def destroy
   @user.destroy
   respond_to do |format|
     format.html { redirect_to users_url, success: 'Your account has been successfully deleted.' }
     format.json { head :no_content }
   end
 end

 private
 # Use callbacks to share common setup or constraints between actions.
 def set_user
   @user = User.find(params[:id])
 end

 def change_user
   if current_user != set_user
     flash[:danger] = "Sorry, you cant #{params[:action]} this user. Click this message to close it"
     redirect_to set_user
   end
 end

 # Never trust parameters from the scary internet, only allow the white list through.
 def user_params
   params.require(:user).permit(:id, :name, :bio, :email, :location, :image_url, :provider, :uid)
 end
end
