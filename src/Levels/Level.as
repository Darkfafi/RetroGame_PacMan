package Levels 
{
	import Assets.fruits.Apple;
	import Assets.fruits.Cherry;
	import Assets.fruits.Fruit;
	import Assets.fruits.Orange;
	import Assets.fruits.Strawberry;
	import flash.display.DisplayObject;
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
		private var eatScoreText : TextField = new TextField();
		
		private var level : int;
		private var fruitList : Array = [Cherry, Strawberry, Orange,Orange,Apple,Apple];
		private var fruit : Fruit = new Fruit();
		
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
			
			level = 1;
			
			stage.addEventListener(TileSystem.NEXT_LEVEN, nextLevel);
			stage.addEventListener(TileSystem.GHOSTS_EATABLE, ghostsEatenCounterSet);
			stage.addEventListener(TileSystem.SPAWN_FRUIT, spawnFruit);
			stage.addEventListener(Ghosts.TURNED_BACK, checkAllGhostStats);
			
			SoundManager.playSound(SoundManager.START_SOUND);
			timerCountdown = new Timer(2200,2);
			ui = new UI();
			startLevel();
			
			readyText.text = "READY!";
			playerOneText.text = "PLAYER ONE";
			
			var format : TextFormat = new TextFormat(null, 15);
			var scoreFormat : TextFormat = new TextFormat(null, 11);
			format.font = "PressStart";
			scoreFormat.font = "PressStart";
			
			readyText.setTextFormat(format);
			readyText.defaultTextFormat = format;
			playerOneText.setTextFormat(format);
			eatScoreText.defaultTextFormat = scoreFormat;
			
			playerOneText.embedFonts = true;
			readyText.embedFonts = true;
			eatScoreText.embedFonts = true;
			
			playerOneText.width = stage.stageWidth/2;
			
			readyText.textColor = 0xDDDD00;
			playerOneText.textColor = 0x00Dfff;
			eatScoreText.textColor = 0x00bfff;
			
			playerOneText.x = stage.stageWidth / 3;
			playerOneText.y = stage.stageHeight / 2.6;
			
			readyText.x = stage.stageWidth / 2.4;
			readyText.y = stage.stageHeight / 1.8;
			
			addChild(playerOneText);
			addChild(readyText);
		}
		
		private function spawnFruit(e:Event):void {
			if (level <= fruitList.length) {
				fruit = new fruitList[level - 1];
				fruit.x = (16 * 14);
				fruit.y = (16 * 21) - 8;
				stage.addChild(fruit);
			}else if (level > fruitList.length) {
				fruit = new fruitList[fruitList.length - 1];
				fruit.x = (16 * 14);
				fruit.y = (16 * 21) - 8;
				stage.addChild(fruit);
			}
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
			
			ui.updatefruitDisplay(level);
			
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
			level += 1;
			startLevel();
		}
		private function gameOver() :void {
			removeEventListener(Event.ENTER_FRAME, loop);
			stage.removeEventListener(TileSystem.NEXT_LEVEN, nextLevel);
			stage.removeEventListener(TileSystem.GHOSTS_EATABLE, ghostsEatenCounterSet);
			stage.removeEventListener(TileSystem.SPAWN_FRUIT, spawnFruit);
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
				if (stage.contains(fruit)) {
					if(fruit.art.visible){
						if (TileSystem.player.hitTestObject(fruit)) {
							SoundManager.playSound(SoundManager.EAT_FRUIT);
							ui.ateFruit(fruit.scoreWorth);
							fruit.destroy();
						}
					}
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
							ghost.visible = false;
							SoundManager.playSound(SoundManager.EAT_GHOST);
							ghostsEatenCounter += 1;
							showScorePause(ui.ateGhost(ghostsEatenCounter));
						}
					}
				}
			}
			if (ghostsEatenCounter == 4) {
				SoundManager.playSound(SoundManager.SIREN);
				ghostsEatenCounter = 0;
			}
		}
		private function showScorePause(scoreText : int) :void {
			gameRunning = false;
			addChild(eatScoreText);
			
			eatScoreText.x = TileSystem.player.x - 10;
			eatScoreText.y = TileSystem.player.y;
			
			eatScoreText.text = scoreText.toString();
			TileSystem.player.visible = false;
			TileSystem.player.stopAnimAt();
			for (var i : int = 0; i < tileSystem.ghosts.length; i++) {
				tileSystem.ghosts[i].stopAnimAt(1);
			}
			setTimeout(resumeAfterScorePause,500)
		}
		
		private function resumeAfterScorePause():void 
		{
			gameRunning = true;
			TileSystem.player.visible = true;
			TileSystem.player.playAnim();
			if(contains(eatScoreText)){
				removeChild(eatScoreText)
			}
			for (var i : int = 0; i < tileSystem.ghosts.length; i++) {
				tileSystem.ghosts[i].visible = true;
				tileSystem.ghosts[i].playAnim();
			}
		}
		private function pacmanKilled():void 
		{
			if (stage.contains(fruit)) {
				if(fruit.art.visible){
					fruit.remove();
				}
			}
			stage.addEventListener(Player.DEATH, deathAnimEnd);
			ui.lives -= 1;
			if (ui.lives < 0) {
				ui.updateLifeDisplay();
			}
			gameRunning = false;
			TileSystem.player.stopAnimAt(5);
			for (var i : int = 0; i < tileSystem.ghosts.length; i++) {
				tileSystem.ghosts[i].stopAnimAt();
			}
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