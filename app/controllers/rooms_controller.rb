class RoomsController < ApplicationController
  #ログインが必要なアクション
  before_action :authenticate_user, {only: [:create,:new]}
  
  def search
    @area = params[:area]
    @keyword = params[:keyword]
    @rooms = Room.search(@area,@keyword)
    render('rooms/index')
  end
  
  def reserve
    @rooms = Room.find_by(id: params[:id])
  end
  
  def index
  end
  
  def new
  end
  
  def create
    @rooms = Room.new(room_param)
    if @rooms.save
      flash[:notice] = "ルームの登録を完了しました"
      redirect_to("/rooms/#{@rooms.id}")
    else
      flash[:notice] = "ルームの登録に失敗しました"
      render 'new'
    end
  end
  
  def posts
    @rooms = Room.where(user_id: @current_user.id)
  end
  
  private
  
  def room_param
    params.permit(:name, :introduction, :fee, :address, :room_image).merge(user_id: @current_user.id)
  end
end
