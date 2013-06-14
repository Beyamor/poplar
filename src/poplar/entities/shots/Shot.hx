package poplar.entities.shots;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.HXP;
import poplar.support.Direction;

/**
 * ...
 * @author beyamor
 */
class Shot extends Entity
{
	private static var SPEED:Float = 800;
	
	private var xIncrement:Float;
	private var yIncrement:Float;
	private var direction:Direction;

	public function new(x:Float, y:Float, direction:Direction, graphic:Graphic) 
	{
		this.direction = direction;
		
		super(x, y, graphic);
		
		switch(direction) {
			
			case LEFT:
				xIncrement = -1;
				yIncrement = 0;
				
			case RIGHT:
				xIncrement = 1;
				yIncrement = 0;
				
			case UP:
				xIncrement = 0;
				yIncrement = -1;
				
			case DOWN:
				xIncrement = 0;
				yIncrement = 1;
		}
	}
	
	private function onCollision(collision:Entity):Void {
		
		// Override in subclass
	}
	
	override public function update():Void 
	{
		super.update();
		
		for (posTest in 0...Math.ceil(HXP.elapsed * SPEED)) {
			
			var collision = collideTypes(["block", "boundary"], x + xIncrement, y + yIncrement);
			
			if (collision == null) {
				
				x += xIncrement;
				y += yIncrement;
			}
			
			else {
				
				onCollision(collision);				
				scene.remove(this);
				break;
			}
		}
	}
}