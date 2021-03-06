class UsersController < ApplicationController
  # 14.25 before_action :logged_in_user, only: [:index, :edit, :update, :destroy] # 10.15 # Index en 10.35 # destroy 10.58
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers] # 14.25
  before_action :correct_user,   only: [:edit, :update] # 10.25
  before_action :admin_user,     only: :destroy

  def index
    #@users = User.all
    #@users = User.paginate(page: params[:page])
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      #log_in @user
      #flash[:success] = "Bienvenido a la App de Ejemplo!"
      #redirect_to @user
      #ESTO TB EQUIVALE redirect_to user_url(@user)
      # Hasta aqui version sin activacion por mail
      #UserMailer.account_activation(@user).deliver_now
      @user.send_activation_email
      flash[:info] = "Por favor verifique su email para activar su cuenta."
      redirect_to root_url
    else
      render 'new'
    end
  end
  def edit
    ############# 10.25
    @user = User.find(params[:id])
  end

  def update
    ############# 10.25
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Perfil actualizado"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuario borrado"
    redirect_to users_url
  end

  def following ### 14.25
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end ### 14.25

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    # Before filters
    
    # Confirms a logged-in user.
# 13.33    def logged_in_user
# 13.33      unless logged_in?
# 13.33        store_location # 10.31
# 13.33        flash[:danger] = "Por favor haga log in."
# 13.33        redirect_to login_url
# 13.33      end
# 13.33    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      # 10.28 redirect_to(root_url) unless @user == current_user
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
