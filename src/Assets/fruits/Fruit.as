package Assets.fruits 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Fruit extends Sprite
	{
		protected var scoreWorth : int;
		protected var art : Sprite = new Sprite();
		
		
		public function Fruit() {
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(art);
		}
		
		public function destroy() :void {
			
			removeChild(art);
			setTimeout(vanish, 1000);
		}
		
		private function vanish():void {
			
		}
	}

}