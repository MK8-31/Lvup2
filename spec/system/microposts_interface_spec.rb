require 'rails_helper'

describe "micropost_interface",type: :system do
    before do
        @user = create(:user)
    end

    it 'マイクロポストインターフェース' do
        log_in(@user)
        visit home_path
        expect(page).to have_selector 'input[type=file]'
        #無効な送信
        expect{
            fill_in "micropost[content]",with: ""
            find('input[name="commit"]').click
        }.to change{ Micropost.count }.by(0)
        expect(page).to have_selector 'div#error_explanation'
        # expect(page).to have_selector 'a[href="/?page=2"]' #pagination系のテストはだめ
        #有効な送信
        content = "abc abc abc"
        expect{
            fill_in "micropost[content]",with: content
            attach_file "#{Rails.root}/spec/fixtures/kitten.jpg"
            find('input[name="commit"]').click
        }.to change{ Micropost.count }.by(1)
        expect(current_path).to eq home_path
        expect(page).to have_content content
        expect(page).to have_selector("img[src$='kitten.jpg']")
        #投稿を削除
        expect{
            find('a',text: 'delete').click
        }.to change{ Micropost.count }.by(-1)
        #違うユーザーのプロフィールにアクセル（削除リンクがないことを確認）
        visit user_path(create(:other_user))
        expect(page).to have_selector 'a',text: 'delete',count: 0
    end
end