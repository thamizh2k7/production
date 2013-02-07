class P2p::ImagesController < ApplicationController

	def destroy
		img = P2p::Image.find(params[:id])
		img.img = nil
		img.destroy

		render :json => {:status => "1"}

	end
end
