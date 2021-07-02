require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  
  it 'createはログインしたユーザーを要求する' do
    expect{
      post relationships_path
    }.to change{ Relationship.count }.by(0)
    expect(response).to redirect_to login_url
  end
    
  it 'destroyはログインしたユーザーを要求する' do
    expect{
      delete relationship_path(1)
    }.to change{ Relationship.count }.by(0)
    expect(response).to redirect_to login_url
  end
  

end
