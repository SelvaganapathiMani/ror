require 'rspec'

class Bookstore
  attr_reader :books

  def initialize
    @books = []
  end

  def add_book(book)
    @books << book
  end

  def total_price
    @books.sum(&:price)
  end

  def book_titles
    @books.map(&:title)
  end

  def find_books_by_author(author)
    @books.select { |book| book.author == author }
  end

  def cheapest_book
    @books.min_by(&:price)
  end
end

class Book
  attr_reader :title, :author, :price

  def initialize(title, author, price)
    @title = title
    @author = author
    @price = price
  end
end

RSpec.describe Bookstore do
  let(:bookstore) { Bookstore.new }
  let(:book1) { Book.new("Book 1", "Author 1", 20) }
  let(:book2) { Book.new("Book 2", "Author 2", 15) }
  let(:book3) { Book.new("Book 3", "Author 1", 25) }

  describe '#add_book' do
    it 'adds a book to the bookstore' do
      bookstore.add_book(book1)
      expect(bookstore.books).to include(book1)
    end
  end

  describe '#total_price' do
    it 'returns the total price of all books in the bookstore' do
      bookstore.add_book(book1)
      bookstore.add_book(book2)
      expect(bookstore.total_price).to eq(35)
    end

    it 'returns 0 for an empty bookstore' do
      expect(bookstore.total_price).to eq(0)
    end
  end

  describe '#book_titles' do
    it 'returns an array of book titles' do
      bookstore.add_book(book1)
      bookstore.add_book(book2)
      expect(bookstore.book_titles).to contain_exactly("Book 1", "Book 2")
    end
  end

  describe '#find_books_by_author' do
    it 'returns books by a specific author' do
      bookstore.add_book(book1)
      bookstore.add_book(book2)
      bookstore.add_book(book3)
      expect(bookstore.find_books_by_author("Author 1")).to contain_exactly(book1, book3)
    end
  end

  describe '#cheapest_book' do
    it 'returns the cheapest book in the bookstore' do
      bookstore.add_book(book1)
      bookstore.add_book(book2)
      bookstore.add_book(book3)
      expect(bookstore.cheapest_book).to eq(book2)
    end

    it 'returns nil for an empty bookstore' do
      expect(bookstore.cheapest_book).to be_nil
    end
  end
end

