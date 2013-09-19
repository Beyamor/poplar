package poplar.entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import poplar.game.Game;

/**
 * ...
 * @author beyamor
 */
class ScoreDisplay extends Entity
{
	private var lastScoreSeen:Int = 0;
	private var game:Game;
	private var text:Text;

	public function new(game:Game, x:Float, y:Float)
	{
		this.game = game;
		lastScoreSeen = game.totalScore;
		
		text = new Text(scoreText());
		super(x, y, text);
		
		layer = -100;
	}
	
	private function scoreText():String {
		
		return game.totalScore + " points";
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (game.totalScore != lastScoreSeen) {
			
			lastScoreSeen = game.totalScore;
			text.text = scoreText();
		}
	}
}