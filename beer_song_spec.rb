require 'rspec/given'
require 'beer_song'

module Beer
  V99 =
    "99 bottles of beer on the wall, 99 bottles of beer.\n" +
    "Take one down and pass it around, 98 bottles of beer on the wall.\n"

  V98 =
    "98 bottles of beer on the wall, 98 bottles of beer.\n" +
    "Take one down and pass it around, 97 bottles of beer on the wall.\n"

  V2 =
    "2 bottles of beer on the wall, 2 bottles of beer.\n" +
    "Take one down and pass it around, 1 bottle of beer on the wall.\n"

  V1 =
    "1 bottle of beer on the wall, 1 bottle of beer.\n" +
    "Take it down and pass it around, no more bottles of beer on the wall.\n"

  V0 =
    "No more bottles of beer on the wall, no more bottles of beer.\n" +
    "Go to the store and buy some more, 99 bottles of beer on the wall.\n"

  describe "Verse" do
    Given(:verse) { Verse.new(n) }

    Invariant { verse.next_verse.number == ((verse.number+99) % 100) }

    context "with 99" do
      Given(:n) { 99 }
      Then { verse.to_s == V99 }
    end

    context "with 98" do
      Given(:n) { 98 }
      Then { verse.to_s == V98 }
    end

    context "with 2" do
      Given(:n) { 2 }
      Then { verse.to_s == V2 }
    end

    context "with 1" do
      Given(:n) { 1 }
      Then { verse.to_s == V1 }
    end

    context "with 0" do
      Given(:n) { 0 }
      Then { verse.to_s == V0 }
    end
  end

  describe Song do
    Given(:song) { Song.new }

    def count(string, pattern)
      string.scan(Regexp.new(Regexp.quote(pattern))).size
    end

    context "with an arbitrary verse" do
      When(:result) { song.verse(99) }
      Then { result == V99 }
   end

    context "with an another arbitrary verse" do
      When(:result) { song.verse(98) }
      Then { result == V98 }
    end

    context "with the ante-penultimate verse" do
      When(:result) { song.verse(2) }
      Then { result == V2 }
    end

    context "with the penultimate verse" do
      When(:result) { song.verse(1) }
      Then { result == V1 }
    end

    context "with the last verse" do
      When(:result) { song.verse(0) }
      Then { result == V0 }
    end

    context "entire song" do
      When(:result) { song.verses(99) }
      Then { count(result, V99 + "\n") == 1 }
      Then { count(result, V98 + "\n") == 1 }
      Then { count(result, V2 + "\n") == 1 }
      Then { count(result, V1 + "\n") == 1 }
      Then { count(result, V0 + "\n") == 1 }
    end
  end
end
