package Events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class CookieEvent extends Event
	{
		public var i:int;
		public var score : int;
		
		public function CookieEvent(str : String, bub : Boolean) 
		{
			super(str,bub);
		}
		
	}

}