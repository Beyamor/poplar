package poplar;

import com.haxepunk.graphics.Backdrop;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import poplar.entities.Block;
import poplar.entities.Boundary;
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
		
		// Top
		add(new Boundary(0, 0, HXP.width, 80));
		
		// Bottom
		add(new Boundary(0, HXP.height - 80, HXP.width, 80));
		
		// Left
		add(new Boundary(0, 0, 80, HXP.height));
		
		// Right
		add(new Boundary(HXP.width - 80, 0, 80, HXP.height));
		
		
		for (i in 5...10) {
			
			add(new Block(80 + i * Block.WIDTH, 512));
		}
		
		for (i in 1...3) {
			
			var y = 512 - i * Block.HEIGHT;
			add(new Block(512, y));
		}
		
		add(new Player(Block.WIDTH * 5, 200));
	}
}