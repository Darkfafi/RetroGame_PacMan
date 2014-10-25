package Ghost 
{
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class YellowGhost extends Ghosts
	{
		private var beginCounter : int = 0;
		public function YellowGhost() 
		{
			ghostArt = new GhostYellow();
			chaseTime = 6;
			runTime = 8;
			
		}
		override protected function preBehavior():void 
		{
			if(allowedInChamber){
				if (!moving && preDirection == 0 && direction == 0) {
					allowedInChamber = true;
					beginCounter = 0;
				}				
				while(this.x%16 != 0 && direction == 0){
					this.x -= 1;
				}
				if (beginCounter < 20) {
					if (hitTestAlert(preDirection)) {
						direction = 0;
					}
					if (hitTestAlert(2) == false && direction != 4) {
						preDirection = 2;
					}else if(hitTestAlert(4) == false){
						preDirection = 4;
					}
					if (!moving) {
						beginCounter ++;
					}
				}else {
					if (beginCounter == 20) {
						preDirection = 2;
						beginCounter ++;	
					}
					
					if (hitTestAlert(2) && beginCounter == 21) {
						preDirection = 1;
						beginCounter ++;
					}
					else if (direction == 1) {
						preDirection = 2;
					}
					else if (direction == 2 && hitTestAlert(direction)) {
						allowedInChamber = false; 
					}
				}
			}
			else if (!allowedInChamber) {
				if (hitTestAlert(3) == false && direction != 4) {
					preDirection = 3;
				}else if (hitTestAlert(4) == false) { 
					preDirection = 4; 
				}else { currentTask = 1; finiteStateTimer.start(); beginCounter = 0;}
			}
		}
	}

}