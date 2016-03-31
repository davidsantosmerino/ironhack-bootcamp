require 'ruby-dictionary'

class WordChain

    def initialize(dictionary)
        @dictionary = dictionary
    end

    def find_chain first_word, second_word
	  	puts first_word
	  	while second_word != first_word
				success = false
				i = 0
				while (first_word.split('')[i] != second_word.split('')[i] && i < first_word.size)
					temp_chars = first_word.split('')
					temp_chars[i] = second_word.split('')[i]
					if @dictionary.exists? temp_chars.join
						puts temp_chars.join
						first_word = temp_chars.join
						success = true
					end
					i += 1
				end
			end
		end

end

dictionary = Dictionary.from_file("/usr/share/dict/words")
my_chain = WordChain.new(dictionary)

my_chain.find_chain("cat", "dog")
