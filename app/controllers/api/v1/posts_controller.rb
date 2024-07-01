module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_user!, except: %i[index show]
      before_action :set_post, only: %i[show update destroy]

      def index
        @posts = Post.all
      end

      def show; end

      def create
        @post = Post.new(post_params)
        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def update
        if @post.update(post_params)
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @post.destroy
        render json: { message: 'Post excluido com sucesso' }, status: :ok
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.permit(:text, :title, :user_id)
      end
    end
  end
end
