package Assets 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Cookie extends Sprite
	{
		public function Cookie() 
		{
			graphics.beginFill(0xFFFF00, 1);
			graphics.drawCircle(8, 8, 2);
			graphics.endFill();
		}
		
	}

}