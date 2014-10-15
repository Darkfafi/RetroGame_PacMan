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
		protected var followingPlayer : Boolean = true; //als hij vast loopt gaat hij een pad volgen en dan als hij de speler niet volgt en weer vast loopt volgt hij de speler weer.
		protected var target : Point = null;
		protected var currentTask : int = 0;
		
		protected override function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var ghostArt : MovieClip = new ghostRed();
			
			drawObject(ghostArt);
			ghostArt.scaleX = 1.5;
			ghostArt.scaleY = 1.5;
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
			
			//elke geest heeft een andere taak. hier word zijn taak gekozen en uitgevoert. Voor test word hier de Chase task in opgeroepen.
			//if not running
			chasePacman();
			//else
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
					moving = false;
					choseDir = Math.abs(dif.y) / dif.y;
					if (choseDir == Math.abs(choseDir)) {
						preDirection = 4; // Down
					}else {
						preDirection = 2; //Up
					}
				}
			}
			if (!moving && hitTestAlert(preDirection)) {
				followingPlayer = false;
			}
			if (!followingPlayer) {
				if (dif.y != 0) {
					preDirection = preMovement;
					if (!moving) {
						movementXY.y = 1;
						if (hitTestAlert(1) == false) {
							preDirection = 1;
							
						}else if (hitTestAlert(3) == false) {
							preDirection = 3;
						}
					}
					if(moving){
						if (dif.y < 0) {
							preDirection = 2;
						}else if (dif.y > 0) {
							
							preDirection = 4;
						}else { direction = 0;}
					}
				}
				else if (dif.x != 0) {
					movementXY.y = 0;
					if(moving){
						if (hitTestAlert(2) == false) {
							preDirection = 2;
						}else if (hitTestAlert(4) == false) {
							preDirection = 4;
						}
					}if(!moving){
						if (dif.x < 0) {
							preDirection = 1;
						}else if (dif.x > 0) {
							
							preDirection = 3;
						}else { direction = 0; }
					}
				}
				if (!moving && hitTestAlert(preDirection)) {
					followingPlayer = true;
				}
				
			}
			trace(followingPlayer);
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
		
	}

}