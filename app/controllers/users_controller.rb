class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,:following,:followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    if @user.profession.profession == 0
      @profession = "剣士"
    elsif @user.profession.profession == 1
      @profession = "魔法使い"
    elsif @user.profession.profession == 2
      @profession = "弓士"
    end
    @star = Lvpro.order(created_at: :desc).find_by(user_id: @user.id,profession: @user.profession.profession).star
    @lv = Lvpro.order(created_at: :desc).find_by(user_id: @user.id,profession: @user.profession.profession).experience_point/100+1
    @ex = Lvpro.order(created_at: :desc).find_by(user_id: @user.id,profession: @user.profession.profession).experience_point%100
    @data0 = @user.lvpros.where(profession: 0).last
    @data1 = @user.lvpros.where(profession: 1).last
    @data2 = @user.lvpros.where(profession: 2).last
    @data_ex = [["剣士", @data0.experience_point],["魔法使い",@data1.experience_point],["弓士",@data2.experience_point]]
    @data_lv = [["剣士", @data0.lv],["魔法使い",@data1.lv],["弓士",@data2.lv]]

  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "アカウント有効化メールをお送りしました。ご確認ください。"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def likes
    @title = "Likes"
    @user  = User.find(params[:id])
    @microposts = @user.likes.paginate(page: params[:page])
    render 'show_like'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # beforeアクション

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end