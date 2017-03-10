# code_challenge

## Requirements
Imagine you have recently written a new language and collected all words into a Dictionary. Similar to the English language, words can be categorized into nouns, verbs and articles. Below is the Dictionary:

Nouns: "abcd", "c", "def", "h", "ij", "cde"
Verbs: "bc", "fg", "g", "hij", "bcd"
Articles: "a", "ac", "e"

However, the rules for creating a sentence in this Language are very different. A valid sentence should
- have all its words present in the Dictionary.
- have a verb.
- have a noun or have at least two articles.

Your task is to write a sentence composer which will take a string as an input and return all possible valid sentences. This composer keeps the characters of the string in the same order, while inserting at most one space between characters as necessary, to create valid words and a valid sentence.

For your convenience, we have provided some sample inputs and outputs.
Input = "abcdefg", should return the following list:
[
"a bc def g",
"a bcd e fg",
"abcd e fg"
]

Input = "abcc", should return the following list:
["a bc c"]

Input = "abcd", should return the following list:
[]

Note: Make sure to list all (if any) assumptions you make.

## Test Suite

The test suite can be run from the root directory with "rspec annkissam_language_spec.rb
