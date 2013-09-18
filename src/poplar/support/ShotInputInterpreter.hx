package poplar.support;
import com.haxepunk.utils.Input;

/**
 * ...
 * @author beyamor
 */
class ShotInputInterpreter
{
	public static var isTryingToShoot(get_isTryingToShoot, null):Bool;
	public static var direction(get_direction, null):Direction;
	
	private static function get_isTryingToShoot():Bool {
		
		return (Input.pressed("shoot-up") || Input.pressed("shoot-down")
				|| Input.pressed("shoot-left") || Input.pressed("shoot-right"));
	}
	
	private static function get_direction():Direction {
		
		if (Input.pressed("shoot-up")) return UP;
		else if (Input.pressed("shoot-down")) return DOWN;
		else if (Input.pressed("shoot-left")) return LEFT;
		else if (Input.pressed("shoot-right")) return RIGHT;
		else return DOWN;
	}
}