package Levels 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import Ghost.Ghosts;
	import Sound.SoundManager;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Level extends MovieClip
	{
		public var tileSystem : TileSystem = new TileSystem();
		private var timerCountdown : Timer = new Timer(2200,2);
		private var gameRunning : Boolean = false;
		private var ui : UI = new UI();
		
		private var readyText : TextField = new TextField();
		private var playerOneText : TextField = new TextField();
		
		public function Level() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(TileSystem.NEXT_LEVEN, nextLevel);
			SoundManager.playSound(SoundManager.START_SOUND);
			startLevel();
			
			readyText.text = "READY!";
			playerOneText.text = "PLAYER ONE";
			
			var format : TextFormat = new TextFormat(null,15);
			
			format.font = "Press Start";
			
			trace(format.size);
			
			readyText.setTextFormat(format);
			playerOneText.setTextFormat(format);
			
			playerOneText.width = stage.stageWidth/2;
			
			readyText.textColor = 0xDDDD00;
			playerOneText.textColor = 0x00Dfff;
			
			playerOneText.x = stage.stageWidth / 3;
			playerOneText.y = stage.stageHeight / 2.6;
			
			readyText.x = stage.stageWidth / 2.4;
			readyText.y = stage.stageHeight / 1.8;
			
			addChild(playerOneText);
			addChild(readyText);
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
			if (!contains(readyText)) {
				addChild(readyText);
			}
			timerCountdown.addEventListener(TimerEvent.TIMER, onTik);
			timerCountdown.start();
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		public function nextLevel(e : Event) :void {
			removeEventListener(Event.ENTER_FRAME, loop);
			SoundManager.stopSound();
			tileSystem.destroy();
			startLevel();
		}
		
		private function onTik(e:TimerEvent):void 
		{
			var t : Timer = e.target as Timer;
			
			switch(t.currentCount) {				
				case 1:
				if(contains(playerOneText)){
					removeChild(playerOneText);
				}
				for (var i : uint = 0; i < tileSystem.ghosts.length; i++) {
					tileSystem.ghosts[i].visible = true;
				}
				//add ready text
				break;
					
				case 2:
				//remove ready text like origenal pacman and start game
				removeChild(readyText);
				
				timerCountdown = new Timer(1000,2);
				timerCountdown.stop();
				gameRunning = true;
				timerCountdown.removeEventListener(TimerEvent.TIMER, onTik);
				
				for (i = 0; i < tileSystem.ghosts.length; i++) {
					tileSystem.ghosts[i].targetPacman();
				}
				SoundManager.playSound(SoundManager.SIREN);
				
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
				if(TileSystem.player != null){
					if (ghost.hitTestObject(TileSystem.player.core) == true) {
						trace("OMG WHAT IS GOING ON! I'M DYING ;-;");
						pacmanKilled();
					}
				}
			}
		}
		
		private function pacmanKilled():void 
		{
			SoundManager.stopSound();
			ui.updateLifeDisplay( -1);
			
			//pacman death animation
			tileSystem.placeMoversOrigPos();
			gameRunning = false;
			if (!contains(readyText)) {
				addChild(readyText);
			}
			
			timerCountdown.addEventListener(TimerEvent.TIMER, onTik);
			timerCountdown.start();
		}
	}

}