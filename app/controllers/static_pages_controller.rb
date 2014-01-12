class StaticPagesController < ApplicationController

  respond_to :html, :js

  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      respond_with @feed_items
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
