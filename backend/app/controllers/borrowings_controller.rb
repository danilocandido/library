class BorrowingsController < ApplicationController
  load_and_authorize_resource
  before_action :set_borrowing, only: %i[ show update destroy ]

  def index
    @borrowings = Borrowing.accessible_by(current_ability)

    render json: @borrowings
  end

  def show
    render json: @borrowing
  end

  def create
    @borrowing = current_user.borrowings.new(borrowing_params)

    if @borrowing.save
      render json: BorrowingSerializer.new(Borrowing.last).serializable_hash[:data][:attributes], status: :created
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

  def update
    if @borrowing.update(borrowing_params)
      render json: @borrowing
    else
      render json: @borrowing.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @borrowing.destroy!
  end

  private

  def set_borrowing
    @borrowing = Borrowing.find(params.expect(:id))
  end

  def borrowing_params
    params.expect(borrowing: %i[user_id book_id borrowed_at due_at returned_at ])
  end
end
