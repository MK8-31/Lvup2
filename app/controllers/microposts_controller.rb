class MicropostsController < ApplicationController
    before_action :logged_in_user,only: [:create,:destroy]
    before_action :correct_user, only: :destroy

    def create
        @micropost = current_user.microposts.build(micropost_params)
        @micropost.image.attach(params[:micropost][:image])
        if @micropost.save
            flash[:success] = "投稿しました。"
            redirect_to home_url
        else
            @feed_items = current_user.feed.paginate(page: params[:page])
            render 'static_pages/home'
        end
    end

    def destroy
        @micropost.destroy
        flash[:success] = "投稿が削除されました。"
        redirect_to request.referrer || home_url
    end





    private

        def micropost_params
            params.require(:micropost).permit(:content,:image)
        end

        def correct_user
            #他のユーザーが他のユーザーの投稿を削除するのを防ぐ
            @micropost = current_user.microposts.find_by(id: params[:id])
            redirect_to root_url if @micropost.nil?
        end
end
