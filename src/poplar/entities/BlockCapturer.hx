package poplar.entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

/**
 * ...
 * @author beyamor
 */
class BlockCapturer extends Entity
{
	private static var SPEED:Float = 800;
	
	private var player:Player;

	public function new(player:Player, x:Float, y:Float) 
	{
		this.player = player;
		super(x, y, new Image("img/shot.png"));
		
		width = height = 24;
		
		centerOrigin();
	}
	
	override public function update():Void 
	{
		super.update();
		
		for (posTest in 0...Math.ceil(HXP.elapsed * SPEED)) {
			
			var xIncrement = 1;
			var yIncrement = 0;
			var collision = collideTypes(["block", "boundary"], x + xIncrement, y + yIncrement);
			
			if (collision == null) {
				
				x += xIncrement;
				y += yIncrement;
			}
			
			else {
				
				if (Std.is(collision, Block)) {
					
					var block = cast(collision, Block);
					
					player.color = block.color;
					scene.remove(block);
				}
				
				scene.remove(this);
				break;
			}
		}
	}
}