package poplar.entities;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import nme.display.BitmapData;

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
	
	public static var	WIDTH:Int	= 48;
	public static var	HEIGHT:Int	= 48;
	
	public function new(x:Float, y:Float) 
	{		
		var sprite = new Image("img/block.png");
		sprite.color = nextColor();
		
		super(x, y, sprite);
		
		width	= WIDTH;
		height	= HEIGHT;
	}
	
}