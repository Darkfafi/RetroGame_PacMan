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
		public function Level1() 
		{
			addChild(tileSystem);
			timerCountdown.addEventListener(TimerEvent.TIMER, onTik);
			timerCountdown.start();
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function onTik(e:TimerEvent):void 
		{
			var t : Timer = e.target as Timer;
			
			switch(t.currentCount) {				
				case 1:
				trace("ready?");
				break;
					
				case 2:
				trace("Go!");
				timerCountdown.reset();
				timerCountdown.stop();
				gameRunning = true;
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