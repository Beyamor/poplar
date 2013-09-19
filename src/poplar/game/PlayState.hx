package poplar.game;
import poplar.GameScene;

/**
 * ...
 * @author beyamor
 */
class PlayState extends GameState
{

	public function new() 
	{
		super();
		
		updatesSpawners = true;
		allowsPlayerMovement = true;
	}
}