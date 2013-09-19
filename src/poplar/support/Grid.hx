package poplar.support;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import nme.geom.Point;
import nme.geom.Rectangle;
import poplar.entities.Block;
import poplar.game.Game;

/**
 * ...
 * @author beyamor
 */
typedef BlockNeighbours = {
		
	var left:Array<Block>;
	var right:Array<Block>;
	var up:Array<Block>;
	var down:Array<Block>;
}
 
class Grid
{
	public static var WIDTH:Int		= 480;
	public static var HEIGHT:Int	= 480;
	
	public var pixelDimensions(default, null):Rectangle;
	
	public var width(get_width, null):Int;
	public var height(get_height, null):Int;
	
	private var scene:Scene;
	private var blocks:Array<Block>;
	private var game:Game;

	public function new(game:Game, scene:Scene) 
	{
		this.game = game;
		this.scene = scene;
		
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
	
	public function anyPixelX():Float {
		
		return pixelDimensions.x + Math.floor(Math.random() * width) * Block.WIDTH;
	}
	
	public function closestPixelX(x:Float):Float {
		
		return Math.round(((x - pixelDimensions.x) / Block.WIDTH)) * Block.WIDTH + pixelDimensions.x;
	}
	
	public function closestPixelY(y:Float):Float {
		
		return Math.round(((y - pixelDimensions.y) / Block.HEIGHT)) * Block.HEIGHT + pixelDimensions.y;
	}
	
	private function pixelToXIndex(x:Float):Int {
		
		return Math.floor((x - pixelDimensions.x) / Block.WIDTH);
	}
	
	private function pixelToYIndex(y:Float):Int {
		
		return Math.floor((y - pixelDimensions.y) / Block.HEIGHT);
	}
	
	public function xIndexToPixel(x:Int):Float {
		
		return pixelDimensions.x + x * Block.WIDTH;
	}
	
	private function getAllStationaryBlocks():Array<Block> {
		
		var blocks:Array<Block> = [];
		var allEntities:Array<Entity> = [];
		
		scene.getClass(Block, allEntities);
		for (entity in allEntities) {
			
			var block:Block = cast(entity, Block);
			if (block.yVel != 0) continue;
			blocks.push(block);
		}
		
		return blocks;
	}
	
	private function blockAt(x:Int, y:Int):Block {
		
		for (block in blocks) {
			
			if (pixelToXIndex(block.x) == x && pixelToYIndex(block.y) == y) return block;
		}
		
		return null;
	}
	
	private function matchingNeighbours(block:Block):BlockNeighbours {
		
		var centerX = pixelToXIndex(block.x);
		var centerY = pixelToYIndex(block.y);
		
		var x:Int;
		var y:Int;
		var neighbour:Block;
		
		var left:Array<Block> = [];
		x = centerX;
		y = centerY;
		while (true) {
			
			--x;
			if (x < 0) break;
			
			neighbour = blockAt(x, y);
			if (neighbour == null) break;
			
			if (neighbour.color != block.color) break;
			left.push(neighbour);
		}
		
		var right:Array<Block> = [];
		x = centerX;
		y = centerY;
		while (true) {
			
			++x;
			if (x >= width) break;
			
			neighbour = blockAt(x, y);
			if (neighbour == null) break;
			
			if (neighbour.color != block.color) break;
			right.push(neighbour);
		}
		
		var up:Array<Block> = [];
		x = centerX;
		y = centerY;
		while (true) {
			
			--y;
			if (y < 0) break;
			
			neighbour = blockAt(x, y);
			if (neighbour == null) break;
			
			if (neighbour.color != block.color) break;
			up.push(neighbour);
		}
		
		var down:Array<Block> = [];
		x = centerX;
		y = centerY;
		while (true) {
			
			++y;
			if (y >= height) break;
			
			neighbour = blockAt(x, y);
			if (neighbour == null) break;
			
			if (neighbour.color != block.color) break;
			down.push(neighbour);
		}
		
		return {
			left: left,
			right: right,
			up: up,
			down: down
		};
	}
	
	public function checkForMatches(block:Block):Bool {
		
		blocks = getAllStationaryBlocks();
		var neighbours:BlockNeighbours = matchingNeighbours(block),
			wasMatched:Bool = false,
			numberOfMatchedBlocks:Int = 0,
			initialBlockAccountedFor:Bool = false;
		
		if (neighbours.left.length + neighbours.right.length >= 2) {
			
			++numberOfMatchedBlocks;
			initialBlockAccountedFor = true;
			wasMatched = true;
			scene.remove(block);
			for (neighbour in neighbours.left) { scene.remove(neighbour); ++numberOfMatchedBlocks; }
			for (neighbour in neighbours.right) { scene.remove(neighbour); ++numberOfMatchedBlocks; }
		}
		
		if (neighbours.up.length + neighbours.down.length >= 2) {
			
			if (!initialBlockAccountedFor) ++numberOfMatchedBlocks;
			wasMatched = true;
			scene.remove(block);
			for (neighbour in neighbours.up) { scene.remove(neighbour); ++numberOfMatchedBlocks; }
			for (neighbour in neighbours.down) { scene.remove(neighbour); ++numberOfMatchedBlocks; }
		}
		
		if (wasMatched) game.registerMatchedBlocks(numberOfMatchedBlocks);
		
		return wasMatched;
	}
}