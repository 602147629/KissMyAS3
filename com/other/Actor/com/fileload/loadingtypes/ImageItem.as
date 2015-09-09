package com.fileload.loadingtypes
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;

    public class ImageItem extends LoadingItem
    {
        public var loader:Loader;

        public function ImageItem(param1:URLRequest, param2:String, param3:String)
        {
            specificAvailableProps = [BulkLoader.CONTEXT];
            super(param1, param2, param3);
            return;
        }// end function

        override public function _parseOptions(param1:Object) : Array
        {
            _context = param1[BulkLoader.CONTEXT] || null;
            return super._parseOptions(param1);
        }// end function

        override public function load() : void
        {
            super.load();
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler, false, 0, true);
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onCompleteHandler, false, 0, true);
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onErrorHandler, false, 100, true);
            this.loader.contentLoaderInfo.addEventListener(Event.OPEN, onStartedHandler, false, 0, true);
            this.loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, super.onHttpStatusHandler, false, 0, true);
            try
            {
                this.loader.load(url, _context);
            }
            catch (e:SecurityError)
            {
                onSecurityErrorHandler(_createErrorEvent(e));
            }
            return;
        }// end function

        public function _onHttpStatusHandler(event:HTTPStatusEvent) : void
        {
            _httpStatus = event.status;
            dispatchEvent(event);
            return;
        }// end function

        override public function onErrorHandler(event:ErrorEvent) : void
        {
            super.onErrorHandler(event);
            return;
        }// end function

        override public function onCompleteHandler(event:Event) : void
        {
            var evt:* = event;
            try
            {
                _content = this.loader.content;
                super.onCompleteHandler(evt);
            }
            catch (e:SecurityError)
            {
                _content = loader;
                super.onCompleteHandler(evt);
            }
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
            var _loc_1:* = null;
            if (this.loader)
            {
                _loc_1 = this.loader.contentLoaderInfo;
                _loc_1.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler, false);
                _loc_1.removeEventListener(Event.COMPLETE, this.onCompleteHandler, false);
                _loc_1.removeEventListener(IOErrorEvent.IO_ERROR, this.onErrorHandler, false);
                _loc_1.removeEventListener(BulkLoader.OPEN, onStartedHandler, false);
                _loc_1.removeEventListener(HTTPStatusEvent.HTTP_STATUS, super.onHttpStatusHandler, false);
            }
            return;
        }// end function

        override public function isImage() : Boolean
        {
            return type == BulkLoader.TYPE_IMAGE;
        }// end function

        override public function isSWF() : Boolean
        {
            return type == BulkLoader.TYPE_MOVIECLIP;
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
