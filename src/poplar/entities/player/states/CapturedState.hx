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
	private var block:Block;
	private var scene(get_scene, null):Scene;
	private var grid(get_grid, null):Grid;
	
	private function get_scene():Scene {
		
		return player.scene;
	}
	
	private function get_grid():Grid {
		
		return block.grid;
	}

	public function new(player:Player, block:Block) 
	{
		super(player);
		
		this.block = block;
	}
	
	override public function enter():Void 
	{
		super.enter();
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
				
				var releaseX:Float = grid.closestPixelX(player.x - block.halfWidth),
					releaseY:Float = player.y + 1;
				
				// Check for free space right below the player
				var collisionBelow = collideBlock(releaseX, releaseY);
				
				// If no collision below, we're good
				// Otherwise, try to reposition the player
				if (collisionBelow != null) {
					
					var collisionAbove = player.collideTypes(["block", "boundary"], player.x, collisionBelow.y - block.height - 1);
					
					// If there's space above
					if (collisionAbove == null) {
						
						// We can shoot! And hey, move the player there
						player.y = collisionBelow.y - block.height - 1;
					}
					
					// Otherwise, there's no space, so don't try to shoot
					else {
						
						canShoot = false;
					}
				}
				
			default:
		}
			
		if (canShoot) {
		
			player.state = new ReleasingState(player, block);
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