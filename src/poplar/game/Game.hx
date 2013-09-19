package poplar.game;
import poplar.GameScene;
import poplar.support.Grid;

/**
 * ...
 * @author beyamor
 */
class Game
{
	private var state:GameState;
	
	public var isUpdatingSpawners(get_isUpdatingSpawners, null):Bool;
	public var grid(default, null):Grid;

	public function new(scene:GameScene) 
	{
		state = new PlayState();
		grid = new Grid(scene);
	}
	
	private function get_isUpdatingSpawners() {
		
		return state.updatesSpawners;
	}
	
	public function respondToBlockLandingOutside():Void {
		
		state = new OverState(BLOCK_OUTSIDE);
	}
	
	public function respondToPlayerDying():Void {
		
		state = new OverState(PLAYER_KILLED);
	}
	
	public function update():Void {
		
		state.update();
	}
}