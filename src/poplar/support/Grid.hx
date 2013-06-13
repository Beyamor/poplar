package poplar.support;
import nme.geom.Point;
import nme.geom.Rectangle;
import poplar.entities.Block;

/**
 * ...
 * @author beyamor
 */
class Grid
{
	public static var WIDTH:Int		= 480;
	public static var HEIGHT:Int	= 480;
	
	public var pixelDimensions(default, null):Rectangle;
	
	public var width(get_width, null):Int;
	public var height(get_height, null):Int;

	public function new() 
	{
		pixelDimensions = new Rectangle(80, 80, WIDTH, HEIGHT);
	}
	
	private function get_width():Int {
		
		return Math.floor(pixelDimensions.width / Block.WIDTH);
	}
	
	private function get_height():Int {
		
		return Math.floor(pixelDimensions.height / Block.HEIGHT);
	}
	
	public function pixelPos(x:Int, y:Int):Point {
		
		if (x < 0 || x >= width || y < 0 || y >= height) throw "Indices out of bounds (" + x + ", " + y + ")";
		
		return new Point(pixelDimensions.x + x * Block.WIDTH, pixelDimensions.y + y * Block.HEIGHT);
	}
}