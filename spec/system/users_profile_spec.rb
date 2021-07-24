require 'rails_helper'

describe 'users_profile',type: :system do
    include ApplicationHelper

    before do
        @user = create(:user)
        create(:orange,user_id: @user.id)
    end

    it 'プロファイル' do
        visit user_path(@user)
        expect(current_path).to eq user_path(@user)
        expect(page).to have_selector 'h1',text: @user.name
        expect(page).to have_selector 'h1>img.gravatar'
        expect(page).to have_content "投稿 (#{@user.microposts.count.to_s})"
        # expect(page).to have_selector '.pagination'
        @user.microposts.paginate(page: 1).each do |micropost|
            expect(page).to have_content micropost.content
        end
    end
end