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
	public class Ghosts extends Sprite
	{
		protected var core : Sprite = new PackmanCore(); //hitbox
		
		//protected var art : MovieClip = new PacManWalk(); //visual art <3
		//protected var art_playing : Boolean = false;
		
		protected var tileSystem : TileSystem = new TileSystem();
		
		//movement
		protected var preDirection : int = 0;
		protected var direction : int = 0;
		
		protected var tile : Number;
		
		protected var walls : Array = [];
		protected var checkPoints : Array = [];
		protected var pacmanPos : Point = new Point();
		protected var target : Point = null;
		
		protected var preMovement : Point = new Point();
		protected var movement : Point = new Point();
		protected var speed : Number = 0.25;
		
		public function Ghosts() 
		{
			walls = tileSystem.worldObPosition(1);
			//checkPoints = tileSystem.worldObPosition(5);
			
			tile = new Number(tileSystem.tileWidth);
			
			addChild(core);
		}
		
		public function update(e : Event) : void {
			
			pacmanPos.x = TileSystem.player.x;
			pacmanPos.y = TileSystem.player.y;
			
			if (target != null) {
				targetPinpoint();
			}else { target = pacmanPos; }
			
			movementGhost();
		}
		
		protected function movementGhost() : void {
			if (hitTestAlert(direction) == false) {
				//if following the player
				this.x += movement.x * tile * speed;
				this.y += movement.y * tile * speed;
				//else if running from player
				}
		}
		
		protected function targetPinpoint() : void { //checktlocatie
			
			var dif : Point = new Point(target.x - this.x, target.y - this.y);
			//trace(Math.abs(dif.x));
			
			if (dif.x != 0) {	
				preMovement.x = Math.abs(dif.x) / dif.x;
				if (preMovement.x == -1) {
					preDirection = 1;
				}else if (preMovement.x == 1) {
					preDirection = 3;
				}
					
			}else if (dif.y != 0) {
					
				preMovement.y = Math.abs(dif.y) / dif.y;
				if (preMovement.y == -1) {
					preDirection = 2;
				}else if (preMovement.y == 1) {
					preDirection = 4;
				}
			}
			moveDir();
		}
		
		private function moveDir():void {
			if (hitTestAlert(preDirection) == false) {
				if (preDirection != direction) {
					if (preDirection == 1 || preDirection == 3) {
						if(this.y % 16 == 0){
							direction = preDirection;
							movement.x = preMovement.x;
							movement.y = 0;
						}
					}
					if (preDirection == 2 || preDirection == 4) {
						if(this.x % 16 == 0){
							direction = preDirection;
							movement.y = preMovement.y;
							movement.x = 0;
						}
					}
				}
			}
		}
		
		protected function closestCheckPoint() :void {
			
			
		}
		
		protected function hitTestAlert(dir : int):Boolean {
			for (var i : uint = 0; i < walls.length; i++) {
				if (dir == 1) {
					if (walls[i].x == this.x - tile && walls[i].y == this.y) {
						return true;
						trace("oii");
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