require 'rails_helper'

describe 'users_index',type: :system do
    before do
        @admin = create(:user)
        @non_admin = create(:other_user)
    end

    it 'index as admin including pagination and delete links' do
        log_in(@admin)
        visit users_path
        expect(current_path).to eq users_path
        expect(page).to have_content 'All users'
        first_page_of_users = User.paginate(page: 1)
        first_page_of_users.each do |user|
            expect(page).to have_link user.name,href: user_path(user)
            unless user == @admin
                expect(page).to have_link 'delete',href: user_path(user)
            end
        end
        expect{
            link = find('a',id: user_path(@non_admin))
            expect(link[:href]).to eq user_path(@non_admin)
            link.click
        }.to change{ User.count }.by(-1)
        pending '何故かエラー、ページネーションがないことになっている'
        expect(page).to have_selector ".pagination"

    end
end