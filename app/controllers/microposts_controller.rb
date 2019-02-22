class MicropostsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy # Agregado en 13.52

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = [] # 13.50
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy # En 13.52
    flash[:success] = "Micropost deleted" # En 13.52
    # Cambiada por EJERCICIO 2 13.3.4... redirect_to request.referrer || root_url # En 13.52
    redirect_back(fallback_location: root_url)
  end

  private

    def micropost_params
      #params.require(:micropost).permit(:content)
      params.require(:micropost).permit(:content, :picture) # 13.61
    end

    def correct_user # En 13.52
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
