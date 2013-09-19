package poplar.spawners;
import com.haxepunk.Scene;
import poplar.game.Game;
import poplar.support.Grid;
import poplar.util.Watch;

/**
 * ...
 * @author beyamor
 */
class PeriodicSpawner extends BlockSpawner
{
	private var watch:Watch;

	public function new(scene:Scene, game:Game, intervalInSeconds:Float)
	{
		super(scene, game);
		
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