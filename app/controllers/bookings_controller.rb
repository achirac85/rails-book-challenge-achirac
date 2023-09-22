class BookingsController < ApplicationController
  before_action :set_room, only: [:new, :create]
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @room = Room.find(params[:room_id])
    @booking = Booking.new
  end

  def edit
    @booking = Booking.find(params[:id])
    @room = @booking.room
  end

  def create
    date_range = params[:booking][:date_range].split(' to ')
    starts_at = date_range[0]
    ends_at = date_range[1]

    @room = Room.find(params[:room_id])
    @booking = @room.bookings.new(booking_params)
    @booking.starts_at = starts_at
    @booking.ends_at = ends_at
    @booking.user_id = current_user.id # assuming you have current_user method

    if @booking.save
      redirect_to room_path(@room), notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def update
    if @booking.update(booking_params)
      redirect_to room_path(@room), notice: 'Booking was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    redirect_to room_path(@room), notice: 'Booking was successfully destroyed.'
  end

  private

  def set_room
    @room = Room.find(params[:room_id]) if params[:room_id].present?
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end


  def booking_params
    params.require(:booking).permit(:user_id, :room_id, :starts_at, :ends_at)
  end
end
