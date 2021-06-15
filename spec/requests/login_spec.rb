require 'rails_helper'

RSpec.describe "Logins", type: :request do
  describe "session" do
    before do
      @user = create(:user)
      # get new_user_path
      # post users_path,params: {name: 'e',email: 'e@example.com',password: 'password',password_confirmation: 'password'}
    end

    it '2番目のウィンドウでログアウトをクリックするユーザーをシュミレート' do
      get login_path
      expect(response).to have_http_status(200)
      post login_path,params: {session: { email: @user.email,password: @user.password } }
      expect(response).to redirect_to user_path(@user)
      expect(is_logged_in?).to be_truthy
      delete logout_path
      expect(response).to redirect_to root_url
      delete logout_path
      expect(response).to redirect_to root_url
      
    end

    it 'login with remembering' do
      log_in_as(@user,remember_me: '1')
      expect(cookies[:remember_token].empty?).to eq false
    end

    it 'login without remembering' do
      log_in_as(@user,remember_me: '1')
      delete logout_path
      log_in_as(@user,remember_me: '0')
      expect(cookies[:remember_token].empty?).to eq true
    end
  end
end
