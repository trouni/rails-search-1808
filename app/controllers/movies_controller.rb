class MoviesController < ApplicationController
  def index
    # SQL IMPLEMENTATION
    @movies = 
      if params[:q].present?
        sql_query = <<~SQL
        title @@ :q OR
        synopsis @@ :q OR
        directors.first_name @@ :q OR
        directors.last_name @@ :q
        SQL

        Movie.joins(:director).where(sql_query, q: "%#{params[:q]}%")
      else
        Movie.all
      end
  end
end
