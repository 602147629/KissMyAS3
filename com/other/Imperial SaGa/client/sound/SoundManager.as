package sound
{
    import flash.media.*;
    import flash.utils.*;
    import resource.*;
    import utility.*;

    public class SoundManager extends Object
    {
        private const _OPTIMIZE_TIME:int = 600000;
        private const _BGM_LOOP_COUNT:int = 9999;
        private var _buttonPushClass:Class;
        private const _aEmbedSound:Array;
        private var _aSound:Dictionary;
        private var _bgmId:int = -1;
        private var _bgm:SoundMedia = null;
        private var _oldBgm:SoundMedia = null;
        private var _seVolume:Number = 1;
        private var _bgmVolume:Number = 1;
        private var _bgmVolumeRate:Number = 1;
        private var _bgmNextId:int = -1;
        private var _bgmLoopCount:int = 9999;
        private var _aLoading:Array;
        private var _aFedeOutChannel:Array;
        private var _bgmFadeState:int;
        private const _BGM_NOT_FADE:int = 0;
        private const _BGM_FADE_OUT:int = 1;
        private const _BGM_FADE_IN:int = 2;
        private const _FADE_OUT_SECOND:Number = 0.5;
        private const _FADE_IN_SECOND:Number = 0.5;
        private var _bCreated:Boolean;
        private var _loader:XmlLoader;
        private var _aSoundListData:Array;
        private static const _MASTER_VOLUME:Number = 1;
        private static const _BGM_VOLUME:Number = 1;
        public static const RESOURCE_PATH:String = "resource/sound/";
        private static var _instance:SoundManager = null;

        public function SoundManager()
        {
            this._aEmbedSound = [];
            this._aLoading = new Array();
            this._bgmFadeState = this._BGM_NOT_FADE;
            this._aSound = new Dictionary(true);
            this._aSoundListData = [];
            this._seVolume = 1;
            this._bgmVolume = 1;
            var _loc_1:* = SoundMixer.soundTransform;
            _loc_1.volume = _MASTER_VOLUME;
            SoundMixer.soundTransform = _loc_1;
            this._aFedeOutChannel = [];
            return;
        }// end function

        public function get bgmId() : int
        {
            return this._bgmNextId == Constant.UNDECIDED ? (this._bgmId) : (this._bgmNextId);
        }// end function

        public function get seVolume() : Number
        {
            return this._seVolume;
        }// end function

        public function setVolumeSe(param1:Number) : void
        {
            this._seVolume = param1;
            if (this._seVolume < 0)
            {
                this._seVolume = 0;
            }
            if (this._seVolume > 1)
            {
                this._seVolume = 1;
            }
            return;
        }// end function

        public function get bgmVolume() : Number
        {
            return this._bgmVolume;
        }// end function

        public function setVolumeBgm(param1:Number) : void
        {
            this._bgmVolume = param1;
            if (this._bgmVolume < 0)
            {
                this._bgmVolume = 0;
            }
            if (this._bgmVolume > 1)
            {
                this._bgmVolume = 1;
            }
            return;
        }// end function

        public function get bgmVolumeRate() : Number
        {
            return this._bgmVolumeRate;
        }// end function

        public function setBgmLoopCount(param1:int) : void
        {
            this._bgmLoopCount = param1;
            return;
        }// end function

        public function addFedeOutChannel(param1:SoundChannel, param2:SoundListData, param3:Number) : void
        {
            this._aFedeOutChannel.push(new SoundFadeoutDelete(param1, param2, param3));
            return;
        }// end function

        public function getFadeOutSecond() : Number
        {
            return this._FADE_OUT_SECOND;
        }// end function

        public function getFadeInSecond() : Number
        {
            return this._FADE_IN_SECOND;
        }// end function

        public function isBgmFade() : Boolean
        {
            return this._bgmFadeState == this._BGM_NOT_FADE;
        }// end function

        public function get bCreated() : Boolean
        {
            return this._bCreated;
        }// end function

        public function loadListData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "SoundList.xml", this.cbLoadComplete, true);
            return;
        }// end function

        public function isListLoaded() : Boolean
        {
            if (this._loader != null)
            {
                return this._loader.bLoaded;
            }
            if (this._bCreated)
            {
                return true;
            }
            return false;
        }// end function

        public function xmlRestoration() : void
        {
            if (this._loader == null || this._loader != null && this._loader.bComplete)
            {
                return;
            }
            this._loader.restoration();
            return;
        }// end function

        private function cbLoadComplete(param1:XML) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = uint(param1.Ver);
            this._aSoundListData = [];
            for each (_loc_3 in param1.Data)
            {
                
                _loc_4 = new SoundListData();
                _loc_4.setXml(_loc_3);
                this._aSoundListData.push(_loc_4);
            }
            this._loader.release();
            this._loader = null;
            this._bCreated = true;
            this.deploymentEmbedSound();
            return;
        }// end function

        public function init() : void
        {
            return;
        }// end function

        private function deploymentEmbedSound() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_1 in this._aEmbedSound)
            {
                
                _loc_2 = _loc_1.id;
                _loc_3 = new this[_loc_1.className] as Sound;
                _loc_4 = new SoundMedia();
                _loc_4.setEmbedSound(_loc_2, _loc_3);
                this._aSound[_loc_2.toString()] = _loc_4;
            }
            return;
        }// end function

        public function loadSound(param1:int, param2:Function = null) : SoundMedia
        {
            var _loc_3:* = new SoundMedia();
            var _loc_4:* = this._aSound[param1.toString()];
            if (this._aSound[param1.toString()] == null)
            {
                _loc_3.load(param1, param2);
                _loc_3.setLoadComleteManager(this.cbLoadCompleteManager);
                this._aSound[param1.toString()] = _loc_3;
                this._aLoading.push(_loc_3);
            }
            else if (_loc_4.bKill)
            {
                _loc_4.bKill = false;
            }
            _loc_3.updateLoadTimeStamp();
            return _loc_3;
        }// end function

        public function loadSoundArray(param1:Array) : Array
        {
            var _loc_3:* = 0;
            var _loc_2:* = new Array();
            for each (_loc_3 in param1)
            {
                
                _loc_2.push(this.loadSound(_loc_3));
            }
            return _loc_2;
        }// end function

        private function cbLoadCompleteManager(param1:SoundMedia) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aLoading.length)
            {
                
                _loc_3 = this._aLoading[_loc_2];
                if (_loc_3 == param1)
                {
                    this._aLoading.splice(_loc_2, 1);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function isLoaded() : Boolean
        {
            return this._aLoading.length == 0 ? (true) : (false);
        }// end function

        public function getLoadTaskNum() : int
        {
            var _loc_3:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this._aLoading.length)
            {
                
                _loc_3 = this._aLoading[_loc_2];
                _loc_1 = _loc_1 + (100 - _loc_3.getDownLoadProgress());
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = false;
            if (this._bgm)
            {
                this._bgm.control();
                _loc_2 = false;
                if (this._bgmFadeState != this._BGM_NOT_FADE)
                {
                    switch(this._bgmFadeState)
                    {
                        case this._BGM_FADE_OUT:
                        {
                            this._bgmVolumeRate = this._bgmVolumeRate - param1 * (1 / this._FADE_OUT_SECOND);
                            if (this._bgmVolumeRate <= 0)
                            {
                                this._bgmVolumeRate = 0;
                                this._bgm.stop();
                                _loc_3 = this._bgm.bKill;
                                this._bgm = null;
                                if (_loc_3)
                                {
                                    this.removeSound(this._bgmId);
                                }
                                this._bgmFadeState = this._BGM_NOT_FADE;
                                this._bgmId = Constant.UNDECIDED;
                                _loc_2 = true;
                            }
                            break;
                        }
                        case this._BGM_FADE_IN:
                        {
                            this._bgmVolumeRate = this._bgmVolumeRate + param1 * (1 / this._FADE_IN_SECOND);
                            if (this._bgmVolumeRate >= 1)
                            {
                                this._bgmVolumeRate = 1;
                                this._bgmFadeState = this._BGM_NOT_FADE;
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                if (this._bgm != null)
                {
                    this._bgm.setVolume(this._bgmVolume * this._bgmVolumeRate);
                }
                if (_loc_2 && this._bgmFadeState == this._BGM_NOT_FADE && this._bgmNextId != Constant.UNDECIDED)
                {
                    this.playNewBgm(this._bgmNextId);
                    this.bgmFadeIn();
                    this._bgmNextId = Constant.UNDECIDED;
                }
            }
            return;
        }// end function

        public function playBgm(param1:int, param2:Number = 0) : void
        {
            if (this._bgmId == Constant.UNDECIDED)
            {
                this.playNewBgm(param1, param2);
                this._bgmFadeState = this._BGM_NOT_FADE;
            }
            else
            {
                this._bgmNextId = param1;
                this.bgmFadeOut();
            }
            return;
        }// end function

        public function stopBgm() : void
        {
            if (this._bgm == null)
            {
                return;
            }
            this.bgmFadeOut();
            return;
        }// end function

        public function pauseBgm() : void
        {
            if (this._bgm == null)
            {
                return;
            }
            this._bgm.pause();
            this._bgmId = Constant.UNDECIDED;
            return;
        }// end function

        public function resumeBgm() : void
        {
            if (this._bgm == null)
            {
                return;
            }
            this._bgm.resume();
            return;
        }// end function

        public function playSe(param1:int, param2:Number = 1) : void
        {
            var _loc_3:* = this._aSound[param1.toString()];
            if (_loc_3 == null)
            {
                Assert.print("サウンドファイルの読み込みが行われていません ID:" + param1);
                return;
            }
            _loc_3.play(param2 * this._seVolume);
            return;
        }// end function

        public function playSeCallBack(param1:int, param2:Function, param3:Number = 1) : void
        {
            var _loc_4:* = this._aSound[param1.toString()];
            this._aSound[param1.toString()].play(param3 * this._seVolume, 0, param2);
            return;
        }// end function

        public function playSeLoop(param1:int, param2:int, param3:Number = 1) : void
        {
            var _loc_4:* = this._aSound[param1.toString()];
            this._aSound[param1.toString()].play(param3 * this._seVolume, param2);
            return;
        }// end function

        private function playNewBgm(param1:int, param2:Number = 0) : void
        {
            var _loc_3:* = this._aSound[param1.toString()];
            if (_loc_3 == null)
            {
                Assert.print("サウンドファイルの読み込みが行われていません ID:" + param1);
                return;
            }
            this._bgmId = param1;
            this._bgm = _loc_3;
            this._bgmLoopCount = this._BGM_LOOP_COUNT;
            this._bgm.playBgm(param2, this._bgmLoopCount);
            this._bgmVolumeRate = 1;
            this._bgm.setVolume(this._bgmVolume * this._bgmVolumeRate);
            return;
        }// end function

        public function setKill(param1:int) : void
        {
            var _loc_2:* = this._aSound[param1.toString()];
            _loc_2.bKill = true;
            return;
        }// end function

        public function getSoundListData(param1:int) : SoundListData
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aSoundListData)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        private function bgmFadeOut() : void
        {
            this._bgmFadeState = this._BGM_FADE_OUT;
            return;
        }// end function

        private function bgmFadeIn() : void
        {
            this._bgmFadeState = this._BGM_FADE_IN;
            return;
        }// end function

        public function removeSoundAll() : void
        {
            var _loc_1:* = null;
            var _loc_3:* = 0;
            this._bgmNextId = Constant.UNDECIDED;
            var _loc_2:* = new Array();
            for (_loc_1 in this._aSound)
            {
                
                _loc_2.push(_loc_1);
            }
            for each (_loc_1 in _loc_2)
            {
                
                _loc_3 = parseInt(_loc_1);
                if (_loc_3 == this._bgmId)
                {
                    continue;
                }
                this.removeSound(_loc_3);
            }
            return;
        }// end function

        public function Optimization() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            this._bgmNextId = Constant.UNDECIDED;
            var _loc_1:* = getTimer();
            var _loc_2:* = [];
            for (_loc_3 in this._aSound)
            {
                
                _loc_5 = this._aSound[_loc_3];
                _loc_6 = parseInt(_loc_3);
                if (_loc_6 == this._bgmId)
                {
                    continue;
                }
                if (_loc_5.bIsEmbed)
                {
                    continue;
                }
                if (_loc_5.bRemoveLock)
                {
                    continue;
                }
                _loc_7 = _loc_1 - _loc_5.loadTimeStamp;
                if (_loc_7 >= this._OPTIMIZE_TIME)
                {
                    _loc_2.push(_loc_6);
                }
            }
            for each (_loc_4 in _loc_2)
            {
                
                this.removeSound(_loc_4);
            }
            return;
        }// end function

        private function removeSound(param1:int) : void
        {
            var _loc_2:* = param1.toString();
            var _loc_3:* = this._aSound[_loc_2];
            if (_loc_3.bIsEmbed)
            {
                return;
            }
            if (_loc_3.bRemoveLock)
            {
                return;
            }
            _loc_3.release();
            delete this._aSound[_loc_2];
            return;
        }// end function

        public function setMute(param1:Boolean) : void
        {
            var _loc_2:* = SoundMixer.soundTransform;
            var _loc_3:* = _MASTER_VOLUME;
            if (param1)
            {
                _loc_3 = 0;
            }
            _loc_2.volume = _loc_3;
            SoundMixer.soundTransform = _loc_2;
            return;
        }// end function

        public static function getInstance() : SoundManager
        {
            if (_instance == null)
            {
                _instance = new SoundManager;
            }
            return _instance;
        }// end function

    }
}
