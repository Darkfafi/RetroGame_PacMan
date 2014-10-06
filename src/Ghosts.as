package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Ghosts extends MovingObject
	{
		//speed = speed * Math.abs(dif.x) / dif.x <---- gebruiken voor links of rechts movement
		protected var followingPlayer : Boolean = false; //als hij vast loopt gaat hij een pad volgen en dan als hij de speler niet volgt en weer vast loopt volgt hij de speler weer.
		protected var target : Point = null;
		protected var currentTask : int = 0;
		
		protected override function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var ghostArt : MovieClip = new PacManWalk();
			
			drawObject(ghostArt);
		}
		
		public function targetPacman() : void {
			
			target = getPlayerLocation();
		}
		
		public override function update(e : Event) :void {
			
			super.update(e);
			ghostTask();
		}
		
		protected function ghostTask():void {
			
			//elke geest heeft een andere taak. hier word zijn taak gekozen en uitgevoert. Voor test word hier de Chase task in opgeroepen.
			//if not running
			chasePacman();
			//else
		}
		
		private function chasePacman():void {
			
			targetPacman(); // <-- wou ik nog anders doen
			
			var dif : Point;
			var choseDir : int = 0;
			
			if(target != null){
				dif = new Point(target.x - this.x, target.y - this.y);
			}
			if (dif.x != 0) {
				choseDir = Math.abs(dif.x) / dif.x;
				if (choseDir == Math.abs(choseDir)) {
					preDirection = 3; // Rechts
				}else {
					preDirection = 1; //Links
				}
			}else if (dif.y != 0) {
				choseDir = Math.abs(dif.y) / dif.y;
				trace(this.x + " " + TileSystem.player.x);
				if (choseDir == Math.abs(choseDir)) {
					preDirection = 4; // Up
				}else {
					preDirection = 2; //Down
				}
			}
		}
		protected override function animate(animDir : int) :void {
			switch(animDir) {
				
				case 1:
					art.rotation = 180;
					break;
				case 2:
					art.rotation = 270;
					break;
				case 3:
					art.rotation = 0;
					break;
				case 4:
					art.rotation = 90;
					break;
			}
		}
		
		protected function getPlayerLocation(): Point {
			var result : Point = new Point();
			result.x = TileSystem.player.x;
			result.y = TileSystem.player.y;
			return result
		}
		
	}

}