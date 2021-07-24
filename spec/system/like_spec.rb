require 'rails_helper'

describe 'like test',type: :system do
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
        @lana.microposts.create!(content: "hello!")

    end



    it "いいね" do
        expect{
            visit user_path(@lana)
            click_on 'like'
        }.to change{@user.likes.count}.by(1)
    end

    it "いいね解除" do
        visit user_path(@lana)
        click_on 'like'
        expect{
            visit user_path(@lana)
            click_on 'like'
            @user.reload
        }.to change{@user.likes.count}.by(-1)

    end
end