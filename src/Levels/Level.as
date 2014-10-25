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
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Level extends MovieClip
	{
		public var tileSystem : TileSystem = new TileSystem();
		private var timerCountdown : Timer;
		private var gameRunning : Boolean = false;
		private var ghostsEatenCounter : int = 0;
		private var ui : UI;
		
		[Embed(source="../../bin/lib/PRESS START REGULAR.TTF", 
		fontName = "PressStart", 
		mimeType = "application/x-font", 
		fontWeight="normal", 
		fontStyle="normal", 
		advancedAntiAliasing="true", 
		embedAsCFF="false")]
		
		private var PrssStart : Class;
		
		private var readyText : TextField = new TextField();
		private var playerOneText : TextField = new TextField();
		
		
		public function Level() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			begingGame();
		}
		
		private function begingGame():void 
		{
			SoundManager.stopSound();
			
			stage.addEventListener(TileSystem.NEXT_LEVEN, nextLevel);
			stage.addEventListener(TileSystem.GHOSTS_EATABLE, ghostsEatenCounterSet);
			stage.addEventListener(Ghosts.TURNED_BACK, checkAllGhostStats);
			
			SoundManager.playSound(SoundManager.START_SOUND);
			timerCountdown = new Timer(2200,2);
			ui = new UI();
			
			startLevel();
			
			readyText.text = "READY!";
			playerOneText.text = "PLAYER ONE";
			
			var format : TextFormat = new TextFormat(null,15);
			
			format.font = "PressStart";
			
			readyText.setTextFormat(format);
			readyText.defaultTextFormat = format;
			playerOneText.setTextFormat(format);
			
			playerOneText.embedFonts = true;
			readyText.embedFonts = true;
			
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
		
		private function checkAllGhostStats(e:Event):void {
			if(gameRunning){
				var counter : int = 0;
				for (var i : int = tileSystem.ghosts.length - 1; i >= 0; i--) {
					if (tileSystem.ghosts[i].eatAble == false || tileSystem.ghosts[i].deadGhost) {
						counter += 1;
						trace(counter);
					}
				}
				if (counter == 4) {
					SoundManager.stopSound();
					SoundManager.playSound(SoundManager.SIREN);
				}
			}
		}
		
		private function ghostsEatenCounterSet(e:Event):void 
		{
			SoundManager.playSound(SoundManager.BLUE_SIREN);
			ghostsEatenCounter = 0;
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
			tileSystem.destroy();
			startLevel();
		}
		private function gameOver() :void {
			removeEventListener(Event.ENTER_FRAME, loop);
			stage.removeEventListener(TileSystem.NEXT_LEVEN, nextLevel);
			stage.removeEventListener(TileSystem.GHOSTS_EATABLE, ghostsEatenCounterSet);
			stage.removeEventListener(Ghosts.TURNED_BACK, checkAllGhostStats);
			
			readyText.text = "Game Over";
			readyText.width = 400;
			readyText.x = stage.stageWidth / 2.8; 
			
			readyText.textColor = 0xFF0000;
			addChild(readyText);
			gameRunning = false;
			setTimeout(reset, 2000);
		}
		
		private function reset():void {
			TileSystem.player.visible = true;
			tileSystem.destroy();
			stage.removeChild(ui);
			begingGame();
		}
		private function deathAnimEnd(e:Event):void 
		{
			stage.removeEventListener(Player.DEATH, deathAnimEnd);
			if(ui.lives < 0){
				gameOver();
			}else { nexTry();}
		}
		
		private function nexTry():void 
		{
			tileSystem.placeMoversOrigPos();
			if (!contains(readyText)) {
				addChild(readyText);
			}
			
			if (ui.lives >= 0) {
				timerCountdown.addEventListener(TimerEvent.TIMER, onTik);
				timerCountdown.start();
			}
		}
		private function onTik(e:TimerEvent):void 
		{
			var t : Timer = e.target as Timer;
			
			switch(t.currentCount) {				
				case 1:
				ui.updateLifeDisplay();
				TileSystem.player.visible = true;
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
				hitTestGhosts();
			}
		}
		
		private function hitTestGhosts():void 
		{
			var l : int = tileSystem.ghosts.length;
			for (var i : int = 0; i < l; i++) {
				var ghost : Ghosts = tileSystem.ghosts[i];
				if(TileSystem.player != null){
					if (ghost.hitTestObject(TileSystem.player.core) == true) {
						if(!ghost.eatAble){
							pacmanKilled();
						}else if (ghost.eatAble && !ghost.deadGhost) {
							ghost.eatGhost();
							SoundManager.playSound(SoundManager.EAT_GHOST);
							ghostsEatenCounter += 1;
							if (ghostsEatenCounter == 4) {
								SoundManager.playSound(SoundManager.SIREN);
							}
							ui.ateGhost(ghostsEatenCounter);
						}
					}
				}
			}
		}
		
		private function pacmanKilled():void 
		{
			stage.addEventListener(Player.DEATH, deathAnimEnd);
			ui.lives -= 1;
			if (ui.lives < 0) {
				ui.updateLifeDisplay();
			}
			gameRunning = false;
			TileSystem.player.stopAnim();
			SoundManager.stopSound();
			setTimeout(playDeathAnim,1000);
		}
		
		private function playDeathAnim():void 
		{
			for (var i : int = 0; i < tileSystem.ghosts.length; i++) {
				tileSystem.ghosts[i].visible = false;
				tileSystem.ghosts[i].x = 10000;
			}
			
			TileSystem.player.playDeathAnimation();
		}
	}

}