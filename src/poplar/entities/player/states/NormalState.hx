package poplar.entities.player.states;
import com.haxepunk.utils.Input;
import poplar.entities.player.Player;
import poplar.support.ShotInputInterpreter;

/**
 * ...
 * @author beyamor
 */
class NormalState extends PlayerState
{

	public function new(player:Player) 
	{
		super(player);
	}
	
	override public function enter():Void 
	{
		super.enter();
		
		player.color = 0xFFFFFFFF;
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (ShotInputInterpreter.isTryingToShoot) {
			
			player.state = new CapturingState(player, ShotInputInterpreter.direction);
		}
	}
}