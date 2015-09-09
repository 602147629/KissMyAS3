package com.fileload
{
    import com.fileload.loadingtypes.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.utils.*;

    public class BulkLoader extends EventDispatcher
    {
        public var _name:String;
        public var _id:int;
        public var _items:Array;
        public var _contents:Dictionary;
        public var _additionIndex:int = 0;
        public var _numConnections:int = 7;
        public var _connections:Array;
        public var _loadedRatio:Number = 0;
        public var _itemsTotal:int = 0;
        public var _itemsLoaded:int = 0;
        public var _totalWeight:int = 0;
        public var _bytesTotal:int = 0;
        public var _bytesTotalCurrent:int = 0;
        public var _bytesLoaded:int = 0;
        public var _percentLoaded:Number = 0;
        public var _weightPercent:Number;
        public var avgLatency:Number;
        public var speedAvg:Number;
        public var _speedTotal:Number;
        public var _startTime:int;
        public var _endTIme:int;
        public var _lastSpeedCheck:int;
        public var _lastBytesCheck:int;
        public var _speed:Number;
        public var totalTime:Number;
        public var logLevel:int = 4;
        public var _allowsAutoIDFromFileName:Boolean = false;
        public var _isRunning:Boolean;
        public var _isFinished:Boolean;
        public var _isPaused:Boolean = true;
        public var _logFunction:Function;
        public var _stringSubstitutions:Object;
        public static const VERSION:String = "$Id$";
        public static const TYPE_BINARY:String = "binary";
        public static const TYPE_IMAGE:String = "image";
        public static const TYPE_MOVIECLIP:String = "movieclip";
        public static const TYPE_SOUND:String = "sound";
        public static const TYPE_TEXT:String = "text";
        public static const TYPE_XML:String = "xml";
        public static const TYPE_VIDEO:String = "video";
        public static const AVAILABLE_TYPES:Array = [TYPE_VIDEO, TYPE_XML, TYPE_TEXT, TYPE_SOUND, TYPE_MOVIECLIP, TYPE_IMAGE, TYPE_BINARY];
        public static var AVAILABLE_EXTENSIONS:Array = ["swf", "jpg", "jpeg", "gif", "png", "flv", "mp3", "xml", "txt", "js"];
        public static var IMAGE_EXTENSIONS:Array = ["jpg", "jpeg", "gif", "png"];
        public static var MOVIECLIP_EXTENSIONS:Array = ["swf"];
        public static var TEXT_EXTENSIONS:Array = ["txt", "js", "php", "asp", "py"];
        public static var VIDEO_EXTENSIONS:Array = ["flv", "f4v", "f4p", "mp4"];
        public static var SOUND_EXTENSIONS:Array = ["mp3", "f4a", "f4b"];
        public static var XML_EXTENSIONS:Array = ["xml"];
        public static var _customTypesExtensions:Object;
        public static const PROGRESS:String = "progress";
        public static const COMPLETE:String = "complete";
        public static const HTTP_STATUS:String = "httpStatus";
        public static const ERROR:String = "error";
        public static const SECURITY_ERROR:String = "securityError";
        public static const OPEN:String = "open";
        public static const CAN_BEGIN_PLAYING:String = "canBeginPlaying";
        public static const CHECK_POLICY_FILE:String = "checkPolicyFile";
        public static const PREVENT_CACHING:String = "preventCache";
        public static const HEADERS:String = "headers";
        public static const CONTEXT:String = "context";
        public static const ID:String = "id";
        public static const PRIORITY:String = "priority";
        public static const MAX_TRIES:String = "maxTries";
        public static const WEIGHT:String = "weight";
        public static const PAUSED_AT_START:String = "pausedAtStart";
        public static const GENERAL_AVAILABLE_PROPS:Array = [WEIGHT, MAX_TRIES, HEADERS, ID, PRIORITY, PREVENT_CACHING, "type"];
        public static var _instancesCreated:int = 0;
        public static var _allLoaders:Object = {};
        public static const DEFAULT_NUM_CONNECTIONS:int = 7;
        public static const LOG_VERBOSE:int = 0;
        public static const LOG_INFO:int = 2;
        public static const LOG_WARNINGS:int = 3;
        public static const LOG_ERRORS:int = 4;
        public static const LOG_SILENT:int = 10;
        public static const DEFAULT_LOG_LEVEL:int = 4;
        public static var _typeClasses:Object = {image:ImageItem, movieclip:ImageItem, xml:XMLItem, video:VideoItem, sound:SoundItem, text:URLItem, binary:BinaryItem};

        public function BulkLoader(param1:String, param2:int = 7, param3:int = 4)
        {
            var name:* = param1;
            var numConnections:* = param2;
            var logLevel:* = param3;
            this._items = [];
            this._contents = new Dictionary(true);
            this._logFunction = function (param1)
            {
                return;
            }// end function
            ;
            if (Boolean(_allLoaders[name]))
            {
                __debug_print_loaders();
                throw new Error("BulkLoader with name\'" + name + "\' has already been created.");
            }
            if (!name)
            {
                throw new Error("Cannot create a BulkLoader instance without a name");
            }
            _allLoaders[name] = this;
            if (numConnections > 0)
            {
                this._numConnections = numConnections;
            }
            this.logLevel = logLevel;
            this._name = name;
            var _loc_6:* = _instancesCreated + 1;
            _instancesCreated = _loc_6;
            this._id = _instancesCreated;
            this._additionIndex = 0;
            addEventListener(BulkLoader.ERROR, function (event:Event) : void
            {
                return;
            }// end function
            , false, 1, true);
            return;
        }// end function

        public function hasItem(param1, param2:Boolean = true) : Boolean
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            if (param2)
            {
                _loc_3 = _allLoaders;
            }
            else
            {
                _loc_3 = [this];
            }
            for each (_loc_4 in _loc_3)
            {
                
                if (_hasItemInBulkLoader(param1, _loc_4))
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function add(param1, param2:Object = null) : LoadingItem
        {
            var _loc_4:* = null;
            var _loc_6:* = null;
            if (!this._name)
            {
                throw new Error("[BulkLoader] Cannot use an instance that has been cleared from memory (.clear())");
            }
            if (!param1 || !String(param1))
            {
                throw new Error("[BulkLoader] Cannot add an item with a null url");
            }
            param2 = param2 || {};
            if (param1 is String)
            {
                param1 = new URLRequest(BulkLoader.substituteURLString(param1, this._stringSubstitutions));
                if (param2[HEADERS])
                {
                    param1.requestHeaders = param2[HEADERS];
                }
            }
            else if (!param1 is URLRequest)
            {
                throw new Error("[BulkLoader] cannot add object with bad type for url:\'" + param1.url);
            }
            var _loc_3:* = this.get(param2[ID]);
            if (_loc_3)
            {
                this.log("Add received an already added id: " + param2[ID] + ", not adding a new item");
                return _loc_3;
            }
            if (param2["type"])
            {
                _loc_4 = param2["type"].toLowerCase();
                if (AVAILABLE_TYPES.indexOf(_loc_4) == -1)
                {
                    this.log("add received an unknown type:", _loc_4, "and will cast it to text", LOG_WARNINGS);
                }
            }
            if (!_loc_4)
            {
                _loc_4 = guessType(param1.url);
            }
            var _loc_7:* = this;
            var _loc_8:* = this._additionIndex + 1;
            _loc_7._additionIndex = _loc_8;
            _loc_3 = new _typeClasses[_loc_4](param1, _loc_4, _instancesCreated + "_" + String(this._additionIndex));
            if (!param2["id"] && this._allowsAutoIDFromFileName)
            {
                param2["id"] = getFileName(param1.url);
                this.log("Adding automatic id from file name for item:", _loc_3, "( id= " + param2["id"] + " )");
            }
            var _loc_5:* = _loc_3._parseOptions(param2);
            for each (_loc_6 in _loc_5)
            {
                
                this.log(_loc_6, LOG_WARNINGS);
            }
            this.log("Added", _loc_3, LOG_VERBOSE);
            _loc_3._addedTime = getTimer();
            _loc_3._additionIndex = this._additionIndex;
            _loc_3.addEventListener(Event.COMPLETE, this._onItemComplete, false, int.MIN_VALUE, true);
            _loc_3.addEventListener(ERROR, this._onItemError, false, 0, true);
            _loc_3.addEventListener(Event.OPEN, this._onItemStarted, false, 0, true);
            _loc_3.addEventListener(ProgressEvent.PROGRESS, this._onProgress, false, 0, true);
            this._items.push(_loc_3);
            (this._itemsTotal + 1);
            this._totalWeight = this._totalWeight + _loc_3.weight;
            this.sortItemsByPriority();
            this._isFinished = false;
            if (!this._isPaused)
            {
                this._loadNext();
            }
            return _loc_3;
        }// end function

        public function start(param1:int = -1) : void
        {
            if (param1 > 0)
            {
                this._numConnections = param1;
            }
            if (this._connections)
            {
                this._loadNext();
                return;
            }
            this._startTime = getTimer();
            this._connections = [];
            this._loadNext();
            this._isRunning = true;
            this._lastBytesCheck = 0;
            this._lastSpeedCheck = getTimer();
            this._isPaused = false;
            return;
        }// end function

        public function reload(param1) : Boolean
        {
            var _loc_2:* = this.get(param1);
            if (!_loc_2)
            {
                return false;
            }
            this._removeFromItems(_loc_2);
            this._removeFromConnections(_loc_2);
            _loc_2.stop();
            _loc_2.cleanListeners();
            _loc_2.status = null;
            this._isFinished = false;
            _loc_2._addedTime = getTimer();
            var _loc_3:* = this;
            _loc_3._additionIndex = this._additionIndex + 1;
            _loc_2._additionIndex = this._additionIndex + 1;
            _loc_2.addEventListener(Event.COMPLETE, this._onItemComplete, false, int.MIN_VALUE, true);
            _loc_2.addEventListener(ERROR, this._onItemError, false, 0, true);
            _loc_2.addEventListener(Event.OPEN, this._onItemStarted, false, 0, true);
            _loc_2.addEventListener(ProgressEvent.PROGRESS, this._onProgress, false, 0, true);
            this._items.push(_loc_2);
            (this._itemsTotal + 1);
            this._totalWeight = this._totalWeight + _loc_2.weight;
            this.sortItemsByPriority();
            this._isFinished = false;
            this.loadNow(_loc_2);
            return true;
        }// end function

        public function loadNow(param1) : Boolean
        {
            var _loc_3:* = null;
            var _loc_2:* = this.get(param1);
            if (!_loc_2)
            {
                return false;
            }
            if (!this._connections)
            {
                this._connections = [];
            }
            if (_loc_2.status == LoadingItem.STATUS_FINISHED || _loc_2.status == LoadingItem.STATUS_STARTED)
            {
                return true;
            }
            if (this._connections.length >= this.numConnections)
            {
                _loc_3 = this._getLeastUrgentOpenedItem();
                this.pause(_loc_3);
                this._removeFromConnections(_loc_3);
                _loc_3.status = null;
            }
            _loc_2._priority = this.highestPriority;
            this._loadNext(_loc_2);
            return true;
        }// end function

        public function _getLeastUrgentOpenedItem() : LoadingItem
        {
            var _loc_1:* = LoadingItem(this._connections.sortOn(["priority", "bytesRemaining", "_additionIndex"], [Array.NUMERIC, Array.DESCENDING, Array.NUMERIC, Array.NUMERIC])[0]);
            return _loc_1;
        }// end function

        public function _loadNext(param1:LoadingItem = null) : Boolean
        {
            var checkItem:LoadingItem;
            var toLoad:* = param1;
            if (this._isFinished)
            {
                return false;
            }
            if (!this._connections)
            {
                this._connections = [];
            }
            this._connections.forEach(function (param1:LoadingItem, ... args) : void
            {
                if (param1.status == LoadingItem.STATUS_ERROR && param1.numTries < param1.maxTries)
                {
                    _removeFromConnections(param1);
                }
                return;
            }// end function
            );
            var next:Boolean;
            if (!toLoad)
            {
                var _loc_3:* = 0;
                var _loc_4:* = this._items;
                while (_loc_4 in _loc_3)
                {
                    
                    checkItem = _loc_4[_loc_3];
                    if (!checkItem._isLoading && checkItem.status != LoadingItem.STATUS_STOPPED)
                    {
                        toLoad = checkItem;
                        break;
                    }
                }
            }
            if (toLoad)
            {
                next;
                this._isRunning = true;
                if (this._connections.length < this.numConnections)
                {
                    this._connections.push(toLoad);
                    toLoad.load();
                    this.log("Will load item:", toLoad, LOG_INFO);
                }
                if (this._connections.length < this.numConnections)
                {
                    this._loadNext();
                }
            }
            return next;
        }// end function

        public function _onItemComplete(event:Event) : void
        {
            var _loc_2:* = event.target as LoadingItem;
            this._removeFromConnections(_loc_2);
            this.log("Loaded ", _loc_2, LOG_INFO);
            this.log("Items to load", this.getNotLoadedItems(), LOG_VERBOSE);
            _loc_2.cleanListeners();
            this._contents[_loc_2.url.url] = _loc_2.content;
            var _loc_3:* = this._loadNext();
            var _loc_4:* = this._isAllDoneP();
            var _loc_5:* = this;
            var _loc_6:* = this._itemsLoaded + 1;
            _loc_5._itemsLoaded = _loc_6;
            if (_loc_4)
            {
                this._onAllLoaded();
            }
            return;
        }// end function

        public function _updateStats() : void
        {
            var _loc_4:* = null;
            this.avgLatency = 0;
            this.speedAvg = 0;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            this._speedTotal = 0;
            var _loc_3:* = 0;
            for each (_loc_4 in this._items)
            {
                
                if (_loc_4._isLoaded && _loc_4.status != LoadingItem.STATUS_ERROR)
                {
                    _loc_1 = _loc_1 + _loc_4.latency;
                    _loc_2 = _loc_2 + _loc_4.bytesTotal;
                    _loc_3 = _loc_3 + 1;
                }
            }
            this._speedTotal = _loc_2 / 1024 / this.totalTime;
            this.avgLatency = _loc_1 / _loc_3;
            this.speedAvg = this._speedTotal / _loc_3;
            return;
        }// end function

        public function _removeFromItems(param1:LoadingItem) : Boolean
        {
            var _loc_2:* = this._items.indexOf(param1);
            if (_loc_2 > -1)
            {
                this._items.splice(_loc_2, 1);
            }
            else
            {
                return false;
            }
            if (param1._isLoaded)
            {
                var _loc_3:* = this;
                var _loc_4:* = this._itemsLoaded - 1;
                _loc_3._itemsLoaded = _loc_4;
            }
            var _loc_3:* = this;
            var _loc_4:* = this._itemsTotal - 1;
            _loc_3._itemsTotal = _loc_4;
            this._totalWeight = this._totalWeight - param1.weight;
            this.log("Removing " + param1, LOG_VERBOSE);
            param1.removeEventListener(Event.COMPLETE, this._onItemComplete, false);
            param1.removeEventListener(ERROR, this._onItemError, false);
            param1.removeEventListener(Event.OPEN, this._onItemStarted, false);
            param1.removeEventListener(ProgressEvent.PROGRESS, this._onProgress, false);
            return true;
        }// end function

        public function _removeFromConnections(param1) : Boolean
        {
            if (!this._connections)
            {
                return false;
            }
            var _loc_2:* = this._connections.indexOf(param1);
            if (_loc_2 > -1)
            {
                this._connections.splice(_loc_2, 1);
                return true;
            }
            return false;
        }// end function

        public function _onItemError(event:ErrorEvent) : void
        {
            var _loc_2:* = event.target as LoadingItem;
            this.log("After " + _loc_2.numTries + " I am giving up on " + _loc_2.url.url, LOG_ERRORS);
            this.log("Error loading", _loc_2, event.text, LOG_ERRORS);
            this._removeFromConnections(_loc_2);
            event.stopPropagation();
            dispatchEvent(event);
            return;
        }// end function

        public function _onItemStarted(event:Event) : void
        {
            var _loc_2:* = event.target as LoadingItem;
            this.log("Started loading", _loc_2, LOG_INFO);
            dispatchEvent(event);
            return;
        }// end function

        public function _onProgress(event:Event = null) : void
        {
            var _loc_2:* = this.getProgressForItems(this._items);
            this._bytesLoaded = _loc_2.bytesLoaded;
            this._bytesTotal = _loc_2.bytesTotal;
            this._weightPercent = _loc_2.weightPercent;
            this._percentLoaded = _loc_2.percentLoaded;
            this._bytesTotalCurrent = _loc_2.bytesTotalCurrent;
            this._loadedRatio = _loc_2.ratioLoaded;
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function getProgressForItems(param1:Array) : BulkProgressEvent
        {
            var _loc_11:* = null;
            var _loc_13:* = undefined;
            var _loc_15:* = 0;
            this._bytesTotalCurrent = 0;
            this._bytesTotal = _loc_15;
            this._bytesLoaded = _loc_15;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_12:* = [];
            for each (_loc_13 in param1)
            {
                
                _loc_11 = this.get(_loc_13);
                if (!_loc_11)
                {
                    continue;
                }
                _loc_6++;
                _loc_3 = _loc_3 + _loc_11.weight;
                if (_loc_11.status == LoadingItem.STATUS_STARTED || _loc_11.status == LoadingItem.STATUS_FINISHED || _loc_11.status == LoadingItem.STATUS_STOPPED)
                {
                    _loc_8 = _loc_8 + _loc_11._bytesLoaded;
                    _loc_10 = _loc_10 + _loc_11._bytesTotal;
                    _loc_5 = _loc_5 + _loc_11._bytesLoaded / _loc_11._bytesTotal * _loc_11.weight;
                    if (_loc_11.status == LoadingItem.STATUS_FINISHED)
                    {
                        _loc_7++;
                    }
                    _loc_4++;
                }
            }
            if (_loc_4 != _loc_6)
            {
                _loc_9 = Number.POSITIVE_INFINITY;
            }
            else
            {
                _loc_9 = _loc_10;
            }
            _loc_2 = _loc_5 / _loc_3;
            if (_loc_3 == 0)
            {
                _loc_2 = 0;
            }
            var _loc_14:* = new BulkProgressEvent(PROGRESS);
            new BulkProgressEvent(PROGRESS).setInfo(_loc_8, _loc_9, _loc_9, _loc_7, _loc_6, _loc_2);
            return _loc_14;
        }// end function

        public function get numConnections() : int
        {
            return this._numConnections;
        }// end function

        public function get contents() : Object
        {
            return this._contents;
        }// end function

        public function get items() : Array
        {
            return this._items.slice();
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get loadedRatio() : Number
        {
            return this._loadedRatio;
        }// end function

        public function get itemsTotal() : int
        {
            return this.items.length;
        }// end function

        public function get itemsLoaded() : int
        {
            return this._itemsLoaded;
        }// end function

        public function set itemsLoaded(param1:int) : void
        {
            this._itemsLoaded = param1;
            return;
        }// end function

        public function get totalWeight() : int
        {
            return this._totalWeight;
        }// end function

        public function get bytesTotal() : int
        {
            return this._bytesTotal;
        }// end function

        public function get bytesLoaded() : int
        {
            return this._bytesLoaded;
        }// end function

        public function get bytesTotalCurrent() : int
        {
            return this._bytesTotalCurrent;
        }// end function

        public function get percentLoaded() : Number
        {
            return this._percentLoaded;
        }// end function

        public function get weightPercent() : Number
        {
            return this._weightPercent;
        }// end function

        public function get isRunning() : Boolean
        {
            return this._isRunning;
        }// end function

        public function get isFinished() : Boolean
        {
            return this._isFinished;
        }// end function

        public function get highestPriority() : int
        {
            var _loc_2:* = null;
            var _loc_1:* = int.MIN_VALUE;
            for each (_loc_2 in this._items)
            {
                
                if (_loc_2.priority > _loc_1)
                {
                    _loc_1 = _loc_2.priority;
                }
            }
            return _loc_1;
        }// end function

        public function get logFunction() : Function
        {
            return this._logFunction;
        }// end function

        public function get allowsAutoIDFromFileName() : Boolean
        {
            return this._allowsAutoIDFromFileName;
        }// end function

        public function set allowsAutoIDFromFileName(param1:Boolean) : void
        {
            this._allowsAutoIDFromFileName = param1;
            return;
        }// end function

        public function getNotLoadedItems() : Array
        {
            return this._items.filter(function (param1:LoadingItem, ... args) : Boolean
            {
                return param1.status != LoadingItem.STATUS_FINISHED;
            }// end function
            );
        }// end function

        public function get speed() : Number
        {
            var _loc_1:* = getTimer() - this._lastSpeedCheck;
            var _loc_2:* = (this.bytesLoaded - this._lastBytesCheck) / 1024;
            var _loc_3:* = _loc_2 / (_loc_1 / 1000);
            this._lastSpeedCheck = _loc_1;
            this._lastBytesCheck = this.bytesLoaded;
            return _loc_3;
        }// end function

        public function set logFunction(param1:Function) : void
        {
            this._logFunction = param1;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get stringSubstitutions() : Object
        {
            return this._stringSubstitutions;
        }// end function

        public function set stringSubstitutions(param1:Object) : void
        {
            this._stringSubstitutions = param1;
            return;
        }// end function

        public function changeItemPriority(param1:String, param2:int) : Boolean
        {
            var _loc_3:* = this.get(param1);
            if (!_loc_3)
            {
                return false;
            }
            _loc_3._priority = param2;
            this.sortItemsByPriority();
            return true;
        }// end function

        public function sortItemsByPriority() : void
        {
            this._items.sortOn(["priority", "_additionIndex"], [Array.NUMERIC | Array.DESCENDING, Array.NUMERIC]);
            return;
        }// end function

        public function _getContentAsType(param1, param2:Class, param3:Boolean = false)
        {
            var res:*;
            var key:* = param1;
            var type:* = param2;
            var clearMemory:* = param3;
            if (!this._name)
            {
                throw new Error("[BulkLoader] Cannot use an instance that has been cleared from memory (.clear())");
            }
            var item:* = this.get(key);
            if (!item)
            {
                return null;
            }
            try
            {
                if (item._isLoaded || item.isStreamable() && item.status == LoadingItem.STATUS_STARTED)
                {
                    res = item.content as type;
                    if (res == null)
                    {
                        throw new Error("bad cast");
                    }
                    if (clearMemory)
                    {
                        this.remove(key);
                    }
                    return res;
                }
            }
            catch (e:Error)
            {
                log("Failed to get content with url: \'" + key + "\'as type:", type, LOG_ERRORS);
            }
            return null;
        }// end function

        public function getContent(param1:String, param2:Boolean = false)
        {
            return this._getContentAsType(param1, Object, param2);
        }// end function

        public function getXML(param1, param2:Boolean = false) : XML
        {
            return XML(this._getContentAsType(param1, XML, param2));
        }// end function

        public function getText(param1, param2:Boolean = false) : String
        {
            return String(this._getContentAsType(param1, String, param2));
        }// end function

        public function getSound(param1, param2:Boolean = false) : Sound
        {
            return Sound(this._getContentAsType(param1, Sound, param2));
        }// end function

        public function getBitmap(param1:String, param2:Boolean = false) : Bitmap
        {
            return Bitmap(this._getContentAsType(param1, Bitmap, param2));
        }// end function

        public function getDisplayObjectLoader(param1:String, param2:Boolean = false) : Loader
        {
            return Loader(this._getContentAsType(param1, Loader, param2));
        }// end function

        public function getMovieClip(param1:String, param2:Boolean = false) : MovieClip
        {
            return MovieClip(this._getContentAsType(param1, MovieClip, param2));
        }// end function

        public function getAVM1Movie(param1:String, param2:Boolean = false) : AVM1Movie
        {
            return AVM1Movie(this._getContentAsType(param1, AVM1Movie, param2));
        }// end function

        public function getNetStream(param1:String, param2:Boolean = false) : NetStream
        {
            return NetStream(this._getContentAsType(param1, NetStream, param2));
        }// end function

        public function getNetStreamMetaData(param1:String, param2:Boolean = false) : Object
        {
            var _loc_3:* = this.getNetStream(param1, param2);
            return Boolean(_loc_3) ? ((this.get(param1) as Object).metaData) : (null);
        }// end function

        public function getBitmapData(param1, param2:Boolean = false) : BitmapData
        {
            var key:* = param1;
            var clearMemory:* = param2;
            try
            {
                return this.getBitmap(key, clearMemory).bitmapData;
            }
            catch (e:Error)
            {
                log("Failed to get bitmapData with url:", key, LOG_ERRORS);
            }
            return null;
        }// end function

        public function getBinary(param1, param2:Boolean = false) : ByteArray
        {
            return ByteArray(this._getContentAsType(param1, ByteArray, param2));
        }// end function

        public function getSerializedData(param1, param2:Boolean = false, param3:Function = null)
        {
            var raw:*;
            var parsed:*;
            var key:* = param1;
            var clearMemory:* = param2;
            var encodingFunction:* = param3;
            try
            {
                raw = this._getContentAsType(key, Object, clearMemory);
                parsed = encodingFunction.apply(null, [raw]);
                return parsed;
            }
            catch (e:Error)
            {
                log("Failed to parse key:", key, "with encodingFunction:" + encodingFunction, LOG_ERRORS);
            }
            return null;
        }// end function

        public function getHttpStatus(param1) : int
        {
            var _loc_2:* = this.get(param1);
            if (_loc_2)
            {
                return _loc_2.httpStatus;
            }
            return -1;
        }// end function

        public function _isAllDoneP() : Boolean
        {
            return this._items.every(function (param1:LoadingItem, ... args) : Boolean
            {
                return param1._isLoaded;
            }// end function
            );
        }// end function

        public function _onAllLoaded() : void
        {
            if (this._isFinished)
            {
                return;
            }
            var _loc_1:* = new BulkProgressEvent(COMPLETE);
            _loc_1.setInfo(this.bytesLoaded, this.bytesTotal, this.bytesTotalCurrent, this._itemsLoaded, this.itemsTotal, this.weightPercent);
            var _loc_2:* = new BulkProgressEvent(PROGRESS);
            _loc_2.setInfo(this.bytesLoaded, this.bytesTotal, this.bytesTotalCurrent, this._itemsLoaded, this.itemsTotal, this.weightPercent);
            this._isRunning = false;
            this._endTIme = getTimer();
            this.totalTime = BulkLoader.truncateNumber((this._endTIme - this._startTime) / 1000);
            this._updateStats();
            this._connections = [];
            this.getStats();
            this._isFinished = true;
            this.log("Finished all", LOG_INFO);
            dispatchEvent(_loc_2);
            dispatchEvent(_loc_1);
            return;
        }// end function

        public function getStats() : String
        {
            var stats:Array;
            stats.push("\n************************************");
            stats.push("All items loaded(" + this.itemsTotal + ")");
            stats.push("Total time(s):       " + this.totalTime);
            stats.push("Average latency(s):  " + truncateNumber(this.avgLatency));
            stats.push("Average speed(kb/s): " + truncateNumber(this.speedAvg));
            stats.push("Median speed(kb/s):  " + truncateNumber(this._speedTotal));
            stats.push("KiloBytes total:     " + truncateNumber(this.bytesTotal / 1024));
            var itemsInfo:* = this._items.map(function (param1:LoadingItem, ... args) : String
            {
                return "\t" + param1.getStats();
            }// end function
            );
            stats.push(itemsInfo.join("\n"));
            stats.push("************************************");
            var statsString:* = stats.join("\n");
            this.log(statsString, LOG_VERBOSE);
            return statsString;
        }// end function

        public function log(... args) : void
        {
            args = isNaN(args[(args.length - 1)]) ? (3) : (int(args.pop()));
            if (args >= this.logLevel)
            {
                this._logFunction("[BulkLoader] " + args.join(" "));
            }
            return;
        }// end function

        public function get(param1) : LoadingItem
        {
            var _loc_2:* = null;
            if (!param1)
            {
                return null;
            }
            if (param1 is LoadingItem)
            {
                return param1;
            }
            for each (_loc_2 in this._items)
            {
                
                if (_loc_2._id == param1 || _loc_2.url.url == param1 || _loc_2.url == param1 || param1 is URLRequest && _loc_2.url.url == param1.url)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function remove(param1, param2:Boolean = false) : Boolean
        {
            var item:LoadingItem;
            var allDone:Boolean;
            var key:* = param1;
            var internalCall:* = param2;
            try
            {
                item = this.get(key);
                if (!item)
                {
                    return false;
                }
                this._removeFromItems(item);
                this._removeFromConnections(item);
                item.destroy();
                delete this._contents[item.url.url];
                if (internalCall)
                {
                    return true;
                }
                item;
                this._onProgress();
                allDone = this._isAllDoneP();
                if (allDone)
                {
                    this._onAllLoaded();
                }
                return true;
            }
            catch (e:Error)
            {
                log("Error while removing item from key:" + key, e.getStackTrace(), LOG_ERRORS);
            }
            return false;
        }// end function

        public function removeAll() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._items.slice())
            {
                
                this.remove(_loc_1, true);
            }
            this._items = [];
            this._connections = [];
            this._contents = new Dictionary();
            return;
        }// end function

        public function clear() : void
        {
            this.removeAll();
            delete _allLoaders[this.name];
            this._name = null;
            return;
        }// end function

        public function removePausedItems() : Boolean
        {
            var stoppedLoads:* = this._items.filter(function (param1:LoadingItem, ... args) : Boolean
            {
                return param1.status == LoadingItem.STATUS_STOPPED;
            }// end function
            );
            stoppedLoads.forEach(function (param1:LoadingItem, ... args) : void
            {
                remove(param1);
                return;
            }// end function
            );
            this._loadNext();
            return stoppedLoads.length > 0;
        }// end function

        public function removeFailedItems() : int
        {
            var numCleared:int;
            var badItems:* = this._items.filter(function (param1:LoadingItem, ... args) : Boolean
            {
                return param1.status == LoadingItem.STATUS_ERROR;
            }// end function
            );
            numCleared = badItems.length;
            badItems.forEach(function (param1:LoadingItem, ... args) : void
            {
                remove(param1);
                return;
            }// end function
            );
            this._loadNext();
            return numCleared;
        }// end function

        public function getFailedItems() : Array
        {
            return this._items.filter(function (param1:LoadingItem, ... args) : Boolean
            {
                return param1.status == LoadingItem.STATUS_ERROR;
            }// end function
            );
        }// end function

        public function pause(param1, param2:Boolean = false) : Boolean
        {
            var _loc_3:* = this.get(param1);
            if (!_loc_3)
            {
                return false;
            }
            if (_loc_3.status != LoadingItem.STATUS_FINISHED)
            {
                _loc_3.stop();
            }
            this.log("STOPPED ITEM:", _loc_3, LOG_INFO);
            var _loc_4:* = this._removeFromConnections(_loc_3);
            if (param2)
            {
                this._loadNext();
            }
            return _loc_4;
        }// end function

        public function pauseAll() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._items)
            {
                
                this.pause(_loc_1);
            }
            this._isRunning = false;
            this._isPaused = true;
            this.log("Stopping all items", LOG_INFO);
            return;
        }// end function

        public function resume(param1) : Boolean
        {
            var _loc_2:* = param1 is LoadingItem ? (param1) : (this.get(param1));
            this._isPaused = false;
            if (_loc_2 && _loc_2.status == LoadingItem.STATUS_STOPPED)
            {
                _loc_2.status = null;
                this._loadNext();
                return true;
            }
            return false;
        }// end function

        public function resumeAll() : Boolean
        {
            this.log("Resuming all items", LOG_VERBOSE);
            var affected:Boolean;
            this._items.forEach(function (param1:LoadingItem, ... args) : void
            {
                if (param1.status == LoadingItem.STATUS_STOPPED)
                {
                    resume(param1);
                    affected = true;
                }
                return;
            }// end function
            );
            this._loadNext();
            return affected;
        }// end function

        override public function toString() : String
        {
            return "[BulkLoader] name:" + this.name + ", itemsTotal: " + this.itemsTotal + ", itemsLoaded: " + this._itemsLoaded;
        }// end function

        public static function createUniqueNamedLoader(param1:int = 7, param2:int = 4) : BulkLoader
        {
            return new BulkLoader(BulkLoader.getUniqueName(), param1, param2);
        }// end function

        public static function getUniqueName() : String
        {
            return "BulkLoader-" + _instancesCreated;
        }// end function

        public static function getLoader(param1:String) : BulkLoader
        {
            return BulkLoader._allLoaders[param1] as BulkLoader;
        }// end function

        public static function _hasItemInBulkLoader(param1, param2:BulkLoader) : Boolean
        {
            var _loc_3:* = param2.get(param1);
            if (_loc_3)
            {
                return true;
            }
            return false;
        }// end function

        public static function whichLoaderHasItem(param1) : BulkLoader
        {
            var _loc_2:* = null;
            for each (_loc_2 in _allLoaders)
            {
                
                if (BulkLoader._hasItemInBulkLoader(param1, _loc_2))
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public static function registerNewType(param1:String, param2:String, param3:Class) : Boolean
        {
            var _loc_4:* = null;
            if (param1.charAt(0) == ".")
            {
                param1 = param1.substring(1);
            }
            if (AVAILABLE_TYPES.indexOf(param2) == -1)
            {
                if (!Boolean(param3))
                {
                    throw new Error("[BulkLoader]: When adding a new type and extension, you must determine which class to use");
                }
                _typeClasses[param2] = param3;
                if (!_customTypesExtensions)
                {
                    _customTypesExtensions = {};
                }
                if (!_customTypesExtensions[param2])
                {
                    _customTypesExtensions[param2] = [];
                    AVAILABLE_TYPES.push(param2);
                }
                _customTypesExtensions[param2].push(param1);
                return true;
            }
            else
            {
                _customTypesExtensions[param2].push(param1);
            }
            var _loc_5:* = {IMAGE_EXTENSIONS:TYPE_IMAGE, VIDEO_EXTENSIONS:TYPE_VIDEO, SOUND_EXTENSIONS:TYPE_SOUND, TEXT_EXTENSIONS:TYPE_TEXT};
            _loc_4 = {IMAGE_EXTENSIONS:TYPE_IMAGE, VIDEO_EXTENSIONS:TYPE_VIDEO, SOUND_EXTENSIONS:TYPE_SOUND, TEXT_EXTENSIONS:TYPE_TEXT}[param2];
            if (_loc_4 && _loc_4.indexOf(param1) == -1)
            {
                _loc_4.push(param1);
                return true;
            }
            return false;
        }// end function

        public static function removeAllLoaders() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in _allLoaders)
            {
                
                _loc_1.removeAll();
                _loc_1.clear();
                _loc_1 = null;
            }
            _allLoaders = {};
            return;
        }// end function

        public static function pauseAllLoaders() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in _allLoaders)
            {
                
                _loc_1.pauseAll();
            }
            return;
        }// end function

        public static function truncateNumber(param1:Number, param2:int = 2) : Number
        {
            var _loc_3:* = Math.pow(10, param2);
            return Math.round(param1 * _loc_3) / _loc_3;
        }// end function

        public static function guessType(param1:String) : String
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = param1.indexOf("?") > -1 ? (param1.substring(0, param1.indexOf("?"))) : (param1);
            var _loc_3:* = _loc_2.substring((_loc_2.lastIndexOf(".") + 1)).toLowerCase();
            if (!Boolean(_loc_3))
            {
                _loc_3 = BulkLoader.TYPE_TEXT;
            }
            if (_loc_3 == BulkLoader.TYPE_IMAGE || BulkLoader.IMAGE_EXTENSIONS.indexOf(_loc_3) > -1)
            {
                _loc_4 = BulkLoader.TYPE_IMAGE;
            }
            else if (_loc_3 == BulkLoader.TYPE_SOUND || BulkLoader.SOUND_EXTENSIONS.indexOf(_loc_3) > -1)
            {
                _loc_4 = BulkLoader.TYPE_SOUND;
            }
            else if (_loc_3 == BulkLoader.TYPE_VIDEO || BulkLoader.VIDEO_EXTENSIONS.indexOf(_loc_3) > -1)
            {
                _loc_4 = BulkLoader.TYPE_VIDEO;
            }
            else if (_loc_3 == BulkLoader.TYPE_XML || BulkLoader.XML_EXTENSIONS.indexOf(_loc_3) > -1)
            {
                _loc_4 = BulkLoader.TYPE_XML;
            }
            else if (_loc_3 == BulkLoader.TYPE_MOVIECLIP || BulkLoader.MOVIECLIP_EXTENSIONS.indexOf(_loc_3) > -1)
            {
                _loc_4 = BulkLoader.TYPE_MOVIECLIP;
            }
            else
            {
                for (_loc_5 in _customTypesExtensions)
                {
                    
                    for each (_loc_6 in _customTypesExtensions[_loc_5])
                    {
                        
                        if (_loc_6 == _loc_3)
                        {
                            _loc_4 = _loc_5;
                            break;
                        }
                        if (_loc_4)
                        {
                            break;
                        }
                    }
                }
                if (!_loc_4)
                {
                    _loc_4 = BulkLoader.TYPE_TEXT;
                }
            }
            return _loc_4;
        }// end function

        public static function substituteURLString(param1:String, param2:Object) : String
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_12:* = null;
            if (!param2)
            {
                return param1;
            }
            var _loc_3:* = /(?P<var_name>\{\s*[^\}]*\})""(?P<var_name>\{\s*[^\}]*\})/g;
            var _loc_4:* = _loc_3.exec(param1);
            var _loc_5:* = _loc_3.exec(param1) ? (_loc_4.var_name) : (null);
            var _loc_6:* = [];
            var _loc_7:* = 0;
            while (Boolean(_loc_4) && Boolean(_loc_4.var_name))
            {
                
                if (_loc_4.var_name)
                {
                    _loc_5 = _loc_4.var_name;
                    _loc_5 = _loc_5.replace("{", "");
                    _loc_5 = _loc_5.replace("}", "");
                    _loc_5 = _loc_5.replace(/\s*""\s*/g, "");
                }
                _loc_6.push({start:_loc_4.index, end:_loc_4.index + _loc_4.var_name.length, changeTo:param2[_loc_5]});
                _loc_7++;
                if (_loc_7 > 400)
                {
                    break;
                }
                _loc_4 = _loc_3.exec(param1);
                _loc_5 = _loc_4 ? (_loc_4.var_name) : (null);
            }
            if (_loc_6.length == 0)
            {
                return param1;
            }
            var _loc_8:* = [];
            var _loc_11:* = param1.substr(0, _loc_6[0].start);
            for each (_loc_10 in _loc_6)
            {
                
                if (_loc_9)
                {
                    _loc_11 = param1.substring(_loc_9.end, _loc_10.start);
                }
                _loc_8.push(_loc_11);
                _loc_8.push(_loc_10.changeTo);
                _loc_9 = _loc_10;
            }
            _loc_8.push(param1.substring(_loc_10.end));
            return _loc_8.join("");
        }// end function

        public static function getFileName(param1:String) : String
        {
            if (param1.lastIndexOf("/") == (param1.length - 1))
            {
                return getFileName(param1.substring(0, (param1.length - 1)));
            }
            var _loc_2:* = param1.lastIndexOf("/") + 1;
            var _loc_3:* = param1.substring(_loc_2);
            var _loc_4:* = _loc_3.indexOf(".");
            if (_loc_3.indexOf(".") == -1)
            {
                if (_loc_3.indexOf("?") > -1)
                {
                    _loc_4 = _loc_3.indexOf("?");
                }
                else
                {
                    _loc_4 = _loc_3.length;
                }
            }
            var _loc_5:* = _loc_3.substring(0, _loc_4);
            return _loc_3.substring(0, _loc_4);
        }// end function

        public static function __debug_print_loaders() : void
        {
            var instNames:String;
            var theNames:Array;
            var _loc_2:* = 0;
            var _loc_3:* = BulkLoader._allLoaders;
            while (_loc_3 in _loc_2)
            {
                
                instNames = _loc_3[_loc_2];
                theNames.push(instNames);
            }
            theNames.sort();
            trace("All loaders");
            theNames.forEach(function (param1, ... args) : void
            {
                trace("\t", param1);
                return;
            }// end function
            );
            trace("===========");
            return;
        }// end function

        public static function __debug_print_num_loaders() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            for each (_loc_2 in BulkLoader._allLoaders)
            {
                
                _loc_1++;
            }
            trace("BulkLoader has ", _loc_1, "instances");
            return;
        }// end function

        public static function __debug_printStackTrace() : void
        {
            try
            {
                throw new Error("stack trace");
            }
            catch (e:Error)
            {
                trace(e.getStackTrace());
            }
            return;
        }// end function

    }
}
