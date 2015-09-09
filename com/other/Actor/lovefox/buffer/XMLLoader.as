package lovefox.buffer
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class XMLLoader extends EventDispatcher
    {
        public var _dataArray:Array;
        private var _urlArray:Array;
        private var _loaderArray:Array;
        private var _totalNumber:uint = 0;
        private var _loadedNumber:uint = 0;
        private var _bytesTotal:uint = 0;
        private var _bytesLoaded:uint = 0;
        private static var _loadCheckDict:Dictionary = new Dictionary(true);
        private static var _buff:Object = {};
        private static var _ranCount:Object = {};

        public function XMLLoader()
        {
            return;
        }// end function

        public function load(param1:Array)
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            if (param1.length == 0)
            {
                dispatchEvent(new Event("complete"));
                return;
            }
            this._urlArray = param1;
            this._loadedNumber = 0;
            this._totalNumber = param1.length;
            this._loaderArray = new Array(this._totalNumber);
            this._dataArray = new Array(this._totalNumber);
            var _loc_3:* = 0;
            while (_loc_3 < this._totalNumber)
            {
                
                if (_buff[param1[_loc_3]] == null)
                {
                    var _loc_5:* = new URLLoader();
                    this._loaderArray[_loc_3] = new URLLoader();
                    _loc_2 = _loc_5;
                    this.configureListeners(_loc_2);
                    _loc_4 = new URLRequest(Config.sourceURL + param1[_loc_3]);
                    _loc_2.load(_loc_4);
                }
                else
                {
                    this._dataArray[_loc_3] = _buff[param1[_loc_3]];
                    var _loc_5:* = this;
                    var _loc_6:* = this._loadedNumber + 1;
                    _loc_5._loadedNumber = _loc_6;
                    dispatchEvent(new ProgressEvent("progress", false, false, this._loadedNumber, this._totalNumber));
                    if (this._loadedNumber == this._totalNumber)
                    {
                        dispatchEvent(new Event("complete"));
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        private function getLoaderIndex(param1) : Number
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._totalNumber)
            {
                
                if (this._loaderArray[_loc_2] == param1)
                {
                    return _loc_2;
                }
                _loc_2 = _loc_2 + 1;
            }
            return -1;
        }// end function

        private function configureListeners(param1:IEventDispatcher) : void
        {
            param1.addEventListener(Event.COMPLETE, this.completeHandler);
            param1.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
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

        private function securityErrorHandler(event:SecurityErrorEvent) : void
        {
            return;
        }// end function

        private function httpStatusHandler(event:HTTPStatusEvent) : void
        {
            return;
        }// end function

        private function completeHandler(event:Event) : void
        {
            event.target.removeEventListener(Event.COMPLETE, this.completeHandler);
            event.target.removeEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            var _loc_4:* = this;
            var _loc_5:* = this._loadedNumber + 1;
            _loc_4._loadedNumber = _loc_5;
            var _loc_2:* = this.getLoaderIndex(event.target);
            var _loc_3:* = this._urlArray[_loc_2];
            _buff[_loc_3] = new XML(event.target.data);
            clearTimeout(_loadCheckDict[_loc_3]);
            delete _loadCheckDict[_loc_3];
            delete event.target.data;
            this._dataArray[_loc_2] = _buff[this._urlArray[_loc_2]];
            dispatchEvent(new ProgressEvent("progress", false, false, this._loadedNumber, this._totalNumber));
            if (this._loadedNumber == this._totalNumber)
            {
                dispatchEvent(new Event("complete"));
            }
            return;
        }// end function

        private function ioErrorHandler(event:IOErrorEvent) : void
        {
            var _loc_2:* = this.getLoaderIndex(event.target);
            var _loc_3:* = this._urlArray[_loc_2];
            clearTimeout(_loadCheckDict[_loc_3]);
            delete _loadCheckDict[_loc_3];
            _loadCheckDict[_loc_3] = setTimeout(loadCheck, 5000, _loc_3, event.target);
            return;
        }// end function

        public static function push(param1, param2)
        {
            _buff[param1] = param2;
            return;
        }// end function

        public static function pick(param1)
        {
            return _buff[param1];
        }// end function

        private static function loadCheck(param1, param2)
        {
            trace("fileloadCheck", param1, param2, String(param1) == "");
            clearTimeout(_loadCheckDict[param1]);
            delete _loadCheckDict[param1];
            if (_ranCount[param1] == null)
            {
                _ranCount[param1] = 0;
            }
            else
            {
                var _loc_4:* = _ranCount;
                var _loc_5:* = param1;
                var _loc_6:* = _ranCount[param1] + 1;
                _loc_4[_loc_5] = _loc_6;
            }
            if (_ranCount[param1] > 10)
            {
                return;
            }
            var _loc_3:* = new URLRequest(Config.sourceURL + param1 + "?ran=" + _ranCount[param1]);
            param2.load(_loc_3);
            return;
        }// end function

    }
}
