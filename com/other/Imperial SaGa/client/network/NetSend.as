package network
{
    import com.hurlant.util.*;
    import develop.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import user.*;
    import utility.*;

    public class NetSend extends Object
    {
        private var _protocolId:int;
        private var _param:Object;
        private var _cbResultFunc:Function;
        private var _downLoadTotal:uint;
        private var _downLoadNow:uint;
        private var _loader:URLLoader;
        private var _retry:int;
        private static const _RETRY_MAX:int = 3;

        public function NetSend(param1:int, param2:Object, param3:Function)
        {
            this._protocolId = param1;
            this._param = param2;
            this._param.protocolId = this._protocolId;
            this._cbResultFunc = param3;
            this._downLoadTotal = 0;
            this._downLoadNow = 0;
            this._retry = 0;
            this.send();
            return;
        }// end function

        public function getDownLoadProgress() : int
        {
            return this._downLoadTotal > 0 ? (100 * this._downLoadNow / this._downLoadTotal) : (0);
        }// end function

        public function release() : void
        {
            this._param = null;
            this._cbResultFunc = null;
            this._loader = null;
            return;
        }// end function

        private function removeEvent() : void
        {
            this._loader.removeEventListener(Event.COMPLETE, this.cbComplete);
            this._loader.removeEventListener(ProgressEvent.PROGRESS, this.cbProgress);
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.cbIoError);
            this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.cbSecurityError);
            return;
        }// end function

        private function send() : void
        {
            var _loc_6:* = false;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_1:* = new URLVariables();
            var _loc_2:* = UserDataManager.getInstance().userData;
            _loc_1.userId = _loc_2.userId;
            _loc_1.sessionId = Main.GetApplicationData().sessionId;
            this._param.accessCount = NetManager.getInstance().accessCount;
            var _loc_3:* = JSON.stringify(this._param);
            var _loc_4:* = Main.GetApplicationData().isNotNetEncryption();
            if (Main.GetApplicationData().isNotNetEncryption() == false)
            {
                _loc_6 = this._protocolId == NetId.PROTOCOL_LOGIN;
                if (_loc_6)
                {
                    Blowfish.createFixitionKey();
                }
                _loc_7 = new ByteArray();
                _loc_7.writeUTFBytes(_loc_3);
                _loc_3 = "";
                _loc_7.position = _loc_7.length;
                _loc_7.writeUnsignedInt(NetManager.FIXED_CODE);
                _loc_8 = Crc32.calc(_loc_7);
                _loc_7.length = _loc_7.length - 4;
                _loc_7.position = _loc_7.length;
                _loc_7.writeUnsignedInt(_loc_8);
                _loc_7.compress();
                _loc_9 = Crypt.encryption(Blowfish.fixationKey, _loc_7);
                _loc_1.data = (_loc_6 ? ("i:") : ("n:")) + Base64.encodeByteArray(_loc_9);
            }
            else
            {
                _loc_1.data = _loc_3;
            }
            var _loc_5:* = new URLRequest(NetManager.getInstance().gatewayUrl);
            new URLRequest(NetManager.getInstance().gatewayUrl).method = URLRequestMethod.POST;
            _loc_5.data = _loc_1;
            this._loader = new URLLoader();
            this._loader.addEventListener(Event.COMPLETE, this.cbComplete);
            this._loader.addEventListener(ProgressEvent.PROGRESS, this.cbProgress);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.cbIoError);
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.cbSecurityError);
            this._loader.dataFormat = URLLoaderDataFormat.BINARY;
            this._loader.load(_loc_5);
            NetManager.getInstance().accessCountUp();
            return;
        }// end function

        private function sendRetry() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._retry + 1;
            _loc_1._retry = _loc_2;
            this.send();
            return;
        }// end function

        private function cbSecurityError(event:SecurityErrorEvent) : void
        {
            this.removeEvent();
            if (this._retry < _RETRY_MAX)
            {
                this.sendRetry();
                return;
            }
            var _loc_2:* = new NetResult(this._protocolId);
            _loc_2.resultCode = NetId.RESULT_SECURITY_ERROR;
            this._cbResultFunc(_loc_2);
            return;
        }// end function

        private function cbIoError(event:IOErrorEvent) : void
        {
            this.removeEvent();
            if (this._retry < _RETRY_MAX)
            {
                this.sendRetry();
                return;
            }
            var _loc_2:* = new NetResult(this._protocolId);
            _loc_2.resultCode = NetId.RESULT_IO_ERROR;
            this._cbResultFunc(_loc_2);
            return;
        }// end function

        private function cbProgress(event:ProgressEvent) : void
        {
            var _loc_2:* = event.bytesTotal;
            if (this._downLoadTotal < _loc_2)
            {
                this._downLoadTotal = _loc_2;
            }
            var _loc_3:* = event.bytesLoaded;
            if (this._downLoadNow < _loc_3)
            {
                this._downLoadNow = _loc_3;
            }
            return;
        }// end function

        private function cbComplete(event:Event) : void
        {
            var jsonData:String;
            var ret:Object;
            var result:NetResult;
            var l:URLLoader;
            var param:ByteArray;
            var code:String;
            var bNotEncryption:Boolean;
            var receiveData:ByteArray;
            var connectionResult:int;
            var data:ByteArray;
            var crc:uint;
            var crcLocal:uint;
            var e:* = event;
            this.removeEvent();
            this._downLoadNow = this._downLoadTotal;
            try
            {
                result = new NetResult(this._protocolId);
                l = e.target as URLLoader;
                param = l.data as ByteArray;
                param.position = 0;
                if (param.length < 4)
                {
                    result.resultCode = NetId.RESULT_ERROR_CONNECTION;
                    this._cbResultFunc(result);
                    return;
                }
                code = param.toString();
                bNotEncryption = Main.GetApplicationData().isNotNetEncryption();
                if (bNotEncryption == false)
                {
                    receiveData = Base64.decodeToByteArray(code);
                    receiveData.position = 0;
                    connectionResult = receiveData.readInt();
                    result.resultCode = connectionResult;
                    if (connectionResult != NetId.RESULT_OK)
                    {
                        DebugLog.print("connectionResult:" + connectionResult);
                    }
                    if (connectionResult != NetId.RESULT_ERROR_LOGOUT && connectionResult != NetId.RESULT_ERROR_MULTIPLE_LOGINS && connectionResult != NetId.RESULT_ERROR_CUT_SESSION)
                    {
                        readByteDelete(receiveData);
                        data = Crypt.decryption(Blowfish.fixationKey, receiveData);
                        data.uncompress();
                        data.position = data.length - 4;
                        crc = data.readUnsignedInt();
                        data.position = data.length - 4;
                        data.writeUnsignedInt(NetManager.FIXED_CODE);
                        crcLocal = Crc32.calc(data);
                        if (crc != crcLocal)
                        {
                            result.resultCode = NetId.RESULT_ERROR_CRC;
                            this._cbResultFunc(result);
                            return;
                        }
                        data.length = data.length - 4;
                        data.position = 0;
                        jsonData = data.readUTFBytes(data.length);
                        ret = JSON.parse(jsonData);
                        result.data = ret.data;
                    }
                }
                else
                {
                    jsonData = code;
                    ret = JSON.parse(jsonData);
                    result.resultCode = ret.result;
                    result.data = ret.data;
                }
                this._cbResultFunc(result);
            }
            catch (e:Error)
            {
                Assert.printError(e, e.message);
            }
            return;
        }// end function

        public static function readByteDelete(param1:ByteArray) : void
        {
            var _loc_2:* = new ByteArray();
            param1.readBytes(_loc_2, 0, param1.bytesAvailable);
            param1.clear();
            _loc_2.readBytes(param1);
            return;
        }// end function

    }
}
