class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  	@name = "KOLYA"
  	

  end

  def contact
  end
end
