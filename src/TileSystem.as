package  
{
	import Assets.BackGround;
	import Assets.Cookie;
	import Assets.Tile;
	import Assets.Wall;
	import Events.CookieEvent;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import Ghost.BlueGhost;
	import Ghost.Ghosts;
	import Ghost.PinkGhost;
	import Ghost.RedGhost;
	import Ghost.YellowGhost;
	import Sound.SoundManager;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class TileSystem extends MovieClip
	{
		private var background : BackGround = new BackGround();
		
		public var tileWidth : int = 16;
		public var tileHight : int = 16;
		
		public static const NEXT_LEVEN : String = "nextLevel";
		
		public var cookies : Array = [];
		
		public static var player : Player;
		public var ghosts : Array  = [];
		
		private var tileWorld : Array = 
		[
			//height 36 tiles en width 28 tiles 
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
			[1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1],
			[1, 3, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 3, 1],
			[1, 0, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 0, 1],
			[1, 3, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 3, 1],
			[1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1],
			[1, 3, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 3, 1],
			[1, 3, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 3, 1],
			[1, 3, 3, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 3, 3, 1],
			[1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1],
			[0, 0, 0, 0, 0, 1, 3, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 3, 1, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 1, 3, 1, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 1, 1, 3, 1, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 1, 3, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 3, 1, 0, 0, 0, 0, 0],
			[1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1],
			[0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 1, 0, 4, 0, 4, 0, 4, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0],
			[1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1],
			[0, 0, 0, 0, 0, 1, 3, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 3, 1, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 3, 1, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 1, 3, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 3, 1, 0, 0, 0, 0, 0],
			[1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1],
			[1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1],
			[1, 3, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 3, 1],
			[1, 3, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 3, 1],
			[1, 0, 3, 3, 1, 1, 3, 3, 3, 3, 3, 3, 3, 0, 2, 3, 3, 3, 3, 3, 3, 3, 1, 1, 3, 3, 0, 1],
			[1, 1, 1, 3, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 3, 1, 1, 1],
			[1, 1, 1, 3, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 3, 1, 1, 1],
			[1, 3, 3, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 3, 3, 1],
			[1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1],
			[1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1],
			[1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1],
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
			
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		];
		
		
		public function TileSystem() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Player.EAT_COOKIE, removeCookie);
		}
		
		private function removeCookie(c:CookieEvent):void 
		{
			removeChild(cookies[c.i]);
			cookies.splice(c.i, 1);
			if (cookies.length == 0) {
				//before dispatch show compleat animation
				for (var i : int = ghosts.length - 1; i >= 0; i--) {
					
					removeChild(ghosts[i]);
					ghosts.splice(i, 1);
				}
				removeChild(player);
				player = null;
				SoundManager.stopSound();
				background.addEventListener(BackGround.ANIMATION_END, endLevel);
				background.endAnim();
				//dispatchEvent(new Event(NEXT_LEVEN, true));
			}
			//add score and add if cookies array == 0 then end game.
		}
		
		private function endLevel(e:Event):void 
		{
			dispatchEvent(new Event(NEXT_LEVEN, true));
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(background);
			
			background.y = tileHight * 3
			var lYRows : int = tileWorld.length;
			for (var i : int = 0; i < lYRows; i++) {
				
				var lXRows : int = tileWorld[i].length;
				
				for (var j : int = 0; j < lXRows; j++) {
					
					var object : Sprite;
					object = new Tile();
					object.x = j * 16;
					object.y = i * 16;
					addChildAt(object,0);
					
					if (tileWorld[i][j] == 1) {
						object = new Wall();
						object.x = j * 16;
						object.y = i * 16;
						addChildAt(object, 1);
						object.visible = false;
						
					}else if (tileWorld[i][j] == 3) {
						
						object = new Cookie();
						object.x = j * 16;
						object.y = i * 16;
						addChild(object);
						cookies.push(object);
					}
					else if (tileWorld[i][j] == 2) {
						
						player = new Player(cookies);
						player.x = j * 16 - tileWidth / 2;
						player.y = i * 16;
						addChild(player);
						
					}else if (tileWorld[i][j] == 4) {
						//if ghosts.length == 0 red else other color else other color
						if(ghosts.length == 0){
							object = new RedGhost();
						}else if (ghosts.length == 1) {
							object = new BlueGhost();
						}else if (ghosts.length == 2) {
							object = new PinkGhost();
						}else if (ghosts.length == 3) {
							object = new YellowGhost();
						}
						object.x = j * 16 - tileWidth / 2;
						object.y = i * 16;
						addChild(object);
						object.visible = false;
						ghosts.push(object);
					}
					if (cookies.length == 240) {
						//plaatst ze boven de koekjes....I know okey jezus maar ik had geen ideeën meer! 
						for (var k : int = 0; k < ghosts.length; k++) {
							addChild(ghosts[k]);
						}
					}
				}
			}
		}
		
		public function worldObPosition(n : int) : Array {
			
			var positionOb : Point;
			var result : Array = [];
			
			var lYRows : int = tileWorld.length;
			for (var i : int = 0; i < lYRows; i++) {
				
				var lXRows : int = tileWorld[i].length;
				
				for (var j : int = 0; j < lXRows; j++) {
					
					if (tileWorld[i][j] == n) {
						
						positionOb = new Point(j * tileWidth, i * tileHight);
						result.push(positionOb);
					}
				}
			}
			//trace(result);
			return result;
		}
		public function placeMoversOrigPos() :void {
			var k : int = -1;
			
			var lYRows : int = tileWorld.length;
				for (var i : int = 0; i < lYRows; i++) {
					var lXRows : int = tileWorld[i].length;
					
					for (var j : int = 0; j < lXRows; j++) {
						if (tileWorld[i][j] == 4) {
							k += 1;
							ghosts[k].x = j * 16 - tileWidth / 2;
							ghosts[k].y = i * 16;
							ghosts[k].followingPlayer = true;
							ghosts[k]._direction = 0;
							ghosts[k].currentTask = 0;
							ghosts[k]._preDirection = 0;
						}
						if (tileWorld[i][j] == 2) {
							player.x = j * 16 - tileWidth / 2;
							player.y = i * 16;
							player._direction = 0;
							player._preDirection = 0;
						}
					}
			}
		}
		public function destroy():void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			removeEventListener(Player.EAT_COOKIE, removeCookie);

			var i:int, l:int, cur:DisplayObject;
			l = this.numChildren;
			trace(l);
			for ( i = l - 1; i >= 0; i--) {
				cur = this.getChildAt( i );
				
				if(cur is Sprite){
					removeChild(cur);
				}
			}
			trace(cookies.length);
			cur = null;
			i = l = NaN;	
		}
	}

}