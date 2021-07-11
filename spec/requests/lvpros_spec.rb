require 'rails_helper'

RSpec.describe "Lvpros", type: :request do

  before do
    @user = create(:user)
  end

  it 'ログインしないでnewにアクセスするとリダイレクト' do
    get new_lvpro_path
    expect(response).to redirect_to login_url
  end

  it 'ログインしないでcreateにアクセスするとリダイレクト' do
    post lvpros_path,params: {lvpros: {experience_point: 30 } }
    expect(response).to redirect_to login_url
  end


end
