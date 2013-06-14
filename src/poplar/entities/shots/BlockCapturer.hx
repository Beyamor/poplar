package poplar.entities.shots;

import com.haxepunk.Entity;
import poplar.entities.Block;
import poplar.entities.player.Player;
import poplar.entities.player.states.CapturingState;
import poplar.support.Direction;

/**
 * ...
 * @author beyamor
 */
class BlockCapturer extends Shot
{
	private var player:CapturingState;

	public function new(player:CapturingState, x:Float, y:Float, direction:Direction) 
	{
		this.player = player;
		
		super(x, y, direction);
	}
	
	override private function onCollision(collision:Entity):Void 
	{		
		if (Std.is(collision, Block)) {
			
			var block = cast(collision, Block);
			
			player.blockHit(block);
			scene.remove(block);
		}
		
		else {
			
			player.shotMissed();
		}
	}
}