package poplar;

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
		
		for (i in 0...Math.ceil(HXP.width / Block.WIDTH)) {
			
			add(new Block(i * Block.WIDTH, 400));
		}
		
		add(new Player(Block.WIDTH * 5, 200));
	}
}