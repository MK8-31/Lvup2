require 'rails_helper'

describe 'following test',type: :system do
    before do
        @user = create(:user)
        @other_user = create(:other_user)
        @archer = create(:archer)
        @lana = create(:lana)
        log_in(@user)
        @user.active_relationships.create!(followed_id: @other_user.id)
        @other_user.active_relationships.create!(followed_id: @user.id)
        @user.active_relationships.create!(followed_id: @archer.id)
        @archer.active_relationships.create!(followed_id: @user.id)

    end

    it "following page" do
        visit following_user_path(@user)
        expect(@user.following.empty?).to eq false
        expect(current_path).to eq following_user_path(@user)
        expect(page).to have_content @user.following.count.to_s
        @user.following.each do |user|
            expect(page).to have_link user.name,href: user_path(user)
        end
    end

    it 'followers page' do
        visit followers_user_path(@user)
        expect(@user.followers.empty?).to eq false
        expect(page).to have_content @user.followers.count.to_s
        @user.followers.each do |user|
            expect(page).to have_link user.name,href: user_path(user)
        end
    end

    it "フォロー" do
        expect{
            visit user_path(@lana)
            find('input[name="commit"]').click
        }.to change{@user.following.count}.by(1)
    end

    it "フォロー解除" do
        @user.follow(@lana)
        expect{
            visit user_path(@lana)
            find('input[name="commit"]').click
        }.to change{@user.following.count}.by(-1)

    end
end