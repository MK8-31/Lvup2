require 'rails_helper'

describe 'users_login',type: :feature do
    before do
        @user = create(:user)
    end

    scenario '間違った情報でログイン' do
        visit login_path
        expect(page).to have_http_status(:success)
        fill_in 'session_email',with: ''
        fill_in 'session_password',with: ''
        find('input[name="commit"]').click
        expect(page).to have_current_path login_path
        expect(page).to have_css '.alert-danger'
        expect(page).to have_selector('.alert-danger',text: 'Eメール・パスワードの組み合わせが間違っています。')
    end

    scenario '正しい情報でログインその後ログアウト' do
        visit login_path
        expect(page).to have_http_status(:success)
        fill_in 'session_email',with: @user.email
        fill_in 'session_password',with: 'password'
        find('input[name="commit"]').click
        expect(page).to have_current_path user_path(@user)
        expect(page).to have_link 'Log in',href: login_path,count: 0
        expect(page).to have_link 'Log out',href: logout_path
        expect(page).to have_link 'Profile',href: user_path(@user)
        click_link 'Log out'
        expect(page).to have_current_path root_path
        expect(page).to have_link 'Log in',href: login_path
        expect(page).to have_link 'Log out',href: logout_path,count: 0
    end

end