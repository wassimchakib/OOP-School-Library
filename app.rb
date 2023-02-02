require './book'
require './student'
require './teacher'
require './rental'

class App
  def list_all_books(books, show_index: false)
    puts 'No books found' if books.empty?
    books.each_with_index do |book, index|
      puts "#{"#{index}) " if show_index}Title: \"#{book.title}\", Author: #{book.author}"
    end
    puts "\n"
  end

  def list_all_people(people, show_index: false)
    puts 'No people found' if people.empty?
    people.each_with_index do |person, index|
      puts "#{"#{index}) " if show_index}[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    puts "\n"
  end

  def list_all_rentals_for_a_person(id_person, persons)
    return persons.find { |person| person.id == id_person }.rentals if persons.any? { |p| p.id == id_person }
  end

  def create_a_person(choice, age, name, specialization, parent_permission)
    classroom = Classroom.new('ClassA')
    return Student.new(classroom, age, name, parent_permission: parent_permission) if choice == 1
    return Teacher.new(age, specialization, name, parent_permission: parent_permission) if choice == 2
  end

  def create_a_book(title, author)
    Book.new(title, author)
  end

  def create_a_rental(book, person, date)
    Rental.new(person, book, date)
  end
end
