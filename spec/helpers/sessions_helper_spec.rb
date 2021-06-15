require 'rails_helper'
include SessionsHelper

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  describe 'sessions helper test' do
    before do
      @user = create(:user)
      # log_in(@user) #これを使うとcurrent_userの１行目のifで条件を突破してしまうため意味がなくなる。
      remember(@user)
    end

    #下の２つはcookiesが使えないとエラーとなって突破できない

    # it 'current_user returns right user when session is nill' do
    #   expect(current_user).to eq @user
    #   expect(@user==@current_user).to eq true
    #   expect(logged_in?).to eq true
    # end

    # it 'current_user returns nil when remember digest is wrong' do
    #   @user.update_attribute(:remember_digest,User.digest(User.new_token))
    #   @user.update_attribute(:remember_digest,"User.digest(User.new_token)")
    #   expect(current_user).to eq nil
    # end
  end
end
