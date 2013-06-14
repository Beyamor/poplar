package poplar.entities.shots;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
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
	private var sprite:Image;

	public function new(x:Float, y:Float, direction:Direction) 
	{
		sprite = new Image("img/shot.png");
		super(x, y, sprite);
		
		width = height = 24;
		
		centerOrigin();
		
		switch(direction) {
			
			case LEFT:
				xIncrement = -1;
				yIncrement = 0;
				
			case RIGHT:
				xIncrement = 1;
				yIncrement = 0;
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