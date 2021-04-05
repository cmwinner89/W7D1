class UsersController < ApplicationController

    def new
        @user = User.new

        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            login!(@user)
            redirect_to user_url(@user)
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

    private

    def user_params
        params.rquire(:user).permit(:username, :password)
    end
end