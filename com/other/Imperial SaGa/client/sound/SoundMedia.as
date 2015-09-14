package sound
{
    import develop.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.utils.*;
    import utility.*;

    public class SoundMedia extends Object
    {
        private var _id:int;
        private var _bRemoveLock:Boolean = false;
        private var _bKill:Boolean;
        private var _bLoaded:Boolean = false;
        private var _downLoadTotal:uint = 0;
        private var _downLoadNow:uint = 0;
        private var _bIsEmbed:Boolean = false;
        private var _sound:Sound;
        private var _loader:URLLoader;
        private var _soundChannel:SoundChannel;
        private var _oldSoundChannel:SoundChannel;
        private var _aSoundChannnel:Array;
        private var _fadeVolume:Number;
        private var _oldFadeVolume:Number;
        private var _pausePosition:Number;
        private var _soundData:SoundListData;
        private var _cbLoadComplete:Function;
        private var _cbLoadCompleteManager:Function;
        private var _cbPlayEnd:Function;
        private var _filePath:String;
        private var _loadTimeStamp:int;
        private var _retry:int;
        private static const _RETRY_MAX:int = 3;

        public function SoundMedia()
        {
            this._aSoundChannnel = [];
            this._fadeVolume = 1;
            this._pausePosition = 0;
            this._loadTimeStamp = 0;
            this._retry = 0;
            this._bRemoveLock = false;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get bRemoveLock() : Boolean
        {
            return this._bRemoveLock;
        }// end function

        public function set bRemoveLock(param1:Boolean) : void
        {
            this._bRemoveLock = param1;
            return;
        }// end function

        public function get bKill() : Boolean
        {
            return this._bKill;
        }// end function

        public function set bKill(param1:Boolean) : void
        {
            this._bKill = param1;
            return;
        }// end function

        public function getDownLoadProgress() : int
        {
            return this._downLoadTotal > 0 ? (100 * this._downLoadNow / this._downLoadTotal) : (0);
        }// end function

        public function get bIsEmbed() : Boolean
        {
            return this._bIsEmbed;
        }// end function

        public function get sound() : Sound
        {
            return this._sound;
        }// end function

        public function get m_fadeVolume() : Number
        {
            return this._fadeVolume;
        }// end function

        public function get loadTimeStamp() : int
        {
            return this._loadTimeStamp;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            this.removeEvent();
            this._loader = null;
            this._soundData = null;
            if (this._soundChannel != null)
            {
                if (this._soundChannel.hasEventListener(Event.SOUND_COMPLETE))
                {
                    this._soundChannel.removeEventListener(Event.SOUND_COMPLETE, this.channel_soundComplete);
                }
            }
            this._soundChannel = null;
            for each (_loc_1 in this._aSoundChannnel)
            {
                
                if (_loc_1.hasEventListener(Event.SOUND_COMPLETE))
                {
                    _loc_1.removeEventListener(Event.SOUND_COMPLETE, this.channel_soundComplete);
                }
            }
            this._aSoundChannnel = null;
            this._sound = null;
            this._cbPlayEnd = null;
            return;
        }// end function

        public function updateLoadTimeStamp() : void
        {
            this._loadTimeStamp = getTimer();
            return;
        }// end function

        public function load(param1:int, param2:Function) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._id = param1;
            this._soundData = SoundManager.getInstance().getSoundListData(param1);
            if (this._soundData == null)
            {
                Assert.print("ID:" + param1 + "のサウンドデータが見つかりません");
                return;
            }
            var _loc_3:* = SoundManager.RESOURCE_PATH + this._soundData.fileName;
            var _loc_4:* = Main.GetApplicationData().isNotResourceDifficultToRead();
            if (Main.GetApplicationData().isNotResourceDifficultToRead() == false)
            {
                _loc_5 = "";
                _loc_6 = _loc_3.split("/");
                for each (_loc_7 in _loc_6)
                {
                    
                    if (_loc_5.length != 0)
                    {
                        _loc_5 = _loc_5 + "/";
                    }
                    _loc_5 = _loc_5 + Md5Hash.getHashValue(_loc_7);
                }
                _loc_3 = _loc_5;
            }
            this._filePath = _loc_3;
            this._cbLoadComplete = param2;
            this._sound = new Sound();
            this._retry = 0;
            this.loadRequest();
            return;
        }// end function

        private function loadRequest() : void
        {
            var _loc_1:* = Main.GetApplicationData().loadPath;
            _loc_1 = _loc_1 + this._filePath;
            this._loader = new URLLoader();
            this._loader.dataFormat = URLLoaderDataFormat.BINARY;
            this._loader.addEventListener(Event.COMPLETE, this.loadComplete);
            this._loader.addEventListener(ProgressEvent.PROGRESS, this.loadProgress);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.loadError);
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadSecurityError);
            this._loader.load(new URLRequest(_loc_1));
            return;
        }// end function

        public function removeEvent() : void
        {
            if (this._loader == null)
            {
                return;
            }
            if (this._loader.hasEventListener(Event.COMPLETE))
            {
                this._loader.removeEventListener(Event.COMPLETE, this.loadComplete);
            }
            if (this._loader.hasEventListener(ProgressEvent.PROGRESS))
            {
                this._loader.removeEventListener(ProgressEvent.PROGRESS, this.loadProgress);
            }
            if (this._loader.hasEventListener(IOErrorEvent.IO_ERROR))
            {
                this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.loadError);
            }
            if (this._loader.hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
            {
                this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadSecurityError);
            }
            return;
        }// end function

        private function loadRetry() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._retry + 1;
            _loc_1._retry = _loc_2;
            this.loadRequest();
            return;
        }// end function

        private function loadSecurityError(event:SecurityErrorEvent) : void
        {
            this.removeEvent();
            if (this._retry < _RETRY_MAX)
            {
                this.loadRetry();
                return;
            }
            var _loc_2:* = "サウンドの読み込みに失敗しました\n";
            _loc_2 = _loc_2 + ("Code:" + event.errorID);
            Assert.print(_loc_2);
            return;
        }// end function

        private function loadError(event:IOErrorEvent) : void
        {
            this.removeEvent();
            if (this._retry < _RETRY_MAX)
            {
                this.loadRetry();
                return;
            }
            var _loc_2:* = "サウンドの読み込みに失敗しました\n";
            _loc_2 = _loc_2 + ("Code:" + event.errorID);
            Assert.print(_loc_2);
            return;
        }// end function

        public function setLoadComleteManager(param1:Function) : void
        {
            this._cbLoadCompleteManager = param1;
            return;
        }// end function

        private function loadProgress(event:ProgressEvent) : void
        {
            var _loc_2:* = event.bytesTotal;
            if (this._downLoadTotal < _loc_2)
            {
                this._downLoadTotal = _loc_2;
            }
            var _loc_3:* = event.bytesLoaded;
            if (this._downLoadNow < _loc_3)
            {
                this._downLoadNow = _loc_3;
            }
            return;
        }// end function

        private function loadComplete(event:Event) : void
        {
            this.removeEvent();
            this._downLoadNow = this._downLoadTotal;
            var _loc_2:* = this._loader.data as ByteArray;
            _loc_2.position = 0;
            _loc_2 = Crypt.decryptionResource(Blowfish.fixationKeyResource, _loc_2);
            this._sound.loadCompressedDataFromByteArray(_loc_2, _loc_2.length);
            this._loader = null;
            this._bLoaded = true;
            if (this._cbLoadCompleteManager != null)
            {
                this._cbLoadCompleteManager(this);
            }
            if (this._cbLoadComplete != null)
            {
                this._cbLoadComplete();
            }
            return;
        }// end function

        public function setEmbedSound(param1:int, param2:Sound) : void
        {
            this._soundData = SoundManager.getInstance().getSoundListData(param1);
            this._sound = param2;
            this._bIsEmbed = true;
            return;
        }// end function

        public function playBgm(param1:Number = 0, param2:int = 0) : void
        {
            if (this._sound == null || this._sound.bytesTotal == 0)
            {
                Assert.print("サウンドが読み込み出来ていません ID:" + this._soundData.id);
                return;
            }
            if (this._soundData && !this._soundData.bLoop)
            {
                param2 = 1;
            }
            this._soundChannel = this._sound.play(param1, param2);
            return;
        }// end function

        public function play(param1:Number, param2:int = 0, param3:Function = null) : void
        {
            if (this._sound == null || this._sound.bytesTotal == 0)
            {
                Assert.print("サウンドが読み込み出来ていません ID:" + this._soundData.id);
                return;
            }
            if (this._soundData.parallelLimit != 0 && this._aSoundChannnel.length >= this._soundData.parallelLimit)
            {
                DebugLog.print("発音限界 ID:" + this._soundData.id + " 最大同時発音数:" + this._soundData.parallelLimit);
                return;
            }
            var _loc_4:* = this._sound.play(0, param2);
            if (this._sound.play(0, param2) != null)
            {
                this.changeVolume(_loc_4, param1);
                this._cbPlayEnd = param3;
                _loc_4.addEventListener(Event.SOUND_COMPLETE, this.channel_soundComplete);
                this._aSoundChannnel.push(_loc_4);
            }
            return;
        }// end function

        private function channel_soundComplete(event:Event) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = event.target as SoundChannel;
            _loc_2.removeEventListener(Event.SOUND_COMPLETE, this.channel_soundComplete);
            if (this._cbPlayEnd != null)
            {
                this._cbPlayEnd();
            }
            if (this._aSoundChannnel != null)
            {
                _loc_3 = this._aSoundChannnel.length - 1;
                while (_loc_3 >= 0)
                {
                    
                    _loc_4 = this._aSoundChannnel[_loc_3];
                    if (_loc_4 == _loc_2)
                    {
                        this._aSoundChannnel.splice(_loc_3, 1);
                        break;
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            return;
        }// end function

        public function stop() : void
        {
            if (this._soundChannel != null)
            {
                this._pausePosition = 0;
                this._soundChannel.stop();
            }
            if (this._oldSoundChannel)
            {
                this._oldSoundChannel.stop();
            }
            return;
        }// end function

        public function pause() : void
        {
            if (this._soundChannel != null)
            {
                this._pausePosition = this._soundChannel.position;
                this._soundChannel.stop();
                this._soundChannel = null;
            }
            if (this._oldSoundChannel)
            {
                this._oldSoundChannel.stop();
                this._oldSoundChannel = null;
            }
            return;
        }// end function

        public function resume() : void
        {
            if (this._pausePosition > 0)
            {
                this.playBgm(this._pausePosition);
                this._pausePosition = 0;
            }
            return;
        }// end function

        public function getVolume() : Number
        {
            return this._soundChannel.soundTransform.volume;
        }// end function

        public function setVolume(param1:Number) : void
        {
            this.changeVolume(this._soundChannel, param1);
            return;
        }// end function

        private function changeVolume(param1:SoundChannel, param2:Number) : void
        {
            this.changeVolume2(param1, this._fadeVolume, param2);
            return;
        }// end function

        private function changeVolume2(param1:SoundChannel, param2:Number, param3:Number) : void
        {
            var _loc_4:* = null;
            if (param1 != null)
            {
                _loc_4 = param1.soundTransform;
                _loc_4.volume = param3 * param2 * this._soundData.voluem;
                param1.soundTransform = _loc_4;
            }
            return;
        }// end function

        public function control() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            if (this._soundChannel == null)
            {
                return;
            }
            if (this._soundData.bLoop == false)
            {
                return;
            }
            if (this._soundData == null)
            {
                return;
            }
            if (this._soundChannel.position >= this._soundData.loopPosition)
            {
                _loc_1 = this._soundChannel.position;
                _loc_2 = _loc_1 - this._soundData.loopPosition;
                _loc_3 = this._soundData.startPosition + _loc_2;
                this._oldSoundChannel = this._soundChannel;
                this._oldFadeVolume = 1;
                this._fadeVolume = 0;
                this.playBgm(_loc_3, 1);
                _loc_4 = this._soundChannel.soundTransform;
                _loc_4.volume = this._fadeVolume;
                this._soundChannel.soundTransform = _loc_4;
            }
            else if (this._oldSoundChannel && this._soundChannel)
            {
                this._fadeVolume = this._fadeVolume + 0.5;
                if (this._fadeVolume >= 1)
                {
                    this._fadeVolume = 1;
                    this._oldFadeVolume = 0;
                }
                else
                {
                    this._oldFadeVolume = this._oldFadeVolume - 0.3;
                    if (this._oldFadeVolume <= 0)
                    {
                        this._oldFadeVolume = 0;
                    }
                }
                this.changeVolume2(this._soundChannel, SoundManager.getInstance().bgmVolume * SoundManager.getInstance().bgmVolumeRate, this._fadeVolume);
                this.changeVolume2(this._oldSoundChannel, SoundManager.getInstance().bgmVolume * SoundManager.getInstance().bgmVolumeRate, this._oldFadeVolume);
                if (this._oldFadeVolume <= 0)
                {
                    this._oldSoundChannel.stop();
                    this._oldSoundChannel = null;
                }
            }
            return;
        }// end function

    }
}
