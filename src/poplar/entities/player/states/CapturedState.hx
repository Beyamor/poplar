package poplar.entities.player.states;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.utils.Input;
import nme.filesystem.StorageVolumeInfo;
import poplar.entities.Block;
import poplar.entities.player.Player;
import poplar.support.Grid;

/**
 * ...
 * @author beyamor
 */
class CapturedState extends PlayerState
{
	private var scene(get_scene, null):Scene;
	private var block:Block;
	
	private function get_scene():Scene {
		
		return player.scene;
	}

	public function new(player:Player, block:Block) 
	{
		this.block = block;
		super(player);
	}
	
	override public function enter():Void 
	{
		super.enter();
		player.block = block;
		player.color = block.color;
	}
	
	private function collideBlock(x:Float, y:Float):Entity {
		
		var collision:Entity = null;
		
		if (collision == null) {
			
			collision = scene.collideRect("block", x, y, block.width, block.height);
		}
		
		if (collision == null) {
			
			collision = scene.collideRect("boundary", x, y, block.width, block.height);
		}
		
		return collision;
	}
	
	private function tryShooting():Void {
		
		var canShoot = true;
			
		switch (player.shotDirection) {
		
			case DOWN:
				
				// Check for free space right below the player
				var collisionBelow = collideBlock(player.releaseX, player.releaseY);
				
				// If no collision below, we're good
				// Otherwise, try to reposition the player
				if (collisionBelow != null) {
					
					var bouncedY = collisionBelow.y - block.height - player.height - 1,
						collisionAbove = player.collideTypes(["block", "boundary"], player.x, bouncedY);
					
					// If there's no space above, we can't shoot
					if (collisionAbove != null) {
						
						canShoot = false;
					}
				}
				
			case RIGHT:
				var collisionRight = collideBlock(player.releaseX, player.releaseY);
				
				if (collisionRight != null) {
					
					var bouncedX = collisionRight.x - block.width - player.width,
						collisionLeft = player.collideTypes(["block", "boundary"], bouncedX, player.y);
					
					if (collisionLeft != null) {
						
						canShoot = false;
					}
				}
				
			default:
		}
			
		if (canShoot) {
		
			player.state = new ReleasingState(player);
		}
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (Input.pressed("shoot")) {
			
			tryShooting();
		}
	}
}