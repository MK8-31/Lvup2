class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def contact
  end

  def news
  end

  def lvupeffect
    gon.user_id = current_user.id
  end
end
