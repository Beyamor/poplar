package poplar.entities.player;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import poplar.entities.Block;
import poplar.entities.player.states.NormalState;
import poplar.entities.player.states.PlayerState;
import poplar.support.Direction;
import poplar.support.Grid;

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
	private var lastHorizontalShotDirection:Direction;
	private var grid:Grid;
	
	public var shotDirection(default, null):Direction;
	public var color(null, set_color):Int;
	public var state(null,set_state):PlayerState;
	public var releaseX(get_releaseX,null):Float;
	public var releaseY(get_releaseY, null):Float;
	
	public var block:Block;

	public function new(grid:Grid, x:Float, y:Float) 
	{		
		this.grid = grid;
		
		sprite = new Image("img/player.png");
		
		super(x, y, sprite);
		
		width			= Math.floor(Block.WIDTH * 0.75);
		height			= Block.HEIGHT;
		//originX			= Math.floor(width / 2);
		//originY			= height;		
		shotDirection	= RIGHT;
		state			= new NormalState(this);
		
		sprite.x		= -(sprite.width - width) / 2;
		//sprite.x		= -sprite.width / 2;
		//sprite.y		= -height;
		
		shotDirection = lastHorizontalShotDirection = RIGHT;
	}
	
	private function die():Void {
		
		x = HXP.halfWidth;
		y = HXP.halfHeight;
	}
	
	override public function update():Void 
	{
		super.update();
		
		// Last update might've set shot direction to up or down
		// However, we only want to shoot that way if up or down is held
		shotDirection = lastHorizontalShotDirection;
		
		// If a block moved onto this entity
		var initialCollision = collide("block", x, y);
		if (initialCollision != null) {
			
			var freeSpace = (initialCollision.collideTypes(
								["block", "boundary"], initialCollision.x, initialCollision.y + Block.HEIGHT)
							== null);
							
			// If free space exists below the block,
			// move into it
			if (freeSpace) {
				
				y		= initialCollision.y + height + Block.HEIGHT;
				yVel	= (cast(initialCollision, Block)).yVel;
			}
			
			// Otherwise, die?
			else {
				
				die();
				//HXP.console.paused = true;
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
			shotDirection = lastHorizontalShotDirection = LEFT;
		}
		
		if (Input.check("right")) {
			
			xVel += HORIZONTAL_ACCELERATION * HXP.elapsed;
			tryingToMoveHorizontally = true;
			shotDirection = lastHorizontalShotDirection = RIGHT;
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
	
	private function get_releaseX():Float {
		
		switch (shotDirection) {
			
			case DOWN:
				return grid.closestPixelX(x);
				
			case RIGHT:
				return x + width;
				
			default:
				return grid.closestPixelX(x);
		}
	}
	
	private function get_releaseY():Float {
		
		switch (shotDirection) {
			
			case DOWN:
				return y + height;
				
			case RIGHT:
				return y;
				
			default:
				return y;
		}
	}
}