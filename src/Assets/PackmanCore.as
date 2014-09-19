package Assets 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class PackmanCore extends Sprite
	{
		
		public function PackmanCore() 
		{
			graphics.beginFill(0xF3D409, 1);
			graphics.drawRect(0, 0, 16, 16);
			graphics.endFill();
			
			graphics.beginFill(0x000000, 1);
			graphics.drawRect(8, 8, 8, 2);
			graphics.endFill();
		}
		
	}

}