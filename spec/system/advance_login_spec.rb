require 'rails_helper'

describe 'advanced_login',type: :system do
    describe 'cookies login' do
        before do
            @user = create(:user)
        end

        it 'cookiesを使ってログイン',focus: true do
            visit login_path
            expect(page).to have_http_status(:success)
            fill_in 'session_email',with: @user.email
            fill_in 'session_password',with: 'password'
            check 'session_remember_me'
            find('input[name="commit"]').click
            expect(page).to have_content @user.name
            expect(page).to have_content("Log out")
            expect(get_me_the_cookie('remember_token')).to_not eq nil
            # show_me_the_cookies
            expire_cookies
            # show_me_the_cookies
            visit root_path
            # pending 'Log out ではなくLog inが出てしまう(永久cookiesを使ってログインできない)'
            expect(page).to have_content "Log out"
        end
    
    end
end