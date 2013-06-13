package poplar.entities;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

/**
 * ...
 * @author beyamor
 */
class Player extends Entity
{

	public function new(x:Float, y:Float) 
	{		
		var sprite = new Image("img/player.png");
		
		super(x, y, sprite);
		
		width	= Block.WIDTH;
		height	= Block.HEIGHT;
	}
	
}