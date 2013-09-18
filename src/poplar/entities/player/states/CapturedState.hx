package poplar.entities.player.states;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.utils.Input;
import nme.filesystem.StorageVolumeInfo;
import poplar.entities.Block;
import poplar.entities.player.Player;
import poplar.support.Direction;
import poplar.support.Grid;
import poplar.support.ShotInputInterpreter;

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
		
		
		var shotDirection:Direction = ShotInputInterpreter.direction,
			canShoot = player.canShootForwards(shotDirection) || player.canBeMovedBackwards(shotDirection);
			
		if (canShoot) {
		
			player.state = new ReleasingState(player, block, shotDirection);
		}
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (ShotInputInterpreter.isTryingToShoot) {
			
			tryShooting();
		}
	}
}