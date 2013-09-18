package poplar.entities.player.states;
import poplar.entities.Block;
import poplar.entities.shots.BlockCapturer;
import poplar.entities.player.Player;
import poplar.support.Direction;

/**
 * ...
 * @author beyamor
 */
class CapturingState extends PlayerState
{
	private var shotDirection:Direction;

	public function new(player:Player, shotDirection:Direction) 
	{
		super(player);
		
		this.shotDirection = shotDirection;
	}
	
	override public function enter():Void 
	{
		super.enter();
		
		var shot = new BlockCapturer(this, player.x + player.halfWidth, player.y + player.halfHeight, shotDirection);
		player.scene.add(shot);
	}
	
	public function blockHit(block:Block):Void {
		
		player.state = new CapturedState(player, block);
	}
	
	public function shotMissed():Void {
		
		player.state = new NormalState(player);
	}
}