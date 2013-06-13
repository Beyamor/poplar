package poplar;

import com.haxepunk.graphics.Backdrop;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import poplar.entities.Block;
import poplar.entities.Boundary;
import poplar.entities.Player;
import poplar.support.Grid;

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
		
		var grid = new Grid();
		
		var	boundaryHeight	= Math.floor(grid.pixelDimensions.top);
		var boundaryWidth	= Math.floor(grid.pixelDimensions.left);
		
		// Top
		add(new Boundary(0, 0, HXP.width, boundaryHeight));
		
		// Bottom
		add(new Boundary(0, HXP.height - boundaryHeight, HXP.width, boundaryHeight));
		
		// Left
		add(new Boundary(0, 0, boundaryWidth, HXP.height));
		
		// Right
		add(new Boundary(HXP.width - boundaryWidth, 0, boundaryWidth, HXP.height));
		
		
		for (i in 5...10) {
			
			var pos = grid.pixelPos(i, grid.height - 1);
			add(new Block(pos.x, pos.y));
		}
		
		for (i in 1...3) {
			
			var pos = grid.pixelPos(grid.width - 1, grid.height - 1 - i);
			add(new Block(pos.x, pos.y));
		}
		
		add(new Player(Block.WIDTH * 5, 200));
	}
}