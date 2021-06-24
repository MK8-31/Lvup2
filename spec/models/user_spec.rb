require 'rails_helper'

RSpec.describe User, type: :model do
    before do
        @user = User.new(name: "example user",email: "user@example.com",password: "foobar",password_confirmation: "foobar")
    end
    it "should be valid" do
        expect(@user.valid?).to eq true
    end

    it "name should be present" do
        @user.name = ''
        expect(@user.valid?).to eq false
    end

    it "email should be present" do
        @user.email = ''
        expect(@user.valid?).to eq false
    end

    it "name should not be too long" do
        @user.name = 'a'*51
        expect(@user.valid?).to eq false
    end

    it "email should not be too long" do
        @user.email = 'a'*244+'@example.com'
        expect(@user.valid?).to eq false
    end

    it "email validation should accept valid address" do
        valid_addresses = %w[user@example.com USER@foo.COM A_DO-eow@foo.bar.org
                                first.last@fooogo.jp bat+rat@dan.jp]
        
        valid_addresses.each do |valid_address|
            @user.email = valid_address
            expect(@user.valid?).to be_truthy, "#{valid_address.inspect} should be valid"
        end
    end

    it "email validation should reject invalid address" do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
            foo@bar_baz.com foo@bar+baz.com]

        invalid_addresses.each do |invalid_address|
            @user.email = invalid_address
            expect(@user.valid?).to be_falsey,"#{invalid_address} should be invalid"
        end
    end

    it "email address should be unique" do
        duplicate_user = @user.dup
        @user.save
        expect(duplicate_user.valid?).to eq false
    end

    it "email addresses should be saved as lower-case" do
        mixed_case_email = "Foo@ExAmpLe.CoM"
        @user.email = mixed_case_email
        @user.save
        expect(mixed_case_email.downcase).to eq @user.reload.email
    end

    it "password should be present (nonblanck)" do
        @user.password = @user.password_confirmation = " "*6
        expect(@user.valid?).to eq false
    end

    it "password should be have a minimum length" do
        @user.password = @user.password_confirmation = 'a'*5
        expect(@user.valid?).to eq false
    end

    it 'authenticate?に渡す値がnilだとエラーにならないかどうか' do
        expect(@user.authenticate?(:remember,'')).to eq false
    end
end