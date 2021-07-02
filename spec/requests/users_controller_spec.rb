require 'rails_helper'

describe 'users_controller',type: :request do
    before do
        @user = create(:user)
        @other_user = create(:other_user)
    end

    it "ログインしていない状態でeditにアクセスするとリダイレクトされる" do
        get edit_user_path(@user)
        expect(response).to redirect_to login_url
    end

    it "ログインしていない状態でupdateにアクセスするとリダイレクトされる" do
        patch user_path(@user),params: {user: {name: @user.name,email: @user.email } }
        expect(response).to redirect_to login_url
    end

    it "違うユーザーでログインした状態でupdateにアクセスするとリダイレクトされる" do
        log_in_as(@other_user)
        patch user_path(@user),params: {user: {name: @user.name,email: @user.email } }
        expect(response).to redirect_to root_url
    end

    it "違うユーザーでログインした状態でeditにアクセスするとリダイレクトされる" do
        log_in_as(@other_user)
        get edit_user_path(@user)
        expect(response).to redirect_to root_url
    end

    it "ログインしないでindexにアクセスするとリダイレクトされる" do
        get users_path
        expect(response).to redirect_to login_url
    end

    it 'ログインしないでdestroyにアクセスするとリダイレクトされる' do
        expect{
            delete user_path(@user)
        }.to change{ User.count }.by(0)
        expect(response).to redirect_to login_path
    end

    it '権限なしのユーザーでログインした後、destroyにアクセスするとリダイレクトされる' do
        log_in_as(@other_user)
        expect{
            delete user_path(@user)
        }.to change{ User.count }.by(0)
        expect(response).to redirect_to root_url
    end

    it "ログインしないでfollowingに行くとリダイレクト" do
        get following_user_path(@user)
        expect(response).to redirect_to login_url
    end

    it "ログインしないでfollowersに行くとリダイレクト" do
        get followers_user_path(@user)
        expect(response).to redirect_to login_url
    end





end