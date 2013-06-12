package poplar;

import com.haxepunk.Engine;
import com.haxepunk.HXP;
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
		
		HXP.world = new PoplarWorld();
	}
	
	public static function main() {
		
		new Main();
	}
}