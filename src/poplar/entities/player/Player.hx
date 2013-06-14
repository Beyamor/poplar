package poplar.entities.player;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import poplar.entities.Block;
import poplar.entities.player.states.NormalState;
import poplar.entities.player.states.PlayerState;
import poplar.support.Direction;

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
	private var sprite:Image;
	
	public var shotDirection(default, null):Direction;
	public var color(null, set_color):Int;
	public var state(null,set_state):PlayerState;

	public function new(x:Float, y:Float) 
	{		
		sprite = new Image("img/player.png");
		
		super(x, y, sprite);
		
		width			= Block.WIDTH;
		height			= Block.HEIGHT;
		shotDirection	= RIGHT;
		state			= new NormalState(this);
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
			shotDirection = LEFT;
		}
		
		if (Input.check("right")) {
			
			xVel += HORIZONTAL_ACCELERATION * HXP.elapsed;
			tryingToMoveHorizontally = true;
			shotDirection = RIGHT;
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
		var canJump = (collideTypes(["block", "boundary"], x, y + 1) != null);
		if (canJump && Input.pressed("jump")) {
			
			yVel = -JUMP_VELOCITY;
		}
		
		if (Input.check("up"))		shotDirection = UP;
		if (Input.check("down"))	shotDirection = DOWN;
		
		// Nice. Let the states have atter
		state.update();
	}
	
	private function set_color(newColor:Int):Int {
		
		sprite.color = newColor;
		return newColor;
	}
	
	private function set_state(newState:PlayerState):PlayerState {
		
		state = newState;
		state.enter();
		return state;
	}
}