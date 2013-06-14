package poplar.entities.player.states;
import poplar.entities.Block;
import poplar.entities.BlockCapturer;
import poplar.entities.player.Player;

/**
 * ...
 * @author beyamor
 */
class CapturingState extends PlayerState
{

	public function new(player:Player) 
	{
		super(player);
	}
	
	override public function enter():Void 
	{
		super.enter();
		
		var shot = new BlockCapturer(this, player.x + player.halfWidth, player.y + player.halfHeight, player.shotDirection);
		player.scene.add(shot);
	}
	
	public function blockHit(block:Block):Void {
		
		player.state = new CapturedState(player, block);
	}
	
	public function shotMissed():Void {
		
		player.state = new NormalState(player);
	}
}