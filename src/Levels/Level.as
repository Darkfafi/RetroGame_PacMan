package Levels 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Level extends MovieClip
	{
		public var tileSystem : TileSystem = new TileSystem();
		private var timerCountdown : Timer = new Timer(1000,2);
		private var gameRunning : Boolean = false;
		private var ui : UI = new UI();
		public function Level() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(TileSystem.NEXT_LEVEN,nextLevel);
			startLevel();
		}
		private function startLevel() :void {
			gameRunning = false;
			if (stage.contains(tileSystem)) {
				removeChild(tileSystem);
				tileSystem  = new TileSystem();
			}
			addChild(tileSystem);
			if(stage.contains(ui) == false){
				stage.addChild(ui);
			}
			timerCountdown.addEventListener(TimerEvent.TIMER, onTik);
			timerCountdown.start();
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		public function nextLevel(e : Event) :void {
			removeEventListener(Event.ENTER_FRAME, loop);
			tileSystem.destroy();
			startLevel();
		}
		
		private function onTik(e:TimerEvent):void 
		{
			var t : Timer = e.target as Timer;
			
			switch(t.currentCount) {				
				case 1:
				trace("ready?");
				//add ready text
				break;
					
				case 2:
				trace("Go!");
				//remove ready text like origenal pacman and start game
				timerCountdown.reset();
				timerCountdown.stop();
				gameRunning = true;
				timerCountdown.removeEventListener(TimerEvent.TIMER, onTik);
				for (var i : uint = 0; i < tileSystem.ghosts.length; i++) {
					tileSystem.ghosts[i].targetPacman();
				}
				break;	
			}
		}
		
		private function loop(e:Event):void 
		{
			if (gameRunning) {
				if(TileSystem.player != null){
					TileSystem.player.update(e);
				}
				for (var i : uint = 0; i < tileSystem.ghosts.length; i++) {
					tileSystem.ghosts[i].update(e);
				}
			}
			hitTestGhosts();
		}
		
		private function hitTestGhosts():void 
		{
			var l : int = tileSystem.ghosts.length;
			for (var i : int = 0; i < l; i++) {
				var ghost : Ghosts = tileSystem.ghosts[i];
				if (ghost.hitTestObject(TileSystem.player.core) == true) {
					trace("OMG WHAT IS GOING ON! I'M DYING ;-;");
					pacmanKilled();
				}
			}
		}
		
		private function pacmanKilled():void 
		{
			ui.updateLifeDisplay( -1);
			
			//pacman death animation
			tileSystem.placeMoversOrigPos();
			gameRunning = false;
			timerCountdown.addEventListener(TimerEvent.TIMER, onTik);
			timerCountdown.start();
		}
	}

}