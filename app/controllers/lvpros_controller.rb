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
        @lv.star = @before_lv.star
        @lv.experience_point += @before_lv.experience_point
        if @before_lv.lv < (@lv.experience_point+100)/100
          flash[:info] = "★★★★レベルアップしました！★★★★"
          current_user.microposts.create!(content: "レベルアップしました!")
          @lv.lv = (@lv.experience_point+100)/100
          @lv.save
          @lv.reload
          if @lv.lv > 100
            flash[:info] = "転生しました。"
            @lv.lv=@lv.lv-100
            @lv.experience_point=@lv.experience_point-10000
            @lv.star=@lv.star+1
            @lv.save
          end
          redirect_to lvupeffect_path
        else
          @lv.save
          flash[:success] = "記録しました。"
          redirect_to current_user
        end
      else
        flash[:danger] = "エラー、データが破損しています。"
      end

    else
      render 'new'
    end
  end


  private

    def lvpro_params
      params.require(:lvpro).permit(:experience_point,:profession)
    end
end
