package poplar.entities.shots;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import poplar.entities.Block;
import poplar.entities.player.states.ReleasingState;
import poplar.support.Direction;

/**
 * ...
 * @author beyamor
 */
class BlockReleaser extends Shot
{
	private var player:ReleasingState;
	private var block:Block;

	public function new(player:ReleasingState, block:Block, x:Float, y:Float, direction:Direction) 
	{
		this.player	= player;
		this.block	= block;
		
		var sprite:Image = new Image("img/block.png");
		sprite.x = -sprite.width / 2;
		sprite.y = -sprite.height / 2;
		sprite.color = block.color;
		
		super(x, y, direction, sprite);
		
		width = block.width;
		height = block.height;
		centerOrigin();
	}
	
	override private function onCollision(collision:Entity):Void 
	{
		block.x = (collision.x < x)? (collision.right) : (collision.left - block.width);
		block.y = y - halfHeight;
		block.yVel = 0;
		scene.add(block);
		player.shotHit();
	}
}