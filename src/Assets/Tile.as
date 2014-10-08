package Assets 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Tile extends Sprite
	{
		
		public function Tile() 
		{
			//graphics.lineStyle(1,0x00ff00);
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, 16, 16);
			graphics.endFill();
		}
		
	}

}