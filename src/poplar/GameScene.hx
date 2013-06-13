package poplar;

import com.haxepunk.graphics.Backdrop;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import poplar.entities.Block;
import poplar.entities.Player;

/**
 * ...
 * @author beyamor
 */
class GameScene extends Scene
{

	public function new() 
	{
		super();
	}

	override public function begin():Dynamic 
	{
		super.begin();
		
		addGraphic(new Backdrop("img/background.png"), 100);
		
		for (i in 0...10) {
			
			add(new Block(80 + i * Block.WIDTH, 512));
		}
		
		for (i in 0...3) {
			
			var y = 512 - i * Block.HEIGHT;
			add(new Block(80, y));
			add(new Block(512, y));
		}
		
		add(new Player(Block.WIDTH * 5, 200));
	}
}