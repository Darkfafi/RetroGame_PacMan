package Assets 
{
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class LargeCookie extends Sprite
	{
		
		public var animateCookie : Boolean = true;
		
		private var timer :Timer = new Timer(500);
		private var color : uint = 0xDDDD00;
		
		public function LargeCookie() 
		{
			//in tile system word gekeken of het is gegeten. zo ja roept het tile system bij elk spookje het kan gegeten worden functie op en die zet een timer aan en na die timer gaat hij weer terug door een andere functie
			graphics.beginFill(color , 1);
			graphics.drawCircle(8, 8, 5);
			graphics.endFill();
			animate();
		}
		private function animate() :void {
			if (animateCookie) {
				
				if (color == 0xDDDD00) {
					color = 0x000000;
				}else { color = 0xDDDD00 };
				
				graphics.clear();
				
				graphics.beginFill(color, 1);
				graphics.drawCircle(8, 8, 5);
				graphics.endFill();
			}
			setTimeout(animate, 150);
		}
		
	}

}