package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import Levels.Level1;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Main extends Sprite 
	{
		private var level1 : Level1 = new Level1();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(level1);
		}
		
	}
	
}