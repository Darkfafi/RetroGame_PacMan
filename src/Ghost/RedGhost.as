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
		private var movingX : Boolean = false;
		
		public function RedGhost() 
		{
			ghostArt = new ghostRed();
		}
		
		override protected function ghostTask():void 
		{
			super.ghostTask();
			chasePacman();
		}
		
		private function chasePacman():void {
			if(followingPlayer){
				targetPacman(); // <-- wou ik nog anders doen
			}
			var dif : Point;
			var choseDir : int = 0;
			
			if(target != null){
				dif = new Point(target.x - this.x, target.y - this.y);
			}
			if (followingPlayer) {
				if (dif.x != 0) {
					choseDir = Math.abs(dif.x) / dif.x;
					if (choseDir == Math.abs(choseDir)) {
						preDirection = 3; // Rechts
					}else {
						preDirection = 1; //Links
					}
				}else if (dif.y != 0) {
					if (direction == 3 || direction == 1) {
						direction = 0;
					}
					choseDir = Math.abs(dif.y) / dif.y;
					if (choseDir == Math.abs(choseDir)) {
						preDirection = 4; // Down
					}else {
						preDirection = 2; //Up
					}
				}
				if (!moving && hitTestAlert(preDirection)) {
					trace("false");
					followingPlayer = false;
				}
			}else {
				if (dif.y != 0 && movingX == false) {
					if (!moving) {
						if (hitTestAlert(1) == false) {
							preDirection = 1;
							
						}else if (hitTestAlert(3) == false) {
							preDirection = 3;
						}
					}
					else{
						if (dif.y < 0) {
							preDirection = 2;
						}else if (dif.y > 0) {
							preDirection = 4;
						}
					}
				}
				else if (dif.x != 0) {
					movingX = true;
					if (!moving) {
						if (hitTestAlert(2) == false) {
							preDirection = 2;
						}else if (hitTestAlert(4) == false) {
							preDirection = 4;
						}
					}
					else{
						if (dif.x < 0) {
							preDirection = 1;
						}else if (dif.x > 0) {
							preDirection = 3;
						}
					}
				}else { movingX = false; followingPlayer = true;}
				//trace(movementXY);
			}
		}
		
	}

}