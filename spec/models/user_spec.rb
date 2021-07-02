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

    it 'authenticated?に渡す値がnilだとエラーにならないかどうか' do
        expect(@user.authenticated?(:remember,'')).to eq false
    end

    it 'destroyに連携してmicropostも消去' do
        @user.save
        @user.microposts.create!(content: "Lorem ipsum")
        expect{
            @user.destroy
        }.to change{ User.count }.by(-1)
    end

    it "should follow and unfollow a user" do
        user = create(:user)
        other_user = create(:other_user)
        expect(user.following?(other_user)).to eq false
        user.follow(other_user)
        expect(user.following?(other_user)).to eq true
        expect(other_user.followers.include?(user)).to eq true
        user.unfollow(other_user)
        expect(user.following?(other_user)).to eq false
    end

    it '正しい投稿のみを表示' do
        user = create(:user)
        other_user = create(:other_user)
        archer = create(:archer)
        create(:orange,user_id: user.id)
        create(:orange,user_id: other_user.id)
        create(:orange,user_id: archer.id)
        user.active_relationships.create!(followed_id: other_user.id)
        other_user.active_relationships.create!(followed_id: user.id)
        user.active_relationships.create!(followed_id: archer.id)
        archer.active_relationships.create!(followed_id: user.id)

        #フォローしているユーザーの投稿を確認
        archer.microposts.each do |post_self|
            expect(user.feed.include?(post_self)).to eq true
        end
        #自分の投稿を確認
        user.microposts.each do |post_self|
            expect(user.feed.include?(post_self)).to eq true
        end
        #フォローしてないユーザーの投稿を確認
        archer.microposts.each do |post_self|
            expect(other_user.feed.include?(post_self)).to eq false
        end
        
    end
end