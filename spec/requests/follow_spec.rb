require 'rails_helper'

describe 'follow',type: :request do
    before do
        @user = create(:user)
        @other_user = create(:other_user)
        log_in_as(@user)
    end

    it '通常の方法でフォロー' do
        expect{
            post relationships_path,params: {followed_id: @other_user.id}
        }.to change{ @user.following.count }.by(1)
    end

    it 'ajaxでフォロー' do
        expect{
            post relationships_path,xhr: true,params: {followed_id: @other_user.id}
        }.to change{ @user.following.count }.by(1)
    end

    it '通常の方法でフォロー解除' do
        @user.follow(@other_user)
        relationship = @user.active_relationships.find_by(followed_id: @other_user.id)
        expect{
            delete relationship_path(relationship)
        }.to change{ @user.following.count }.by(-1)
    end
    
    it 'ajaxでフォロー解除' do
        @user.follow(@other_user)
        relationship = @user.active_relationships.find_by(followed_id: @other_user.id)
        expect{
            delete relationship_path(relationship),xhr: true
        }.to change{ @user.following.count }.by(-1)
    end
    


end