package poplar.entities.player.states;
import poplar.entities.Block;
import poplar.entities.player.Player;
import poplar.entities.shots.BlockReleaser;

/**
 * ...
 * @author beyamor
 */
class ReleasingState extends PlayerState
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
		
		var shot = new BlockReleaser(
			this,
			block,
			player.x,
			player.y - player.halfHeight,
			player.shotDirection
		);
		player.scene.add(shot);
		
		player.color = 0xFFFFFF;
	}
	
	public function shotHit():Void {
		
		player.state = new NormalState(player);
	}
}