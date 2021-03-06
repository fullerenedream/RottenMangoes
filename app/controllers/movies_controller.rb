class MoviesController < ApplicationController
  
  def index
    @movies = Movie.all
    if params[:title].present?
      @movies = @movies.search_by_title(params[:title])
    end
    if params[:director].present?
      @movies = @movies.search_by_director(params[:director])
    end
    if params[:duration].present?
      @movies = @movies.search_by_duration(params[:duration])
    end
    @movies
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movies_path
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :poster, :description
    )
  end

end
