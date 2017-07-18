require 'minitest/autorun'
require 'minitest/pride'
require_relative 'food_chain'

class NoCheating < IOError
  def message
    # "The use of File.open and IO.read is restricted.\n"
    # 'This exercise intends to help you improve your ability to work '
    # 'with data generated from your code. Your program must not read '
    # 'the song.txt file.'
  end
end

class FoodChainTest < Minitest::Test
  # This test is an acceptance test.
  #
  # If you find it difficult to work the problem with so much
  # output, go ahead and add a `skip`, and write whatever
  # unit tests will help you. Then unskip it again
  # to make sure you got it right.
  # There's no need to submit the tests you write, unless you
  # specifically want feedback on them.
  def test_the_whole_song
    song_file = File.expand_path('../song.txt', __FILE__)
    expected  = IO.read(song_file)
    assert_equal expected, FoodChain.song
  end

  # Tests that an error is effectively raised when IO.read or
  # File.open are used within FoodChain.
  def test_read_guard
    song_file = File.expand_path('../song.txt', __FILE__)
    ["IO.read '#{song_file}'", "File.open '#{song_file}'"].each do |trigger|
      assert_raises(NoCheating) { FoodChain.send :class_eval, trigger }
    end
  end

  def setup
    @obj = FoodChain.new
  end

  # Problems in exercism evolve over time,
  # as we find better ways to ask questions.
  # The version number refers to the version of the problem you solved,
  # not your solution.
  #
  # Define a constant named VERSION inside of BookKeeping.
  # If you are curious, read more about constants on RubyDoc:
  # http://ruby-doc.org/docs/ruby-doc-bundle/UsersGuide/rg/constants.html
  def test_version
    skip
    assert_equal 2, BookKeeping::VERSION
  end
end

module RestrictedClasses
  class File
    def self.open(*)
      fail NoCheating
    end

    def self.read(*)
      fail NoCheating
    end

    def open(*)
      fail NoCheating
    end

    def read(*)
      fail NoCheating
    end
  end

  class IO
    def self.read(*)
      fail NoCheating
    end

    def read(*)
      fail NoCheating
    end
  end
end

class FoodChain

  ANIMAL_INTERACTIONS= {
    fly: nil,
    spider: 'It wriggled and jiggled and tickled inside her.',
    bird: 'How absurd to swallow a bird!',
    cat: 'Imagine that, to swallow a cat!',
    dog: 'What a hog, to swallow a dog!',
    goat: 'Just opened her throat and swallowed a goat!',
    cow: "I don't know how she swallowed a cow!",
    horse: "She's dead, of course!\n"
  }

  ANIMAL_LISTS = ANIMAL_INTERACTIONS.keys

  CATCH_ANIMAL = {
    spider: "spider that wriggled and jiggled and tickled inside her"
  }

  def self.song
    build_song
  end

  def self.build_song
    song = []
    ANIMAL_LISTS.count.times do |line|
      song << build_stanza(line)
    end
    song.compact.join("\n")
  end

  def self.build_stanza(stanza_number)
    stanza = []
    stanza << build_first_line_and_action(stanza_number)
    if stanza_number != 7
      stanza << build_swallow_lines(stanza_number)
      stanza << build_last_line
    end
    stanza.compact
  end

  def self.build_first_line_and_action(stanza_number)
    animal_key = ANIMAL_LISTS[stanza_number]
    line = []
    line << "I know an old lady who swallowed a #{animal_key.to_s}."
    line << ANIMAL_INTERACTIONS[animal_key]
    line.compact
  end

  def self.build_last_line
    "I don't know why she swallowed the fly. Perhaps she'll die.\n"
  end

  def self.build_swallow_lines(stanza_number)
    swallow_lines = []
    return if stanza_number == 0
    stanza_number.times do |sn|
      animal_ckey = ANIMAL_LISTS[sn + 1]
      animal_skey = ANIMAL_LISTS[sn + 0]
      swallowed_animal = CATCH_ANIMAL[ANIMAL_LISTS[sn + 0]] || ANIMAL_LISTS[sn + 0].to_s
      swallow_lines << "She swallowed the #{animal_ckey.to_s} to catch the #{swallowed_animal}."
    end
    swallow_lines.reverse.compact
  end
end

FoodChain.prepend RestrictedClasses
