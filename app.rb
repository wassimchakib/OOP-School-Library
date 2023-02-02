require './book'
require './student'
require './teacher'
require './rental'

class App
  def list_all_books(books, show_index: true)
    books.each_with_index do |book, index|
      puts "#{"#{index}) " if show_index}Title: \"#{book.title}\", Author: #{book.author}" 
    end
  end

  def list_all_people(people, show_index: false)
    people.each_with_index do |person, index|
      puts "#{"#{index}) " if show_index}[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
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

app = App.new
book1 = app.create_a_book('Atomic habits', 'James Clear')
book2 = app.create_a_book('Millionaire Mindset', 'Simo Life')
books = [book1, book2]
app.list_all_books(books)
person1 = app.create_a_person(1, 19, 'Wassim', nil, parent_permission: false)
person2 = app.create_a_person(2, 35, 'Lord', 'Mathematics', parent_permission: true)
persons = [person1, person2]
app.list_all_people(persons)
app.create_a_rental(book1, person2, '2022-09-23')
app.create_a_rental(book2, person2, '2023-01-20')
app.list_all_rentals_for_a_person(863, persons)
