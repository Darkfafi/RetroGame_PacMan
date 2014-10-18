package Ghost
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
		public var followingPlayer : Boolean = false; //als hij vast loopt gaat hij een pad volgen en dan als hij de speler niet volgt en weer vast loopt volgt hij de speler weer.
		protected var target : Point = null;
		
		protected var _currentTask : int = 0;
		
		protected var ghostArt : MovieClip = new MovieClip();
		protected var allowedInChamber = true;
		public var eatAble : Boolean = false;
		
		protected override function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			drawObject(ghostArt);
			
			ghostArt.scaleX = 2;
			ghostArt.scaleY = 2;
		}
		
		public function targetPacman() : void {
			
			target = getPlayerLocation();
		}
		
		public override function update(e : Event) :void {
			
			super.update(e);
			animateDir();
			ghostTask();
		}
		protected function ghostTask():void {
			
			//elke geest heeft een andere taak. hier word zijn taak gekozen en uitgevoert.
			//if not running
			if (_currentTask == 0) {
				preBehavior();
			}
			//task
			//else
		}
		protected function preBehavior() : void {
			// hier gaat het gedrag in wat de spook doet aan het begin van het spel;
			
		}
		protected override function animate(animDir : int) :void {
			switch(animDir) {
				case 1:
					art.gotoAndPlay(13);
					break;
				case 2:
					art.gotoAndPlay(1);
					break;
				case 3:
					art.gotoAndPlay(5);
					break;
				case 4:
					art.gotoAndPlay(9);
					break;
			}
		}
		
		private function animateDir():void 
		{
			if (art.currentFrame == 16) {
				art.gotoAndPlay(13);
			}
			if (art.currentFrame == 4) {
				art.gotoAndPlay(1);
			}
			if (art.currentFrame == 8) {
				art.gotoAndPlay(5);
			}
			if (art.currentFrame == 12) {
				art.gotoAndPlay(9);
			}
		}
		
		protected function getPlayerLocation(): Point {
			var result : Point = new Point();
			result.x = TileSystem.player.x;
			result.y = TileSystem.player.y;
			return result
		}
		
		public function set currentTask(value:int):void 
		{
			_currentTask = value;
		}
		
	}

}