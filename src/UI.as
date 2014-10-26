package  
{
	import Assets.fruits.Fruit;
	import Events.CookieEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;
	import Sound.SoundManager;
	
	//Test
	import flash.system.fscommand;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class UI extends Sprite
	{
		public static const GAME_OVER : String = "gameOver";
		
		public var _uiFont : TextFormat = new TextFormat();
		
		private var _oneUp : TextField = new TextField();
		private var _scoreDisplay : TextField = new TextField();
		
		private var _highScoreText : TextField = new TextField();
		private var _highScoreDisplay : TextField = new TextField();
		
		private var livesDisplayObjects : Array = [];
		private var fruitList : Array = [Fruit1,Fruit2,Fruit3,Fruit3,Fruit4,Fruit4];
		private var fruitsDisplayObjects : Array = []; // <-- for eatable fruits that give extra score right down origenal pacman
		
		private var innerHighscore : SharedObject;
		private var hightscore : int; // met xml file krijgen. of shared object
		
		private var _score : int = 0;
		private var _lives : int = 3;
		
		
		[Embed(source="../bin/lib/PRESS START REGULAR.TTF", 
		fontName = "PressStart", 
		mimeType = "application/x-font", 
		fontWeight="normal", 
		fontStyle="normal", 
		advancedAntiAliasing="true", 
		embedAsCFF="false")]
		
		private var PrssStart : Class;
		
		public function UI() 
		{
			innerHighscore = SharedObject.getLocal("Highscore");
			
			setFont();
			
			_scoreDisplay.defaultTextFormat = _uiFont;
			_highScoreDisplay.defaultTextFormat = _uiFont;
			_highScoreText.defaultTextFormat = _uiFont;
			_oneUp.defaultTextFormat = _uiFont;
			
			_highScoreText.text = "HIGH SCORE:";
			
			_scoreDisplay.text = "SCORE : " + "00";
			_oneUp.text = "1UP";
			
			if(innerHighscore.data){
				hightscore = innerHighscore.data.score;
			}
			
			if (hightscore != 0) {
				_highScoreDisplay.text = hightscore.toString();
			}
			
			addChild(_oneUp);
			addChild(_scoreDisplay);
			addChild(_highScoreText);
			addChild(_highScoreDisplay);
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_scoreDisplay.width = stage.stageWidth / 2;
			
			_scoreDisplay.x = 20;
			_scoreDisplay.y = 20;
			
			_oneUp.x = _scoreDisplay.x;
			_oneUp.y = _scoreDisplay.y - 15;
			
			_highScoreText.x = _scoreDisplay.x + 160;
			_highScoreText.width = stage.stageWidth / 2;
			
			_highScoreDisplay.x = _highScoreText.x + 40;
			_highScoreDisplay.y = _scoreDisplay.y;
			
			oneUpAnimate();
			
			updateLifeDisplay();
			lives -= 1;
			stage.addEventListener(Player.EAT_COOKIE, ateCookie);
		}
		
		private function setFont() :void {
			
			_uiFont.color = 0xEEEEEE;
			_uiFont.font = "PressStart";
			_scoreDisplay.embedFonts = true;
			_highScoreDisplay.embedFonts = true;
			_highScoreText.embedFonts = true;
			_oneUp.embedFonts = true;
		}
		private function oneUpAnimate():void {
			if (_oneUp.visible) {
				_oneUp.visible = false;
			}else { _oneUp.visible = true; }
			setTimeout(oneUpAnimate, 500);
		}
		private function ateCookie(c:CookieEvent):void 
		{
			updateScoreDisplay(c.score)
		}
		public function ateGhost(counter : int) :int {
			var scr : int = 200 * counter;
			
			if (counter == 3) {
				scr = 800;
			}else if (counter == 4) {
				scr = 1600;
			}
			updateScoreDisplay(scr);
			return scr;
		}
		
		public function ateFruit(scoreValue : int) :void {
			updateScoreDisplay(scoreValue);
			trace(scoreValue);
		}
		
		private function updateScoreDisplay(scr : int):void {
			
			_score += scr;
			_scoreDisplay.text = "SCORE : " + _score;
			
			if (_score % 10000 == 0) {
				lives += 1;
				SoundManager.playSound(SoundManager.LIVES_ONE_UP);
				updateLifeDisplay();
			}
			if (_score > hightscore) {
				hightscore = _score;
				_highScoreDisplay.text = hightscore.toString();
			}
		}
		public function updateLifeDisplay():void {
			
			for (var l : int = 0; l < livesDisplayObjects.length; l++) {
				removeChild(livesDisplayObjects[l]);
			}
			
			livesDisplayObjects = [];
			
			for (var i : int = 0; i < _lives; i++) {
				
				var liveDis : MovieClip = new PacmanFull();
				liveDis.gotoAndStop(3);
				liveDis.scaleX = 0.35;
				liveDis.scaleY = 0.35;
				liveDis.rotation = 180;
				addChild(liveDis);
				liveDis.x = (i * 30) + 35;
				liveDis.y = stage.stageHeight - 15;
				livesDisplayObjects.push(liveDis);
			}
			if (_lives < 0) {
				stage.removeEventListener(Player.EAT_COOKIE, ateCookie);
				innerHighscore.data.score = hightscore;
				innerHighscore.flush();
			}
		}
		
		public function updatefruitDisplay(level : int) :void {
			if(level <= fruitList.length){
				for (var l : int = 0; l < fruitsDisplayObjects.length; l++) {
					removeChild(fruitsDisplayObjects[l]);  //<--- maakt display schoon
				}
				
				fruitsDisplayObjects = [];
				
				for (var i : int = 0; i < level; i++) {
					trace(fruitList[i]);
					var fruitDis : MovieClip = new fruitList[i] as MovieClip;
					addChild(fruitDis);
					fruitDis.x = 448 - 35 - (i * 30) ;
					fruitDis.y = 576 - 15;
					fruitsDisplayObjects.push(fruitDis);
				}
			}
		}
		
		public function get lives():int 
		{
			return _lives;
		}
		
		public function set lives(value:int):void 
		{
			_lives = value;
		}
		
	}

}