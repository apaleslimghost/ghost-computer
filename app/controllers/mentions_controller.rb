class MentionsController < ApplicationController
	skip_forgery_protection

	def create
		uri = URI::parse(params[:target])
		route_params = Rails.application.routes.recognize_path(uri.path)

		return unless route_params[:controller] == 'posts' && route_params[:action] == 'show'

		post = Post.find!(route_params[:id])

		if mention = Mention.find_by(post: post, source: params[:source])
			mention.fetch_source!
		else
			Mention.create(
				post: post,
				source: params[:source]
			)
		end

		head 201
	end
end
