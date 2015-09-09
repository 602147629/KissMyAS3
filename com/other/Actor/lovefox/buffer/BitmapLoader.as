package lovefox.buffer
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class BitmapLoader extends EventDispatcher
    {
        private var _totalNumber:uint = 0;
        private var _loadedNumber:uint = 0;
        public var _urlArray:Array;
        private var _dynamicData:Object;
        private static var _objectPool:Array = [];
        private static var _buff:Object = {};
        private static var _picBuff:Object = {};
        private static var _loadingBuff:Object = {};
        private static var _urlloaderDict:Dictionary = new Dictionary();
        private static var _loaderDict:Dictionary = new Dictionary();
        private static var _loadCheckDict:Dictionary = new Dictionary(true);
        private static var _loadWaitingArray:Array = [];
        private static var _loadWaitingCount:Number = 0;
        private static var _loadCompleteBuff:Object = {};
        private static var _subLoadStack:Object = [];
        private static var _loadingCount:Number = 0;
        private static var _makingObj:Object = {};
        private static var _ranCount:Object = {};

        public function BitmapLoader()
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
            var _loc_2:* = null;
            if (_picBuff[param1] == null)
            {
                if (_buff[param1] == null || _buff[param1].length == 0)
                {
                    delete _buff[param1];
                    delete _loadingBuff[param1];
                    loadPic(param1, this.onComplete);
                    return false;
                }
                if (_makingObj[param1] == null)
                {
                    _makingObj[param1] = 0;
                }
                var _loc_3:* = _makingObj;
                var _loc_4:* = param1;
                var _loc_5:* = _makingObj[param1] + 1;
                _loc_3[_loc_4] = _loc_5;
                _loc_2 = getFreeLoader();
                _loaderDict[_loc_2.contentLoaderInfo] = param1;
                _loc_2.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.handleMakePicComplete);
                _loc_2.contentLoaderInfo.addEventListener(Event.COMPLETE, this.handleMakePicComplete);
                _loc_2.loadBytes(_buff[param1]);
            }
            else
            {
                var _loc_3:* = this;
                var _loc_4:* = this._loadedNumber + 1;
                _loc_3._loadedNumber = _loc_4;
                dispatchEvent(new ProgressEvent("progress", false, false, this._loadedNumber, this._totalNumber));
                if (this._loadedNumber == this._totalNumber)
                {
                    var _loc_4:* = loadingCount - 1;
                    loadingCount = _loc_4;
                    dispatchEvent(new Event("complete"));
                }
            }
            return true;
        }// end function

        private function handleMakePicComplete(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = _loaderDict[param1.target];
            _picBuff[_loc_2] = param1.target.loader.content.bitmapData;
            var _loc_4:* = this;
            var _loc_5:* = this._loadedNumber + 1;
            _loc_4._loadedNumber = _loc_5;
            dispatchEvent(new ProgressEvent("progress", false, false, this._loadedNumber, this._totalNumber));
            if (this._loadedNumber == this._totalNumber)
            {
                var _loc_5:* = loadingCount - 1;
                loadingCount = _loc_5;
                dispatchEvent(new Event("complete"));
            }
            var _loc_4:* = _makingObj;
            var _loc_5:* = _loc_2;
            var _loc_6:* = _makingObj[_loc_2] - 1;
            _loc_4[_loc_5] = _loc_6;
            if (_makingObj[_loc_2] <= 0)
            {
                delete _makingObj[_loc_2];
            }
            param1.target.removeEventListener(Event.COMPLETE, this.handleMakePicComplete);
            param1.target.loader.unload();
            delete _loaderDict[param1.target];
            return;
        }// end function

        public function close()
        {
            return;
        }// end function

        public static function newBitmapLoader()
        {
            return new BitmapLoader;
        }// end function

        private static function getFreeLoader()
        {
            return new Loader();
        }// end function

        public static function clearBuff(param1 = false)
        {
            var _loc_2:* = undefined;
            trace("clearBuff");
            for (_loc_2 in _picBuff)
            {
                
                if (_picBuff[_loc_2] != null)
                {
                    if (param1)
                    {
                        if (_loadingBuff[_loc_2] == null && _loadCompleteBuff[_loc_2] == null && _makingObj[_loc_2] == null)
                        {
                            _picBuff[_loc_2].dispose();
                            delete _picBuff[_loc_2];
                        }
                        continue;
                    }
                    _picBuff[_loc_2].dispose();
                    delete _picBuff[_loc_2];
                }
            }
            _picBuff = {};
            for (_loc_2 in _makingObj)
            {
                
                delete _makingObj[_loc_2];
            }
            _makingObj = {};
            return;
        }// end function

        public static function clearBuffOne(param1)
        {
            trace("clearBuffOne");
            if (_picBuff[param1.toLowerCase()] != null)
            {
                if (_loadingBuff[param1.toLowerCase()] == null && _loadCompleteBuff[param1.toLowerCase()] == null)
                {
                    _picBuff[param1.toLowerCase()].dispose();
                    delete _picBuff[param1.toLowerCase()];
                }
            }
            return;
        }// end function

        public static function clearBuffArr(param1)
        {
            var _loc_2:* = undefined;
            trace("clearBuffArr");
            for (_loc_2 in param1)
            {
                
                if (_picBuff[param1[_loc_2].toLowerCase()] != null)
                {
                    if (_loadingBuff[param1[_loc_2].toLowerCase()] == null && _loadCompleteBuff[param1[_loc_2].toLowerCase()] == null && _makingObj[param1[_loc_2].toLowerCase()] == null)
                    {
                        _picBuff[param1[_loc_2].toLowerCase()].dispose();
                        delete _picBuff[param1[_loc_2].toLowerCase()];
                    }
                }
            }
            return;
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
            if (_picBuff[param1.toLowerCase()] == null)
            {
                return null;
            }
            return _picBuff[param1.toLowerCase()].clone();
        }// end function

        public static function dispose(param1)
        {
            if (_loadingBuff[param1.toLowerCase()] == null && _loadCompleteBuff[param1.toLowerCase()] == null && _makingObj[param1.toLowerCase()] == null)
            {
                if (_picBuff[param1.toLowerCase()] != null)
                {
                    _picBuff[param1.toLowerCase()].dispose();
                    delete _picBuff[param1.toLowerCase()];
                }
            }
            return;
        }// end function

        public static function setByteArray(param1)
        {
            var _loc_2:* = undefined;
            for (_loc_2 in param1)
            {
                
                _buff[_loc_2.toLowerCase()] = param1[_loc_2];
            }
            return;
        }// end function

        public static function setPicBuff(param1)
        {
            var _loc_2:* = undefined;
            for (_loc_2 in param1)
            {
                
                _picBuff[_loc_2.toLowerCase()] = param1[_loc_2];
            }
            return;
        }// end function

        private static function loadPic(param1, param2 = null, param3:Boolean = false)
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (String(param1) == "")
            {
                Config.error();
            }
            if (_buff[param1] == null && _picBuff[param1] == null)
            {
                if (_loadingBuff[param1] == null)
                {
                    if (_loadWaitingCount < 10)
                    {
                        _loc_4 = new URLLoader();
                        _loc_4.dataFormat = URLLoaderDataFormat.BINARY;
                        _loadingBuff[param1] = _loc_4;
                        _urlloaderDict[_loc_4] = param1;
                        clearTimeout(_loadCheckDict[param1]);
                        _loadCheckDict[param1] = setTimeout(loadCheck, 15000, param1, _loc_4);
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
                        var _loc_7:* = _loadWaitingCount + 1;
                        _loadWaitingCount = _loc_7;
                    }
                    else
                    {
                        _loadWaitingArray.push(param1);
                    }
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
                if (_loadWaitingArray.length > 0)
                {
                    loadPic(_loadWaitingArray.shift(), null);
                }
                if (param2 != null)
                {
                    BitmapLoader.param2(param1);
                }
            }
            return;
        }// end function

        private static function loadCheck(param1, param2)
        {
            var url:* = param1;
            var loader:* = param2;
            trace("loadCheck", url, loader, String(url) == "");
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
            delete _picBuff[url];
            var _loc_5:* = _loadWaitingCount - 1;
            _loadWaitingCount = _loc_5;
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
            var _loc_3:* = undefined;
            event.target.removeEventListener(Event.COMPLETE, completeHandler);
            event.target.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            var _loc_2:* = _urlloaderDict[event.target];
            _buff[_loc_2] = event.target.data;
            clearTimeout(_loadCheckDict[_loc_2]);
            delete _loadCheckDict[_loc_2];
            delete _loadingBuff[_loc_2];
            var _loc_5:* = _loadWaitingCount - 1;
            _loadWaitingCount = _loc_5;
            while (_loadCompleteBuff[_loc_2].length > 0)
            {
                
                if (!BitmapLoader._loadCompleteBuff[_loc_2].shift()(_loc_2))
                {
                    return;
                }
            }
            delete _loadCompleteBuff[_loc_2];
            if (_loadWaitingArray.length > 0)
            {
                loadPic(_loadWaitingArray.shift());
            }
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
            var _loc_4:* = _loadWaitingCount - 1;
            _loadWaitingCount = _loc_4;
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
