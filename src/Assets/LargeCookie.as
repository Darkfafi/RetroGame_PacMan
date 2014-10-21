package Assets 
{
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class LargeCookie 
	{
		public var animateCookie : Boolean = true;
		private var timer :Timer = new Timer(500);
		
		public function LargeCookie() 
		{
			//in tile system word gekeken of het is gegeten. zo ja roept het tile system bij elk spookje het kan gegeten worden functie op en die zet een timer aan en na die timer gaat hij weer terug door een andere functie
			
		}
		private function animate() :void {
			if (animateCookie) {
				
			}
		}
		
	}

}