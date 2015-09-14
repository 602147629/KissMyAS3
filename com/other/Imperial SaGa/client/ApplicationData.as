package 
{
    import develop.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import user.*;

    public class ApplicationData extends Object
    {
        private var _gameId:int;
        private var _worldId:int;
        private var _timeToolUrl:String;
        private var _sessionId:String;
        private var _userConfigData:UserConfigData;
        private var _maintenanceData:MaintenanceData;
        private var _startUpParams:Object;
        private var _bLogin:Boolean;
        private var _serverTime:uint;
        private var _measureTime:uint;
        private var _aVersion:Array;
        private var _configData:Object;
        private var _cbLoaded:Function;
        private var _loadPath:String;
        private const _configObject:Object;
        private var _loginBonusGetTime:uint;
        private var _throttleState:String;
        private var _throttleFrameRate:Number;

        public function ApplicationData(param1:Main)
        {
            this._configObject = {configFile:"config.txt"};
            this._startUpParams = new Object();
            this._timeToolUrl = "";
            this._sessionId = "";
            this._aVersion = new Array();
            this._userConfigData = new UserConfigData();
            this._userConfigData.init(param1.stage);
            this._maintenanceData = new MaintenanceData();
            this._loadPath = "";
            this._configData = this._configObject;
            this._loginBonusGetTime = 0;
            param1.stage.addEventListener(ThrottleEvent.THROTTLE, this.stage_throttle);
            this._throttleState = ThrottleType.RESUME;
            this._throttleFrameRate = Constant.FPS;
            return;
        }// end function

        public function setGameData(param1:int, param2:int) : void
        {
            this._gameId = param1;
            this._worldId = param2;
            return;
        }// end function

        public function checkChargeJumpEnable() : Boolean
        {
            var _loc_1:* = UserDataManager.getInstance().userData.channel;
            var _loc_2:* = null;
            if (_loc_1 != null && _loc_1 != "")
            {
                _loc_2 = this.getConfigValue("chargeUrl_" + _loc_1) as String;
            }
            else
            {
                _loc_2 = this.getConfigValue("chargeUrl") as String;
            }
            return _loc_2 != null && _loc_2 != "";
        }// end function

        public function getChargeJumpUrl() : String
        {
            var _loc_1:* = "";
            var _loc_2:* = UserDataManager.getInstance().userData.channel;
            var _loc_3:* = null;
            if (_loc_2 != null && _loc_2 != "")
            {
                _loc_3 = this.getConfigValue("chargeUrl_" + _loc_2) as String;
            }
            else
            {
                _loc_3 = this.getConfigValue("chargeUrl") as String;
            }
            if (_loc_3 != null)
            {
                _loc_1 = _loc_3;
            }
            var _loc_4:* = _loc_1;
            return _loc_1;
        }// end function

        public function getHelpJumpUrl() : String
        {
            var _loc_3:* = null;
            var _loc_1:* = "http://www.imperialsaga.jp/help";
            var _loc_2:* = UserDataManager.getInstance().userData.channel;
            if (_loc_2 != null && _loc_2 != "")
            {
                _loc_3 = this.getConfigValue("helpUrl_" + _loc_2) as String;
            }
            else
            {
                _loc_3 = this.getConfigValue("helpUrl") as String;
            }
            if (_loc_3 != null)
            {
                _loc_1 = _loc_3;
            }
            return _loc_1;
        }// end function

        public function getOfficialJumpUrl() : String
        {
            var _loc_3:* = null;
            var _loc_1:* = "http://www.imperialsaga.jp/";
            var _loc_2:* = UserDataManager.getInstance().userData.channel;
            if (_loc_2 != null && _loc_2 != "")
            {
                _loc_3 = this.getConfigValue("officialUrl_" + _loc_2) as String;
            }
            else
            {
                _loc_3 = this.getConfigValue("officialUrl") as String;
            }
            if (_loc_3 != null)
            {
                _loc_1 = _loc_3;
            }
            return _loc_1;
        }// end function

        public function setTimeToolUrl(param1:String) : void
        {
            this._timeToolUrl = param1 != null ? (param1) : ("");
            return;
        }// end function

        public function getTimeToolUrl() : String
        {
            var _loc_1:* = this.startUpParams["netcafe"];
            if (_loc_1)
            {
                return this._timeToolUrl;
            }
            return "";
        }// end function

        public function get sessionId() : String
        {
            return this._sessionId;
        }// end function

        public function setSessionId(param1:String) : void
        {
            this._sessionId = param1;
            return;
        }// end function

        public function get userConfigData() : UserConfigData
        {
            return this._userConfigData;
        }// end function

        public function get maintenanceData() : MaintenanceData
        {
            return this._maintenanceData;
        }// end function

        public function setMaintenanceData(param1:Object) : void
        {
            if (this._maintenanceData)
            {
                this._maintenanceData.setRecive(param1);
            }
            return;
        }// end function

        public function get startUpParams() : Object
        {
            return this._startUpParams;
        }// end function

        public function get bLogin() : Boolean
        {
            return this._bLogin;
        }// end function

        public function set bLogin(param1:Boolean) : void
        {
            this._bLogin = param1;
            return;
        }// end function

        public function get serverTime() : uint
        {
            return this._serverTime;
        }// end function

        public function get measureTime() : uint
        {
            return this._measureTime;
        }// end function

        public function getConfigValue(param1:String)
        {
            return this._configData[param1];
        }// end function

        public function get loadPath() : String
        {
            return this._loadPath;
        }// end function

        public function setLoadPath(param1:String) : void
        {
            var _loc_2:* = param1.split("/");
            this._loadPath = "";
            var _loc_3:* = 0;
            while (_loc_3 < (_loc_2.length - 1))
            {
                
                if (this._loadPath.length != 0)
                {
                    this._loadPath = this._loadPath + "/";
                }
                this._loadPath = this._loadPath + _loc_2[_loc_3];
                _loc_3++;
            }
            this._loadPath = this._loadPath + "/";
            return;
        }// end function

        public function get loginBonusGetTime() : uint
        {
            return this._loginBonusGetTime;
        }// end function

        public function set loginBonusGetTime(param1:uint) : void
        {
            this._loginBonusGetTime = param1;
            return;
        }// end function

        public function get throttleState() : String
        {
            return this._throttleState;
        }// end function

        public function get throttleFrameRate() : Number
        {
            return this._throttleFrameRate;
        }// end function

        public function setStartUpParam(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1 == null)
            {
                return;
            }
            for (_loc_2 in param1)
            {
                
                if (_loc_2 == "data")
                {
                    _loc_3 = param1[_loc_2];
                    _loc_4 = /@""@/g;
                    _loc_3 = _loc_3.replace(_loc_4, "+");
                    _loc_4 = /_""_/g;
                    _loc_3 = _loc_3.replace(_loc_4, "/");
                    this._startUpParams[_loc_2] = _loc_3;
                    continue;
                }
                this._startUpParams[_loc_2] = param1[_loc_2];
            }
            return;
        }// end function

        public function isNotNetEncryption() : Boolean
        {
            return false;
        }// end function

        public function isNotResourceDifficultToRead() : Boolean
        {
            return false;
        }// end function

        public function isNotResourceEncryption() : Boolean
        {
            return false;
        }// end function

        public function setServerTime(param1:uint) : void
        {
            this._serverTime = param1;
            this._measureTime = getTimer();
            return;
        }// end function

        public function addVersion(param1:VersionInfo) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aVersion)
            {
                
                if (_loc_2.id == param1.id)
                {
                    return;
                }
            }
            this._aVersion.push(param1);
            return;
        }// end function

        public function checkVersion(param1:Array) : String
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = "";
            return _loc_2;
            if (param1.length == 0 || this._aVersion.length == 0)
            {
                _loc_2 = "バージョン情報が有りません";
                return _loc_2;
            }
            if (param1.length != this._aVersion.length)
            {
                _loc_2 = _loc_2 + "バージョンチェックの回数が間違っています";
            }
            return _loc_2;
        }// end function

        private function versionType(param1:int) : String
        {
            var _loc_2:* = "";
            switch(param1)
            {
                case CommonConstant.PARAMETER_VERSION_PLAYER:
                {
                    _loc_2 = "プレイヤーパラメーター";
                    break;
                }
                case CommonConstant.PARAMETER_VERSION_ENEMY:
                {
                    _loc_2 = "エネミーパラメーター";
                    break;
                }
                case CommonConstant.PARAMETER_VERSION_SKILL:
                {
                    _loc_2 = "スキルパラメーター";
                    break;
                }
                case CommonConstant.PARAMETER_VERSION_FORMATION:
                {
                    _loc_2 = "陣形パラメータ";
                    break;
                }
                case CommonConstant.PARAMETER_VERSION_ITEM:
                {
                    _loc_2 = "アイテム";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function loadConfig(param1:Function) : void
        {
            this._cbLoaded = param1;
            var _loc_2:* = new URLLoader();
            _loc_2.addEventListener(Event.COMPLETE, this.cbComplete);
            _loc_2.addEventListener(IOErrorEvent.IO_ERROR, this.cbIoError);
            _loc_2.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.cbSecurityError);
            _loc_2.load(new URLRequest(this._loadPath + String(this.getConfigValue("configFile"))));
            return;
        }// end function

        private function loadEnd(param1:URLLoader) : void
        {
            param1.removeEventListener(Event.COMPLETE, this.cbComplete);
            param1.removeEventListener(IOErrorEvent.IO_ERROR, this.cbIoError);
            param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.cbSecurityError);
            this._cbLoaded();
            return;
        }// end function

        private function cbComplete(event:Event) : void
        {
            var _loc_2:* = event.target as URLLoader;
            this.configFileDecomposition(_loc_2.data);
            this.loadEnd(_loc_2);
            return;
        }// end function

        private function cbSecurityError(event:SecurityErrorEvent) : void
        {
            DebugLog.print("Config File SECURITY_ERROR -> " + event.errorID + ":" + event.text);
            this.loadEnd(event.target as URLLoader);
            return;
        }// end function

        private function cbIoError(event:IOErrorEvent) : void
        {
            DebugLog.print("Config File IO_ERROR -> " + event.errorID + ":" + event.text);
            this.loadEnd(event.target as URLLoader);
            return;
        }// end function

        private function configFileDecomposition(param1:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = NaN;
            var _loc_12:* = false;
            var _loc_2:* = param1.split("\r\n");
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3 == "")
                {
                    continue;
                }
                if (_loc_3.length == 1)
                {
                    continue;
                }
                if (_loc_3.indexOf("//") == 0)
                {
                    continue;
                }
                _loc_4 = _loc_3.split("=");
                if (_loc_4.length < 2)
                {
                    continue;
                }
                _loc_5 = _loc_4[0];
                _loc_5 = _loc_5.replace(new RegExp(/( |\	t)""( |\t)/g), "");
                _loc_6 = _loc_4[1];
                _loc_7 = 2;
                while (_loc_7 < _loc_4.length)
                {
                    
                    _loc_6 = _loc_6 + ("=" + _loc_4[_loc_7]);
                    _loc_7++;
                }
                _loc_8 = _loc_6.indexOf("\"");
                if (_loc_8 >= 0)
                {
                    _loc_9 = _loc_6.lastIndexOf("\"");
                    if (_loc_9 >= 0)
                    {
                        _loc_6 = _loc_6.slice((_loc_8 + 1), _loc_9);
                        this._configData[_loc_5] = _loc_6;
                    }
                    continue;
                }
                if (this.isArray(_loc_6))
                {
                    _loc_10 = this.getArray(_loc_6);
                    this._configData[_loc_5] = _loc_10;
                    continue;
                }
                _loc_11 = parseFloat(_loc_6);
                if (isNaN(_loc_11) == false)
                {
                    this._configData[_loc_5] = _loc_11;
                    continue;
                }
                if (_loc_6.indexOf("false") != -1)
                {
                    _loc_6 = "";
                }
                _loc_12 = Boolean(_loc_6);
                this._configData[_loc_5] = _loc_12;
            }
            return;
        }// end function

        private function isArray(param1:String) : Boolean
        {
            var _loc_2:* = param1.indexOf("[");
            var _loc_3:* = param1.lastIndexOf("]");
            if (_loc_2 >= 0 && _loc_3 >= 0)
            {
                return true;
            }
            return false;
        }// end function

        private function getArray(param1:String) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = param1.indexOf("[");
            var _loc_4:* = param1.lastIndexOf("]");
            param1 = param1.slice((_loc_3 + 1), _loc_4);
            _loc_2 = param1.split(",");
            return _loc_2;
        }// end function

        private function stage_throttle(event:ThrottleEvent) : void
        {
            this._throttleState = event.state;
            this._throttleFrameRate = event.targetFrameRate;
            return;
        }// end function

    }
}
