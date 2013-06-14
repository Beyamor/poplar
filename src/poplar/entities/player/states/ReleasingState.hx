package poplar.entities.player.states;
import poplar.entities.Block;
import poplar.entities.player.Player;
import poplar.entities.shots.BlockReleaser;
import poplar.GameScene;

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
			(cast(player.scene, GameScene)).grid.closestPixelX(player.x - block.halfWidth),
			player.y - player.height,
			player.shotDirection
		);
		player.scene.add(shot);
		
		player.color = 0xFFFFFF;
	}
	
	public function shotHit():Void {
		
		player.state = new NormalState(player);
	}
}