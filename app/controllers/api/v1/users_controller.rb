module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!, except: %i[index show]
      before_action :set_user, only: %i[show update destroy]

      def index
        @users = User.all
      end

      def show; end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
        render json: { message: 'Usuario excluido com sucesso' }, status: :ok
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end
