package  
{
	import Assets.PackmanCore;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class MovingObject extends Sprite
	{
		
		public var core : Sprite = new PackmanCore(); //hitbox
		
		protected var art : MovieClip; //visual art <3
		protected var art_playing : Boolean = false;
		
		protected var tileSystem : TileSystem = new TileSystem();
		
		//movement
		protected var preDirection : int = 0;
		protected var direction : int = 0;
		protected var moving : Boolean = false;
		protected var preMovement : int = 0;
		protected var movementXY : Point = new Point();
		
		protected var tile : Number;
		protected var walls : Array;
		
		protected var speed : Number = 0.25;
		
		public function MovingObject() 
		{	
			tile = new Number(tileSystem.tileWidth);
			walls = tileSystem.worldObPosition(1);
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		protected function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			///voer de drawobject functie hier uit411212
		}
		protected function drawObject(_sprite : MovieClip) :void {
			
			art = _sprite;
			
			addChild(core); // core = hitbox pacman
			core.visible = false;
			addChild(art);
			art.stop();
			art.x = 8;
			art.y = 8;
			
		}
		
		public function update(e : Event) :void {
			movement();
		}
		
		protected function movement():void {
			
			//teleport sides of stage
			if (this.x < 0 - core.width /2 && direction == 1) {
				this.x = tile * 28;
			}
			if (this.x > stage.stageWidth - core.width / 3 && direction == 3) {
				this.x = 0 - tile;
			}
			
			if (hitTestAlert(direction) == false && direction != 0) {
				moving = true;
				if (art_playing == false && direction != 0) {
					art_playing = true;
					art.play();
				}
				if (movementXY.x == 1) {
					movementXY.y = 0;
					if (direction == 1){
						this.x -= tile * speed;
					}
					if (direction == 3) {
						this.x += tile * speed;
					}	
				}
				if (movementXY.y == 1) {
					movementXY.x = 0;
					if (direction == 4) {
						this.y += tile * speed;
					}
					if (direction == 2) {
						this.y -= tile * speed;
					}
				}
			}else { art_playing = false; moving = false; art.stop();}
			moveDir();
		}
		
		//voor rotatie bereken vanaf links boven van pacman waar hij word geplaatst
		protected function moveDir():void {
			if (hitTestAlert(preDirection) == false) {
				if (preDirection != direction) {
					if(preDirection == 2 || preDirection == 4){
						if (this.x % 16 == 0) {
							movementXY.x = 0;
							movementXY.y = 1;
							preMovement = direction;
							direction = preDirection;
							animate(direction);
						}
					}
					if(preDirection == 1 || preDirection == 3){
						if (this.y % 16 == 0) {
							movementXY.y = 0;
							movementXY.x = 1;
							preMovement = direction;
							direction = preDirection;
							animate(direction);
						}
					}
				}
			}
		}
		protected function animate(animInt : int) :void {
		}
		
		protected function hitTestAlert(dir : int):Boolean {
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
		
		public function set _preDirection(value:int):void 
		{
			preDirection = value;
		}
		
		public function set _direction(value:int):void 
		{
			direction = value;
		}
		
	}

}