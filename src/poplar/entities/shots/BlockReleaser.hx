package poplar.entities.shots;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import poplar.entities.Block;
import poplar.entities.player.states.ReleasingState;
import poplar.entities.ShotBlock;
import poplar.GameScene;
import poplar.support.Direction;

/**
 * ...
 * @author beyamor
 */
class BlockReleaser extends Shot
{
	private var playerState:ReleasingState;
	private var block:Block;

	public function new(playerState:ReleasingState, block:Block, x:Float, y:Float, direction:Direction) 
	{
		this.playerState	= playerState;
		this.block	= new ShotBlock(block, direction);
		
		var sprite:Image = new Image("img/block.png");
		sprite.color = block.color;
		
		super(x, y, direction, sprite);
		
		width = block.width;
		height = block.height;
	}
	
	override private function onCollision(collision:Entity):Void 
	{
		switch (direction) {
			
			case LEFT, RIGHT:
				block.x = (collision.x < x)? (collision.right) : (collision.left - block.width);
				block.y = y;
				
			case UP, DOWN:
				block.x = x;
				block.y = (collision.y < y)? (collision.bottom) : (collision.top - block.height);
				
				if (Std.is(collision, Block)) {
					
					var otherBlock = cast(collision, Block);
					block.yVel = otherBlock.yVel;
					block.y += otherBlock.yVel * HXP.elapsed;
				}
		}
		
		block.yVel = 0;
		scene.add(block);
		block.grid.checkForMatches(block);
		playerState.shotHit();
	}
}