class SearchesController < ApplicationController
  def search
    # params
    #  search_method(e.g. 'perfect', 'prefix', 'suffix', 'partial')
    #  search_model(e.g. 'Book', 'User')
    #  word(e.g. 'test1')
    target_model = search_params[:search_model]
    if target_model == 'User'
      User.search_by(search_params)
    elsif target_model == 'Book'
      Book.search_by(search_params)
    end
    
    private
    
    def search_params
      params.permit(:search_method, :search_model, :word)
    end
  end
end
