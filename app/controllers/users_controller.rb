class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to @user , notice: 'プロフィールを編集しました'
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
    @follower = @user.following_users #showの部分でフォロワーの数を表示させたいためで必修ではありません。
    @followed = @user.follower_users  #showの部分でフォロワーの数を表示させたいためで必修ではありません。
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  #フォローしているユーザー
  def followings
    @user = User.find(params[:id])
    @follower = @user.following_users
  end

  #フォローされているユーザー
  def followers
    @user = User.find(params[:id])
    @followed = @user.follower_users
  end


  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
