require 'rails_helper'

feature 'users_signup', type: :feature do
    before do
        ActionMailer::Base.deliveries.clear
    end

    scenario 'ユーザー登録成功とアカウント有効化' do
        visit signup_path
        expect(page).to have_content('ユーザー登録')

        fill_in 'user_name',with: 'testuser'
        fill_in 'user_email',with: 'test@example.com'
        fill_in 'user_password',with: 'foobar'
        fill_in 'user_password_confirmation',with: 'foobar'
        find('input[name="commit"]').click
        expect(ActionMailer::Base.deliveries.size).to eq 1
        # user = assigns(:user)
        # expect(user.activated?).to eq false
        # #有効化してない状態でログイン
        # log_in(user)
        # expect(logged_in?).to eq false
        #有効化トークンが不正の場合->requests spec

        #トークンは正しいがメールアドレスが無効->requests spec
        


        # expect(page).to have_content('testuser')
    end

    scenario 'ユーザー登録失敗' do
        visit signup_path
        expect(page).to have_content('ユーザー登録')

        fill_in 'user_name',with: ''
        fill_in 'user_email',with: 'test@example'
        fill_in 'user_password',with: 'bar'
        fill_in 'user_password_confirmation',with: 'foo'
        find('input[name="commit"]').click

        expect(page).to have_content('ユーザー登録')
        expect(page).to have_css '.alert-danger'
        expect(page).to have_css '#error_explanation'
    end
end