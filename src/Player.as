package  
{
	import Assets.Packman;
	import Assets.Wall;
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
		private var up : Boolean;
		private var right : Boolean;
		private var down : Boolean;
		private var left : Boolean;
		private var direction : int = 0;
		
		private var tile : Number;
		private var walls : Array;
		
		public var posX : Number;
		public var posY : Number;
		
		private var speed : Number = new Number(0.25);
		
		public function Player(_posx : Number, _posy : Number) 
		{
			addChild(art);
			
			tile = new Number(tileSystem.tileWidth);
			walls = tileSystem.worldObPosition(1);
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
				/*left = true;
				up = false;
				right = false;
				down = false;*/
				direction = 1;
			}
			else if (e.keyCode == 38) {
				/*up = true;
				left = false;
				right = false;
				down = false;*/
				direction = 2;
			}else if (e.keyCode == 39) {
				/*right = true;
				left = false;
				up = false;
				down = false;*/
				direction = 3;
				
			}else if (e.keyCode == 40) {
				/*left = false;
				up = false;
				right = false;
				down = true;*/
				direction = 4;
			}
		}
		
		public function update(e:Event):void 
		{
			moveDir();
			//this.x%tile == 0  <-- goed idee Ramses! Dit moet je zeker weten later gebruiken om hem later te laten bewegen in bochten zonder dat pac-man zichzelf van kant maakt. <3
			if (left && hitTestAlert() == false){
				this.x -= tile * speed;
			}
			if (up && hitTestAlert() == false) {
				this.y -= tile * speed;
			}
			if (right && hitTestAlert() == false) {
				this.x += tile * speed;
			}
			if (down && hitTestAlert() == false) {
				this.y += tile * speed;
			}
		}
		
		private function moveDir():void {
			
			for (var i : uint = 0; i < walls.length; i++) {
				if (direction == 1 && walls[i].x != this.x - tile && walls[i].y == this.y) {
						up = false;
						left = true;
						right = false;
						down = false;
				}else if (direction == 2 && walls[i].y != this.y - tile && walls[i].x == this.x) {
						up = true;
						left = false;
						right = false;
						down = false;
				}else if (direction == 3 && walls[i].x != this.x + tile && walls[i].y == this.y) {
						right = true;
						left = false;
						up = false;
						down = false;
				}else if (direction == 4 && walls[i].y != this.y + tile && walls[i].x == this.x) {
						left = false;
						up = false;
						right = false;
						down = true;
				}
			}
			
		}
		
		private function hitTestAlert():Boolean {
			for (var i : uint = 0; i < walls.length; i++) {
				if (left) {
					if (walls[i].x == this.x - tile && walls[i].y == this.y) {
						return true;
						break;
					}
				}else if (up) {
					if (walls[i].y == this.y - tile && walls[i].x == this.x) {
						return true;
						break;
					}
				}else if (right) {
					if (walls[i].x == this.x + tile && walls[i].y == this.y) {
						return true;
						break;
					}
				}else if (down) {
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