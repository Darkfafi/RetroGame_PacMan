package Sound 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class SoundManager extends Sprite
	{
		public static const START_SOUND : String = "startSound";
		public static const EAT_DOT_SOUND : String = "eatDotWaka";
		
		
		private static var soundChannel : SoundChannel = new SoundChannel();
		
		private static var currentSound : Sound;
		
		private static var allUrls : Array = [];
		private static var allSounds : Array = [];
		
		
		
		public static function loadSounds() : void 
		{
			allUrls.push(new URLRequest("http://vocaroo.com/media_command.php?media=s0ETrEMQ8xl4&command=download_mp3")); // Start Sound
			allUrls.push(new URLRequest("http://vocaroo.com/media_command.php?media=s08KsNc1Jn97&command=download_mp3")); // wakka wakka Sound
			//allUrls.push(new URLRequest("http://vocaroo.com/media_command.php?media=s0Ue8yUb2GOS&command=download_mp3")); // wakka wakka Sound
			
			for (var i : int = 0; i < allUrls.length; i++) {
				var sound : Sound = new Sound();
				sound.load(allUrls[i]);
				allSounds.push(sound);
			}
			
		}
		
		public static function playSound(soundString : String) : void {
			var sound : Sound = new Sound();
			
			switch(soundString) {
				case START_SOUND:
					sound = allSounds[0];
					break;
				case EAT_DOT_SOUND:
					sound = allSounds[1];
					break;
			}
			
			if (currentSound != sound) {
				currentSound = sound;
				soundChannel = sound.play();
			}else {
				soundChannel.stop();
				soundChannel = sound.play();
				currentSound = null;
			}
		}
		
	}

}