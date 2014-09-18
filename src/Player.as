package  
{
	import Assets.Packman;
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
	public class Player extends Sprite
	{
		private var art : Sprite = new Packman();
		private var tileSystem : TileSystem = new TileSystem();
		
		//movement
		private var preDirection : int = 0;
		private var direction : int = 0;
		
		private var tile : Number;
		private var walls : Array;
		
		public var posX : Number;
		public var posY : Number;
		
		private var speed : Number = 0.25;
		
		//cookies
		private var cookies : Array;
		public static const EAT_COOKIE : String = "eatCookie";
		
		public function Player(_posx : Number, _posy : Number) 
		{
			addChild(art);
			
			tile = new Number(tileSystem.tileWidth);
			walls = tileSystem.worldObPosition(1);
			cookies = TileSystem.cookies;
			
			trace(walls);
			
			posX = _posx;
			posY = _posy;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
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
		
		public function update(e:Event):void 
		{
			//this.x%tile == 0  <-- goed idee Ramses! Dit moet je zeker weten later gebruiken om hem later te laten bewegen in bochten zonder dat pac-man zichzelf van kant maakt. <3	
			movement();
			
			if (this.x <= 0 - this.width/3) {
				this.x = stage.stageWidth - this.width/2;
			}else if (this.x >= stage.stageWidth - this.width/3) {
				this.x = 0 - this.width/2;
			}
			
			for (var i : int = 0; i < cookies.length; i++) {
				if (this.hitTestObject(cookies[i])) {
					var c : CookieEvent = new CookieEvent(Player.EAT_COOKIE,true);
					c.i = i;
					dispatchEvent(c);
				}
				
			}
		}
		private function movement():void {
			
			if(hitTestAlert(direction) == false){
				if (direction == 1){
					this.x -= tile * speed;
				}
				if (direction == 2) {
					this.y -= tile * speed;
				}
				if (direction == 3) {
					this.x += tile * speed;
				}
				if (direction == 4) {
					this.y += tile * speed;
				}
			}
			moveDir();
		}
		private function moveDir():void {
			if(hitTestAlert(preDirection) == false){
				if(this.x%16 == 0){
					if (preDirection == 2) {
						//up
						direction = 2;
					}
					if (preDirection == 4) {
						//down
						direction = 4;
					}
				}if (this.y % 16 == 0) {
						
					if (preDirection == 3) {
						//right
						direction = 3
					}
					if (preDirection == 1) {
						//left
						direction = 1;
					}
				}
			}
		}
		
		private function hitTestAlert(dir : int):Boolean {
			for (var i : uint = 0; i < walls.length; i++) {
				if (dir == 1) {
					if (walls[i].x == this.x - tile && walls[i].y == this.y) {
						return true;
						break;
					}
				}else if (dir == 2) {
					if (walls[i].y == this.y - tile && walls[i].x == this.x) {
						return true;
						break;
					}
				}else if (dir == 3) {
					if (walls[i].x == this.x + tile && walls[i].y == this.y) {
						return true;
						break;
					}
				}else if (dir == 4) {
					if (walls[i].y == this.y + tile && walls[i].x == this.x) {
						return true;
						break;
					}
				}
			}
			return false;
		}
	}

}