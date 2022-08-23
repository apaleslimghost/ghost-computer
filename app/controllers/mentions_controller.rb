class MentionsController < ApplicationController
	skip_forgery_protection

	def create
		uri = URI::parse(params[:target])
		route_params = Rails.application.routes.recognize_path(uri.path)

		return unless route_params[:controller] == 'posts' && route_params[:action] == 'show'

		post = Post.find!(route_params[:id])

		Mention.find_or_create_by(post: post, source: params[:source]) do |mention|
			mention.fetch_source!
		end

		head 201
	end
end
