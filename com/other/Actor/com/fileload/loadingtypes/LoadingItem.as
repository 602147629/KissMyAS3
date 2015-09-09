package com.fileload.loadingtypes
{
    import flash.events.*;
    import flash.net.*;

    public class LoadingItem extends EventDispatcher
    {
        public var _type:String;
        public var url:URLRequest;
        public var _id:String;
        public var _uid:String;
        public var _additionIndex:int;
        public var _priority:int = 0;
        public var _isLoaded:Boolean;
        public var _isLoading:Boolean;
        public var status:String;
        public var maxTries:int = 3;
        public var numTries:int = 0;
        public var weight:int = 1;
        public var preventCache:Boolean;
        public var _bytesTotal:int = -1;
        public var _bytesLoaded:int = 0;
        public var _bytesRemaining:int = 10000000;
        public var _percentLoaded:Number;
        public var _weightPercentLoaded:Number;
        public var _addedTime:int;
        public var _startTime:int;
        public var _responseTime:Number;
        public var _latency:Number;
        public var _totalTime:int;
        public var _timeToDownload:int;
        public var _speed:Number;
        public var _content:Object;
        public var _httpStatus:int = -1;
        public var _context:Object = null;
        public var specificAvailableProps:Array;
        public var propertyParsingErrors:Array;
        public var errorEvent:ErrorEvent;
        public static const STATUS_STOPPED:String = "stopped";
        public static const STATUS_STARTED:String = "started";
        public static const STATUS_FINISHED:String = "finished";
        public static const STATUS_ERROR:String = "error";

        public function LoadingItem(param1:URLRequest, param2:String, param3:String)
        {
            this._type = param2;
            this.url = param1;
            if (!this.specificAvailableProps)
            {
                this.specificAvailableProps = [];
            }
            this._uid = param3;
            return;
        }// end function

        public function _parseOptions(param1:Object) : Array
        {
            var _loc_3:* = null;
            this.preventCache = param1[BulkLoader.PREVENT_CACHING];
            this._id = param1[BulkLoader.ID];
            this._priority = int(param1[BulkLoader.PRIORITY]) || 0;
            this.maxTries = param1[BulkLoader.MAX_TRIES] || 3;
            this.weight = int(param1[BulkLoader.WEIGHT]) || 1;
            var _loc_2:* = BulkLoader.GENERAL_AVAILABLE_PROPS.concat(this.specificAvailableProps);
            this.propertyParsingErrors = [];
            for (_loc_3 in param1)
            {
                
                if (_loc_2.indexOf(_loc_3) == -1)
                {
                    this.propertyParsingErrors.push(this + ": got a wrong property name: " + _loc_3 + ", with value:" + param1[_loc_3]);
                }
            }
            return this.propertyParsingErrors;
        }// end function

        public function get content()
        {
            return this._content;
        }// end function

        public function load() : void
        {
            var _loc_1:* = null;
            if (this.preventCache)
            {
                _loc_1 = "BulkLoaderNoCache=" + this._uid + "_" + int(Math.random() * 100 * getTimer());
                if (this.url.url.indexOf("?") == -1)
                {
                    this.url.url = this.url.url + ("?" + _loc_1);
                }
                else
                {
                    this.url.url = this.url.url + ("&" + _loc_1);
                }
            }
            this._isLoading = true;
            this._startTime = getTimer();
            return;
        }// end function

        public function onHttpStatusHandler(event:HTTPStatusEvent) : void
        {
            this._httpStatus = event.status;
            dispatchEvent(event);
            return;
        }// end function

        public function onProgressHandler(param1) : void
        {
            this._bytesLoaded = param1.bytesLoaded;
            this._bytesTotal = param1.bytesTotal;
            this._bytesRemaining = this._bytesTotal - this.bytesLoaded;
            this._percentLoaded = this._bytesLoaded / this._bytesTotal;
            this._weightPercentLoaded = this._percentLoaded * this.weight;
            dispatchEvent(param1);
            return;
        }// end function

        public function onCompleteHandler(event:Event) : void
        {
            this._totalTime = getTimer();
            this._timeToDownload = (this._totalTime - this._responseTime) / 1000;
            if (this._timeToDownload == 0)
            {
                this._timeToDownload = 0.2;
            }
            this._speed = BulkLoader.truncateNumber(this.bytesTotal / 1024 / this._timeToDownload);
            if (this._timeToDownload == 0)
            {
                this._speed = 3000;
            }
            this.status = STATUS_FINISHED;
            this._isLoaded = true;
            dispatchEvent(event);
            event.stopPropagation();
            return;
        }// end function

        public function onErrorHandler(event:ErrorEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this.numTries + 1;
            _loc_2.numTries = _loc_3;
            event.stopPropagation();
            if (this.numTries < this.maxTries)
            {
                this.status = null;
                this.load();
            }
            else
            {
                this.status = STATUS_ERROR;
                this.errorEvent = event;
                this._dispatchErrorEvent(this.errorEvent);
            }
            return;
        }// end function

        public function _dispatchErrorEvent(event:ErrorEvent) : void
        {
            this.status = STATUS_ERROR;
            dispatchEvent(new ErrorEvent(BulkLoader.ERROR, true, false, event.text));
            return;
        }// end function

        public function _createErrorEvent(param1:Error) : ErrorEvent
        {
            return new ErrorEvent(BulkLoader.ERROR, false, false, param1.message);
        }// end function

        public function onSecurityErrorHandler(event:ErrorEvent) : void
        {
            this.status = STATUS_ERROR;
            this.errorEvent = event as ErrorEvent;
            event.stopPropagation();
            this._dispatchErrorEvent(this.errorEvent);
            return;
        }// end function

        public function onStartedHandler(event:Event) : void
        {
            this._responseTime = getTimer();
            this._latency = BulkLoader.truncateNumber((this._responseTime - this._startTime) / 1000);
            this.status = STATUS_STARTED;
            dispatchEvent(event);
            return;
        }// end function

        override public function toString() : String
        {
            return "LoadingItem url: " + this.url.url + ", type:" + this._type + ", status: " + this.status;
        }// end function

        public function stop() : void
        {
            if (this._isLoaded)
            {
                return;
            }
            this.status = STATUS_STOPPED;
            this._isLoading = false;
            return;
        }// end function

        public function cleanListeners() : void
        {
            return;
        }// end function

        public function isVideo() : Boolean
        {
            return false;
        }// end function

        public function isSound() : Boolean
        {
            return false;
        }// end function

        public function isText() : Boolean
        {
            return false;
        }// end function

        public function isXML() : Boolean
        {
            return false;
        }// end function

        public function isImage() : Boolean
        {
            return false;
        }// end function

        public function isSWF() : Boolean
        {
            return false;
        }// end function

        public function isLoader() : Boolean
        {
            return false;
        }// end function

        public function isStreamable() : Boolean
        {
            return false;
        }// end function

        public function destroy() : void
        {
            this._content = null;
            return;
        }// end function

        public function get bytesTotal() : int
        {
            return this._bytesTotal;
        }// end function

        public function get bytesLoaded() : int
        {
            return this._bytesLoaded;
        }// end function

        public function get bytesRemaining() : int
        {
            return this._bytesRemaining;
        }// end function

        public function get percentLoaded() : Number
        {
            return this._percentLoaded;
        }// end function

        public function get weightPercentLoaded() : Number
        {
            return this._weightPercentLoaded;
        }// end function

        public function get priority() : int
        {
            return this._priority;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function get isLoaded() : Boolean
        {
            return this._isLoaded;
        }// end function

        public function get addedTime() : int
        {
            return this._addedTime;
        }// end function

        public function get startTime() : int
        {
            return this._startTime;
        }// end function

        public function get responseTime() : Number
        {
            return this._responseTime;
        }// end function

        public function get latency() : Number
        {
            return this._latency;
        }// end function

        public function get totalTime() : int
        {
            return this._totalTime;
        }// end function

        public function get timeToDownload() : int
        {
            return this._timeToDownload;
        }// end function

        public function get speed() : Number
        {
            return this._speed;
        }// end function

        public function get httpStatus() : int
        {
            return this._httpStatus;
        }// end function

        public function get id() : String
        {
            return this._id;
        }// end function

        public function getStats() : String
        {
            return "Item url:" + this.url.url + ", total time: " + this._timeToDownload + "(s), latency:" + this._latency + "(s), speed: " + this._speed + " kb/s, size: " + BulkLoader.truncateNumber(this._bytesTotal / 1024) + " kb";
        }// end function

    }
}
