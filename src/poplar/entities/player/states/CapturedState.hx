package poplar.entities.player.states;
import com.haxepunk.utils.Input;
import poplar.entities.Block;
import poplar.entities.player.Player;

/**
 * ...
 * @author beyamor
 */
class CapturedState extends PlayerState
{
	private var block:Block;

	public function new(player:Player, block:Block) 
	{
		super(player);
		
		this.block = block;
	}
	
	override public function enter():Void 
	{
		super.enter();
		player.color = block.color;
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (Input.pressed("shoot")) {
			
			player.state = new ReleasingState(player, block);
		}
	}
}