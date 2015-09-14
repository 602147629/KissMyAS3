package network
{
    import develop.*;
    import flash.events.*;
    import flash.utils.*;
    import message.*;
    import sound.*;
    import tutorial.*;
    import utility.*;

    public class NetManager extends Object
    {
        private const _ERROR_CODE_MAINTENANCE:int = 2;
        private const _ERROR_CODE_SESSION:int = 12;
        private const _ERROR_CODE_SESSION2:int = 17;
        private const _ERROR_CODE_MULTIPLE_LOGINS:int = 13;
        private const _ERROR_CODE_CROWN_IS_NOT_ENOUGH:int = 22;
        private const _ERROR_CODE_SERVER_ERROR:int = 16;
        private const _GATEWAY_URL:String = "http://test/";
        private var _gatewayUrl:String = "";
        private var _bDummyServer:Boolean;
        private var _aNetTask:Array;
        private var _nowTask:NetTask;
        private var _sender:NetSend;
        private var _bSendEnd:Boolean;
        private var _accessCount:uint;
        public static const FIXED_CODE:uint = 837929560;
        private static var _instance:NetManager = null;

        public function NetManager()
        {
            this._aNetTask = new Array();
            this._nowTask = null;
            this._bDummyServer = false;
            this._gatewayUrl = this._GATEWAY_URL;
            this._accessCount = 0;
            var _loc_1:* = Main.GetApplicationData().getConfigValue("gateway") as String;
            if (_loc_1 != null)
            {
                this._gatewayUrl = _loc_1;
            }
            return;
        }// end function

        public function get gatewayUrl() : String
        {
            return this._gatewayUrl;
        }// end function

        public function get bDummyServer() : Boolean
        {
            return this._bDummyServer;
        }// end function

        public function get accessCount() : uint
        {
            return this._accessCount;
        }// end function

        public function accessCountUp() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._accessCount + 1;
            _loc_1._accessCount = _loc_2;
            return;
        }// end function

        public function init() : void
        {
            return;
        }// end function

        public function request(param1:NetTask) : void
        {
            this._aNetTask.push(param1);
            this.requestFunc();
            return;
        }// end function

        public function isConnected() : Boolean
        {
            return this._nowTask == null && this._aNetTask.length == 0;
        }// end function

        public function getTaskNum() : int
        {
            var _loc_1:* = 0;
            if (this._sender)
            {
                _loc_1 = _loc_1 + (100 - this._sender.getDownLoadProgress());
            }
            _loc_1 = _loc_1 + 100 * this._aNetTask.length;
            return _loc_1;
        }// end function

        public function createParam() : Object
        {
            var _loc_1:* = new Object();
            return _loc_1;
        }// end function

        private function requestFunc() : void
        {
            var res:NetResult;
            var delay:Timer;
            if (this._sender != null || this._nowTask != null || this._aNetTask.length == 0)
            {
                return;
            }
            this._nowTask = this._aNetTask.shift();
            if (TutorialManager.getInstance().isUseTutorialProtocol())
            {
                res;
                switch(this._nowTask.protocolId)
                {
                    case NetId.PROTOCOL_EMPLOYMENT_HIGH:
                    case NetId.PROTOCOL_FORMATION_SET:
                    {
                        res = new NetResult(this._nowTask.protocolId);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (res)
                {
                    DebugLog.print("TUTORIAL_PROTOCOL: TIMER_START");
                    delay = new Timer(100, 1);
                    delay.addEventListener(TimerEvent.TIMER_COMPLETE, function (event:TimerEvent) : void
            {
                DebugLog.print("TUTORIAL_PROTOCOL: TIMER_COMPLETE");
                res.resultCode = NetId.RESULT_OK;
                _nowTask.tutorialProtocol(res);
                DebugLog.print("TUTORIAL_PROTOCOL: RESULT_FUNC[" + res.resultCode + "]");
                resultFunc(res);
                return;
            }// end function
            );
                    delay.start();
                    return;
                }
            }
            this._sender = new NetSend(this._nowTask.protocolId, this._nowTask.param, this.resultFunc);
            return;
        }// end function

        private function resultFunc(param1:NetResult) : void
        {
            var _loc_3:* = null;
            this._bSendEnd = true;
            var _loc_2:* = this._nowTask.receive(param1);
            this.commonRecive(param1);
            if (_loc_2)
            {
                if (this._nowTask.cbReceive != null)
                {
                    this._nowTask.cbReceive(param1);
                }
            }
            else if (param1.resultCode == NetId.RESULT_ERROR_MAINTENANCE)
            {
                SoundManager.getInstance().xmlRestoration();
                Main.GetProcess().createMaintenanceWindow();
            }
            else
            {
                _loc_3 = this.getErrorMessage(param1.resultCode) + "\nPid:" + this._nowTask.protocolId + "\nCode:" + param1.resultCode;
                Assert.print(_loc_3);
            }
            this._nowTask.relelase();
            this._nowTask = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bSendEnd)
            {
                this._bSendEnd = false;
                if (this._sender != null)
                {
                    this._sender.release();
                    this._sender = null;
                }
                this.requestFunc();
            }
            return;
        }// end function

        private function getErrorMessage(param1:int) : String
        {
            var _loc_2:* = "";
            switch(param1)
            {
                case this._ERROR_CODE_MAINTENANCE:
                {
                    _loc_2 = MessageManager.getInstance().getMessage(MessageId.ERROR_CODE_MAINTENANCE);
                    break;
                }
                case this._ERROR_CODE_SESSION:
                case this._ERROR_CODE_SESSION2:
                {
                    _loc_2 = MessageManager.getInstance().getMessage(MessageId.ERROR_CODE_SESSION);
                    break;
                }
                case this._ERROR_CODE_CROWN_IS_NOT_ENOUGH:
                {
                    _loc_2 = MessageManager.getInstance().getMessage(MessageId.ERROR_CODE_CROWN_IS_NOT_ENOUGH);
                    break;
                }
                case this._ERROR_CODE_SERVER_ERROR:
                {
                    _loc_2 = MessageManager.getInstance().getMessage(MessageId.ERROR_CODE_SERVER_ERROR);
                    break;
                }
                default:
                {
                    if (_loc_2 == "")
                    {
                        _loc_2 = MessageManager.getInstance().getMessage(MessageId.ERROR_CONNECTION_ERROR);
                    }
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function commonRecive(param1:NetResult) : void
        {
            if (param1.data.hasOwnProperty("epochTime"))
            {
                Main.GetApplicationData().setServerTime(param1.data.epochTime);
            }
            if (param1.data.maintenanceData != null)
            {
                Main.GetApplicationData().setMaintenanceData(param1.data);
            }
            return;
        }// end function

        public static function getInstance() : NetManager
        {
            if (_instance == null)
            {
                _instance = new NetManager;
            }
            return _instance;
        }// end function

    }
}
