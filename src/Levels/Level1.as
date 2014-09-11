package Levels 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Level1 extends MovieClip
	{
		private var tileSystem : TileSystem = new TileSystem();
		
		public function Level1() 
		{
			addChild(tileSystem);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void 
		{
			tileSystem.player.update(e);
		}
		
	}

}