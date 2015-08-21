class SessionsController < ApplicationController

  #before_action :facecontroll, only: [:new, :create]
  
  def new

  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
      sign_in user 
      redirect_back_or user # удивительное свойство Rails, что можно по объекту модели сразу отправлять на URL, вопрос в том как оно это делает ?
  	else
        flash.now[:error] = 'Invalid email/password combination'
        render 'new'
  	end
  	
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  

  private
  
  def facecontroll
    if signed_in?
      redirect_to root_url
    end 
  end



end
