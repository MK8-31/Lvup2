require 'rails_helper'

RSpec.describe "Professions", type: :request do

  before do
    @user = create(:user)
    @user.create_profession!(profession: 0)
  end

  it 'ログインしないでeditにアクセスするとリダイレクト' do
    get edit_profession_path(@user.profession)
    expect(response).to redirect_to login_url
  end

  it 'ログインしないでupdateにアクセスするとリダイレクト' do
    patch profession_path(@user.profession),params: {profession: {profession: 0 } }
    expect(response).to redirect_to login_url
  end

  it '0~2を送ると更新される' do
    log_in_as(@user)
    patch profession_path(@user.profession),params: {profession: {profession: 2 } }
    expect(response).to redirect_to @user
    @user.reload
    expect(@user.profession.profession).to eq 2
  end


  it '0~2以外を送るとエラー' do
    log_in_as(@user)
    patch profession_path(@user.profession),params: {profession: {profession: 4 } }
    expect(@user.reload.profession.profession).to eq 0
  end


end
