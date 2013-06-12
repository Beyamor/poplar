package poplar;

import com.haxepunk.Scene;
import poplar.entities.Block;

/**
 * ...
 * @author beyamor
 */
class GameScene extends Scene
{

	public function new() 
	{
		super();
	}

	override public function begin():Dynamic 
	{
		super.begin();
		add(new Block(100, 100));
	}
}