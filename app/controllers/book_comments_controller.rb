class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_back fallback_location: root_path
  end

  def destroy
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.find_by(book: book, id: params[:id])
    comment.destroy
    redirect_back fallback_location: root_path
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:body)
  end
  
  def ensure_correct_user
    comment = BookComment.find(params[:id])
    unless comment.user == current_user
      redirect_back fallback_location: root_path
    end
  end
end
