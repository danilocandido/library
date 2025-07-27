class BorrowingSerializer
  include JSONAPI::Serializer

  attribute :book_title do |borrowing|
    borrowing.book && borrowing.book.title
  end

  attribute :returned_date do |user|
    user.returned_at && user.returned_at.strftime('%m/%d/%Y')
  end
end
