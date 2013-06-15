package poplar.spawners;
import com.haxepunk.Scene;
import com.haxepunk.utils.Input;
import poplar.support.Grid;

/**
 * ...
 * @author beyamor
 */
class ManualSpawner extends BlockSpawner
{

	public function new(scene:Scene, grid:Grid)
	{
		super(scene, grid);
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (Input.pressed("spawnBlock")) spawnNextBlock();
	}
}