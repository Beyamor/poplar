package poplar.spawners;
import com.haxepunk.Scene;
import poplar.support.Grid;
import poplar.util.Watch;

/**
 * ...
 * @author beyamor
 */
class PeriodicSpawner extends BlockSpawner
{
	private var watch:Watch;

	public function new(scene:Scene, grid:Grid, intervalInSeconds:Float)
	{
		super(scene, grid);
		
		watch = new Watch(intervalInSeconds);
		watch.addCallback(function():Void {
			
			spawnNextBlock();
		});
		watch.loops = true;
	}
	
	override public function update():Void 
	{
		super.update();
		
		watch.update();
	}
}