package poplar.entities.player.states;
import com.haxepunk.utils.Input;
import poplar.entities.player.Player;

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
		player.block = null;
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (Input.pressed("shoot")) {
			
			player.state = new CapturingState(player);
		}
	}
}