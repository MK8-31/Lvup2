require 'rails_helper'

RSpec.describe 'users_edit',type: :system do
    before do
        @user = create(:user)
        #ログインしないとusers//editには行けないため先にログインする。
        # visit login_path
        # fill_in "session_email",with: @user.email
        # fill_in "session_password",with: @user.password
        # find('input[name="commit"]').click
    end

    it 'unsuccessful edit' do
        log_in(@user)
        visit edit_user_path(@user)
        expect(current_path).to eq edit_user_path(@user)
        fill_in "user_name",with: ""
        fill_in "user_email",with: "foo@invalid"
        fill_in "user_password",with: 'foo'
        fill_in "user_password_confirmation",with: 'bar'
        find('input[name="commit"]').click
        expect(page).to have_css(".alert-danger")
    end

    it 'successful edit with friendly forwarding' do
        visit edit_user_path(@user)
        log_in(@user)
        expect(current_path).to eq edit_user_path(@user)
        fill_in "user_name",with: "name"
        fill_in "user_email",with: "name@valid.com"
        fill_in "user_password",with: 'foobar'
        fill_in "user_password_confirmation",with: 'foobar'
        find('input[name="commit"]').click
        expect(page).to have_css(".alert-success")
        expect(current_path).to eq user_path(@user)
    end


end