class ArticlesController < ApplicationController
	def list
		if current_user
		     @user_id = current_user.id
		else
		    redirect_to new_user_session_path, notice: 'You are not logged in.'
		end
	end
end
