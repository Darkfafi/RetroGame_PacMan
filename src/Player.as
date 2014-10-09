package  
{
	import Assets.PackmanCore;
	import Assets.Wall;
	import Events.CookieEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Player extends MovingObject
	{
		//cookies
		private var cookies : Array;
		public static const EAT_COOKIE : String = "eatCookie";
		
		public function Player(cookies : Array) 
		{
			this.cookies = cookies;
		}
		
		protected override function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var pacmanArt : MovieClip = new PacManWalk();
			
			drawObject(pacmanArt);
			
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
		}
		
		private function eatCookie():void 
		{
			// If you touch a cookie. Then eat it <3
			for (var i : int = 0; i < cookies.length; i++) {
				if (core.hitTestObject(cookies[i])) {
					var c : CookieEvent = new CookieEvent(Player.EAT_COOKIE,true);
					c.i = i;
					c.score = 10;
					dispatchEvent(c);
				}
			}
		}
	}

}