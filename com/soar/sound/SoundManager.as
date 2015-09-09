package com.soar.sound {
	import flash.events.Event;
	import flash.media.Sound;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class SoundManager {
		private var backgroundSound:SoundSprite;
		private var soundMap:Vector.<SoundSprite> = new Vector.<SoundSprite>();
		
		public function SoundManager() {}
		
		/* 設定背景音樂 */
		public function setBackground(_sound:Sound):void {
			if (backgroundSound != null) {
				backgroundSound.removeSound();
				backgroundSound = null;
			}
			backgroundSound = new SoundSprite(_sound, "", .3);
		}
		
		/**
		 * 播放背景音樂，音樂將無限制循環直至停止播放
		 * @param	_repeat	設定循環次數 -1:監聽式無限循環
		 */
		public function playBackground(_repeat:int = -1):void {
			backgroundSound.playSound(_repeat);
		}
		
		/* 停止背景音樂 */
		public function stopBackground():void {
			backgroundSound.stopSound();
		}
		
		/* 變更背景音樂音量 0:最小聲 1:最大聲*/
		public function ChangeBGVolume(_volume:Number):void {
			if (_volume > 1)
				_volume = 1;
			if (_volume < 0)
				_volume = 0;
			backgroundSound.changeVolume(_volume);
		}
		
		/* 增加單個音效 */
		public function addSound(_sound:Sound, _name:String):void {
			soundMap.push(new SoundSprite(_sound, _name));
		}
		
		/* 增加多個音效 */
		public function addSounds(_sounds:Array):void {
			for each (var obj:Array in _sounds) {
				soundMap.push(new SoundSprite(obj[0], obj[1]));
			}
		}
		
		public function playSound(_name:String, _repeat:int = 0):void {
			if (_repeat < 0)
				_repeat = 0;
			for each (var obj:SoundSprite in soundMap) {
				if (obj.name == _name) {
					obj.playSound(_repeat);
					break;
				}
			}
		}
		
		public function stopSound(_name:String):void {
			for each (var obj:SoundSprite in soundMap) {
				if (obj.name == _name) {
					obj.stopSound();
					break;
				}
			}
		}
		
		public function ChangeSoundVolume(_volume:Number):void {
			if (_volume > 1)
				_volume = 1;
			if (_volume < 0)
				_volume = 0;
			for each (var obj:SoundSprite in soundMap) {
				obj.changeVolume(_volume);
			}
		}
	}
}

import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

class SoundSprite {
	private var sound:Sound;
	private var transform:SoundTransform;
	private var channel:SoundChannel;
	private var isPlaying:Boolean = false;
	private var soundName:String;
	
	public function set name(_name:String):void {
		soundName = _name;
	}
	
	public function get name():String {
		return soundName;
	}
	
	public function get playing():Boolean {
		return isPlaying;
	}
	
	public function SoundSprite(_sound:Sound, _name:String = "", _defaultVol:Number = .6) {
		this.sound = _sound;
		this.transform = new SoundTransform(_defaultVol)
		this.soundName = _name;
	}
	
	public function playSound(_loop:int):void {
		isPlaying = true;
		if (_loop == -1) {
			this.channel = this.sound.play(0, int.MAX_VALUE, this.transform);
			this.channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		} else {
			this.channel = this.sound.play(0, _loop, this.transform);
		}
	
	}
	
	public function stopSound():void {
		if (isPlaying) {
			this.channel.stop();
			if (channel.hasEventListener(Event.SOUND_COMPLETE))
				channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			isPlaying = false;
		}
	}
	
	private function onSoundComplete(e:Event):void {
		channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		this.channel = this.sound.play(0, 1, this.transform);
		this.channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
	}
	
	public function changeVolume(_vol:Number):void {
		transform.volume = _vol;
		if (this.channel != null)
			this.channel.soundTransform = transform;
	}
	
	public function removeSound():void {
		channel.stop();
		if (channel.hasEventListener(Event.SOUND_COMPLETE))
			channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		transform = null;
		sound.close();
		sound = null;
	}

}