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
	public function new(x:Float, y:Float) 
	{
		super(x, y, new Image("img/block.png"));
	}
	
}