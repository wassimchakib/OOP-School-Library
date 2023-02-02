require './app'

class Main
  attr_accessor :list_of_books, :list_of_people

  def initialize
    @list_of_books = []
    @list_of_people = []
  end

  def show_options
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
    gets.chomp
  end

  def ask_question(question)
    print question
    gets.chomp
  end

  def create_student(app)
    age = ask_question('Age: ')
    name = ask_question('Name: ')
    parent_permission = ask_question('Has parent permission? [Y/N]: ') == 'y'
    @list_of_people.push(app.create_a_person(1, age, name, nil, parent_permission: parent_permission))
    puts "Person created successfully\n\n"
  end

  def create_teacher(app)
    age = ask_question('Age: ')
    name = ask_question('Name: ')
    specialization = ask_question('Specialization: ')
    @list_of_people.push(app.create_a_person(2, age, name, specialization, parent_permission: true))
    puts "Person created successfully\n\n"
  end

  def person_builder(app)
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    case gets.chomp
    when '1' then create_student(app)
    when '2' then create_teacher(app)
    else 'Invalid Request!'
    end
  end

  def book_builder(app)
    title = ask_question('Title: ')
    author = ask_question('Author: ')
    @list_of_books.push(app.create_a_book(title, author))
    puts "Book created successfully\n\n"
  end

  def rental_builder(app)
    if list_of_books.empty? || list_of_people.empty?
      puts "Book list or Person list is empty, please try again\n\n"
      return nil
    end
    puts 'Select a book from the following list by number'
    app.list_all_books(list_of_books, show_index: true)
    book = gets.chomp
    puts "\nSelect a person from the following list by number (not id)"
    app.list_all_people(list_of_people, show_index: true)
    person = gets.chomp
    print "\nDate: "
    date = gets.chomp
    app.create_a_rental(list_of_books[book.to_i], list_of_people[person.to_i], date)
    puts "Rental created successfully\n\n"
  end

  def show_rental(app)
    id = ask_question('ID of person: ')
    print "Rentals: \n"
    rentals = app.list_all_rentals_for_a_person(id.to_i, list_of_people)
    rentals&.each { |r| puts "Date: #{r.date}, Book \"#{r.book.title}\" by #{r.book.author}" }
    print "\n"
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def run
    app = App.new
    puts "Welcome to School library App! \n\n"
    loop do
      case show_options
      when '1' then app.list_all_books(list_of_books)
      when '2' then app.list_all_people(list_of_people)
      when '3' then person_builder(app)
      when '4' then book_builder(app)
      when '5' then rental_builder(app)
      when '6' then show_rental(app)
      when '7'
        puts "Thank you for using this app!\n\n"
        break
      else puts 'Incorrect choice, Please try again. (Hint: choose between 1 and 7)'
      end
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
end

app = Main.new
app.run
