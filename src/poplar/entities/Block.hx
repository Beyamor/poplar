package poplar.entities;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import nme.display.BitmapData;
import poplar.support.Grid;

/**
 * ...
 * @author beyamor
 */ 
class Block extends Entity
{	
	private static var colors:Array<Int> = [0xE01B1B, 0x3485F7, 0x32ED11, 0xF5952F, 0xFCED12, 0xF285D2];
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
	
	public function new(x:Float, y:Float, grid:Grid) 
	{		
		this.grid = grid;
		
		var sprite = new Image("img/block.png");
		sprite.color = color = nextColor();
		
		super(x, y, sprite);
		
		width	= WIDTH;
		height	= HEIGHT;
		type	= "block";
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (collideTypes(["block", "boundary"], x, y + 1) == null) {
			
			yVel = FALL_SPEED;
			
			for (yTest in 0...Math.ceil(yVel * HXP.elapsed)) {
				
				var yIncrement = 1;
				
				if (collideTypes(["block", "boundary"], x, y + yIncrement) == null) {
					
					y += yIncrement;
				}
				
				else {
					
					break;
				}
			}
		}
		
		else {
			
			if (yVel != 0) {
			
				yVel = 0;
				x = grid.closestPixelX(x);
				y = grid.closestPixelY(y);
			}
		}
	}
}