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
