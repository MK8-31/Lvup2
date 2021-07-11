class LvprosController < ApplicationController
  before_action :logged_in_user,only: [:new,:create]
  
  def new
    @before_lv = Lvpro.order(created_at: :desc).find_by(user_id: current_user.id,profession: current_user.profession.profession)
    @lv = current_user.lvpros.build
  end

  def create
    @before_lv = Lvpro.order(created_at: :desc).find_by(user_id: current_user.id,profession: current_user.profession.profession)
    @lv = current_user.lvpros.build(lvpro_params)
    if @lv.save
      @lv.profession = current_user.profession.profession
      if !@before_lv.nil?
        @lv.lv = @before_lv.lv
        @lv.experience_point += @before_lv.experience_point
        if @before_lv.lv < (@lv.experience_point+100)/100
          flash[:info] = "レベルアップしました！"
          current_user.microposts.create!(content: "レベルアップしました!")
          @lv.lv = (@lv.experience_point+100)/100
          
        end
      end
      @lv.save
      flash[:success] = "記録しました。"
      redirect_to current_user
    else
      render 'new'
    end
  end


  private

    def lvpro_params
      params.require(:lvpro).permit(:experience_point,:profession)
    end
end
