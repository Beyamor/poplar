package poplar.entities.player;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import poplar.entities.Block;
import poplar.entities.player.states.NormalState;
import poplar.entities.player.states.PlayerState;
import poplar.game.Game;
import poplar.support.Direction;
import poplar.support.Grid;

/**
 * ...
 * @author beyamor
 */
class Player extends Entity
{
	public static var	GRAVITY:Float					= 2000;
	public static var	HORIZONTAL_ACCELERATION:Float	= 2000;
	public static var	MAX_HORIZONTAL_SPEED:Float		= 250;
	public static var	FRICTION:Float					= 2000;
	public static var	JUMP_VELOCITY:Float				= 700;
	
	public var	xVel:Float	= 0;
	public var	yVel:Float	= 0;
	private var sprite:Image;
	public var game(default, null):Game;
	private var grid(get_grid, null):Grid;
	private var movementControl:PlayerMovement;
	
	public var color(null, set_color):Int;
	public var state(null,set_state):PlayerState;

	public function new(game:Game, x:Float, y:Float) 
	{		
		this.game = game;
		
		sprite = new Image("img/player.png");
		
		super(x, y, sprite);
		
		width			= Math.floor(Block.WIDTH * 0.75);
		height			= Block.HEIGHT;
		state			= new NormalState(this);
		
		sprite.x		= -(sprite.width - width) / 2;
		
		type = "player";
		
		movementControl = new PlayerMovement(this);
	}
	
	private function die():Void {
		
		if (scene != null) scene.remove(this);
		game.respondToPlayerDying();
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
				
				y		= initialCollision.bottom;
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
		
		movementControl.checkHorizontal();
		
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
		
		movementControl.checkVertical();
		
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
	
	public function getReleaseX(shotDirection:Direction):Float {
		
		switch (shotDirection) {
			
			case DOWN, UP:
				return grid.closestPixelX(x);
				
			case RIGHT:
				return x + width;
				
			case LEFT:
				return x - Block.WIDTH;
		}
	}
	
	public function getReleaseY(shotDirection:Direction):Float {
		
		switch (shotDirection) {
			
			case DOWN:
				return y + height;
				
			case RIGHT, LEFT:
				return y;
				
			case UP:
				return y - Block.HEIGHT;
		}
	}
	
	private function collideBlock(x:Float, y:Float):Entity {
		
		var collision:Entity = null;
		
		if (collision == null) {
			
			collision = scene.collideRect("block", x, y, Block.WIDTH, Block.HEIGHT);
		}
		
		if (collision == null) {
			
			collision = scene.collideRect("boundary", x, y, Block.WIDTH, Block.HEIGHT);
		}
		
		return collision;
	}
	
	public function canShootForwards(shotDirection:Direction):Bool {
		
		return (collideBlock(getReleaseX(shotDirection), getReleaseY(shotDirection)) == null);
	}
	
	public function canBeMovedBackwards(shotDirection:Direction):Bool {
		
		var	forwardCollision = collideBlock(getReleaseX(shotDirection), getReleaseY(shotDirection)),
			bouncedX:Float = x,
			bouncedY:Float = y;
			
		switch (shotDirection) {
			
			case DOWN:
				bouncedY = forwardCollision.top - Block.HEIGHT - height;
				
			case RIGHT:
				bouncedX = forwardCollision.left - Block.WIDTH - width;
				
			case LEFT:
				bouncedX = forwardCollision.right + Block.WIDTH;
				
			case UP:
				bouncedY = forwardCollision.bottom + Block.HEIGHT;
		}
		
		return (collideTypes(["block", "boundary"], bouncedX, bouncedY) == null);
	}
	
	private function get_grid():Grid {
		
		return game.grid;
	}
}