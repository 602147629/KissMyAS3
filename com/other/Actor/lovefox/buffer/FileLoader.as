package lovefox.buffer
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class FileLoader extends EventDispatcher
    {
        private var _totalNumber:uint = 0;
        private var _loadedNumber:uint = 0;
        private var _urlArray:Array;
        private var _dynamicData:Object;
        private static var _objectPool:Array = [];
        private static var _buff:Object = {};
        private static var _loadingBuff:Object = {};
        private static var _urlloaderDict:Dictionary = new Dictionary();
        private static var _loaderDict:Dictionary = new Dictionary();
        private static var _loadCheckDict:Dictionary = new Dictionary(true);
        private static var _loadCompleteBuff:Object = {};
        private static var _subLoadStack:Object = [];
        private static var _loadingCount:Object = 0;
        private static var _ranCount:Object = {};
        private static var _freeLoaderStack:Object = [];

        public function FileLoader()
        {
            this._dynamicData = {};
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            this._dynamicData = param1;
            return;
        }// end function

        public function get data() : Object
        {
            return this._dynamicData;
        }// end function

        public function load(param1:Array)
        {
            var _loc_2:* = undefined;
            if (param1.length == 0)
            {
                dispatchEvent(new Event("complete"));
                return;
            }
            this._urlArray = param1;
            this._loadedNumber = 0;
            this._totalNumber = param1.length;
            _loc_2 = 0;
            while (_loc_2 < this._totalNumber)
            {
                
                loadPic(param1[_loc_2].toLowerCase(), this.onComplete);
                _loc_2 = _loc_2 + 1;
            }
            var _loc_4:* = loadingCount + 1;
            loadingCount = _loc_4;
            return;
        }// end function

        private function onComplete(param1 = null)
        {
            var _loc_2:* = this;
            var _loc_3:* = this._loadedNumber + 1;
            _loc_2._loadedNumber = _loc_3;
            dispatchEvent(new ProgressEvent("progress", false, false, this._loadedNumber, this._totalNumber));
            if (this._loadedNumber == this._totalNumber)
            {
                var _loc_3:* = loadingCount - 1;
                loadingCount = _loc_3;
                dispatchEvent(new Event("complete"));
            }
            return true;
        }// end function

        public static function newFileLoader()
        {
            return new BitmapLoader();
        }// end function

        private static function getFreeLoader()
        {
            return new Loader();
        }// end function

        private static function get loadingCount()
        {
            return _loadingCount;
        }// end function

        private static function set loadingCount(param1)
        {
            _loadingCount = param1;
            if (_loadingCount == 0)
            {
                startSubLoad();
            }
            return;
        }// end function

        public static function subLoad(param1:Array)
        {
            _subLoadStack = param1;
            startSubLoad();
            return;
        }// end function

        private static function startSubLoad()
        {
            if (_subLoadStack.length > 0)
            {
                loadPic(_subLoadStack[0].toLowerCase(), handleSubLoadComplete);
            }
            return;
        }// end function

        private static function handleSubLoadComplete(param1 = null)
        {
            _subLoadStack.shift();
            if (loadingCount <= 0)
            {
                startSubLoad();
            }
            return;
        }// end function

        public static function pick(param1)
        {
            if (_buff[param1.toLowerCase()] == null)
            {
                return null;
            }
            return _buff[param1.toLowerCase()];
        }// end function

        private static function loadPic(param1, param2 = null, param3:Boolean = false)
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (_buff[param1] == null)
            {
                if (_loadingBuff[param1] == null)
                {
                    _loc_4 = new URLStream();
                    _loc_4.endian = Endian.LITTLE_ENDIAN;
                    _loadingBuff[param1] = _loc_4;
                    _urlloaderDict[_loc_4] = param1;
                    configureListeners(_loc_4);
                    if (param3)
                    {
                        if (_ranCount[param1] == null)
                        {
                            _ranCount[param1] = 0;
                        }
                        else
                        {
                            var _loc_6:* = _ranCount;
                            var _loc_7:* = param1;
                            var _loc_8:* = _ranCount[param1] + 1;
                            _loc_6[_loc_7] = _loc_8;
                        }
                        if (_ranCount[param1] > 10)
                        {
                            return;
                        }
                        _loc_5 = new URLRequest(Config.sourceURL + param1 + "?ran=" + _ranCount[param1]);
                    }
                    else if (Config.verObj[param1] == null)
                    {
                        _loc_5 = new URLRequest(Config.sourceURL + param1 + "?ver=" + Config.ver);
                    }
                    else
                    {
                        _loc_5 = new URLRequest(Config.sourceURL + param1 + "?ver=" + Config.verObj[param1]);
                    }
                    _loc_4.load(_loc_5);
                }
                if (_loadCompleteBuff[param1] == null)
                {
                    _loadCompleteBuff[param1] = [];
                }
                if (param2 != null)
                {
                    _loadCompleteBuff[param1].push(param2);
                }
            }
            else
            {
                FileLoader.param2(param1);
            }
            return;
        }// end function

        private static function loadCheck(param1, param2)
        {
            var url:* = param1;
            var loader:* = param2;
            trace("fileloadCheck", url, loader, String(url) == "");
            loader.removeEventListener(Event.COMPLETE, completeHandler);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            try
            {
                loader.close();
            }
            catch (e)
            {
            }
            clearTimeout(_loadCheckDict[url]);
            delete _loadCheckDict[url];
            delete _loadingBuff[url];
            delete _urlloaderDict[loader];
            delete _buff[url];
            loadPic(url, null, true);
            return;
        }// end function

        private static function configureListeners(param1:IEventDispatcher) : void
        {
            param1.addEventListener(Event.COMPLETE, completeHandler);
            param1.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            return;
        }// end function

        private static function completeHandler(event:Event) : void
        {
            var url:*;
            var i:*;
            var obj:*;
            var event:* = event;
            event.target.removeEventListener(Event.COMPLETE, completeHandler);
            event.target.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            url = _urlloaderDict[event.target];
            clearTimeout(_loadCheckDict[url]);
            delete _loadCheckDict[url];
            delete _loadingBuff[url];
            var bytesArray:* = new ByteArray();
            event.target.readBytes(bytesArray, 0, event.target.bytesAvailable);
            try
            {
                obj = bytesArray.readObject();
            }
            catch (e)
            {
                _loadCheckDict[url] = setTimeout(loadCheck, 10000, url, event.target);
                return;
            }
            bytesArray.clear();
            _buff[url] = obj;
            while (_loadCompleteBuff[url].length > 0)
            {
                
                if (!FileLoader._loadCompleteBuff[url].shift()(url))
                {
                    return;
                }
            }
            delete _loadCompleteBuff[url];
            event.target.close();
            return;
        }// end function

        private static function ioErrorHandler(event:IOErrorEvent) : void
        {
            event.target.removeEventListener(Event.COMPLETE, completeHandler);
            event.target.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            event.target.close();
            var _loc_2:* = _urlloaderDict[event.target];
            clearTimeout(_loadCheckDict[_loc_2]);
            delete _loadCheckDict[_loc_2];
            delete _loadingBuff[_loc_2];
            trace("ioErrorHandler," + _loc_2);
            _loadCheckDict[_loc_2] = setTimeout(loadCheck, 10000, _loc_2, event.target);
            return;
        }// end function

        private static function initHandler(event:Event) : void
        {
            var _loc_2:* = _urlloaderDict[event.target];
            return;
        }// end function

    }
}
