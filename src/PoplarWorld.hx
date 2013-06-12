package ;

import com.haxepunk.World;
import poplar.entities.Block;

/**
 * ...
 * @author beyamor
 */
class PoplarWorld extends World
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