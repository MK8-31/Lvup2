require 'rails_helper'

feature 'users_signup', type: :feature do
    scenario 'ユーザー登録成功' do
        visit signup_path
        expect(page).to have_content('ユーザー登録')

        fill_in 'user_name',with: 'testuser'
        fill_in 'user_email',with: 'test@example.com'
        fill_in 'user_password',with: 'foobar'
        fill_in 'user_password_confirmation',with: 'foobar'
        find('input[name="commit"]').click

        expect(page).to have_content('testuser')
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