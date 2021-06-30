require 'rails_helper'

RSpec.describe Micropost, type: :model do
  before do
    @user = create(:user)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
    create(:orange,user_id: @user.id)
    create(:apple,user_id: @user.id)
    create(:run,user_id: @user.id)
    @most_recent = create(:most_recent,user_id: @user.id)
  end


  it '有効化どうか' do
    expect(@micropost.valid?).to eq true
  end

  it 'user idがないとエラー' do
    @micropost.user_id = nil
    expect(@micropost.valid?).to eq false
  end

  it 'contentがないとエラー' do
    @micropost.content = " "
    expect(@micropost.valid?).to eq false
  end

  it 'contentは１４０文字以内' do
    @micropost.content = "a"*141
    expect(@micropost.valid?).to eq false
  end

  it '最新の投稿が一番上に来ているか' do
    expect(@most_recent).to eq Micropost.first
  end
end
