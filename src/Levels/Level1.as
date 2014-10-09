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
	public class Level1 extends MovieClip
	{
		public var tileSystem : TileSystem = new TileSystem();
		private var timerCountdown : Timer = new Timer(2000,2);
		private var gameRunning : Boolean = false;
		private var ui : UI = new UI();
		public function Level1() 
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
			trace("fsdfdsfd");
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
			if(gameRunning){
				TileSystem.player.update(e);
				for (var i : uint = 0; i < tileSystem.ghosts.length; i++) {
					tileSystem.ghosts[i].update(e);
				}
			}
		}
	}

}