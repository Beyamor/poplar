package poplar.spawners;

import com.haxepunk.Scene;
import com.haxepunk.World;
import flash.geom.Point;
import poplar.entities.Block;
import poplar.game.Game;
import poplar.support.Grid;
import poplar.util.Updateable;
import poplar.util.Watch;

/**
 * ...
 * @author beyamor
 */
class BlockSpawner implements Updateable
{
	private var scene:Scene;
	private var game:Game;
	
	private var grid(get_grid, null):Grid;

	public function new(scene:Scene, game:Game) 
	{
		this.scene = scene;
		this.game = game;
	}
	
	private function spawnNextBlock():Void {
		
		var pos = new Point(grid.anyPixelX(), -Block.HEIGHT);
		var color = Block.colors[Math.floor(Math.random() * Block.colors.length)];
		scene.add(new Block(game, pos.x, pos.y, color));
	}
	
	public function update():Void {
		
		// Override in subclass
	}
	
	private function get_grid():Grid {
		
		return game.grid;
	}
}