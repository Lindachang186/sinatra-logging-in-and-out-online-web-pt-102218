class Helpers < ActiveRecord::Base

  def self.current_user(session)
    @user = User.find_by(id: session[:user_id])
  end

  def self.is_logged_in?(session)
    if @user
      true 
    end
  end

end
