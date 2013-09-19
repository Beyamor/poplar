package poplar.entities;
import com.haxepunk.Entity;
import poplar.support.Direction;

/**
 * ...
 * @author beyamor
 */
class ShotBlock extends Block
{
	private var shotDirection:Direction;

	public function new(originalBlock:Block, shotDirection:Direction) 
	{
		super(originalBlock.game, originalBlock.x, originalBlock.y, originalBlock.color);
		
		this.shotDirection = shotDirection;
	}
	
	override public function added():Void 
	{
		super.added();
		
		// So, uh, to prevent the player from smooshing themself with their own block,
		// we want to bounce them away from the shot block when it first enters the world
		var player:Entity = collide("player", x, y);
		if (player == null) return;
		
		switch (shotDirection) {
			
			case DOWN:
				player.y = y - player.height;
				
			case RIGHT:
				player.x = x - player.width;
				
			case LEFT:
				player.x = x + width;
				
			case UP:
				player.y = y + height;
		}
	}
}