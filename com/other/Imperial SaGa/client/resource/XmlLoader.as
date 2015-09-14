package resource
{
    import develop.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import utility.*;

    public class XmlLoader extends Object
    {
        private var _xml:XML = null;
        private var _loader:URLLoader;
        private var _filePath:String;
        private var _cbComplete:Function;
        private var _bRemoveEvent:Boolean;
        private var _resData:ByteArray;
        private var _bComplete:Boolean;
        private var _bExpansion:Boolean;
        private var _bNotEncryption:Boolean;
        private var _retry:int;
        private static const _RETRY_MAX:int = 3;

        public function XmlLoader()
        {
            this._resData = new ByteArray();
            this._retry = 0;
            return;
        }// end function

        public function get xml() : XML
        {
            return this._xml;
        }// end function

        public function get bLoaded() : Boolean
        {
            return this._resData.length > 0 || this._bComplete;
        }// end function

        public function get bComplete() : Boolean
        {
            return this._bComplete;
        }// end function

        public function set bNotEncryption(param1:Boolean) : void
        {
            this._bNotEncryption = param1;
            return;
        }// end function

        public function release() : void
        {
            this._resData.clear();
            if (this._loader != null)
            {
                this.removeEvent();
                this._loader = null;
            }
            this._xml = null;
            return;
        }// end function

        public function load(param1:String, param2:Function, param3:Boolean) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._cbComplete = param2;
            var _loc_4:* = Main.GetApplicationData().isNotResourceDifficultToRead();
            if (Main.GetApplicationData().isNotResourceDifficultToRead() == false && this._bNotEncryption == false)
            {
                _loc_5 = "";
                _loc_6 = param1.split("/");
                for each (_loc_7 in _loc_6)
                {
                    
                    if (_loc_5.length != 0)
                    {
                        _loc_5 = _loc_5 + "/";
                    }
                    _loc_5 = _loc_5 + Md5Hash.getHashValue(_loc_7);
                }
                param1 = _loc_5;
            }
            this._filePath = param1;
            this._bRemoveEvent = false;
            this._bComplete = false;
            this._bExpansion = param3;
            this._retry = 0;
            this.loadRequest();
            return;
        }// end function

        private function loadRequest() : void
        {
            var _loc_1:* = Main.GetApplicationData().loadPath;
            _loc_1 = _loc_1 + this._filePath;
            var _loc_2:* = new URLRequest(_loc_1);
            this._loader = new URLLoader();
            this._loader.addEventListener(Event.COMPLETE, this.loaderComplete);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.loaderIoError);
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loaderSecurityError);
            this._loader.dataFormat = URLLoaderDataFormat.BINARY;
            this._loader.load(_loc_2);
            return;
        }// end function

        private function removeEvent() : void
        {
            if (this._bRemoveEvent == false)
            {
                this._loader.removeEventListener(Event.COMPLETE, this.loaderComplete);
                this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.loaderIoError);
                this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loaderSecurityError);
                this._bRemoveEvent = true;
            }
            return;
        }// end function

        private function loadRetry() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._retry + 1;
            _loc_1._retry = _loc_2;
            this.loadRequest();
            return;
        }// end function

        private function loaderIoError(event:IOErrorEvent) : void
        {
            DebugLog.print("XML読み込み失敗");
            this.removeEvent();
            if (this._retry < _RETRY_MAX)
            {
                this.loadRetry();
                return;
            }
            var _loc_2:* = "リストデータの読み込みに失敗しました\n";
            _loc_2 = _loc_2 + ("Code:" + event.errorID);
            Assert.print(_loc_2);
            return;
        }// end function

        private function loaderSecurityError(event:SecurityErrorEvent) : void
        {
            DebugLog.print("XML読み込み失敗:" + event.text);
            this.removeEvent();
            if (this._retry < _RETRY_MAX)
            {
                this.loadRetry();
                return;
            }
            var _loc_2:* = "リストデータの読み込みに失敗しました\n";
            _loc_2 = _loc_2 + ("Code:" + event.errorID);
            Assert.print(_loc_2);
            return;
        }// end function

        private function loaderComplete(event:Event) : void
        {
            this.removeEvent();
            var _loc_2:* = event.currentTarget as URLLoader;
            var _loc_3:* = _loc_2.data as ByteArray;
            _loc_3.position = 0;
            this._resData.writeBytes(_loc_3);
            this._resData.position = 0;
            _loc_3.clear();
            if (this._bExpansion)
            {
                this.restoration();
                return;
            }
            ResourceManager.getInstance().addLoadedXml(this);
            return;
        }// end function

        public function restoration() : void
        {
            var xmlData:String;
            var mes:String;
            if (this._resData.length == 0)
            {
                return;
            }
            try
            {
                this._resData = Crypt.decryptionResource(Blowfish.fixationKeyResource, this._resData, this._bNotEncryption);
                xmlData = this._resData.readUTFBytes(this._resData.length);
                this._xml = new XML(xmlData);
                if (this._cbComplete != null)
                {
                    this._cbComplete(this._xml);
                }
                this._resData.clear();
                this._bComplete = true;
            }
            catch (e:Error)
            {
                DebugLog.print("XML分解エラー");
                mes;
                mes = mes + ("Code:" + e.errorID);
                Assert.print(mes);
            }
            return;
        }// end function

    }
}
