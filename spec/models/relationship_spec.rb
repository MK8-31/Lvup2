require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @user = create(:user)
    @other_user = create(:other_user)
    @relationship = Relationship.new(follower_id: @user.id,followed_id: @other_user.id)
  end

  it "should be valid" do
    expect(@relationship.valid?).to eq true
  end

  it "should require a follower_id" do
    @relationship.follower_id = nil
    expect(@relationship.valid?).to eq false
  end

  it "should require a followed_id" do
    @relationship.followed_id = nil
    expect(@relationship.valid?).to eq false
  end
end
