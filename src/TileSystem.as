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
			[0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0],
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
				for (var i : int = 0; i < ghosts.length; i++) {
					
					removeChild(ghosts[i]);
					ghosts.splice(i, 1);
				}
				removeChild(player);
				player = null;
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
						
						object = new redGhost();
						object.x = j * 16 - tileWidth / 2;
						object.y = i * 16;
						addChild(object);
						ghosts.push(object);
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
			
			var lYRows : int = tileWorld.length;
				for (var i : int = 0; i < lYRows; i++) {
					var lXRows : int = tileWorld[i].length;
					
					for (var j : int = 0; j < lXRows; j++) {
						var l : int = ghosts.length;
						for (var k : int = 0; k < l; k++) {
							if (ghosts[k] is Ghosts && tileWorld[i][j] == 4) {
								ghosts[k].x = j * 16 - tileWidth / 2;
								ghosts[k].y = i * 16;
							}
						}
						if (tileWorld[i][j] == 2) {
							player.x = j * 16 - tileWidth / 2;
							player.y = i * 16;
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
			for ( i = 0; i < l; i++ ) {
				if(cur is Sprite){
					cur = this.getChildAt( i );
					removeChild(cur);
				}
			}
			trace(cookies.length);
			cur = null;
			i = l = NaN;	
		}
	}

}