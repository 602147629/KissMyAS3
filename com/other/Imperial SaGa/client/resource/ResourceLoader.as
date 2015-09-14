package resource
{
    import develop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import sound.*;
    import utility.*;

    public class ResourceLoader extends Object
    {
        private var _bLoaded:Boolean = false;
        private var _bDownLoad:Boolean = false;
        private var _downLoadTotal:uint = 0;
        private var _downLoadNow:uint = 0;
        private var _bRemoveLock:Boolean = false;
        private var _loader:Loader = null;
        private var _loaderData:URLLoader;
        private var _aCbComplete:Array;
        private var _cbCompleteManager:Function = null;
        private var _filePath:String;
        private var _loadTimeStamp:int;
        private var _optimizeTime:int;
        private var _bMovie:Boolean;
        private var _downloadFile:ByteArray;
        private var _option:ResourceLoaderOption;
        private var _retry:int;
        private static const _RETRY_MAX:int = 3;

        public function ResourceLoader()
        {
            this._aCbComplete = new Array();
            this._downloadFile = new ByteArray();
            this._loadTimeStamp = 0;
            this._optimizeTime = 0;
            this._retry = 0;
            return;
        }// end function

        public function get bLoaded() : Boolean
        {
            return this._bLoaded;
        }// end function

        public function get bDownLoad() : Boolean
        {
            return this._bDownLoad;
        }// end function

        public function getDownLoadProgress() : int
        {
            return this._downLoadTotal > 0 ? (100 * this._downLoadNow / this._downLoadTotal) : (0);
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

        public function get loadTimeStamp() : int
        {
            return this._loadTimeStamp;
        }// end function

        public function get optimizeTime() : int
        {
            return this._optimizeTime;
        }// end function

        public function set optimizeTime(param1:int) : void
        {
            this._optimizeTime = param1;
            return;
        }// end function

        public function get bMovie() : Boolean
        {
            return this._bMovie;
        }// end function

        public function set bMovie(param1:Boolean) : void
        {
            this._bMovie = param1;
            return;
        }// end function

        public function release() : void
        {
            this.removeEvent();
            if (this._loader != null)
            {
                this._loader.unload();
            }
            this._loader = null;
            this._loaderData = null;
            if (this._downloadFile)
            {
                this._downloadFile.clear();
            }
            this._downloadFile = null;
            return;
        }// end function

        public function updateLoadTimeStamp() : void
        {
            this._loadTimeStamp = getTimer();
            return;
        }// end function

        public function setBinary(param1:ByteArray) : void
        {
            var _loc_2:* = new LoaderContext();
            this._retry = _RETRY_MAX;
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.cbLoaderInfoComplete);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.cbLoaderIoError);
            this._loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loader_securityError);
            this._loader.loadBytes(param1, _loc_2);
            return;
        }// end function

        public function load(param1:String, param2:Function, param3:ResourceLoaderOption) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._option = param3;
            var _loc_4:* = this.getLoadPath(this._option);
            if (this._option.bNotEncryption == false)
            {
                _loc_5 = "";
                _loc_6 = param1.split("/");
                for each (_loc_7 in _loc_6)
                {
                    
                    if (_loc_5.length != 0)
                    {
                        _loc_5 = _loc_5 + "/";
                    }
                    _loc_5 = _loc_5 + Md5Hash.getHashValue(_loc_7);
                }
                param1 = _loc_5;
            }
            _loc_4 = _loc_4 + param1;
            this._filePath = param1;
            this.addCbComplete(param2);
            this._retry = 0;
            this.loadRequest(_loc_4);
            return;
        }// end function

        private function loadRequest(param1:String) : void
        {
            this._loaderData = new URLLoader();
            this._loaderData.dataFormat = URLLoaderDataFormat.BINARY;
            this._loaderData.addEventListener(Event.COMPLETE, this.cbLoadDataComplete);
            this._loaderData.addEventListener(ProgressEvent.PROGRESS, this.cbLoaderProgress);
            this._loaderData.addEventListener(IOErrorEvent.IO_ERROR, this.cbLoaderIoError);
            this._loaderData.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loader_securityError);
            this._loaderData.load(new URLRequest(param1));
            this.updateLoadTimeStamp();
            return;
        }// end function

        private function getLoadPath(param1:ResourceLoaderOption) : String
        {
            var _loc_2:* = Main.GetApplicationData().loadPath;
            if (param1.bUrl)
            {
                _loc_2 = "";
            }
            return _loc_2;
        }// end function

        public function addCbComplete(param1:Function) : void
        {
            if (param1 != null)
            {
                this._aCbComplete.push(param1);
            }
            return;
        }// end function

        public function setLoadComleteManager(param1:Function) : void
        {
            this._cbCompleteManager = param1;
            return;
        }// end function

        private function removeEvent() : void
        {
            if (this._loader != null)
            {
                if (this._loader.contentLoaderInfo.hasEventListener(Event.COMPLETE))
                {
                    this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.cbLoaderInfoComplete);
                }
                if (this._loader.contentLoaderInfo.hasEventListener(IOErrorEvent.IO_ERROR))
                {
                    this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.cbLoaderIoError);
                }
                if (this._loader.contentLoaderInfo.hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
                {
                    this._loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loader_securityError);
                }
            }
            if (this._loaderData != null)
            {
                if (this._loaderData.hasEventListener(Event.COMPLETE))
                {
                    this._loaderData.removeEventListener(Event.COMPLETE, this.cbLoadDataComplete);
                }
                if (this._loaderData.hasEventListener(ProgressEvent.PROGRESS))
                {
                    this._loaderData.removeEventListener(ProgressEvent.PROGRESS, this.cbLoaderProgress);
                }
                if (this._loaderData.hasEventListener(IOErrorEvent.IO_ERROR))
                {
                    this._loaderData.removeEventListener(IOErrorEvent.IO_ERROR, this.cbLoaderIoError);
                }
                if (this._loaderData.hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
                {
                    this._loaderData.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loader_securityError);
                }
            }
            return;
        }// end function

        private function loadRetry() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._retry + 1;
            _loc_1._retry = _loc_2;
            this.loadRequest(this.getLoadPath(this._option) + this._filePath);
            return;
        }// end function

        private function cbLoaderIoError(event:IOErrorEvent) : void
        {
            this.removeEvent();
            if (this._retry < _RETRY_MAX)
            {
                this.loadRetry();
                return;
            }
            var _loc_2:* = "リソースデータの読み込みに失敗しました\n";
            _loc_2 = _loc_2 + ("Code:" + event.errorID);
            Assert.print(_loc_2);
            return;
        }// end function

        private function loader_securityError(event:SecurityErrorEvent) : void
        {
            this.removeEvent();
            if (this._retry < _RETRY_MAX)
            {
                this.loadRetry();
                return;
            }
            var _loc_2:* = "リソースデータの読み込みに失敗しました\n";
            _loc_2 = _loc_2 + ("Code:" + event.errorID);
            Assert.print(_loc_2);
            return;
        }// end function

        private function cbLoaderInfoComplete(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.removeEvent();
            this._bLoaded = true;
            this.callbackCompleteManager();
            for each (_loc_2 in this._aCbComplete)
            {
                
                this._loc_2();
            }
            this._aCbComplete = [];
            if (this._bMovie)
            {
                _loc_3 = this.getMovieData();
                _loc_4 = new SoundTransform();
                _loc_4.volume = SoundManager.getInstance().bgmVolume;
                _loc_3.soundTransform = _loc_4;
            }
            return;
        }// end function

        private function callbackCompleteManager() : void
        {
            if (this._cbCompleteManager != null)
            {
                this._cbCompleteManager(this);
            }
            this._cbCompleteManager = null;
            return;
        }// end function

        private function cbLoaderProgress(event:ProgressEvent) : void
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

        private function cbLoadDataComplete(event:Event) : void
        {
            this.removeEvent();
            this._bDownLoad = true;
            this._downLoadNow = this._downLoadTotal;
            var _loc_2:* = this._loaderData.data as ByteArray;
            _loc_2.position = 0;
            if (this._option.bNotDecryption == false)
            {
                _loc_2 = Crypt.decryptionResource(Blowfish.fixationKeyResource, _loc_2);
            }
            if (this._bMovie == false)
            {
                this.setBinary(_loc_2);
            }
            else
            {
                this._downloadFile.writeBytes(_loc_2);
                this.callbackCompleteManager();
            }
            this._loaderData = null;
            return;
        }// end function

        public function createBitmap() : Bitmap
        {
            if (this._loader.content is Bitmap == false)
            {
                return null;
            }
            var _loc_1:* = this._loader.content as Bitmap;
            return new Bitmap(_loc_1.bitmapData.clone());
        }// end function

        public function createMovieClip(param1:String) : MovieClip
        {
            if (this._loader == null)
            {
                return null;
            }
            var _loc_2:* = this._loader.contentLoaderInfo.applicationDomain.getDefinition(param1) as Class;
            return new _loc_2;
        }// end function

        public function duplicateMovieClip() : MovieClip
        {
            if (this._loader == null)
            {
                return null;
            }
            var _loc_1:* = this._loader.content as MovieClip;
            var _loc_2:* = _loc_1.constructor;
            return new _loc_2;
        }// end function

        public function createSwfInBitmap(param1:String) : BitmapData
        {
            if (this._loader == null)
            {
                return null;
            }
            var _loc_2:* = this._loader.contentLoaderInfo.applicationDomain.getDefinition(param1) as Class;
            return new _loc_2;
        }// end function

        public function createClass(param1:String) : Class
        {
            if (this._loader == null)
            {
                return null;
            }
            var _loc_2:* = this._loader.contentLoaderInfo.applicationDomain.getDefinition(param1) as Class;
            return _loc_2;
        }// end function

        public function loadMovieData() : void
        {
            if (this._downloadFile.length == 0)
            {
                return;
            }
            this.setBinary(this._downloadFile);
            return;
        }// end function

        public function getMovieData() : MovieClip
        {
            if (this._downloadFile.length == 0)
            {
                return null;
            }
            if (this._bDownLoad == false)
            {
                return null;
            }
            if (this._loader == null)
            {
                return null;
            }
            return this._loader.content as MovieClip;
        }// end function

        public function removeMovie() : void
        {
            if (this._loader == null)
            {
                return;
            }
            var _loc_1:* = this._loader.content as MovieClip;
            if (_loc_1 != null)
            {
                _loc_1.stop();
            }
            DebugLog.print("Movie unloadAndStop");
            this._loader.unloadAndStop();
            return;
        }// end function

    }
}
