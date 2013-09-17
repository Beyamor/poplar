package poplar.entities.player.states;
import poplar.entities.Block;
import poplar.entities.player.Player;
import poplar.entities.shots.BlockReleaser;
import poplar.GameScene;
import poplar.support.Direction;

/**
 * ...
 * @author beyamor
 */
class ReleasingState extends PlayerState
{
	public function new(player:Player) 
	{
		super(player);
	}
	
	override public function enter():Void 
	{
		super.enter();
		
		var shot = new BlockReleaser(
			this,
			player.block,
			player.releaseX,
			player.releaseY,
			player.shotDirection
		);
		player.scene.add(shot);
		
		player.color = 0xFFFFFF;
		player.block = null;
	}
	
	public function shotHit():Void {
		
		player.state = new NormalState(player);
	}
}