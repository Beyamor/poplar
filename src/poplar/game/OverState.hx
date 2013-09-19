package poplar.game;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import poplar.GameScene;

/**
 * ...
 * @author beyamor
 */
class OverState extends GameState
{

	public function new(endCondition:EndCondition, game:Game, scene:GameScene) 
	{
		super();
		
		scene.removeScoreDisplay();
		
		updatesSpawners = false;
		allowsPlayerMovement = false;
		
		var reasonForDying:String;
		switch (endCondition) {
			
			case BLOCK_OUTSIDE:
				reasonForDying = "BLOCKED";
				
			case PLAYER_KILLED:
				reasonForDying = "CRUSHED";
		}
		
		var explanation:Text = new Text(reasonForDying, 0, 0, 0, 0, { size: 32, color: 0xffffff } ),
			points:Text = new Text("You scored " + game.totalScore + " points!", 0, 0, 0, 0, { size: 20, color: 0xffffff } ),
			instructions:Text = new Text("Press space to restart", 0, 0, 0, 0, { size: 20, color: 0xffffff } );
			
		scene.addGraphic(new Backdrop("img/screen.png"), -125);
			
		scene.addGraphic(explanation, -150, HXP.halfWidth - (explanation.width / 2), 200);
		scene.addGraphic(points, -150, HXP.halfWidth - (points.width / 2), 250);
		scene.addGraphic(instructions, -150, HXP.halfWidth - (instructions.width / 2), 270);
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (Input.check("next-scene")) HXP.scene = new GameScene();
	}
}