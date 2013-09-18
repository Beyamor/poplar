package poplar.entities;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import nme.display.BitmapData;
import poplar.GameScene;
import poplar.support.Grid;

/**
 * ...
 * @author beyamor
 */ 
class Block extends Entity
{	
	public static var colors:Array<Int> = [0xE01B1B, 0x3485F7, 0x32ED11, 0xF5952F, 0xFCED12, 0xF285D2];
	private static var colorIndex:Int = 0;
	private static function nextColor():Int {
		var color = colors[colorIndex % colors.length];
		++colorIndex;
		return color;
	}
	
	public static var	WIDTH:Int			= 48;
	public static var	HEIGHT:Int			= 48;
	public static var	FALL_SPEED:Float	= 200;
	
	public var yVel:Float = 0;
	public var color(default, null):Int;
	public var grid:Grid;
	
	private var hasEnteredArena:Bool = false;
	
	public function new(x:Float, y:Float, grid:Grid, color:UInt) 
	{		
		this.grid = grid;
		
		var sprite = new Image("img/block.png");
		sprite.color = this.color = color;
		
		super(x, y, sprite);
		
		width	= WIDTH;
		height	= HEIGHT;
		type	= "block";
	}
	
	private function stopMoving():Void {
		
		yVel = 0;
		x = grid.closestPixelX(x);
		y = grid.closestPixelY(y);
		
		var wasMatched = grid.checkForMatches(this);
		
		// if above arena and not removed, game over baby
		if (!wasMatched && y < grid.pixelDimensions.top) {
			
			if (Std.is(scene, GameScene)) {
				
				(cast(scene, GameScene)).respondToBlockOutsideArena();
			}
		}
	}
	
	private function collidableTypes():Array<String> {
		
		if (hasEnteredArena) return ["block", "boundary"];
		else return ["block"];
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (y >= grid.pixelDimensions.top) hasEnteredArena = true;
		
		if (collideTypes(collidableTypes(), x, y + 1) == null) {
			
			yVel = FALL_SPEED;
			
			for (yTest in 0...Math.ceil(yVel * HXP.elapsed)) {
				
				var yIncrement = 1;
				
				if (collideTypes(collidableTypes(), x, y + yIncrement) == null) {
					
					y += yIncrement;
				}
				
				else {
					
					stopMoving();
					break;
				}
			}
		}
		
		else {
			
			if (yVel != 0) {
			
				stopMoving();
			}
		}
	}
}