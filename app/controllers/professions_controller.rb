class ProfessionsController < ApplicationController
  before_action :logged_in_user,only: [:edit,:update]

  def edit
    if current_user.profession.nil?
      current_user.create_profession(profession: 0)
    end
    @profession = current_user.profession
  end

  def update
    @profession = current_user.profession
    if @profession.update(profession_params)
      if Lvpro.order(created_at: :desc).find_by(user_id: current_user.id,profession: current_user.profession.profession).nil?
        current_user.lvpros.create!(experience_point: 0,profession: current_user.profession.profession)
      end
      flash[:success] = "転職しました。"
      redirect_to current_user
    else
      render 'edit'
    end
  end


  private

    def profession_params
      params.require(:profession).permit(:profession)
    end

      
end
