package poplar.util;
import com.haxepunk.HXP;

/**
 * The timer can be used to set time-based alarms.
 * Attach callbacks to be triggered at the end of some period.
 * 
 * (The standard timer doesn't hook into FP, obviously.)
 * @author beyamor
 */
class Watch implements Updateable
{
	private var	totalTime:Float;
	private var elapsedtime:Float = 0;
	private var callbacks:Array<Void -> Void>;
	
	/**
	 * If the timer loops, it will start counting up again after it fires.
	 * Any callbacks will be called every time the timer fires.
	 */
	public var loops:Bool				= false;
	
	/**
	 * Creates a new Timer with a period of the given time in seconds.
	 * new Timer(1) fires after one second.
	 */
	public function new(timeInSeconds:Float)
	{
		totalTime	= timeInSeconds;
		callbacks	= [];
	}
	
	/**
	 * Adds a callback to be called when the timer fires.
	 */
	public function addCallback(callbackToAdd:Void -> Void):Watch {
		
		callbacks.push(callbackToAdd);
		return this;
	}
	
	/**
	 * Whether the timer has seen enough time elapse.
	 */
	public var hasFired(get_hasFired, null):Bool;
	public function get_hasFired():Bool {
		
		return elapsedtime >= totalTime;
	}
	
	/**
	 * Updates, potentially calling callbacks.
	 */
	public function update():Void {
		
		if (hasFired) {
			
			if (loops)	elapsedtime -= totalTime;
			else		return;
		};
		
		elapsedtime += HXP.elapsed;
		
		if (hasFired) {
			
			for (call in callbacks) {
				
				call();
			}
		}
	}
	
	/**
	 * The percent elapsed as a number between 0 and 1.
	 * Clamps to 1.
	 */
	public var percentElapsed(get_percentElapsed, null):Float;
	public function get_percentElapsed():Float {
		
		return Math.min(1, elapsedtime / totalTime);
	}
}