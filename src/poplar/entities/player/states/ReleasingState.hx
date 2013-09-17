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
	private var block:Block;

	public function new(player:Player, block:Block) 
	{
		super(player);
		this.block = block;
	}
	
	override public function enter():Void 
	{
		super.enter();
		
		var x = block.grid.closestPixelX(player.x - block.halfWidth);
		var y = player.y - block.height;
		
		switch (player.shotDirection) {
			
			case DOWN:
				y = player.y;
				
			default:
		}
		
		var shot = new BlockReleaser(
			this,
			block,
			x,
			y,
			player.shotDirection
		);
		player.scene.add(shot);
		
		player.color = 0xFFFFFF;
	}
	
	public function shotHit():Void {
		
		player.state = new NormalState(player);
	}
}