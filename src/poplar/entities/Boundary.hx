package poplar.entities;

import com.haxepunk.Entity;

/**
 * ...
 * @author beyamor
 */
class Boundary extends Entity
{

	public function new(x:Float, y:Float, width:Int, height:Int) 
	{
		super(x, y);
		
		this.width	= width;
		this.height	= height;
		type = "boundary";
	}
	
}