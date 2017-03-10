require "pry"
require "./annkissam_language"

describe AnnkissamLanguage do
  describe "valid_word" do
    let(:annkissam_language) { AnnkissamLanguage.new }

    context "with a valid word" do
      it "returns the word" do
        expect(annkissam_language.valid_word?("fg")).to be true
      end
    end

    context "with an invalid word" do
      it "returns nil" do
        expect(annkissam_language.valid_word?("zx")).to be false
      end
    end
  end

  describe "potential_sentences" do
    let(:annkissam_language) { AnnkissamLanguage.new }

    context "when the first letter is not the first letter of any words" do
      it "returns an empty array" do
        expect(annkissam_language.potential_sentences("z")).to eq []
      end
    end

    context "when the first letter is a valid word" do
      it "returns the letter in an array as a potential_sentence" do
        expect(annkissam_language.potential_sentences("c")).to eq ["c"]
      end
    end

    context "when the letters make one potential sentence" do
      it "returns a sentence" do
        result = ["fg c bcd"]
        expect(annkissam_language.potential_sentences("fgcbcd")).to eq result
      end
    end

    context "with letters that make several potential sentences" do
      it "returns all potential sentences" do
        result  = ["abcd e fg", "a bc def g", "a bcd e fg"]
        expect(annkissam_language.potential_sentences("abcdefg")).to eq result
      end
    end
  end

  describe "find_valid_words" do
    let(:annkissam_language) { AnnkissamLanguage.new }

    context "when a string is a valid word" do
      it "returns an array of the valid words" do
        expect(annkissam_language.find_valid_words("g")).to eq ["g"]
      end
    end

    context "when a string has two valid words" do
      it "returns an array of the valid words" do
        expect(annkissam_language.find_valid_words("ch")).to eq ["c", "h"]
      end
    end

    context "when a string has two valid words using the same letter" do
      it "returns an array of the valid words" do
        expect(annkissam_language.find_valid_words("fg")).to eq ["fg", "g"]
        expect(annkissam_language.find_valid_words("gf")).to eq ["g"]
      end
    end

    context "when a string has many valid words that share letters" do
      it "returns an array of the valid words" do
        result = ["fg", "g", "a", "ac", "c", "bc", "c"]
        expect(annkissam_language.find_valid_words("fgacbc")).to eq result
      end
    end
  end

  describe "two_articles?" do
    let(:annkissam_language) { AnnkissamLanguage.new }

    context "when there are two articles" do
      it "returns true" do
        sentence = "ac a"
        expect(annkissam_language.two_articles?(sentence)).to eq true
      end
    end

    context "when there are not two articles" do
      it "returns false" do
        sentence = "ac fg"
        expect(annkissam_language.two_articles?(sentence)).to eq false
      end
    end

    context "when it has three articles" do
      it "returns true" do
        sentence = "ac a e"
        expect(annkissam_language.two_articles?(sentence)).to be true
      end
    end

    context "when it has exactly two articles" do
      it "returns true" do
        sentence = "ac a"
        expect(annkissam_language.two_articles?(sentence)).to be true
      end
    end
  end

  describe "has_type?" do
    let(:annkissam_language) { AnnkissamLanguage.new }

    context "when VERBS are passed in" do
      context "when there are no verbs" do
        it "returns false" do
          verbs = "bc", "fg", "g", "hij", "bcd"
          sentence = "ac e def"
          expect(annkissam_language.has_type?(sentence, verbs)).to be false
        end
      end

      context "when there is atleast one verb" do
        it "returns true" do
          verbs = "bc", "fg", "g", "hij", "bcd"
          sentence = "ac e def bc"
          expect(annkissam_language.has_type?(sentence, verbs)).to be true
        end
      end
    end

    context "when NOUNS are passed in" do
      context "when there are no nouns" do
        it "returns false" do
          nouns = "abcd", "c", "def", "h", "ij", "cde"
          sentence = "bc fg g hij"
          expect(annkissam_language.has_type?(sentence, nouns)).to be false
        end
      end

      context "when there is atleast one noun" do
        it "returns true" do
          nouns = "abcd", "c", "def", "h", "ij", "cde"
          sentence = "bc fg g hij abcd"
          expect(annkissam_language.has_type?(sentence, nouns)).to be true
        end
      end
    end
  end

  describe "compose" do
    let(:annkissam_language) { AnnkissamLanguage.new }

    context "when no valid sentences are present" do
      it "returns an empty array" do
        string = "abcd"
        result = []
        expect(annkissam_language.compose(string)).to eq result
      end
    end

    context "when one valid sentence is present" do
      it "returns the sentence in an array" do
        string = "bcc"
        result = ["bc c"]
        expect(annkissam_language.compose(string)).to eq result
      end
    end

    context "with several reapeated characters" do
      it "returns all valid sentences" do
        string = "aaaaaaaaaacfg"
        result  = ["a a a a a a a a a ac fg", "a a a a a a a a a a c fg"]
        expect(annkissam_language.compose(string)).to eq result
      end
    end

    context "when several valid sentences are present" do
      it "returns all valid sentences" do
        string = "abcdefg"
        result  = ["abcd e fg", "a bc def g", "a bcd e fg"]
        expect(annkissam_language.compose(string)).to eq result
      end
    end

    context "with over 12 valid sentences" do
      it "returns all valid sentences" do
        string = "abcdefgchachij"

        result = ["abcd e fg c h ac hij", "a bc def g c h ac hij",
                   "a bcd e fg c h ac hij", "abcd e fg c h a c hij",
                   "abcd e fg c h ac h ij", "a bc def g c h a c hij",
                   "a bc def g c h ac h ij", "a bcd e fg c h a c hij",
                   "a bcd e fg c h ac h ij", "abcd e fg c h a c h ij",
                   "a bc def g c h a c h ij","a bcd e fg c h a c h ij"]

        expect(annkissam_language.compose(string)).to eq result
      end
    end
  end
end
