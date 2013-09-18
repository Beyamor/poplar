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
		
		var canShoot = player.canShootForwards() || player.canBeMovedBackwards();
			
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