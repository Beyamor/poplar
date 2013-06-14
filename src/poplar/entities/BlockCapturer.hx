package poplar.entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import poplar.entities.player.Player;
import poplar.entities.player.states.CapturingState;
import poplar.support.Direction;

/**
 * ...
 * @author beyamor
 */
class BlockCapturer extends Entity
{
	private static var SPEED:Float = 800;
	
	private var player:CapturingState;
	private var xIncrement:Float;
	private var yIncrement:Float;

	public function new(player:CapturingState, x:Float, y:Float, direction:Direction) 
	{
		this.player = player;
		super(x, y, new Image("img/shot.png"));
		
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
				
				if (Std.is(collision, Block)) {
					
					var block = cast(collision, Block);
					
					player.blockHit(block);
					scene.remove(block);
				}
				
				else {
					
					player.shotMissed();
				}
				
				scene.remove(this);
				break;
			}
		}
	}
}