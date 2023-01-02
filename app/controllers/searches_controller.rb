class SearchesController < ApplicationController
  def search
    # params
    #  search_method(e.g. 'perfect', 'prefix', 'suffix', 'partial')
    #  search_model(e.g. 'Book', 'User')
    #  search_query(e.g. 'test1')
    target_model = search_params[:search_model]
    if target_model == 'User'
      @users = User.search_by(search_params)
    elsif target_model == 'Book'
      @books = Book.search_by(search_params)
    end
  end
    
  private
    
  def search_params
    params.permit(:search_method, :search_model, :search_query)
  end
end
