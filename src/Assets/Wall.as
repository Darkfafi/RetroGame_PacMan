package Assets 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Wall extends Sprite
	{
		public function Wall() 
		{
			graphics.lineStyle(1,0xFFFFFF);
			graphics.beginFill(0x696969);
			graphics.drawRect(0, 0, 15, 15);
			graphics.endFill();
		}
		
	}

}