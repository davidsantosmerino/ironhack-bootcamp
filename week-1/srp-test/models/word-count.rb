require "./models/user"

class WordCount

  def initialize
    @user = User.new
    start
  end

  def start
    if ask_login
      ask_word_to_count
    else
      puts "Please type a correct user and password"
      start
    end
  end

  def ask_login
    puts "Username: "
    user = gets.chomp
    puts "Password: "
    passwd = gets.chomp
    @user.login user, passwd
  end

  def ask_word_to_count
    puts "Now we're ready to say how long is your word. Type a word..."
    word = gets.chomp
    word_count word
  end

  def word_count word
    puts "Your word has #{word.length} characters"
  end

end
