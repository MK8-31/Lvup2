require 'rails_helper'

describe "レベルアップと転職",type: :system do
    before do
        @user = create(:user)
        log_in(@user)
    end

    it "経験値とレベルアップ" do
        visit new_lvpro_path
        expect(page).to have_selector 'h1',text: "記録"
        fill_in "lvpro_experience_point",with: "20"
        find('input[name="commit"]').click
        expect(current_path).to eq user_path(@user)
        expect(page).to have_content @user.name
        expect(page).to have_content "職業：剣士"
        expect(page).to have_content "Lv: 1"
        # expect(page).to eq have_content "Ex: 20 / 100"
        visit new_lvpro_path
        expect(page).to have_selector 'h1',text: "記録"
        fill_in "lvpro_experience_point",with: "80"
        find('input[name="commit"]').click
        expect(page).to have_content "Lv: 2"
    end

    it "転職" do
        visit edit_profession_path(@user.profession)
        expect(page).to have_selector 'h1',text: "転職"
        select '魔法使い',from: '職業'
        find('input[name="commit"]').click
        expect(current_path).to eq user_path(@user)
        expect(page).to have_content @user.name
        expect(page).to have_content "職業：魔法使い"
        visit edit_profession_path(@user.profession)
        expect(page).to have_selector 'h1',text: "転職"
        select '弓士',from: '職業'
        find('input[name="commit"]').click
        expect(current_path).to eq user_path(@user)
        expect(page).to have_content @user.name
        expect(page).to have_content "職業：弓士"

    end
end