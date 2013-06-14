package poplar.entities;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;

/**
 * ...
 * @author beyamor
 */
class Player extends Entity
{
	private static var	GRAVITY:Float					= 2000;
	private static var	HORIZONTAL_ACCELERATION:Float	= 2000;
	private static var	MAX_HORIZONTAL_SPEED:Float		= 250;
	private static var	FRICTION:Float					= 2000;
	private static var	JUMP_VELOCITY:Float				= 700;
	
	private var	xVel:Float	= 0;
	private var	yVel:Float	= 0;

	public function new(x:Float, y:Float) 
	{		
		var sprite = new Image("img/player.png");
		
		super(x, y, sprite);
		
		width	= Block.WIDTH;
		height	= Block.HEIGHT;
	}
	
	private function die():Void {
		
		x = HXP.halfWidth;
		y = HXP.halfHeight;
	}
	
	override public function update():Void 
	{
		super.update();
		
		// If a block moved onto this entity
		var initialCollision = collide("block", x, y);
		if (initialCollision != null) {
			
			var freeSpace = (initialCollision.collideTypes(
								["block", "boundary"], initialCollision.x, initialCollision.y + Block.HEIGHT)
							== null);
							
			// If free space exists below the block,
			// move into it
			if (freeSpace) {
				
				y		= initialCollision.y + Block.HEIGHT;
				yVel	= (cast(initialCollision, Block)).yVel;
			}
			
			// Otherwise, die?
			else {
				
				die();
				return;
			}
		}
		
		// Cool. Okay. At this point, we should be free of any blocks.
		// Let's move on to the regular motion.
		// Apply gravity
		yVel += GRAVITY * HXP.elapsed;
		
		// Check for horizontal movement
		var	tryingToMoveHorizontally:Bool = false;
		
		if (Input.check("left")) {
			
			xVel -= HORIZONTAL_ACCELERATION * HXP.elapsed;
			tryingToMoveHorizontally = true;
		}
		
		if (Input.check("right")) {
			
			xVel += HORIZONTAL_ACCELERATION * HXP.elapsed;
			tryingToMoveHorizontally = true;
		}
		
		// If the player is not trying to move, apply friction
		if (!tryingToMoveHorizontally)	{
			
			var frictionAmount = Math.min(FRICTION * HXP.elapsed, Math.abs(xVel));
			xVel -= frictionAmount * HXP.sign(xVel);
		}
		
		// Alright. Stepwise move in x axis.
		xVel = HXP.clamp(xVel, -MAX_HORIZONTAL_SPEED, MAX_HORIZONTAL_SPEED);
		for (xTest in 0...Math.ceil(Math.abs(xVel * HXP.elapsed))) {
			
			var xIncrement = HXP.sign(xVel);
			
			if (collideTypes(["block", "boundary"], x + xIncrement, y) == null) {
				
				x += xIncrement;
			}
			
			else {
				
				xVel = 0;
			}
		}
		
		// Stepwise move in y axis
		for (yTest in 0...Math.ceil(Math.abs(yVel * HXP.elapsed))) {
			
			var yIncrement = HXP.sign(yVel);
			var collision = collideTypes(["block", "boundary"], x, y + yIncrement);
			
			// If we didn't hit anything, keep going
			if (collision == null) {
				
				y += yIncrement;
			}
			
			// Otherwise, whoa, collision
			else {
				
				// If it's a block, match its speed
				// (this should let us fall on blocks consistently)
				if (Std.is(collision, Block)) {
					
					yVel = (cast(collision, Block)).yVel;
				}
				
				else {
				
					yVel = 0;
				}
				break;
			}
		}
		
		// And handle jumping
		var canJump = (yVel == 0) && (collideTypes(["block", "boundary"], x, y + 1) != null);
		if (canJump && Input.pressed("jump")) {
			
			yVel -= JUMP_VELOCITY;
		}
	}
}