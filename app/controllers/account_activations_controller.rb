class AccountActivationsController < ApplicationController

    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation,params[:id])
            user.activate
            log_in user
            flash[:success] = "アカウントが有効化されました。"
            current_user.lvpros.create!(lv: 1,experience_point: 0,profession: 0)
            current_user.lvpros.create!(lv: 1,experience_point: 0,profession: 1)
            current_user.lvpros.create!(lv: 1,experience_point: 0,profession: 2)
            redirect_to user
        else
            flash[:danger] = "アカウント有効化リンクが無効です。"
            redirect_to root_url
        end
    end
end
