package Assets.fruits 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Fruit extends Sprite
	{
		private var showScoreText : TextField = new TextField(); 
		public var scoreWorth : int;
		public var art : Sprite;
		private var timer : Number = new Number();
		
		[Embed(source="../../../bin/lib/PRESS START REGULAR.TTF", 
		fontName = "PressStart", 
		mimeType = "application/x-font", 
		fontWeight="normal", 
		fontStyle="normal", 
		advancedAntiAliasing="true", 
		embedAsCFF="false")]
		
		private var PrssStart : Class;
		
		
		public function Fruit() {
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			var format : TextFormat = new TextFormat("PressStart", 11, 0xFFFFFF);
			showScoreText.defaultTextFormat = format;
			showScoreText.embedFonts = true;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			showScoreText.text = scoreWorth.toString();
			addChild(art);
			
			timer = setTimeout(remove,6000); //<--- hoe lang het op het spel blijft bestaan.
		}
		
		private function remove():void {
			
			stage.removeChild(this);
		}
		
		public function destroy() :void {
			clearTimeout(timer);
			
			//removeChild(art);
			art.visible = false;
			addChild(showScoreText);
			showScoreText.x = -20;
			showScoreText.y = -5;
			
			setTimeout(vanish, 2000);
		}
		
		private function vanish():void {
			stage.removeChild(this);
		}
	}

}