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
		public static const PAC_DEATH : int = 3;
		public static const EAT_GHOST : int = 4;
		public static const BLUE_SIREN : int = 5;
		public static const EAT_FRUIT : int = 6;
		public static const LIVES_ONE_UP : int = 7;
		
		public static var allSoundsLoaded : Boolean = false;
		
		private static var soundChannel : SoundChannel = new SoundChannel();
		private static var musicChannel : SoundChannel = new SoundChannel();
		private static var totalSoundsLoaded : int = 0;
		private static var currentSound : Sound = null;
		
		private static var allUrls : Array = [];
		private static var allSounds : Array = [];
		
		public static function loadSounds() : void 
		{
			
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/gapErwin/Retro_Game/bin/sounds/GameStart.mp3")); // Start Sound
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/gapErwin/Retro_Game/bin/sounds/Wakaedit.mp3")); // wakka wakka Sound
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/gapErwin/Retro_Game/bin/sounds/alarmEditAnders.mp3")); // Siren Sound
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/gapErwin/Retro_Game/bin/sounds/PacmanDies.mp3")); // Pacman dies Sound
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/gapErwin/Retro_Game/bin/sounds/PacmanEatingGhost.mp3")); // Eat Ghost Sound
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/gapErwin/Retro_Game/bin/sounds/BlueGhostsMove.mp3")); // blueGhost Siren Sound
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/gapErwin/Retro_Game/bin/sounds/PacmanEatingCherry.mp3")); // eating Fruit Sound
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/gapErwin/Retro_Game/bin/sounds/PacmanExtraLive.mp3")); // life up Sound
			
			
			for (var i : int = 0; i < allUrls.length; i++) {
				var sound : Sound = new Sound();
				sound.addEventListener(Event.COMPLETE, soundLoaded);
				sound.load(allUrls[i]);
				allSounds.push(sound);
			}
			if (allUrls.length == 0) {
				allSoundsLoaded = true;
			}
		}
		
		static private function soundLoaded(e:Event):void 
		{
			e.target.removeEventListener(Event.COMPLETE, soundLoaded);
			totalSoundsLoaded += 1;
			if (totalSoundsLoaded == allUrls.length) {
				allSoundsLoaded = true;
			}
		}
		public static function playSound(soundInt : int) : void {
			
			var sound : Sound = new Sound();
			sound = allSounds[soundInt];
			
			if (sound != null){
				if (currentSound != sound) {
					currentSound = sound;
					var trans : SoundTransform = new SoundTransform();
					
					if (sound == allSounds[SIREN]) {
						musicChannel.stop();
						trans.volume = 0.2;
						musicChannel = sound.play(30, 99999,trans);
					}else if (sound == allSounds[BLUE_SIREN]) {
						musicChannel.stop();
						trans.volume = 1;
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