require 'rails_helper'

RSpec.describe "AccountActivations", type: :request do
  describe "signup test" do
    it "アカウント有効化とサイイン" do
      get signup_path
      expect{
        post users_path, params: { user: {  name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" } }
        }.to change{ User.count }.by(1)
      expect(ActionMailer::Base.deliveries.size).to eq 1
      user = assigns(:user)
      expect(user.activated?).to eq false
      #有効化してない状態でログイン
      log_in_as(user)
      expect(user.activated?).to eq false
      expect(is_logged_in?).to eq false
    # 有効化トークンが不正な場合
      get edit_account_activation_path("invalid token", email: user.email)
      expect(is_logged_in?).to eq false
      # トークンは正しいがメールアドレスが無効な場合
      get edit_account_activation_path(user.activation_token, email: 'wrong')
      expect(is_logged_in?).to eq false
      # 有効化トークンが正しい場合
      get edit_account_activation_path(user.activation_token, email: user.email)
      expect(user.reload.activated?).to eq true
      expect(response).to redirect_to user_path(user)
      expect(is_logged_in?).to eq true
    end
  end
end
