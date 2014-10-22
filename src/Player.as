package  
{
	import Assets.PackmanCore;
	import Assets.Wall;
	import Events.CookieEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import Sound.SoundManager;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Player extends MovingObject
	{
		//als je fruitje pakt. visible pacman is false. the score.visible bijv "100" is true. de score is altijd in het spel en word niet op het moment geaddchild. 
		//cookies
		private var cookies : Array;
		public static const EAT_COOKIE : String = "eatCookie";
		public static const DEATH : String = "death";
		
		public function Player(cookies : Array) 
		{
			this.cookies = cookies;
		}
		
		protected override function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var pacmanArt : MovieClip = new PacmanFull();
			
			drawObject(pacmanArt);
			
			art.scaleX = 0.4;
			art.scaleY = 0.4;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == 37) {
				preDirection = 1;
			}
			else if (e.keyCode == 38) {
				preDirection = 2;
			}else if (e.keyCode == 39) {
				preDirection = 3;
				
			}else if (e.keyCode == 40) {
				preDirection = 4;
			}
		}
		
		protected override function animate(animDir : int) :void {
			switch(animDir) {
				case 1:
					art.rotation = 180;
					break;
				case 2:
					art.rotation = 270;
					break;
				case 3:
					art.rotation = 0;
					break;
				case 4:
					art.rotation = 90;
					break;
			}
		}
		
		public override function update(e:Event):void 
		{
			super.update(e);
			
			eatCookie();
			if (art.currentFrame == 5) {
				art.gotoAndPlay(1);
			}
			if (moving == false && art_playing == false && direction != 0) {
				stopAnim();
			}
		}
		public function stopAnim() {
			art.gotoAndStop(5);
		}
		private function endAnime(e:Event):void 
		{
			if(art.currentFrame == art.totalFrames){
				stage.removeEventListener(Event.ENTER_FRAME, endAnime);
				art.gotoAndStop(1);
				this.visible = false;
				dispatchEvent(new Event(DEATH, true));
			}
		}
		public function playDeathAnimation() :void {
			art.gotoAndPlay(6);
			trace("fgdfg");
			art.rotation = 270;
			SoundManager.playSound(SoundManager.PAC_DEATH);
			stage.addEventListener(Event.ENTER_FRAME, endAnime);
		}
		
		private function eatCookie():void 
		{
			// If you touch a cookie. Then eat it <3
			for (var i : int = 0; i < cookies.length; i++) {
				if (core.hitTestObject(cookies[i])) {
					var c : CookieEvent = new CookieEvent(Player.EAT_COOKIE,true);
					c.i = i;
					c.score = 10 ;
					dispatchEvent(c);
					SoundManager.playSound(SoundManager.EAT_DOT_SOUND);
				}
			}
		}
	}

}