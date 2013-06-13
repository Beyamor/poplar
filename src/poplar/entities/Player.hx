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
	
	override public function update():Void 
	{
		super.update();
		
		var	tryingToMoveHorizontally:Bool = false;
		
		if (Input.check("left")) {
			
			xVel -= HORIZONTAL_ACCELERATION * HXP.elapsed;
			tryingToMoveHorizontally = true;
		}
		
		if (Input.check("right")) {
			
			xVel += HORIZONTAL_ACCELERATION * HXP.elapsed;
			tryingToMoveHorizontally = true;
		}
		
		if (!tryingToMoveHorizontally)	{
			
			var frictionAmount = Math.min(FRICTION * HXP.elapsed, Math.abs(xVel));
			xVel -= frictionAmount * HXP.sign(xVel);
		}
		
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
		
		var canJump:Bool = false;
		
		for (yTest in 0...Math.ceil(Math.abs(yVel * HXP.elapsed))) {
			
			var yIncrement = HXP.sign(yVel);
			
			if (collideTypes(["block", "boundary"], x, y + yIncrement) == null) {
				
				y += yIncrement;
			}
			
			else {
				
				yVel = 0;
				canJump = true;
				break;
			}
		}
		
		if (canJump && Input.pressed("jump")) {
			
			yVel -= JUMP_VELOCITY;
		}
		
		yVel += GRAVITY * HXP.elapsed;
	}
}