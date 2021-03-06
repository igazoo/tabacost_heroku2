class SessionsController < ApplicationController
  def new
    @user=User.new

  end

  def create
    user=User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to histories_path, success: 'ログインに成功しました'

    else
      flash.now[:danger]='ログインに失敗しました'
      render :new

    end
  end

  def destroy
    log_out
    redirect_to root_url, info: 'ログアウトしました'
  end

  private

  def name_params
    params.require(:session).permit(:name)
  end

  def password_params
    params.require(:session).permit(:password)
  end

end
