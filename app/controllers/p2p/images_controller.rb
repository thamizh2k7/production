class P2p::ImagesController < ApplicationController

	def destroy
		begin
			img = P2p::Image.find(params[:id])
		rescue
			render :json => {:status => "0"}
			return
		end
		
		img.img = nil
		img.destroy

		render :json => {:status => "1"}

	end
end
