class Rental
  attr_accessor :person, :date, :book

  def initialize(person, book, date)
    @person = person
    @book = book
    @date = date
    person.rentals.push(self) unless person.rentals.include?(self)
    book.rentals.push(self) unless person.rentals.include?(self)
  end
end
