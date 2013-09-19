package poplar;

import com.haxepunk.graphics.Backdrop;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import poplar.entities.Block;
import poplar.entities.Boundary;
import poplar.entities.player.Player;
import poplar.entities.ScoreDisplay;
import poplar.game.Game;
import poplar.spawners.BlockSpawner;
import poplar.spawners.ColumnSpawner;
import poplar.spawners.ManualSpawner;
import poplar.spawners.PeriodicSpawner;
import poplar.support.Grid;

/**
 * ...
 * @author beyamor
 */
class GameScene extends Scene
{
	private var blockSpawner:BlockSpawner;
	private var game:Game;
	private var scoreDisplay:ScoreDisplay;

	public function new() 
	{
		super();
	}

	override public function begin():Dynamic 
	{
		super.begin();
		
		addGraphic(new Backdrop("img/background.png"), 100);
		addGraphic(new Backdrop("img/foreground.png"), -100);
		
		game = new Game(this);
		
		var	boundaryHeight	= Math.floor(game.grid.pixelDimensions.top);
		var boundaryWidth	= Math.floor(game.grid.pixelDimensions.left);
		
		// Top
		add(new Boundary(0, 0, HXP.width, boundaryHeight));
		
		// Bottom
		add(new Boundary(0, HXP.height - boundaryHeight, HXP.width, boundaryHeight));
		
		// Left
		add(new Boundary(0, 0, boundaryWidth, HXP.height));
		
		// Right
		add(new Boundary(HXP.width - boundaryWidth, 0, boundaryWidth, HXP.height));
		
		add(new Player(game, Block.WIDTH * 5, 200));
		
		blockSpawner = new PeriodicSpawner(this, game, 1.4);
		//blockSpawner = new ManualSpawner(this, game);
		//blockSpawner = new ColumnSpawner(this, game, 1);
		
		scoreDisplay = new ScoreDisplay(game, 20, 20);
		add(scoreDisplay);
	}
	
	override public function update():Dynamic 
	{
		super.update();
		
		game.update();
		if (game.isUpdatingSpawners) blockSpawner.update();
	}
	
	public function removeScoreDisplay():Void {
		
		if (scoreDisplay != null) {
			
			if (scoreDisplay.scene != null) scoreDisplay.scene.remove(scoreDisplay);
			scoreDisplay = null;
		}
	}
}