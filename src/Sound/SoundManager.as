package Sound 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class SoundManager extends Sprite
	{
		public static const START_SOUND : int = 0;
		public static const EAT_DOT_SOUND : int = 1;
		public static const SIREN : int = 2;
		
		public static var allSoundsLoaded : Boolean = false;
		
		private static var soundChannel : SoundChannel = new SoundChannel();
		private static var musicChannel : SoundChannel = new SoundChannel();
		
		private static var currentSound : Sound = null;
		
		private static var allUrls : Array = [];
		private static var allSounds : Array = [];
		
		public static function loadSounds() : void 
		{
			allUrls.push(new URLRequest("http://vocaroo.com/media_command.php?media=s0ETrEMQ8xl4&command=download_mp3")); // Start Sound
			allUrls.push(new URLRequest("http://vocaroo.com/media_command.php?media=s08KsNc1Jn97&command=download_mp3")); // wakka wakka Sound
			allUrls.push(new URLRequest("http://vocaroo.com/media_command.php?media=s0YVMXhlb9xR&command=download_mp3")); // Siren Sound
			
			if(allUrls.length > 0){
				for (var i : int = 0; i < allUrls.length; i++) {
					var sound : Sound = new Sound();
					sound.load(allUrls[i]);
					if(sound.bytesLoaded == sound.bytesTotal){
						allSounds.push(sound);
						if (allSounds.length == allUrls.length) {
							allSoundsLoaded = true;
						}
					}
				}
			}else { allSoundsLoaded = true; }
		}
		public static function playSound(soundInt : int) : void {
			
			var sound : Sound = new Sound();
			
			sound = allSounds[soundInt];
			if (sound != null){
				if (currentSound != sound) {
					currentSound = sound;
					if (sound == allSounds[SIREN]) {
						var trans : SoundTransform = new SoundTransform(0.2);
						musicChannel = sound.play(290, 99999,trans);
					}else{
						soundChannel = sound.play();
					}
				}else {
					soundChannel.stop();
					soundChannel = sound.play();
					currentSound = null;
				}
			}
		}
		public static function stopSound() :void {
			soundChannel.stop();
			musicChannel.stop();
		}
		
	}

}