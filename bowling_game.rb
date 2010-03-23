# A Ruby attempt at the BowlingGame.
#
# References:
# * http://www.xprogramming.com/xpmag/acsBowling 
# * http://butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata
# * (and even started on the rspec home page http://rspec.info/)
class BowlingGame
  
  NUMBER_OF_FRAMES = 10
  
  # Set up the game. The throws Array holds the number of pins hit per throw
  # and the attempt is the time at which the throw was taken.
  def initialize
    @throws = []
    @attempt = 0
  end
  
  # Add the number of pins hit for a throw
  def record_score(number_of_pins_hit)
    @throws << number_of_pins_hit
  end
  
  # Return the score for the game.
  # Two throws per frame. 
  # If the first throw is a ten (a strike)
  #  then add 10 plus the next two throws to the score.
  # If the two throws together add up to 10 (a spare) 
  #  then add 10 plus the subsequent throw to the score.
  def score
    result = 0
    
    NUMBER_OF_FRAMES.times do
      if strike?
        result += 10 + next_two_throws
      elsif spare?
        result += 10 + next_throw
      else
        result += frame_score
      end
    end
    
    return result
  end
  
  private
  
    # Determine if the current attempt was a strike
    def strike?
      return score_for_attempt == 10
    end
  
    # Determine if the current attempt was a spare
    def spare?
      return (score_for_attempt + score_for_attempt(1)) == 10
    end
  
    # Return the score for the frame assuming that the frame does not include
    # a spare or strike (which is taken into account elsewhere)
    def frame_score
      increment_frame
      return score_for_attempt(-2) + score_for_attempt(-1)
    end
  
    # If a strike was thrown we add the next two throws to the score for the frame
    def next_two_throws
      increment_frame
      return score_for_attempt + score_for_attempt(1)
    end
  
    # If a spare was thrown we add the next throw to the score for the frame
    def next_throw
      increment_frame
      return score_for_attempt
    end

    # Return the number_of_pins_hit in the throws array for the current attempt
    # number. Since the game was designed to increment the attempt for the
    # current roll, the throw_attempt_offset is used to get the number_of_pins_hit
    # relative to the current attempt.
    def score_for_attempt(throw_attempt_offset = 0)
      return @throws[@attempt + throw_attempt_offset].to_i
    end

    # Move the attempt number for the frame 
    # Two throws for a regular frame or a spare, one throw for a strike
    def increment_frame
      advance = strike? ? 1 : 2
      @attempt += advance
    end
  
end
