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
	
	override public function update():Void 
	{
		super.update();
		
		if (wasHit) {
			
			// Cool. Uh. Let's try to keep the player alive, eh?
		var block = player.block;
		
		switch (shotDirection) {
			
			case DOWN:
				
				// Check for free space right below the player
				var collisionBelow = collideBlock(player.releaseX, player.releaseY);
				
				// If no collision below, we're good
				// Otherwise, try to reposition the player
				if (collisionBelow != null) {
					
					var bouncedY = collisionBelow.y - block.height - player.height - 1,
						collisionAbove = player.collideTypes(["block", "boundary"], player.x, bouncedY);
					
					// If there's no space above, we can't shoot
					if (collisionAbove == null) {
						
						player.y = bouncedY;
					}
				}
				
			case RIGHT:
				var collisionRight = collideBlock(player.releaseX, player.releaseY);
				
				if (collisionRight != null) {
					
					var bouncedX = collisionRight.x - block.width - player.width,
						collisionLeft = player.collideTypes(["block", "boundary"], bouncedX, player.y);
					
					if (collisionLeft == null) {
						
						player.x = bouncedX;
					}
				}
				
			default:
		}
		
		player.block = null;
		player.state = new NormalState(player);
		}
	}
	
	public function shotHit():Void {
		
		wasHit = true;
	}
}