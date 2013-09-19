package poplar;

import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.utils.Input;

/**
 * ...
 * @author beyamor
 */
class IntroScene extends Scene
{

	public function new() 
	{
		super();
		
		var title:Text = new Text("Poplar", 0, 0, 0, 0, { size: 48, color: 0xffffff } );
		addGraphic(title, 0, HXP.halfWidth - title.width / 2, 200);
		
		var instructionsText = "Moved with WASD\nShoot with the arrow keys\nMatch 3+ blocks to clear them\n\nPress space to start";
		var instructions:Text = new Text(instructionsText, 0, 0, 0, 0, { size: 20, color: 0xffffff, align: CENTER } );
		addGraphic(instructions, 0, HXP.halfWidth - instructions.width / 2, 300);
	}
	
	override public function update():Dynamic 
	{
		super.update();
		
		if (Input.pressed("next-scene")) HXP.scene = new GameScene();
	}
}