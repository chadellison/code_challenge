class AnnkissamLanguage
  NOUNS = "abcd", "c", "def", "h", "ij", "cde"
  VERBS = "bc", "fg", "g", "hij", "bcd"
  ARTICLES = "a", "ac", "e"

  def compose(string)
    potential_sentences(string).select do |sentence|
      has_type?(sentence, NOUNS) && has_type?(sentence, VERBS) ||
      two_articles?(sentence)
    end
  end

  def two_articles?(sentence)
    sentence = sentence.split

    sentence.include?("a") && sentence.include?("ac") ||
    sentence.include?("a") && sentence.include?("e") ||
    sentence.include?("ac") && sentence.include?("e")
  end

  def has_type?(sentence, type)
    (sentence.split & type).count > 0
  end

  def potential_sentences(string)
    word_combos = []
    words = find_valid_words(string)

    words.count.times { |n| word_combos += words.combination(n + 1).to_a }

    word_combos.select { |combo| combo.join == string }
      .map { |words| words.join(" ") }.uniq
  end

  def find_valid_words(string)
    valid_words = []

    string.length.times do |count|
      (string.length - count).times do |index|
        word = string[count..(count + index)]

        if valid_word?(word)
          valid_words << word
        end
      end
    end

    valid_words
  end

  def valid_word?(word)
    if (NOUNS + VERBS + ARTICLES).any? { |valid_word| valid_word == word }
      true
    else
      false
    end
  end
end
