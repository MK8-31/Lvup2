module RequestHelpers
    def is_logged_in?
        !session[:user_id].nil?
    end

    def log_in_as(user,password: 'password',remember_me: '1')
        post login_path,params: {session: {email: user.email,password: password,remember_me: remember_me } }
        if user.activated?
            session[:user_id] = user.id #これを先に書くとsessionがないというエラーになる。
        end
    end

    def remember(user)
        user.remember
        cookies[:user_id] = user.id
        cookies[:remember_token] = user.remember_token
    end

    def log_in(user)
        visit login_path
        fill_in "session_email",with: user.email
        fill_in "session_password",with: user.password
        find('input[name="commit"]').click
    end
end