﻿package com.fileload.loadingtypes
{
    import flash.events.*;
    import flash.net.*;

    public class URLItem extends LoadingItem
    {
        public var loader:URLLoader;

        public function URLItem(param1:URLRequest, param2:String, param3:String)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function _parseOptions(param1:Object) : Array
        {
            return super._parseOptions(param1);
        }// end function

        override public function load() : void
        {
            super.load();
            this.loader = new URLLoader();
            this.loader.addEventListener(ProgressEvent.PROGRESS, onProgressHandler, false, 0, true);
            this.loader.addEventListener(Event.COMPLETE, this.onCompleteHandler, false, 0, true);
            this.loader.addEventListener(IOErrorEvent.IO_ERROR, super.onErrorHandler, false, 0, true);
            this.loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, super.onHttpStatusHandler, false, 0, true);
            this.loader.addEventListener(Event.OPEN, this.onStartedHandler, false, 0, true);
            try
            {
                this.loader.load(url);
            }
            catch (e:SecurityError)
            {
                onSecurityErrorHandler(_createErrorEvent(e));
            }
            return;
        }// end function

        override public function onStartedHandler(event:Event) : void
        {
            super.onStartedHandler(event);
            return;
        }// end function

        override public function onCompleteHandler(event:Event) : void
        {
            _content = this.loader.data;
            super.onCompleteHandler(event);
            return;
        }// end function

        override public function stop() : void
        {
            try
            {
                if (this.loader)
                {
                    this.loader.close();
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
            if (this.loader)
            {
                this.loader.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler, false);
                this.loader.removeEventListener(Event.COMPLETE, this.onCompleteHandler, false);
                this.loader.removeEventListener(IOErrorEvent.IO_ERROR, onErrorHandler, false);
                this.loader.removeEventListener(BulkLoader.OPEN, this.onStartedHandler, false);
                this.loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, super.onHttpStatusHandler, false);
            }
            return;
        }// end function

        override public function isText() : Boolean
        {
            return true;
        }// end function

        override public function destroy() : void
        {
            this.stop();
            this.cleanListeners();
            _content = null;
            this.loader = null;
            return;
        }// end function

    }
}
