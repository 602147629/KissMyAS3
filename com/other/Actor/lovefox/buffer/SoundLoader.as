package lovefox.buffer
{
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.utils.*;

    public class SoundLoader extends EventDispatcher
    {
        private var _totalNumber:uint = 0;
        private var _loadedNumber:uint = 0;
        private var _bytesTotal:uint = 0;
        private var _bytesLoaded:uint = 0;
        public var _urlArray:Array;
        private static var _urlloaderDict:Dictionary;
        private static var _buff:Object = {};
        private static var _loadingBuff:Object = {};
        private static var _loadCompleteBuff:Object = {};
        private static var _subLoadStack:Object = [];
        private static var _loadingCount:Object = 0;

        public function SoundLoader()
        {
            return;
        }// end function

        public function load(param1:Array)
        {
            var _loc_2:* = null;
            if (param1.length == 0)
            {
                dispatchEvent(new Event("complete"));
                return;
            }
            this._urlArray = param1;
            this._loadedNumber = 0;
            this._totalNumber = param1.length;
            var _loc_3:* = 0;
            while (_loc_3 < this._totalNumber)
            {
                
                loadSound(param1[_loc_3].toLowerCase(), this.onComplete);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_5:* = loadingCount + 1;
            loadingCount = _loc_5;
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
            return;
        }// end function

        private function httpStatusHandler(event:HTTPStatusEvent) : void
        {
            return;
        }// end function

        private function initHandler(event:Event) : void
        {
            return;
        }// end function

        private function openHandler(event:Event) : void
        {
            return;
        }// end function

        private function progressHandler(event:ProgressEvent) : void
        {
            return;
        }// end function

        private function unLoadHandler(event:Event) : void
        {
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
                loadSound(_subLoadStack[0].toLowerCase(), handleSubLoadComplete);
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

        private static function loadSound(param1, param2 = null)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (_buff[param1] == null)
            {
                if (_loadingBuff[param1] == null)
                {
                    _loc_3 = new Sound();
                    _loadingBuff[param1] = _loc_3;
                    if (_urlloaderDict == null)
                    {
                        _urlloaderDict = new Dictionary();
                    }
                    _urlloaderDict[_loc_3] = param1;
                    configureListeners(_loc_3);
                    _loc_4 = new URLRequest(Config.sourceURL + param1);
                    _loc_3.load(_loc_4);
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
                SoundLoader.param2(param1);
            }
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
            _buff[_loc_2] = event.target;
            delete _loadingBuff[_loc_2];
            _loc_3 = 0;
            while (_loc_3 < _loadCompleteBuff[_loc_2].length)
            {
                
                var _loc_4:* = _loadCompleteBuff[_loc_2];
                _loc_4._loadCompleteBuff[_loc_2][_loc_3](_loc_2);
                _loc_3 = _loc_3 + 1;
            }
            delete _loadCompleteBuff[_loc_2];
            return;
        }// end function

        private static function ioErrorHandler(event:IOErrorEvent) : void
        {
            var _loc_2:* = _urlloaderDict[event.target];
            delete _loadingBuff[_loc_2];
            trace("ioErrorHandler," + _loc_2);
            loadSound(_loc_2);
            return;
        }// end function

    }
}
