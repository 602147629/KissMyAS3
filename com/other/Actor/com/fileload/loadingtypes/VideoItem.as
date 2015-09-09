package com.fileload.loadingtypes
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;

    public class VideoItem extends LoadingItem
    {
        private var nc:NetConnection;
        public var stream:NetStream;
        public var dummyEventTrigger:Sprite;
        public var _checkPolicyFile:Boolean;
        public var pausedAtStart:Boolean = false;
        public var _metaData:Object;
        public var _canBeginStreaming:Boolean = false;

        public function VideoItem(param1:URLRequest, param2:String, param3:String)
        {
            specificAvailableProps = [BulkLoader.CHECK_POLICY_FILE, BulkLoader.PAUSED_AT_START];
            super(param1, param2, param3);
            var _loc_4:* = 0;
            _bytesLoaded = 0;
            _bytesTotal = _loc_4;
            return;
        }// end function

        override public function _parseOptions(param1:Object) : Array
        {
            this.pausedAtStart = param1[BulkLoader.PAUSED_AT_START] || false;
            this._checkPolicyFile = param1[BulkLoader.CHECK_POLICY_FILE] || false;
            return super._parseOptions(param1);
        }// end function

        override public function load() : void
        {
            super.load();
            this.nc = new NetConnection();
            this.nc.connect(null);
            this.stream = new NetStream(this.nc);
            this.stream.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler, false, 0, true);
            this.stream.addEventListener(NetStatusEvent.NET_STATUS, this.onNetStatus, false, 0, true);
            this.dummyEventTrigger = new Sprite();
            this.dummyEventTrigger.addEventListener(Event.ENTER_FRAME, this.createNetStreamEvent, false, 0, true);
            var customClient:* = new Object();
            customClient.onCuePoint = function (... args) : void
            {
                return;
            }// end function
            ;
            customClient.onMetaData = this.onVideoMetadata;
            customClient.onPlayStatus = function (... args) : void
            {
                return;
            }// end function
            ;
            this.stream.client = customClient;
            try
            {
                this.stream.play(url.url, this._checkPolicyFile);
            }
            catch (e:SecurityError)
            {
                onSecurityErrorHandler(_createErrorEvent(e));
            }
            this.stream.seek(0);
            return;
        }// end function

        public function createNetStreamEvent(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            if (_bytesTotal == _bytesLoaded && _bytesTotal > 8)
            {
                if (this.dummyEventTrigger)
                {
                    this.dummyEventTrigger.removeEventListener(Event.ENTER_FRAME, this.createNetStreamEvent, false);
                }
                this.fireCanBeginStreamingEvent();
                _loc_2 = new Event(Event.COMPLETE);
                this.onCompleteHandler(_loc_2);
            }
            else if (_bytesTotal == 0 && this.stream && this.stream.bytesTotal > 4)
            {
                _loc_3 = new Event(Event.OPEN);
                this.onStartedHandler(_loc_3);
                _bytesLoaded = this.stream.bytesLoaded;
                _bytesTotal = this.stream.bytesTotal;
            }
            else if (this.stream)
            {
                _loc_4 = new ProgressEvent(ProgressEvent.PROGRESS, false, false, this.stream.bytesLoaded, this.stream.bytesTotal);
                if (this.isVideo() && this.metaData && !this._canBeginStreaming)
                {
                    _loc_5 = getTimer() - responseTime;
                    if (_loc_5 > 100)
                    {
                        _loc_6 = bytesLoaded / (_loc_5 / 1000);
                        _bytesRemaining = _bytesTotal - bytesLoaded;
                        _loc_7 = _bytesRemaining / (_loc_6 * 0.8);
                        _loc_8 = this.metaData.duration - this.stream.bufferLength;
                        if (_loc_8 > _loc_7)
                        {
                            this.fireCanBeginStreamingEvent();
                        }
                    }
                }
                super.onProgressHandler(_loc_4);
            }
            return;
        }// end function

        override public function onCompleteHandler(event:Event) : void
        {
            _content = this.stream;
            super.onCompleteHandler(event);
            return;
        }// end function

        override public function onStartedHandler(event:Event) : void
        {
            _content = this.stream;
            if (this.pausedAtStart && this.stream)
            {
                this.stream.pause();
            }
            super.onStartedHandler(event);
            return;
        }// end function

        override public function stop() : void
        {
            try
            {
                if (this.stream)
                {
                    this.stream.close();
                }
            }
            catch (e:Error)
            {
            }
            super.stop();
            return;
        }// end function

        override public function cleanListeners() : void
        {
            if (this.stream)
            {
                this.stream.removeEventListener(IOErrorEvent.IO_ERROR, onErrorHandler, false);
                this.stream.removeEventListener(NetStatusEvent.NET_STATUS, this.onNetStatus, false);
            }
            if (this.dummyEventTrigger)
            {
                this.dummyEventTrigger.removeEventListener(Event.ENTER_FRAME, this.createNetStreamEvent, false);
                this.dummyEventTrigger = null;
            }
            return;
        }// end function

        override public function isVideo() : Boolean
        {
            return true;
        }// end function

        override public function isStreamable() : Boolean
        {
            return true;
        }// end function

        override public function destroy() : void
        {
            if (this.stream)
            {
            }
            this.stop();
            this.cleanListeners();
            this.stream = null;
            super.destroy();
            return;
        }// end function

        function onNetStatus(event:NetStatusEvent) : void
        {
            var _loc_2:* = null;
            if (!this.stream)
            {
                return;
            }
            this.stream.removeEventListener(NetStatusEvent.NET_STATUS, this.onNetStatus, false);
            if (event.info.code == "NetStream.Play.Start")
            {
                _content = this.stream;
                _loc_2 = new Event(Event.OPEN);
                this.onStartedHandler(_loc_2);
            }
            else if (event.info.code == "NetStream.Play.StreamNotFound")
            {
                onErrorHandler(_createErrorEvent(new Error("[VideoItem] NetStream not found at " + this.url.url)));
            }
            return;
        }// end function

        function onVideoMetadata(param1) : void
        {
            this._metaData = param1;
            return;
        }// end function

        public function get metaData() : Object
        {
            return this._metaData;
        }// end function

        public function get checkPolicyFile() : Object
        {
            return this._checkPolicyFile;
        }// end function

        private function fireCanBeginStreamingEvent() : void
        {
            if (this._canBeginStreaming)
            {
                return;
            }
            this._canBeginStreaming = true;
            var _loc_1:* = new Event(BulkLoader.CAN_BEGIN_PLAYING);
            dispatchEvent(_loc_1);
            return;
        }// end function

        public function get canBeginStreaming() : Boolean
        {
            return this._canBeginStreaming;
        }// end function

    }
}
