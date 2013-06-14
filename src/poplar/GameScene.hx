package poplar;

import com.haxepunk.graphics.Backdrop;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import poplar.control.BlockSpawner;
import poplar.entities.Block;
import poplar.entities.Boundary;
import poplar.entities.player.Player;
import poplar.support.Grid;

/**
 * ...
 * @author beyamor
 */
class GameScene extends Scene
{
	private var blockSpawner:BlockSpawner;

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
		
		add(new Player(Block.WIDTH * 5, 200));
		
		blockSpawner = new BlockSpawner(this, grid);
	}
	
	override public function update():Dynamic 
	{
		super.update();
		
		blockSpawner.update();
	}
}