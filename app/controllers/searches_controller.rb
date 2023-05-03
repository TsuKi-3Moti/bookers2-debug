class SearchesController < ApplicationController

  def search
    @books = Book.where(':search_word LIKE?', "%#{keyword}%")
    # @users = User.where()
  end

  private

  def search_params
    params.require(:search).permit(:search_word, :model_name, :match)
  end

end