module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_user!, except: :index
      before_action :set_post
      before_action :set_comment, only: %i[update destroy]

      def index
        @comments = @post.comments
      end

      def create
        @comment = @post.comments.new(comment_params)

        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def update
        if @comment.update(comment_params)
          render json: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @comment.destroy
        render json: { message: 'Comentário excluido com sucesso' }, status: :ok
      end

      private

      def set_comment
        @comment = @post.comments.find(params[:id])
      end

      def set_post
        @post = Post.find(params[:post_id])
      end

      def comment_params
        params.permit(:comment, :name)
      end
    end
  end
end
