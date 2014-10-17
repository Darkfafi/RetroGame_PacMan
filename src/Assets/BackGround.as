package Assets 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class BackGround extends MovieClip
	{
		public static const ANIMATION_END : String = "animationEnd";
		
		private var background : Background = new Background();
		private var secondloop : Boolean = false;
		
		public function BackGround() 
		{	
			addChildAt(background,0);
			background.gotoAndStop(1);
		}
		
		public function endAnim() :void {
			var timer : Timer = new Timer(130, 8);
			
			timer.addEventListener(TimerEvent.TIMER, endAnimationAnimate);
			
			timer.start();
			
		}
		
		private function endAnimationAnimate(e:TimerEvent):void 
		{
			var t : Timer = e.target as Timer;
			
			switch(t.currentCount) {
				case 1:
					background.gotoAndStop(2);
					break;
				case 2:
					background.gotoAndStop(1);
					break;
				case 3:
					background.gotoAndStop(2);
					break;
				case 4:
					background.gotoAndStop(1);
					if (secondloop == true) {
						secondloop = false;
						t.reset();
						t.stop();
						dispatchEvent(new Event(ANIMATION_END));
					}else { t.reset(); t.start(); }
					secondloop = true;
					break;
			}
		}
		
	}

}