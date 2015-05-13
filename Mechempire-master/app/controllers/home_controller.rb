class HomeController < ApplicationController
  before_action :admin_user, only: [:stat]
  def index
  end

  def about
  end

  def aboutus
    
  end

  def join
    
  end

  def achieve
    
  end

  def gamebg
  end

  def newer
  end
  
  def download
  end

  def wonderful
  end

  def stat
  end

  def opensource
  end

  def vedio
    @id = params[:id]
  end

  def wondervedio
    id = params[:id]
    if FileTest::exist?("battle/previous/#{id}.txt")
      send_file "battle/previous/#{id}.txt", :type => 'application/txt'
    else
      render 'public/404.html'
    end
  end
end
