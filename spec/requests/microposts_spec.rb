require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  describe "GET /index" do
    before do
      @user = create(:user)
      @other_user = create(:other_user)
      @micropost = create(:orange,user_id: @user.id)
    end

    it 'ログインしないでcreateに行くとリダイレクトされる' do
      expect{
        post microposts_path,params: { micropost: {content: "Lorem ipsum"}}
      }.to change{ User.count }.by(0)
      expect(response).to redirect_to login_url
    end
    
  

    it 'ログインしないでdestroyに行くとリダイレクトされる' do
      expect{
        delete micropost_path(@micropost)
      }.to change{ User.count }.by(0)
      expect(response).to redirect_to login_url
    end

    it '間違ったmicropostをdestroyするとリダイレクト' do
      log_in_as(@user)
      micropost = create(:apple,user_id: @other_user.id)
      expect{
        delete micropost_path(micropost)
      }.to change{ User.count }.by(0)
      expect(response).to redirect_to root_url
    end
    
  end
  
end

