class UsersController < ApplicationController
  #ログインが必要なアクション
  before_action :authenticate_user, {only: [:update,:update_password]}
  #すでにログインしている場合
  before_action :forbit_login_user, {only: [:new,:login]}
  #ログインしてるユーザのアクセス制限
  before_action :ensure_correct_user, {only: [:update,:update_password,:account,:profile]}
  
  def sign_up
    
  end
  
  def sign_in
    
  end
  
  def new
    @user = User.new(name: params[:name],
                     email: params[:email],
                     password: params[:password],
                     password_confirmation: params[:password_confirmation],
                     image: "default_image.jpg")
    if @user.save
      session[:user_id] = @user.id
      flash[:notice]="ユーザー作成に成功しました。"
      redirect_to("/users/account/#{@user.id}")
    else
      render("users/sign_up")
    end
  end
  
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログイン完了しました。"
      redirect_to("/users/account/#{@user.id}")
    else
      flash[:notice] = "ログインに失敗しました。"
      render("/users/sign_in")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end
  
  def account
    @user = User.find_by(id: params[:id])
  end
  
  def profile
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.profile = params[:profile]
    if params[:image]
      @user.image = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{params[:id]}.jpg",image.read)
    end
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/profile/#{@user.id}")
    else
      flash[:notice] = "ユーザー情報の編集に失敗しました"

      render 'profile'
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update_password
    @user = User.find_by(id: params[:id])
    if params[:email].empty?
      flash[:notice] = "メールアドレスを入力してください"
      render 'edit'
    elsif params[:current_password].empty?
      flash[:notice] = "現在のパスワードを入力してください"
      render 'edit'
    elsif params[:new_password].empty? || params[:new_password_confirmation].empty?
      flash[:notice] = "変更後のパスワードを入力してください"
      render 'edit'
    elsif params[:new_password] != params[:new_password_confirmation]
      flash[:notice] = "変更後のパスワードが一致しません"
      render 'edit'
    elsif @user && @user.authenticate(params[:current_password])
      @user.email = params[:email]
      @user.password = params[:new_password]
      @user.password_confirmation = params[:new_password_confirmation]
      if @user.save
        flash[:notice] = "ユーザー情報を編集しました"
        redirect_to("/users/account/#{@user.id}")
      else
        flash[:notice] = "ユーザー情報の編集に失敗しました"
        render 'edit'
      end
    else
      flash[:notice] = "ユーザーの編集に失敗しました"
      render 'edit'
    end
    
  end
  
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end
  
  private
    def user_update_params
      params.permit(:name,:profile,:image,:password,:password_confirmation)
    end
end