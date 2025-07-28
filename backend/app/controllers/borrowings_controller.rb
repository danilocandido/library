class BorrowingsController < ApplicationController
  load_and_authorize_resource

  def index
    @dashboards = DashboardService.new(current_user).call
    render json: :created, status: :ok
  end

  def create
    @borrowing = current_user.borrowings.new(borrowing_params)

    if @borrowing.save
      render json: BorrowingSerializer.new(@borrowing).serializable_hash[:data][:attributes], status: :created
    else
      render json: @borrowing.errors, status: :unprocessable_entity
    end
  end

  def return
    @borrowing = Borrowing.find_by(borrowing_params)

    @borrowing.return!

    render json: @borrowing, status: :ok
  rescue
    render json: @borrowing, status: :not_found
  end

  private

  def borrowing_params
    params.expect(borrowing: %i[user_id book_id borrowed_at due_at returned_at ])
  end
end
