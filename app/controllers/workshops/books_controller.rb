class Workshops::BooksController < BooksController 
  before_action :find_workshop!, only: [:new, :create]
  before_action :authenticate_user!

  def index
    select = 'workshops.title, workshops.price, books.id, books.total_price, books.start_date, books.end_date'
    @books = Book.select(select).joins('INNER JOIN workshops ON books.workshop_id = workshops.id').where(user_id: current_user.id).all
    puts @books.inspect
  end

  def show
    @book = Book.find(params[:id])
    @workshop = Workshop.find(@book.workshop_id)
  end

  def new 
    @title = 'Book an workshop'
    Book.where(workshop_id: @workshop.id).find_each do |book|
      @dates ||= []
      @dates.push({start: book.start_date, end: book.end_date})
    end 
    @dates = @dates.to_json
  end 

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to :workshops_books_all
    else 
      redirect_to :workshops_new_book
    end
  end 

  def delete
    @book = Book.find(params[:id])
    @book.destroy
    respond_to do |format|
      format.html { redirect_to workshops_books_all_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy
  end

  private 
    def find_workshop!
      @workshop = Workshop.where(id: params[:workshop_id]).first
      puts "Find workshop : " + @workshop.inspect
    end

    def book_params
      params.permit(:start_date, :end_date, :workshop_id)
    end
end