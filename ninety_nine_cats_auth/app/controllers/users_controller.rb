class UsersController < ApplicationController

    # before_action :require_logged_out, only: [:new, :create]
    # before_action :require_logged_in, only: [:index, :show]

    def index
        @users = User.all
        render :index
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    def new
        # debugger
        @user = User.new
        # debugger
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            login!(@user)
            redirect_to user_url
        else
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        user = User.find(params[:id])

        if user.update(user_params)
            redirect_to new_user
        else
            render json: user.errors.full_messages, status: 422
        end
    end

    def destroy
        user = User.find(params[:id])
  
        user.destroy
        redirect_to users_url 
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end