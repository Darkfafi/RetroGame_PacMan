package Ghost 
{
	import flash.geom.Point;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class PinkGhost extends Ghosts 
	{
		private var stopChaseTimer : Timer = new Timer(5000);
		public function PinkGhost() 
		{
			ghostArt = new GhostPink();
			chaseTime = 8;
			runTime = 4;
		}
		
		override protected function preBehavior():void 
		{
			while(this.x%16 != 0 && direction == 0){
				this.x += 1;
			}
			if (hitTestAlert(2) == false && direction != 3 && direction != 4) {
				preDirection = 2;
			}else if (hitTestAlert(3) == false && direction != 4) { 
				preDirection = 3; 
			}else if (hitTestAlert(4) == false) {
				preDirection = 4;
			}
			else { currentTask = 1; finiteStateTimer.start(); allowedInChamber = false;}
		}
		override protected function chasePacman(r : int):void 
		{
			super.chasePacman(r);
			if (stopChaseTimer.currentCount == 1) {
				followingPlayer = false;
				stopChaseTimer.reset();
				stopChaseTimer.start();
			}
		}
		
	}

}