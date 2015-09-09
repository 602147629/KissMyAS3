package com.fileload.loadingtypes
{
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;

    public class SoundItem extends LoadingItem
    {
        public var loader:Sound;

        public function SoundItem(param1:URLRequest, param2:String, param3:String)
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
            this.loader = new Sound();
            this.loader.addEventListener(ProgressEvent.PROGRESS, onProgressHandler, false, 0, true);
            this.loader.addEventListener(Event.COMPLETE, this.onCompleteHandler, false, 0, true);
            this.loader.addEventListener(IOErrorEvent.IO_ERROR, this.onErrorHandler, false, 0, true);
            this.loader.addEventListener(Event.OPEN, this.onStartedHandler, false, 0, true);
            this.loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, super.onSecurityErrorHandler, false, 0, true);
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

        override public function onStartedHandler(event:Event) : void
        {
            _content = this.loader;
            super.onStartedHandler(event);
            return;
        }// end function

        override public function onErrorHandler(event:ErrorEvent) : void
        {
            super.onErrorHandler(event);
            return;
        }// end function

        override public function onCompleteHandler(event:Event) : void
        {
            _content = this.loader;
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
                this.loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onErrorHandler, false);
                this.loader.removeEventListener(BulkLoader.OPEN, this.onStartedHandler, false);
                this.loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, super.onSecurityErrorHandler, false);
            }
            return;
        }// end function

        override public function isStreamable() : Boolean
        {
            return true;
        }// end function

        override public function isSound() : Boolean
        {
            return true;
        }// end function

        override public function destroy() : void
        {
            this.cleanListeners();
            this.stop();
            _content = null;
            this.loader = null;
            return;
        }// end function

    }
}
