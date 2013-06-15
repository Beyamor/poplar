package poplar.spawners;

import com.haxepunk.Scene;
import com.haxepunk.World;
import poplar.entities.Block;
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
	private var grid:Grid;

	public function new(scene:Scene, grid:Grid) 
	{
		this.scene = scene;
		this.grid = grid;
	}
	
	private function spawnNextBlock():Void {
		
		var pos = grid.pixelPos(grid.anyX(), 0);
		scene.add(new Block(pos.x, pos.y, grid));
	}
	
	public function update():Void {
		
		// Override in subclass
	}
}