package Ghost
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class RedGhost extends Ghosts
	{	
		public function RedGhost() 
		{
			ghostArt = new ghostRed();
			allowedInChamber = false;
			chaseTime = 10;
			runTime = 5;
		}
		
		override protected function preBehavior():void 
		{
			super.preBehavior();
			
			if (hitTestAlert(1) == false && direction != 4) {
				preDirection = 1;
			}else if (hitTestAlert(4) == false) { 
				preDirection = 4; 
			}else { currentTask = 1; finiteStateTimer.start(); }
			
		}
	}
}