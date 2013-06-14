package poplar.control;

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
	private var watch:Watch;

	public function new(scene:Scene, grid:Grid) 
	{
		watch = new Watch(2);
		watch.addCallback(function():Void {
			
			var pos = grid.pixelPos(grid.anyX(), 0);
			scene.add(new Block(pos.x, pos.y, grid));
		});
		watch.loops = true;
	}
	
	public function update():Void {
		
		watch.update();
	}
}