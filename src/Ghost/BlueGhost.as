package Ghost 
{
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class BlueGhost extends Ghosts
	{
		private var beginCounter : int = 0;
		public function BlueGhost() 
		{
			ghostArt = new GhostBlue();
			chaseTime = 7;
			runTime = 5;
		}
		
		override protected function preBehavior():void 
		{
			if(allowedInChamber){
				if (!moving && preDirection == 0 && direction == 0) {
					beginCounter = 0;
				}
				
				while(this.x%16 != 0 && direction == 0){
					this.x += 1;
				}
				if (beginCounter < 10) {
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
					if (beginCounter == 10) {
						preDirection = 2;
						beginCounter ++;	
					}
					
					if (hitTestAlert(2) && beginCounter == 11) {
						preDirection = 3;
						beginCounter ++;
					}
					else if (direction == 3) {
						preDirection = 2;
					}
					else if (direction == 2 && hitTestAlert(direction)) {
						allowedInChamber = false; 
					}
				}
			}else {
				if (hitTestAlert(1) == false && direction != 4) {
					preDirection = 1;
				}else if (hitTestAlert(4) == false) { 
					preDirection = 4; 
				}else { currentTask = 1; finiteStateTimer.start(); }
			}
		}
		
	}

}