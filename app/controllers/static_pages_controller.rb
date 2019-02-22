class StaticPagesController < ApplicationController
  def home
    # 13.47 se cambia esta linea por las 2 dentro del IF @micropost = current_user.microposts.build if logged_in?
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
