package poplar;

import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;

/**
 * ...
 * @author beyamor
 */

class Main extends Engine
{
	public function new() {
		
		super(640, 640);
	}
	
	override public function init():Dynamic 
	{
		super.init();
		HXP.console.enable();
		
		HXP.scene = new GameScene();
		
		Input.define("up", [Key.UP]);
		Input.define("down", [Key.DOWN]);
		Input.define("left", [Key.LEFT]);
		Input.define("right", [Key.RIGHT]);
		Input.define("jump", [Key.X]);
		Input.define("shoot", [Key.C]);
		Input.define("spawnBlock", [Key.ENTER]);
	}
	
	public static function main() {
		
		new Main();
	}
}