require 'bowling_game'

describe BowlingGame do

	before(:each) do
    @bowling_game = BowlingGame.new
  end

	it 'should create a new instance of bowling game' do
	  @bowling_game.should_not be_nil
  end
  
  it 'should have a score of zero for a gutter ball' do
    @bowling_game.record_score(0)
    @bowling_game.score.should == 0
  end

  it 'should have a score of 1 for one pin hit' do
    @bowling_game.record_score(1)
    @bowling_game.score.should == 1
  end
  
  it 'should have a frame score of 9 for nine pins hit in two throws' do
    @bowling_game.record_score(5)
    @bowling_game.record_score(4)
    @bowling_game.score.should == 9
  end

  it 'should add the next throw to the current frame for a spare' do
    @bowling_game.record_score(5)
    @bowling_game.record_score(5)
    @bowling_game.record_score(1)
    
    @bowling_game.score.should == 12
  end
  
  it 'should add the next two throws to the current frame for a strike' do
    
    @bowling_game.record_score(10)
    @bowling_game.record_score(1)
    @bowling_game.record_score(1)
    
    @bowling_game.score.should == 14
  end

  it 'should have a score of zero for an all gutter game' do
    20.times { @bowling_game.record_score(0) }
    @bowling_game.score.should == 0
  end

  it 'should have a score of 20 for a game of all ones' do
    20.times { @bowling_game.record_score(1) }
    @bowling_game.score.should == 20
  end
    
  it 'should have a perfect score of 300 for all strikes (10 per roll)' do
    12.times { @bowling_game.record_score(10) }
    @bowling_game.score.should == 300
  end

  it 'should have a score of 150 for a game of all spares (5 per roll)' do
    21.times { @bowling_game.record_score(5) }
    @bowling_game.score.should == 150
  end
  
  # And now that I find that there was a ruby quiz for the bowling game
  # (http://rubyquiz.strd6.com/quizzes/181)
  # let's see if the game works as expected
  it 'should have a score of 140 for the ruby quiz # 181' do
    scores = [6,2,7,1,10,9,0,8,2,10,10,3,5,7,2,5,5,8]
    scores.each { |score| @bowling_game.record_score(score) }
    @bowling_game.score.should == 140
  end
  


end

