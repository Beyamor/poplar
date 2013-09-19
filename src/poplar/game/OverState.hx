package poplar.game;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import poplar.GameScene;

/**
 * ...
 * @author beyamor
 */
class OverState extends GameState
{

	public function new(endCondition:EndCondition) 
	{
		super();
		
		updatesSpawners = false;
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (Input.check("next-scene")) HXP.scene = new GameScene();
	}
}