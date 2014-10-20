package Ghost 
{
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class BlueGhost extends Ghosts
	{
		var beginCounter : int;
		public function BlueGhost() 
		{
			ghostArt = new GhostBlue();
		}
		
		override protected function preBehavior():void 
		{
			if (beginCounter < 5) {
				
				
			}
			else { currentTask = 1; finiteStateTimer.start(); }
		}
		
	}

}