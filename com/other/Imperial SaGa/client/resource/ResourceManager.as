package resource
{
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;

    public class ResourceManager extends Object
    {
        private var _classPieceShadow:Class;
        private var _classWindow:Class;
        private const _OPTIMIZE_TIME:int = 600000;
        private const _OPTIMIZE_TIME_CHAR:int = 1.8e+006;
        private const _fontPath:String;
        private var _aEmbedClass:Array;
        private var _aLoader:Dictionary;
        private var _aLoading:Array;
        private var _fontName:String;
        private var _aLoadedXml:Array;
        public static const EMBED_COMMON_WINDOW:String = "_classWindow";
        private static var _instance:ResourceManager = null;

        public function ResourceManager()
        {
            this._classPieceShadow = ResourceManager__classPieceShadow;
            this._classWindow = ResourceManager__classWindow;
            this._fontPath = ResourcePath.FONT_PATH + "Font.swf";
            this._aEmbedClass = [EMBED_COMMON_WINDOW];
            this._aLoading = new Array();
            this._aLoader = new Dictionary(true);
            this._aLoadedXml = [];
            this.initialize();
            return;
        }// end function

        public function get fontName() : String
        {
            return this._fontName;
        }// end function

        private function initialize() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_1 in this._aEmbedClass)
            {
                
                _loc_2 = new ResourceLoader();
                _loc_2.bRemoveLock = true;
                _loc_2.setLoadComleteManager(this.cbLoaderComplete);
                this._aLoader[_loc_1] = _loc_2;
                this._aLoading.push(_loc_2);
                _loc_3 = this[_loc_1];
                _loc_2.setBinary(new _loc_3);
            }
            return;
        }// end function

        public function loadFont() : void
        {
            var _loc_1:* = this.loadResource(this._fontPath, this.cbLoadFontComplete);
            _loc_1.bRemoveLock = true;
            return;
        }// end function

        private function cbLoadFontComplete() : void
        {
            var _loc_1:* = this._aLoader[this._fontPath];
            if (_loc_1 == null)
            {
                return;
            }
            var _loc_2:* = _loc_1.createClass("font2");
            Font.registerFont(_loc_2);
            var _loc_3:* = new _loc_2;
            this._fontName = _loc_3.fontName;
            return;
        }// end function

        public function loadResource(param1:String, param2:Function = null) : ResourceLoader
        {
            return this.load(param1, param2, new ResourceLoaderOption());
        }// end function

        public function loadResourceUrl(param1:String, param2:Function = null) : ResourceLoader
        {
            var _loc_3:* = new ResourceLoaderOption();
            _loc_3.bUrl = true;
            _loc_3.bNotEncryption = true;
            _loc_3.bNotDecryption = true;
            return this.load(param1, param2, _loc_3);
        }// end function

        public function loadResourceMovie(param1:String) : ResourceLoader
        {
            var _loc_2:* = this.loadResource(param1, null);
            _loc_2.bMovie = true;
            return _loc_2;
        }// end function

        private function load(param1:String, param2:Function, param3:ResourceLoaderOption) : ResourceLoader
        {
            var _loc_4:* = null;
            var _loc_6:* = null;
            if (param3.bNotEncryption == false)
            {
                param3.bNotEncryption = Main.GetApplicationData().isNotResourceDifficultToRead();
            }
            _loc_4 = this._aLoader[param1];
            if (_loc_4 != null)
            {
                if (_loc_4.bLoaded)
                {
                    if (param2 != null)
                    {
                        this.param2();
                    }
                }
                else
                {
                    _loc_4.addCbComplete(param2);
                }
                return _loc_4;
            }
            _loc_4 = new ResourceLoader();
            _loc_4.load(param1, param2, param3);
            _loc_4.setLoadComleteManager(this.cbLoaderComplete);
            this._aLoader[param1] = _loc_4;
            this._aLoading.push(_loc_4);
            _loc_4.optimizeTime = this._OPTIMIZE_TIME;
            var _loc_5:* = [ResourcePath.PLAYER_PATH, ResourcePath.PLAYER_BUSTUP_PATH];
            for each (_loc_6 in _loc_5)
            {
                
                if (param1.indexOf(_loc_6) >= 0)
                {
                    _loc_4.optimizeTime = this._OPTIMIZE_TIME_CHAR;
                    break;
                }
            }
            return _loc_4;
        }// end function

        private function cbLoaderComplete(param1:ResourceLoader) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aLoading.length)
            {
                
                _loc_3 = this._aLoading[_loc_2];
                if (_loc_3 == param1)
                {
                    this._aLoading.splice(_loc_2, 1);
                    break;
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

        public function loadArray(param1:Array) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = new Array();
            for each (_loc_3 in param1)
            {
                
                _loc_2.push(this.loadResource(_loc_3));
            }
            return _loc_2;
        }// end function

        public function addLoadedXml(param1:XmlLoader) : void
        {
            this._aLoadedXml.push(param1);
            return;
        }// end function

        public function restorationXmlAll() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aLoadedXml)
            {
                
                if (_loc_1.bComplete)
                {
                    continue;
                }
                _loc_1.restoration();
            }
            this._aLoadedXml = [];
            return;
        }// end function

        public function createBitmap(param1:String) : Bitmap
        {
            var _loc_2:* = this._aLoader[param1];
            if (_loc_2 == null)
            {
                return null;
            }
            return _loc_2.createBitmap();
        }// end function

        public function createMovieClip(param1:String, param2:String) : MovieClip
        {
            var _loc_3:* = this._aLoader[param1];
            if (_loc_3 == null)
            {
                return null;
            }
            return _loc_3.createMovieClip(param2);
        }// end function

        public function createMovieClipDirect(param1:String) : MovieClip
        {
            var _loc_2:* = this._aLoader[param1];
            if (_loc_2 == null)
            {
                return null;
            }
            return _loc_2.duplicateMovieClip();
        }// end function

        public function createSwfInBitmap(param1:String, param2:String) : BitmapData
        {
            var _loc_3:* = this._aLoader[param1];
            if (_loc_3 == null)
            {
                return null;
            }
            return _loc_3.createSwfInBitmap(param2);
        }// end function

        public function createEmbedBitmap(param1:String) : Bitmap
        {
            var _loc_2:* = this[param1] as Class;
            return new _loc_2 as Bitmap;
        }// end function

        public function loadMovieData(param1:String, param2:Function) : void
        {
            var _loc_3:* = this._aLoader[param1];
            if (_loc_3 == null)
            {
                return;
            }
            _loc_3.addCbComplete(param2);
            return _loc_3.loadMovieData();
        }// end function

        public function getMovie(param1:String) : MovieClip
        {
            var _loc_2:* = this._aLoader[param1];
            if (_loc_2 == null)
            {
                return null;
            }
            return _loc_2.getMovieData();
        }// end function

        public function removeMovie(param1:String) : void
        {
            var _loc_2:* = this._aLoader[param1];
            if (_loc_2 == null)
            {
                return;
            }
            return _loc_2.removeMovie();
        }// end function

        public function removeResource(param1:String, param2:Boolean = false) : void
        {
            if (this._aLoader[param1] == null)
            {
                return;
            }
            var _loc_3:* = this._aLoader[param1];
            if (param2 == false && _loc_3.bRemoveLock)
            {
                return;
            }
            _loc_3.release();
            delete this._aLoader[param1];
            return;
        }// end function

        public function removeResourceAll(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = new Array();
            for (_loc_2 in this._aLoader)
            {
                
                _loc_3.push(_loc_2);
            }
            for each (_loc_2 in _loc_3)
            {
                
                this.removeResource(_loc_2, param1);
            }
            return;
        }// end function

        public function Optimization() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_1:* = getTimer();
            var _loc_2:* = [];
            for (_loc_3 in this._aLoader)
            {
                
                _loc_4 = this._aLoader[_loc_3];
                if (_loc_4.bRemoveLock)
                {
                    continue;
                }
                _loc_5 = _loc_1 - _loc_4.loadTimeStamp;
                if (_loc_5 >= _loc_4.optimizeTime)
                {
                    _loc_2.push(_loc_3);
                }
            }
            for each (_loc_3 in _loc_2)
            {
                
                this.removeResource(_loc_3);
            }
            return;
        }// end function

        public static function getInstance() : ResourceManager
        {
            if (_instance == null)
            {
                _instance = new ResourceManager;
            }
            return _instance;
        }// end function

    }
}
