package  
{
	import Events.CookieEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	//Test
	import flash.system.fscommand;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class UI extends Sprite
	{
		private var _uiFont : TextFormat = new TextFormat();
		
		private var _scoreDisplay : TextField = new TextField();
		
		private var _highScoreText : TextField = new TextField();
		private var _highScoreDisplay : TextField = new TextField();
		
		private var livesDisplayObjects : Array = [];
		private var fruitsDisplayObjects : Array = []; // <-- for eatable fruits that give extra score right down origenal pacman
		
		private var innerHighscore : SharedObject;
		private var hightscore : int; // met xml file krijgen. of shared object
		
		private var _score : int = 0;
		private var lives : int = 2;
		
		
		
		public function UI() 
		{
			innerHighscore = SharedObject.getLocal("Highscore");
			
			setFont();
			
			_scoreDisplay.defaultTextFormat = _uiFont;
			_highScoreDisplay.defaultTextFormat = _uiFont;
			_highScoreText.defaultTextFormat = _uiFont;
			
			_highScoreText.text = "HIGH SCORE:";
			
			_scoreDisplay.text = "SCORE : " + "00";
			
			if(innerHighscore.data){
				hightscore = innerHighscore.data.score;
			}
			
			if (hightscore != 0) {
				_highScoreDisplay.text = hightscore.toString();
			}
			
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
			
			_highScoreText.x = _scoreDisplay.x + 160;
			_highScoreText.width = stage.stageWidth / 2;
			
			_highScoreDisplay.x = _highScoreText.x + 40;
			_highScoreDisplay.y = _scoreDisplay.y;
			
			updateLifeDisplay(0);
			
			stage.addEventListener(Player.EAT_COOKIE, ateCookie);
		}
		
		private function setFont() :void {
			
			_uiFont.color = 0xEEEEEE;
			_uiFont.font = "Press Start";
			_scoreDisplay.embedFonts;
		}
		private function ateCookie(c:CookieEvent):void 
		{
			updateScoreDisplay(c.score)
		}
		private function updateScoreDisplay(scr : int):void {
			
			_score += scr;
			_scoreDisplay.text = "SCORE : " + _score;
			
			if (_score % 10000 == 0) {
				updateLifeDisplay(1);
			}
			if (_score > hightscore) {
				innerHighscore.data.score = _score;
				hightscore = innerHighscore.data.score;
				_highScoreDisplay.text = hightscore.toString();
				//end game flush gebruiken om highscore op te slaan.
			}
		}
		public function updateLifeDisplay(live : int):void {
			
			lives += live;
			
			for (var l : int = 0; l < livesDisplayObjects.length; l++) {
				removeChild(livesDisplayObjects[l]);
			}
			
			livesDisplayObjects = [];
			
			for (var i : int = 0; i < lives; i++) {
				
				var liveDis : MovieClip = new PacManWalk();
				liveDis.gotoAndStop(4);
				liveDis.scaleX = 0.7;
				liveDis.scaleY = 0.7;
				addChild(liveDis);
				liveDis.x = (i * 30) + 30;
				liveDis.y = stage.stageHeight - 15;
				livesDisplayObjects.push(liveDis);
			}
			if (lives <= 0) {
				fscommand('quit');
			}
		}
		
	}

}