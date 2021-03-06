module Beer

  class Verse
    attr_reader :number

    CACHE = { }

    def self.new(n)
      CACHE[n] || super(n)
    end

    def self.cached
      obj = new
      CACHE[obj.number] = obj
    end

    def initialize(n)
      @number = n
    end

    def to_s
      "#{on_the_wall.capitalize}, #{of_beer}.\n" +
        "#{action}, #{next_verse.on_the_wall}.\n"
    end

    def next_verse
      Verse.new(pred)
    end

    protected

    def on_the_wall
      "#{of_beer} on the wall"
    end

    private

    def pred
      number - 1
    end

    def of_beer
      "#{amount} #{bottles} of beer"
    end

    def bottles
      "bottles"
    end

    def pronoun
      "one"
    end

    def amount
      @number.to_s
    end

    def action
      "Take #{pronoun} down and pass it around"
    end

    class HardwiredVerse < Verse
      def self.new
        super(:ignore)
      end
    end

    class Zero < HardwiredVerse
      def initialize(_)
        super(0)
      end

      def pred
        99
      end

      def amount
        "no more"
      end

      def action
        "Go to the store and buy some more"
      end

      cached
    end

    class One < HardwiredVerse
      def initialize(_)
        super(1)
      end

      def bottles
        "bottle"
      end

      def pronoun
        "it"
      end

      cached
    end
  end

  class Song
    def verses(start, finish=0)
      start.downto(finish).map { |n| verse(n) + "\n" }.join
    end

    def verse(n)
      Verse.new(n).to_s
    end
  end
end
