require 'rails_helper'

describe 'like',type: :request do
    before do
        @user = create(:user)
        @other_user = create(:other_user)
        log_in_as(@user)
        @micropost = @other_user.microposts.create!(content: "hello!")
    end

    it '通常の方法でいいね' do
        expect{
            post likes_path,params: {micropost_id: @micropost.id}
        }.to change{ @user.likes.count }.by(1)
    end

    it 'ajaxでいいね' do
        expect{
            post likes_path,xhr: true,params: {micropost_id: @micropost.id}
        }.to change{ @user.likes.count }.by(1)
    end

    it '通常の方法でいいね解除' do
        post likes_path,params: {micropost_id: @micropost.id}

        like = @user.likes.find_by(micropost_id: @micropost.id)
        expect{
            delete like_path(like)
        }.to change{ @user.likes.count }.by(-1)
    end
    
    it 'ajaxでいいね解除' do
        post likes_path,xhr: true,params: {micropost_id: @micropost.id}
        like = @user.likes.find_by(micropost_id: @micropost.id)
        expect{
            delete like_path(like),xhr: true
        }.to change{ @user.likes.count }.by(-1)
    end
    


end