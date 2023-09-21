class BookingsController < ApplicationController
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
  end

  def destroy
  end

  private

  def booking_params
    params.require(:booking).permit(:starts_at, :ends_at)
  end
end
