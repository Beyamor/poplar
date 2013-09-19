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
		
		HXP.scene = new GameScene();
		
		Input.define("move-left", [Key.A]);
		Input.define("move-right", [Key.D]);
		Input.define("jump", [Key.W]);
		Input.define("shoot-left", [Key.LEFT]);
		Input.define("shoot-right", [Key.RIGHT]);
		Input.define("shoot-up", [Key.UP]);
		Input.define("shoot-down", [Key.DOWN]);
		Input.define("spawnBlock", [Key.ENTER]);
		Input.define("next-scene", [Key.SPACE]);
	}
	
	public static function main() {
		
		new Main();
	}
}