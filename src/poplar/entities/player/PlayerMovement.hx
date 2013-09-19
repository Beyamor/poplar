package poplar.entities.player;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;

/**
 * ...
 * @author beyamor
 */
class PlayerMovement
{
	private var player:Player;

	public function new(player:Player) 
	{
		this.player = player;
	}
	
	public function checkHorizontal():Void {
		
		if (!player.game.isAllowingPlayerMovement) return;
		
		var	tryingToMoveHorizontally:Bool = false;
		
		if (Input.check("move-left")) {
			
			player.xVel -= Player.HORIZONTAL_ACCELERATION * HXP.elapsed;
			tryingToMoveHorizontally = true;
		}
		
		if (Input.check("move-right")) {
			
			player.xVel += Player.HORIZONTAL_ACCELERATION * HXP.elapsed;
			tryingToMoveHorizontally = true;
		}
		
		// If the player is not trying to move, apply friction
		if (!tryingToMoveHorizontally)	{
			
			var frictionAmount = Math.min(Player.FRICTION * HXP.elapsed, Math.abs(player.xVel));
			player.xVel -= frictionAmount * HXP.sign(player.xVel);
		}
	}
	
	public function checkVertical():Void {
		
		if (!player.game.isAllowingPlayerMovement) return;
		
		var canJump = (player.collideTypes(["block", "boundary"], player.x, player.y + 1) != null);
		if (canJump && Input.pressed("jump")) {
			
			player.yVel = -Player.JUMP_VELOCITY;
		}
	}
}