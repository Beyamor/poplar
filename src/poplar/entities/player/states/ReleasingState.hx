package poplar.entities.player.states;
import com.haxepunk.Entity;
import poplar.entities.Block;
import poplar.entities.player.Player;
import poplar.entities.shots.BlockReleaser;
import poplar.entities.shots.Shot;
import poplar.GameScene;
import poplar.support.Direction;

/**
 * ...
 * @author beyamor
 */
class ReleasingState extends PlayerState
{
	private var shotDirection:Direction;
	
	public var wasHit:Bool = false;
	
	public function new(player:Player) 
	{
		super(player);
		shotDirection = player.shotDirection;
	}
	
	override public function enter():Void 
	{
		super.enter();
		
		var shot = new BlockReleaser(
			this,
			player.block,
			player.releaseX,
			player.releaseY,
			player.shotDirection
		);
		player.scene.add(shot);
		
		player.color = 0xFFFFFF;
	}
	
	private function collideBlock(x:Float, y:Float):Entity {
		
		var collision:Entity = null;
		
		if (collision == null) {
			
			collision = player.scene.collideRect("block", x, y, player.block.width, player.block.height);
		}
		
		if (collision == null) {
			
			collision = player.scene.collideRect("boundary", x, y, player.block.width, player.block.height);
		}
		
		return collision;
	}
	
	public function shotHit():Void {
		
		player.state = new NormalState(player);
	}
}