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
	public class Player extends Sprite
	{
		private var core : Sprite = new PackmanCore(); //hitbox
		
		private var art : MovieClip = new PacManWalk(); //visual art <3
		private var art_playing : Boolean = false;
		
		private var tileSystem : TileSystem = new TileSystem();
		
		//movement
		private var preDirection : int = 0;
		private var direction : int = 0;
		
		private var tile : Number;
		private var walls : Array;
		
		//public var posX : Number;
		//public var posY : Number;
		
		private var speed : Number = 0.25;
		
		//cookies
		private var cookies : Array;
		public static const EAT_COOKIE : String = "eatCookie";
		
		public function Player(_posx : Number, _posy : Number) 
		{
			addChild(core); // core = hitbox pacman
			core.visible = false;
			addChild(art);
			art.stop();
			art.x = 8;
			art.y = 8;
			art.scaleX = 0.75;
			art.scaleY = 0.75;
			
			tile = new Number(tileSystem.tileWidth);
			walls = tileSystem.worldObPosition(1);
			cookies = TileSystem.cookies;
			
			//posX = _posx;
			//posY = _posy;
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
			eatCookie();
		}
		
		private function eatCookie():void 
		{
			// If you touch a cookie. Then eat it <3
			for (var i : int = 0; i < cookies.length; i++) {
				if (core.hitTestObject(cookies[i])) {
					var c : CookieEvent = new CookieEvent(Player.EAT_COOKIE,true);
					c.i = i;
					dispatchEvent(c);
				}
			}
		}
		private function movement():void {
			
			//teleport sides of stage
			if (this.x < 0 - core.width /2 && direction == 1) {
				this.x = tile * 28;
			}
			if (this.x > stage.stageWidth - core.width / 3 && direction == 3) {
				this.x = 0 - tile;
			}
			
			if (hitTestAlert(direction) == false) {
				if (art_playing == false && direction != 0) {
					art_playing = true;
					art.play();
				}
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
			}else { art.gotoAndStop(5); art_playing = false;}
			moveDir();
		}
		
		//voor rotatie bereken vanaf links boven van pacman waar hij word geplaatst
		private function moveDir():void {
			if (hitTestAlert(preDirection) == false) {
				if(preDirection != direction){
					if (this.x % 16 == 0) {
						if (preDirection == 2) {
							//up
							art.rotation = 270;
							direction = 2;
						}
						if (preDirection == 4) {
							//down
							art.rotation = 90;
							direction = 4
						}
					}if (this.y % 16 == 0) {
						if (preDirection == 3) {
							//right
							art.rotation = 0;
							direction = 3
						}
						if (preDirection == 1) {
							//left
							art.rotation = 180;
							direction = 1;
						}
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