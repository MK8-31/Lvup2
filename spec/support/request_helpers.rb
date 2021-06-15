module RequestHelpers
    def is_logged_in?
        !session[:user_id].nil?
    end

    def log_in_as(user,password: 'password',remember_me: '1')
        post login_path,params: {session: {email: user.email,password: password,remember_me: remember_me } }
        session[:user_id] = user.id #これを先に書くとsessionがないというエラーになる。
    end

    def remember(user)
        user.remember
        cookies[:user_id] = user.id
        cookies[:remember_token] = user.remember_token
    end
end