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
	private var scene:GameScene;
	
	public var isUpdatingSpawners(get_isUpdatingSpawners, null):Bool;
	public var isAllowingPlayerMovement(get_isAllowingPlayerMovement, null):Bool;
	public var grid(default, null):Grid;
	public var totalScore:Int = 0;

	public function new(scene:GameScene) 
	{
		this.scene = scene;
		
		state = new PlayState();
		grid = new Grid(this, scene);
	}
	
	private function get_isUpdatingSpawners() {
		
		return state.updatesSpawners;
	}
	
	private function get_isAllowingPlayerMovement() {
		
		return state.allowsPlayerMovement;
	}
	
	public function respondToBlockLandingOutside():Void {
		
		state = new OverState(BLOCK_OUTSIDE, this, scene);
	}
	
	public function respondToPlayerDying():Void {
		
		state = new OverState(PLAYER_KILLED, this, scene);
	}
	
	public function update():Void {
		
		state.update();
	}
	
	public function registerMatchedBlocks(numberOfMatchedBlocks):Void {
		
		var score = (numberOfMatchedBlocks - 2) * 100;
		totalScore += score;
	}
}