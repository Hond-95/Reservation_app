class ReservationsController < ApplicationController
  def confirm
    if params[:end_ymd].empty? || params[:start_ymd].empty?
      flash[:notice] = "日付を指定してください"
      redirect_to("/rooms/#{params[:room_id]}")
    elsif params[:start_ymd] < Time.now || params[:end_ymd] < Time.now 
      flash[:notice] = "過去の日付は無効です"
      redirect_to("/rooms/#{params[:room_id]}")      
    elsif params[:guests].empty?
      flash[:notice] = "人数を指定してください"
      redirect_to("/rooms/#{params[:room_id]}")
    else
      @stay_days =(params[:end_ymd].to_date - params[:start_ymd].to_date).numerator
      @fee = params[:fee]
      @total_amount = params[:guests].to_i * @stay_days.to_i * params[:fee].to_i
      @reserve = Reservation.new(reserve_params)
      session[:reserve] = @reserve
    end
  end
  
  def create
		if @reserve = Reservation.create!(session[:reserve])
		  flash[:notice] = "予約を完了しました"
		  redirect_to("/reservation/#{@reserve.id}")
		else
		  session.delete(:reserve)
		  flash[:notice] = "予約を失敗しました"
		  redirect_to("/rooms/#{session[:reserve].room_id}")
		end
  end
  
  def posts
    @reserve = Reservation.find_by(id: params[:id])
    @room = Room.find_by(id: @reserve.room_id)
  end
  
  def index
    @reservations = Reservation.where(user_id: @current_user.id)
  end

private
  def reserve_params
    params.permit(:start_ymd, :end_ymd, :guests, :room_id).merge(total_amount: @total_amount,user_id: @current_user.id)
  end
end
