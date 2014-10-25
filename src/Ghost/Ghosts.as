package Ghost
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import Sound.SoundManager;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Ghosts extends MovingObject
	{
		//speed = speed * Math.abs(dif.x) / dif.x <---- gebruiken voor links of rechts movement
		public static const TURNED_BACK : String = "turnedBack";
		protected var finiteStateTimer : Timer;
		protected var chaseTime : int;
		protected var runTime : int;
		
		public var followingPlayer : Boolean = false; //als hij vast loopt gaat hij een pad volgen en dan als hij de speler niet volgt en weer vast loopt volgt hij de speler weer.
		protected var target : Point = null;
		
		protected var _currentTask : int = 0;
		
		protected var ghostArt : MovieClip = new MovieClip();
		protected var deadGhostArt : MovieClip = new GhostEatable();
		
		protected var allowedInChamber : Boolean = true;
		
		private var changeBackTimer : Number;
		
		public var eatAble : Boolean = false;
		public var deadGhost : Boolean = false;
		
		protected var movingX : Boolean = false;
		
		protected var origPosition : Point = new Point();
		
		protected override function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(deadGhostArt);
			deadGhostArt.stop();
			deadGhostArt.visible = false;
			deadGhostArt.x = 8;
			deadGhostArt.y = 8;
			
			origPosition.x = 216;
			origPosition.y = 224;
			drawObject(ghostArt);
			
			ghostArt.scaleX = 2;
			ghostArt.scaleY = 2;
			
			deadGhostArt.scaleX = 2;
			deadGhostArt.scaleY = 2;
			
			finiteStateTimer = new Timer(chaseTime * 1000);
			
			finiteStateTimer.addEventListener(TimerEvent.TIMER, switchState);
		}
		
		private function switchState(e:TimerEvent):void 
		{
			followingPlayer = true;
			if(!eatAble){
				if (_currentTask == 1 && !deadGhost) {
					_currentTask = 2;
					finiteStateTimer = new Timer(runTime * 1000);
				}else if (_currentTask == 2) {
					_currentTask = 1;
					finiteStateTimer = new Timer(chaseTime * 1000);
				}
			}
			finiteStateTimer.start();
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
			else if (_currentTask == 1) {
				//als timer 0 = dan zet timer aan. na timer verander naar wegren modus ofzo idk <3
				chasePacman(1);
			}else if (_currentTask == 2) {// run function 
				chasePacman (-1); 
			} 
			//task
			//else
		}
		override public function beginState():void 
		{
			super.beginState();
			if (eatAble) {
				if (deadGhost) {
					deadGhost = false;
				}
				turnBackToNormal();
			}
			allowedInChamber = true;
			_currentTask = 0;
		}
		protected function preBehavior() : void {
			// hier gaat het gedrag in wat de spook doet aan het begin van het spel;		
		}
		protected override function animate(animDir : int) :void {
			if (!eatAble) {
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
			}else if (eatAble && deadGhost) {
				switch(animDir) {
					case 1:
						deadGhostArt.gotoAndStop(16);
						break;
					case 2:
						deadGhostArt.gotoAndStop(13);
						break;
					case 3:
						deadGhostArt.gotoAndStop(14);
						break;
					case 4:
						deadGhostArt.gotoAndStop(15);
						break;
				}
			}
		}
		
		private function animateDir():void 
		{
			if (!eatAble) {
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
			}else if (eatAble) {
				if (deadGhostArt.currentFrame == 4) {
					deadGhostArt.gotoAndPlay(1);
				}
				if (deadGhostArt.currentFrame == 12) {
					deadGhostArt.gotoAndPlay(5);
				}
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
		public function ghostTurnsEatable(time : int) :void {
			eatAble = true;
			deadGhostArt.gotoAndPlay(1);
				if (deadGhostArt.visible == false) {
					art.stop();
					ghostArt.visible = false;
					deadGhostArt.visible = true;
				}
			changeBackTimer = setTimeout(turningBackToNormal, time - time / 6,time / 6);
		}
		private function turningBackToNormal(timeTurnBack : int):void {
			if(!deadGhost && eatAble){
				deadGhostArt.gotoAndPlay(5);
				changeBackTimer = setTimeout(turnBackToNormal,timeTurnBack);
			}
		}
		public function turnBackToNormal() :void {
			if (!deadGhost && eatAble) {
				dispatchEvent(new Event(TURNED_BACK,true));
				clearTimeout(changeBackTimer);
				eatAble = false;
				deadGhost = false;
				art.visible = true;
				deadGhostArt.stop();
				deadGhostArt.visible = false;
			}
		}
		public function eatGhost() :void {
			deadGhost = true;
			deadGhostArt.gotoAndStop(13);
			currentTask = 1;
		}
		
		protected function chasePacman(r : int):void {
			if (followingPlayer) {
				if(!deadGhost){
					targetPacman();
				}else {
					target = origPosition;
				}
			}
			var dif : Point;
			var choseDir : int = 0;
			
			if (target != null) {
				if (deadGhost) {
					r = 1;
				}
				dif = new Point(target.x * r - this.x, target.y * r - this.y);
			}
			
			if (deadGhost && dif.x == 0 && dif.y == 0 && this.x == origPosition.x && this.y == origPosition.y) {
				eatAble = false;
				deadGhost = false;
				art.visible = true;
				deadGhostArt.stop();
				deadGhostArt.visible = false;
				_currentTask = 0;
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
					followingPlayer = false;
				}else if (!moving && deadGhost) {
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
			}
		}
		
	}

}