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
	public static var	WIDTH:Int	= 48;
	public static var	HEIGHT:Int	= 48;
	
	public function new(x:Float, y:Float) 
	{
		super(x, y, new Image("img/block.png"));
	}
	
}