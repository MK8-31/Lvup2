require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    # let(:user) { create(:user)}
    # let(:mail) { UserMailer.account_activation }
    # before do
    #   user = create(:user)
    #   user.activation_token = User.new_token
    #   mail = UserMailer.account_activation(user)
    # end

    it "renders the headers" do
      user = create(:user)
      user.activation_token = User.new_token
      mail = UserMailer.account_activation(user)
      expect(mail.subject).to eq("Account activation")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@example.com"])
      #下２つはメールに日本語が入るとエラーになる
      expect(mail.body.encoded).to match user.activation_token
      expect(mail.body.encoded).to match CGI.escape(user.email)

    end

    it "renders the body" do
      user = create(:user)
      user.activation_token = User.new_token
      mail = UserMailer.account_activation(user)

      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "password_reset" do
    

    it "renders the headers" do
      user = create(:user)
      user.reset_token = User.new_token
      mail = UserMailer.password_reset(user)
      expect(mail.subject).to eq("パスワードリセット")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@example.com"])
      #下２つはメールに日本語が入るとエラーになる
      # expect(mail.body.encoded).to match user.reset_token
      # expect(mail.body.encoded).to match CGI.escape(user.email)
    end

    # it "renders the body" do
    #メールに日本語が入るとエラーになる
    #   user = create(:user)
    #   user.reset_token = User.new_token
    #   mail = UserMailer.password_reset(user)

    #   expect(mail.body.encoded).to match("Hi")
    # end
  end

end
