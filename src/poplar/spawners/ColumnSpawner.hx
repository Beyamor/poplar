package poplar.spawners;
import com.haxepunk.Scene;
import flash.geom.Point;
import poplar.entities.Block;
import poplar.game.Game;
import poplar.support.Grid;
import poplar.util.Watch;

/**
 * ...
 * @author beyamor
 */
class ColumnSpawner extends BlockSpawner
{
	private var watch:Watch;
	private var colorIndex:Int = 0;

	public function new(scene:Scene, game:Game, intervalInSeconds:Float)
	{
		super(scene, game);
		
		watch = new Watch(intervalInSeconds);
		watch.addCallback(function():Void {
			
			spawnNextBlock();
		});
		watch.loops = true;
	}
	
	override private function spawnNextBlock():Void 
	{
		var pos = new Point(grid.xIndexToPixel(6), -Block.HEIGHT);
		
		var color = Block.colors[colorIndex % Block.colors.length];
		++colorIndex;
		
		scene.add(new Block(game, pos.x, pos.y, color));
	}
	
	override public function update():Void 
	{
		super.update();
		
		watch.update();
	}
}