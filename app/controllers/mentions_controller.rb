class MentionsController < ApplicationController
	skip_forgery_protection

	def create
		uri = URI::parse(params[:target])
		route_params = Rails.application.routes.recognize_path(uri.path)

		return unless route_params[:controller] == 'posts' && route_params[:action] == 'show'

		Mention.create(
			post: Post.find(route_params[:id]),
			source: params[:source]
		)

		head 201
	end
end
