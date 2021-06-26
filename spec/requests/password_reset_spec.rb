require 'rails_helper'

describe 'password_reset',type: :request do
    before do
        ActionMailer::Base.deliveries.clear
        @user = create(:user)
    end

    it 'パスワードをリセット' do
        get new_password_reset_path
        expect(response).to have_http_status(200)
        #メールアドレスが無効
        post password_resets_path,params: { password_reset: { email: ""} }
        expect(response).to render_template('password_resets/new')
        #メールアドレスが有効
        post password_resets_path,params: { password_reset: { email: @user.email } }
        expect(@user.reset_digest).to_not eq @user.reload.reset_digest
        expect(ActionMailer::Base.deliveries.size).to eq 1
        expect(response).to redirect_to root_url
        #パスワード再設定フォームのテスト
        user = assigns(:user)
        #メールアドレスが無効
        get edit_password_reset_path(user.reset_token,email: "")
        expect(response).to redirect_to root_url
        #無効なユーザー
        user.toggle!(:activated)
        get edit_password_reset_path(user.reset_token, email: user.email)
        expect(response).to redirect_to root_url
        user.toggle!(:activated)
        #メールアドレスが有効で、トークンが無効
        get edit_password_reset_path('wrong token', email: user.email)
        expect(response).to redirect_to root_url
        #メールアドレスもトークンも無効
        get edit_password_reset_path(user.reset_token, email: user.email)
        expect(response).to render_template('password_resets/edit')
        #無効なパスワードとパスワード確認
        patch password_reset_path(user.reset_token),params: { email: user.email, user: { password: "foobaz",password_confirmation: "barbbb" } }
        expect(response).to render_template('password_resets/edit')
        #パスワードが空
        patch password_reset_path(user.reset_token),params: { email: user.email,user: { password: "",password_confirmation: "" } }
        expect(response).to render_template('password_resets/edit')
        #有効なパスワードとパスワード確認
        patch password_reset_path(user.reset_token),params: { email: user.email, user: { password: "foobaz",password_confirmation: "foobaz" } }
        expect(is_logged_in?).to eq true
        expect(response).to redirect_to user

    end
end