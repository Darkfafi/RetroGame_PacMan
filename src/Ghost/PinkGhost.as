package Ghost 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class PinkGhost extends Ghosts 
	{
		
		public function PinkGhost() 
		{
			ghostArt = new GhostPink();
		}
		
		override protected function preBehavior():void 
		{
			while(this.x%16 != 0 && direction == 0){
				this.x -= 1;
			}
			if (hitTestAlert(2) == false && direction != 3 && direction != 4) {
				preDirection = 2;
			}else if (hitTestAlert(3) == false && direction != 4) { 
				preDirection = 3; 
			}else if (hitTestAlert(4) == false) {
				preDirection = 4;
			}
			else { currentTask = 1; }
		}
		
	}

}