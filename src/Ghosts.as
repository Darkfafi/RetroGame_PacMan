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
		//protected var preDirection : int = 0;
		protected var direction : int = 1;
		
		protected var tile : Number;
		
		protected var walls : Array = [];
		protected var checkPoints : Array = [];
		protected var pacmanPos : Point = new Point();
		protected var target : Point = null;
		
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
			if(movement.x != 0){
				this.x += movement.x * tile * speed;
			}
			if(movement.y != 0){
				this.y += movement.y * tile * speed;
			}
		}
		
		protected function targetPinpoint() : void { //checktlocatie
			
			var dif : Point = new Point(target.x - this.x, target.y - this.y);
			//trace(Math.abs(dif.x));
			
			if(hitTestAlert() == false){
				if (dif.x != 0) {
					
					movement.x = Math.abs(dif.x) / dif.x;
					if(this.y%tile == 0){
						movement.y = 0;
					}
					
				}else if (dif.y != 0) {
					
					movement.y = Math.abs(dif.y) / dif.y;
					if(this.x%tile == 0){
						movement.x = 0;
					}
				}
			}else {
				movement.x = 0;
				movement.y = 0;
				if (target == pacmanPos) {
					//pak dicht bij zijnste checkPoint
					
				}else { target == pacmanPos; }	
			}
		}
		
		protected function closestCheckPoint() :void {
			
			
		}
		
		protected function hitTestAlert():Boolean {
			for (var i : uint = 0; i < walls.length; i++) {
				if (movement.x == -1) {
					if (walls[i].x == this.x - tile && walls[i].y == this.y) {
						return true;
						break;
					}
				}else if (movement.y == -1) {
					if (walls[i].y == this.y - tile && walls[i].x == this.x) {
						return true;
						break;
					}
				}else if (movement.x == 1) {
					if (walls[i].x == this.x + tile && walls[i].y == this.y) {
						return true;
						break;
					}
				}else if (movement.y == 1) {
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