package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import lovefox.buffer.*;
    import lovefox.isometric.*;
    import lovefox.title.*;
    import lovefox.unit.*;

    public class Main extends Sprite
    {
        private static var _localToWeb:Boolean = false;
        public static var _baseURL:String;
        public static var _buffComplete:Boolean = false;
        public static var _enterGameFlag:Boolean = false;
        public static var _unitMap:Object = {};
        public static var _main:Main;
        public static var _mapInitX:Object = 0;
        public static var _mapUiX:Object = -120;
        public static var _temp:Object;
        public static var _temp1:Object;
        public static var _eventTile:LogicalTile;
        private static var _loginBtn1:Sprite;
        private static var _loginBtn2:Sprite;
        public static var _preMapId:Number = 0;
        private static var _firstLoadingPic:Object;
        private static var _checkJsTimer:Object;
        public static var _loginMode:Object;
        private static var _outmode:Object;
        private static var _verLoadCount:int = 0;
        public static var _data1Complete:Boolean = false;
        private static var _loginSubComplete:Boolean = false;
        public static var _gameServerComplete:Boolean = false;
        public static var _uiComplete:Boolean = false;
        private static var _realEnterCount:int = 2;
        private static var _firstMapLoading:Boolean = true;
        private static var _thanksCount:uint = 0;
        private static var _thanksIndex:uint = 0;
        private static var _thanksArray:Array = [];
        private static var _titleSet:TextSet;
        private static var _title:String = "仙境·幻想";
        private static var _subtitle:String = "paradise fantasy";
        private static var _defaultPrologue:String = "人是何时出现在这片大地的,古老的索尼奥;在时间的流动中,人一出生就有了自己的命运;神所选中的人,出现在传说的舞台上;他们的英雄事迹,永远不会褪色;然而大地正在改变,混乱驱逐着秩序;善与恶争夺着,人心共鸣虽然灾祸降世,荣耀蒙上阴影;但人们决不会坐以待毙,寻求希望;少年迈上冒险的旅程你也是其中之一;在那里,一定有,你追寻的东西";

        public function Main()
        {
            var _loc_1:* = new ContextMenu();
            _loc_1.hideBuiltInItems();
            this.contextMenu = _loc_1;
            this.focusRect = false;
            Security.allowDomain("*");
            _main = this;
            Component.initStage(stage);
            Config.stage = stage;
            Config.main = this;
            Loading.resize(1000, 500);
            Loading.open();
            Text2Bitmap.init();
            this.checkMode();
            return;
        }// end function

        private function thanksLoop(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            if (_thanksCount % 100 == 1 && _thanksIndex < _thanksArray.length)
            {
                _loc_2 = 0;
                if (Math.random() < 0.5)
                {
                    _loc_2 = 1;
                }
                if (_loc_2 == 0)
                {
                    _loc_3 = Math.floor(Math.random() * (stage.stageWidth - 200) + 100);
                    if (Math.random() < 0.5)
                    {
                        _loc_4 = Math.floor(Math.random() * (stage.stageHeight / 2 - 100) + 20);
                    }
                    else
                    {
                        _loc_4 = Math.floor(stage.stageHeight / 2 + Math.random() * (stage.stageHeight / 2 - 150) + 100 - 20);
                    }
                }
                else
                {
                    if (Math.random() < 0.5)
                    {
                        _loc_3 = Math.floor(Math.random() * (stage.stageWidth / 2 - 200) + 20);
                    }
                    else
                    {
                        _loc_3 = Math.floor(stage.stageWidth / 2 + Math.random() * (stage.stageWidth / 2 - 200) + 200 - 20);
                    }
                    _loc_4 = Math.floor(Math.random() * (stage.stageHeight - 200) + 100);
                }
                _loc_5 = _thanksArray[_thanksIndex++];
                if (_loc_3 < stage.stageWidth / 2)
                {
                    _loc_6 = new TextSet(_loc_5[0], _loc_5[1]);
                }
                else
                {
                    _loc_6 = new TextSet(_loc_5[0], _loc_5[1], 16777215, 16, 1);
                }
                _loc_6.x = _loc_3;
                _loc_6.y = _loc_4;
                stage.addChild(_loc_6);
            }
            var _loc_8:* = _thanksCount + 1;
            _thanksCount = _loc_8;
            return;
        }// end function

        private function checkJavaScriptReady() : Boolean
        {
            var _loc_1:* = ExternalInterface.call("isReady");
            return _loc_1;
        }// end function

        private function checkMode()
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_1:* = LoaderInfo(stage.loaderInfo).parameters;
            _outmode = String(_loc_1.mode);
            if (_localToWeb)
            {
                _loginMode = 0;
                Config.loginName = "278928293";
                Config.loginPass = "{\"sso\":\"CqIvtkVJianERV73dWQA_aPIpICx66XSC2QkdvWr.UYxDWjdM76QoG9AE79KCu32hPGYUJYtk8DJFg23gtY_-D_EXnlcETCIheQJTAO9vsFvQ4ewN3vAuAeAaAUqFWuIASprV8McEH2iWNYQDUaiaUChX.sd82-icASr3qpS9G80\",\"person\":\"fbYXiLJbUMhUElc.DLmeUJ_G_EHHRtTbRgS9vbBHUG3Rgk4eKTYROsXQj93GKMnlYXVgNxRts71Tu2qZwmmXsuYr2nefqfRM6JA977E4pX_o6.YNa12MSBfwdDww2F3bAbk.5zqUzj5spo2NhfGFyXEJwjzLR2CdNwXzdPPJtfS-rGcc78obo3rF1DkwHLDiTZQ-BO14fumSRKP4yQt6NKQRLvYwDlBm7.IVHZto3DhIDPV8XZnMAUNn7kJa.f6r3CaTbLJjtJvLmXVegqUrEK-oqVQTOJkcO9RyLXlIcBs0\"}";
                _loc_2 = "14.17.124.160:443".split(":");
                Config.loginIp = _loc_2[0];
                Config.loginPort = Number(_loc_2[1]);
                Config.sourceURL = "http://t13.xj.kunlun.com/";
                _thanksArray = [];
                _loc_3 = _defaultPrologue.split(";");
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    _thanksArray[_loc_4] = _loc_3[_loc_4].split(",");
                    _loc_4++;
                }
                this.init();
            }
            else if (_outmode != "local" && ExternalInterface.available)
            {
                _loginMode = 0;
                this.checkJS();
            }
            else
            {
                _loginMode = 1;
                _loc_3 = ["game_config.xml"];
                _loc_5 = new XMLLoader();
                _loc_5.addEventListener("complete", this.subCons);
                _loc_5.load(_loc_3);
            }
            return;
        }// end function

        private function getJs(param1)
        {
            var str:* = param1;
            try
            {
                return ExternalInterface.call(str);
            }
            catch (e)
            {
                return "";
            }
            return;
        }// end function

        private function checkJS(param1 = null)
        {
            var person:*;
            var sso:*;
            var loginServer:*;
            var ver:*;
            var prologueStr:String;
            var timezoneStr:String;
            var defaultSwitch:Boolean;
            var switchNum:Number;
            var defaultSwitchNum:int;
            var arr:Array;
            var i:int;
            var now:Date;
            var offset:int;
            var event:* = param1;
            clearTimeout(_checkJsTimer);
            if (this.checkJavaScriptReady())
            {
                try
                {
                    ExternalInterface.call("onMainStart");
                }
                catch (e)
                {
                }
                Config._autoEnterGameIn30 = this.getJs("DirectLoginGame");
                Config.loginName = this.getJs("getPassportId");
                person = this.getCookie("KL_PERSON");
                sso = this.getCookie("KL_SSO");
                Config.loginPass = "{\"sso\":\"" + sso + "\",\"person\":\"" + person + "\"}";
                loginServer = this.getJs("getServerAddress").split(":");
                Config.loginIp = loginServer[0];
                Config.loginPort = Number(loginServer[1]);
                Config.gameId = this.getJs("getGameId");
                Config.regionId = this.getJs("getRegionId");
                Config.payURL = this.getJs("getPayUrl");
                Config.vipURL = this.getJs("getVipUrl");
                Config.navURL = this.getJs("getNavUrl");
                Config.serverName = this.getJs("getServerName");
                if (Config.serverName == "")
                {
                    Config.serverName = Config.navURL;
                }
                Config.sourceURL = this.getJs("getCdnUrl");
                Config.replayURL = this.getJs("getVideoUrl");
                Config.bardURL = Config.replayURL + "bard/";
                ver = this.getJs("getVer");
                if (ver != "")
                {
                    Config.ver = ver;
                }
                Config._ogfs = this.getJs("getOgfsUrl");
                Config._credits = this.getJs("getCreditsUrl");
                Config._bandemail = this.getJs("getBandEmailUrl");
                Config._bandmobile = this.getJs("getBandMobileUrl");
                prologueStr = this.getJs("getPrologue");
                if (prologueStr == null || prologueStr == "")
                {
                    prologueStr = _defaultPrologue;
                }
                if (prologueStr != "")
                {
                    _thanksArray = [];
                    arr = prologueStr.split(";");
                    i;
                    while (i < arr.length)
                    {
                        
                        _thanksArray[i] = arr[i].split(",");
                        i = (i + 1);
                    }
                }
                _title = this.getJs("getTitle");
                if (_title == null || _title == "")
                {
                    _title = "仙境·幻想";
                }
                _subtitle = this.getJs("getSubtitle");
                if (_subtitle == null || _subtitle == "")
                {
                    _subtitle = "Paradise Fantasy";
                }
                timezoneStr = this.getJs("getServerTimeZone");
                if (timezoneStr != null && timezoneStr != "")
                {
                    now = new Date();
                    offset = Number(timezoneStr.substring(1)) / 100 * 60 * 60 * 1000;
                    if (timezoneStr.substring(0, 1) == "+")
                    {
                        Config._serverTimeZoneOffset = offset + now.timezoneOffset * 60 * 1000;
                    }
                    else
                    {
                        Config._serverTimeZoneOffset = -1 * offset + now.timezoneOffset * 60 * 1000;
                    }
                }
                defaultSwitch = Config._switchMobage;
                switchNum = this.getJs("getSwitchMobage");
                if (isNaN(switchNum))
                {
                    Config._switchMobage = defaultSwitch;
                }
                else if (switchNum == 1)
                {
                    Config._switchMobage = true;
                }
                else
                {
                    Config._switchMobage = false;
                }
                defaultSwitch = Config._switchRandName;
                switchNum = this.getJs("getSwitchRandName");
                if (isNaN(switchNum))
                {
                    Config._switchRandName = defaultSwitch;
                }
                else if (switchNum == 1)
                {
                    Config._switchRandName = true;
                }
                else
                {
                    Config._switchRandName = false;
                }
                defaultSwitch = Config._switchHttpHead;
                switchNum = this.getJs("getSwitchHttpHead");
                if (isNaN(switchNum))
                {
                    Config._switchHttpHead = defaultSwitch;
                }
                else if (switchNum == 1)
                {
                    Config._switchHttpHead = true;
                }
                else
                {
                    Config._switchHttpHead = false;
                }
                defaultSwitch = Config._switchEnglish;
                switchNum = this.getJs("getSwitchEnglish");
                if (isNaN(switchNum))
                {
                    Config._switchEnglish = defaultSwitch;
                }
                else if (switchNum == 1)
                {
                    Config._switchEnglish = true;
                }
                else
                {
                    Config._switchEnglish = false;
                }
                defaultSwitch = Config._switchCustomTitle;
                switchNum = this.getJs("getSwitchCustomTitle");
                if (isNaN(switchNum))
                {
                    Config._switchCustomTitle = defaultSwitch;
                }
                else if (switchNum == 1)
                {
                    Config._switchCustomTitle = true;
                }
                else
                {
                    Config._switchCustomTitle = false;
                }
                defaultSwitchNum = Config._switchLoadingNumber;
                switchNum = this.getJs("getSwitchLoadingNumber");
                if (isNaN(switchNum))
                {
                    Config._switchLoadingNumber = defaultSwitchNum;
                }
                else
                {
                    Config._switchLoadingNumber = switchNum;
                }
                defaultSwitch = AutoDrug.canBuy;
                switchNum = this.getJs("getSwitchAutoDrug");
                if (isNaN(switchNum))
                {
                    AutoDrug.canBuy = defaultSwitch;
                }
                else if (switchNum == 1)
                {
                    AutoDrug.canBuy = true;
                }
                else
                {
                    AutoDrug.canBuy = false;
                }
                defaultSwitch = Config._switchNameLength;
                switchNum = this.getJs("getSwitchNameLength");
                if (isNaN(switchNum))
                {
                    Config._switchNameLength = defaultSwitch;
                }
                else if (switchNum == 1)
                {
                    Config._switchNameLength = true;
                }
                else
                {
                    Config._switchNameLength = false;
                }
                if (Boolean(this.getJs("getSwitchQQ")))
                {
                    Config._lanVersion = LanVersion.QQ_ZH_CN;
                }
                this.init();
            }
            else
            {
                _checkJsTimer = setTimeout(this.checkJS, 1000);
            }
            return;
        }// end function

        public function addMonitor(param1)
        {
            return;
        }// end function

        public function subCons(param1)
        {
            var arr:Array;
            var i:int;
            var event:* = param1;
            if (ExternalInterface.available)
            {
                try
                {
                    ExternalInterface.call("onMainStart");
                }
                catch (e)
                {
                }
            }
            var prologueStr:* = _defaultPrologue;
            if (prologueStr != null)
            {
                _thanksArray = [];
                arr = prologueStr.split(";");
                i;
                while (i < arr.length)
                {
                    
                    _thanksArray[i] = arr[i].split(",");
                    i = (i + 1);
                }
            }
            event.target.removeEventListener("complete", this.subCons);
            var configXML:* = XMLLoader.pick("game_config.xml");
            Config.loginName = String(configXML.account);
            Config.loginIp = String(configXML.ip);
            Config.loginPort = Number(configXML.port);
            this.init();
            return;
        }// end function

        public function init()
        {
            ClientSocket.init();
            Observe.init();
            Config.map = new Map();
            Config.map.addEventListener("progress", this.onMapProgress);
            Config.map.addEventListener("complete", this.onMapComplete);
            addChild(Config.map);
            this.preLoad();
            if (Config._switchCustomTitle)
            {
                Loading._loading.loadPicTitle("stuff/pic/loading/custom_title.jpg");
            }
            else
            {
                trace("_titleSet", getTimer());
                _titleSet = new TextSet(_title, _subtitle, 39372, 32, 2);
                _titleSet.x = stage.stageWidth / 2;
                _titleSet.y = stage.stageHeight / 2 - 48;
                stage.addChild(_titleSet);
                _titleSet.addEventListener("over", this.titleSetOver);
                _titleSet.addEventListener("destroy", this.titleSetDestroy);
                Config.startLoop(this.thanksLoop);
            }
            Config.stage.addEventListener(Event.RESIZE, this.resizeHandler);
            this.resize();
            return;
        }// end function

        private function resizeHandler(event:Event) : void
        {
            this.resize();
            return;
        }// end function

        public function resize()
        {
            if (_titleSet != null)
            {
                _titleSet.x = stage.stageWidth / 2;
                _titleSet.y = stage.stageHeight / 2 - 48;
            }
            var _loc_1:* = stage.stageWidth;
            var _loc_2:* = stage.stageHeight;
            if (_loc_1 == 0 || _loc_2 == 0)
            {
                return;
            }
            if (Config.map != null)
            {
                if (Config.chatMode)
                {
                    Config.map.x = 0;
                    if (Config._switchEnglish)
                    {
                        Config._chatWidth = Math.max(int(_loc_1 / 3), 305);
                    }
                    Config.map.setSize(_loc_1 - Config.chatWidth, _loc_2);
                }
                else
                {
                    Config.map.x = 0;
                    Config.map.setSize(_loc_1, _loc_2);
                }
            }
            if (Config.ui != null)
            {
                Config.ui.x = 0;
                Config.ui.resize(_loc_1, _loc_2);
            }
            if (Config.ui == null)
            {
                AlertUI.resize(_loc_1, _loc_2);
            }
            if (Config.loginUI != null)
            {
                Config.loginUI.resize();
            }
            Loading.resize(_loc_1, _loc_2);
            return;
        }// end function

        public function preLoad()
        {
            if (_verLoadCount > 10)
            {
                return;
            }
            var _loc_1:* = new URLStream();
            _loc_1.endian = Endian.LITTLE_ENDIAN;
            _loc_1.addEventListener(Event.COMPLETE, this.handleVerFileComplete);
            _loc_1.addEventListener(IOErrorEvent.IO_ERROR, this.handleVerFileError);
            _loc_1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleVerFileError);
            if (_verLoadCount == 0)
            {
                _loc_1.load(new URLRequest(Config.sourceURL + "ver.mpq?ver=" + Config.ver));
            }
            else
            {
                _loc_1.load(new URLRequest(Config.sourceURL + "ver.mpq?ran=" + _verLoadCount));
            }
            return;
        }// end function

        private function handleVerFileComplete(param1)
        {
            var event:* = param1;
            event.target.removeEventListener(Event.COMPLETE, this.handleVerFileComplete);
            event.target.removeEventListener(IOErrorEvent.IO_ERROR, this.handleVerFileError);
            event.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleVerFileError);
            var bytesArray:* = new ByteArray();
            event.target.readBytes(bytesArray, 0, event.target.bytesAvailable);
            try
            {
                bytesArray.uncompress();
                Config.verObj = bytesArray.readObject();
                this.subPreload();
            }
            catch (e)
            {
                var _loc_5:* = _verLoadCount + 1;
                _verLoadCount = _loc_5;
                setTimeout(preLoad, 5000);
            }
            return;
        }// end function

        private function handleVerFileError(param1)
        {
            param1.target.removeEventListener(Event.COMPLETE, this.handleVerFileComplete);
            param1.target.removeEventListener(IOErrorEvent.IO_ERROR, this.handleVerFileError);
            param1.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleVerFileError);
            var _loc_3:* = _verLoadCount + 1;
            _verLoadCount = _loc_3;
            setTimeout(this.preLoad, 5000);
            return;
        }// end function

        private function subPreload()
        {
            _firstLoadingPic = "stuff/pic/loading/" + Math.ceil(Math.random() * Config._switchLoadingNumber) + ".jpg";
            Loading.resize(stage.stageWidth, stage.stageHeight);
            var _loc_1:* = new Buffer();
            _loc_1.addEventListener(ProgressEvent.PROGRESS, this.bufferProgress);
            _loc_1.addEventListener("complete", this.bufferComplete);
            _loc_1.buffInit("data0.mpq", [_firstLoadingPic, "stuff/pic/loading/bar.png"]);
            return;
        }// end function

        private function bufferProgress(event:ProgressEvent) : void
        {
            var _loc_2:* = event.bytesLoaded / event.bytesTotal;
            Loading.setProgress(event.bytesLoaded, event.bytesTotal);
            return;
        }// end function

        private function bufferComplete(event:Event) : void
        {
            event.target.removeEventListener(ProgressEvent.PROGRESS, this.bufferProgress);
            event.target.removeEventListener("complete", this.bufferComplete);
            Config.stopLoop(this.thanksLoop);
            if (_titleSet != null)
            {
                _titleSet.over();
            }
            else
            {
                this.titleSetOver();
                Loading.close(true);
            }
            Loading.addPic(_firstLoadingPic);
            Security.allowDomain("*");
            new PushButton(null, 0, 0, "", null, Config.findUI("treeItem").button1);
            new PushButton(null, 0, 0, "", null, Config.findUI("treeItem").button2);
            return;
        }// end function

        private function titleSetDestroy(param1 = null) : void
        {
            param1.target.removeEventListener("destroy", this.titleSetDestroy);
            Loading.close(true);
            return;
        }// end function

        private function getCookie(param1)
        {
            return ExternalInterface.call("getNav", param1);
        }// end function

        private function receivedFromJavaScript(param1:String) : void
        {
            return;
        }// end function

        private function titleSetOver(param1 = null) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            for (_loc_2 in Config._charactorMap)
            {
                
                UnitClip.initLayerStack(_loc_2, Config._charactorMap[_loc_2].layer);
            }
            Table.init();
            GClip.init();
            new AlertUI(Config.stage);
            stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.handleMouseWheel);
            this.subTitleSetOver();
            _loc_3 = new Buffer();
            _loc_3.addEventListener(ProgressEvent.PROGRESS, this.bufferProgress1);
            _loc_3.addEventListener("complete", this.bufferComplete1);
            _loc_3.buffInit("data1.mpq");
            return;
        }// end function

        private function bufferProgress1(event:ProgressEvent) : void
        {
            if (Config.loginUI != null)
            {
                Config.loginUI.initStepProgress(event.bytesLoaded / event.bytesTotal);
            }
            return;
        }// end function

        private function bufferComplete1(param1)
        {
            param1.target.removeEventListener(ProgressEvent.PROGRESS, this.bufferProgress1);
            param1.target.removeEventListener("complete", this.bufferComplete1);
            _data1Complete = true;
            if (_loginSubComplete)
            {
                Config.loginUI.initStep1();
                Config.startLoop(this.trueRealEnterGameAtTheEndOfTheWorld);
            }
            return;
        }// end function

        public function realEnterGame()
        {
            _loginSubComplete = true;
            if (_data1Complete)
            {
                Config.loginUI.initStep1();
                Config.startLoop(this.trueRealEnterGameAtTheEndOfTheWorld);
            }
            return;
        }// end function

        public function reconnectComplete()
        {
            _gameServerComplete = true;
            if (_uiComplete)
            {
                Config.loginUI.loginGamerServer();
            }
            return;
        }// end function

        private function trueRealEnterGameAtTheEndOfTheWorld(param1)
        {
            var _loc_2:* = undefined;
            var _loc_4:* = _realEnterCount - 1;
            _realEnterCount = _loc_4;
            if (_realEnterCount <= 0)
            {
                Config.stopLoop(this.trueRealEnterGameAtTheEndOfTheWorld);
            }
            else
            {
                return;
            }
            Item.initMonsterItem();
            this.resize();
            for (_loc_2 in Config._mapMap)
            {
                
                Config._mapMap[_loc_2].id = _loc_2;
            }
            TeamHeadUI.init();
            Ubb.init();
            DistrictMap.init();
            Hang.init();
            Config.ui = new GameUI();
            Config.ui.init();
            Player.level = Player.level;
            EventMouse.init();
            this.resize();
            Config.loginUI.initStep2();
            _uiComplete = true;
            if (_gameServerComplete)
            {
                Config.loginUI.loginGamerServer();
            }
            return;
        }// end function

        private function subTitleSetOver(param1 = null) : void
        {
            Config.loginUI = new Login();
            addChild(Config.loginUI);
            Config.loginUI.init();
            var _loc_2:* = Config.checkVersion();
            if (_loc_2 < 10)
            {
                AlertUI.alert(Config.language("Main", 3), Config.language("Main", 4, _loc_2), [Config.language("Main", 5)], [this.goAdobe], null, false, false);
            }
            this.resize();
            return;
        }// end function

        private function goAdobe(param1)
        {
            var _loc_2:* = "http://www.adobe.com/go/getflash";
            var _loc_3:* = new URLRequest(_loc_2);
            navigateToURL(_loc_3, "_self");
            return;
        }// end function

        private function handleMouseWheel(event:MouseEvent) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = event.target;
            while (_loc_3 != null)
            {
                
                if (_loc_3 == Config.map)
                {
                    _loc_2 = true;
                    break;
                }
                _loc_3 = _loc_3.parent;
            }
            if (Config.map._state == "ready" && _loc_2)
            {
                if (event.delta > 0 && Config.map.zoom < 1.6)
                {
                    Config.map.zoom = Math.min(1.6, Config.map.zoom + 0.2);
                }
                else if (event.delta < 0 && Config.map.zoom > 1)
                {
                    Config.map.zoom = Math.max(1, Config.map.zoom - 0.2);
                }
            }
            return;
        }// end function

        private function autoDoing()
        {
            var _loc_1:* = undefined;
            if (Config.doingCookie != null)
            {
                _loc_1 = Config.doingCookie;
                if (_loc_1.act == "hangMonster")
                {
                    Hang.selectedTargetType = UNIT_TYPE_ENUM.TYPEID_UNIT;
                    Hang.hangMonster(_loc_1.monsterID);
                    Config.doingCookie = null;
                }
                else if (_loc_1.act == "hangPosition")
                {
                    Hang.hangPosition(_loc_1.taskID, _loc_1.eventId);
                    Config.doingCookie = null;
                }
                else if (_loc_1.act == "hangGather")
                {
                    Hang.selectedTargetType = UNIT_TYPE_ENUM.TYPEID_GATHER;
                    Hang.hangGather(_loc_1.gatherID);
                    Config.doingCookie = null;
                }
                else if (_loc_1.act == "hangNpc")
                {
                    Hang.selectedTargetType = UNIT_TYPE_ENUM.TYPEID_NPC;
                    Hang.hangNpc(_loc_1.npcID);
                    Config.doingCookie = null;
                }
                else if (_loc_1.act == "hangstart")
                {
                    Hang.selectedMap = DistrictMap.realMapId;
                    Hang.selectedTarget = _loc_1.selectedTarget;
                    Hang.selectedTargetType = UNIT_TYPE_ENUM.TYPEID_UNIT;
                    Hang.start();
                    Config.doingCookie = null;
                    Config.ui._monsterIndexUI.setHangState(_loc_1.selectedTarget);
                }
                else if (_loc_1.act == "hangStall")
                {
                    Config.message("hangStall" + _loc_1.stallData.length);
                    if (_loc_1.stallData.length > 0)
                    {
                        Config.doingCookie = null;
                        Config.ui._stallUI.setStall(_loc_1.ad, _loc_1.stallData);
                    }
                }
            }
            return;
        }// end function

        public function buffJump()
        {
            if (Player._buffJump)
            {
                Config.player.go(Player._buffJump);
                Player._buffJump = null;
            }
            return;
        }// end function

        public function enterMapId(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = null;
            _preMapId = Config.map.id;
            var _loc_2:* = Config.map.id == param1;
            Config.clearMap(_loc_2);
            Config.ui._dialogue.closedialogue();
            if (!_loc_2)
            {
                Loading.open();
                if (param1 > 1000000000)
                {
                    Config.ui._fbEntranceUI.close();
                }
                Config.mapId = param1;
                _loc_3 = Config._mapMap[Config.mapId];
                if (_loc_3 == null)
                {
                    Config.map.data = null;
                    if (Config.mapId > 1000000000)
                    {
                        _loc_6 = String(Config.mapId);
                        _loc_4 = "data/fbmap/" + _loc_6.substring(0, 4) + "/" + _loc_6.substring(4, 6) + "/" + _loc_6 + ".xml";
                    }
                    else
                    {
                        _loc_4 = "data/xml/" + Config.mapId + ".xml";
                    }
                    _loc_5 = new XMLLoader();
                    _loc_5.addEventListener("complete", this.subEnterMapId);
                    _loc_5.load([_loc_4]);
                }
                else
                {
                    this.enterMap(_loc_3);
                }
            }
            return;
        }// end function

        private function subEnterMapId(param1 = null)
        {
            var _loc_2:* = undefined;
            var _loc_4:* = null;
            param1.target.removeEventListener("complete", this.subEnterMapId);
            if (Config.mapId > 1000000000)
            {
                _loc_4 = String(Config.mapId);
                _loc_2 = "data/fbmap/" + _loc_4.substring(0, 4) + "/" + _loc_4.substring(4, 6) + "/" + _loc_4 + ".xml";
            }
            else
            {
                _loc_2 = "data/xml/" + Config.mapId + ".xml";
            }
            var _loc_3:* = XMLLoader.pick(_loc_2);
            _loc_3.id = Config.mapId;
            Config._mapMap[Config.mapId] = XML2Object.toObj(_loc_3, true);
            this.enterMap(_loc_3);
            return;
        }// end function

        public function enterMap(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            Loading.open();
            Config.map.id = param1.id;
            Config.map.data = param1.mapData;
            if (Config.player != null)
            {
                Config.player.stop(true, true);
                if (Config.map._type == 26)
                {
                    Config.player.hideFollower = true;
                }
                else
                {
                    Config.player.hideFollower = false;
                }
            }
            Config._mapLoading = true;
            if (param1.mapData.type > 1 && param1.mapData.type != 12 && param1.mapData.type != 15 && param1.mapData.type != 16 && param1.mapData.type != 20 && param1.mapData.type != 25 && param1.mapData.type != 26 && param1.mapData.type != 27)
            {
                Config.message(Config.language("Main", 6));
                Config.ui._pkmode.pkchange(true);
            }
            else
            {
                Config.ui._pkmode.pkchange(false);
            }
            if (param1.mapData.type == 3 || param1.mapData.type == 13)
            {
                Config.ui._chatUI.bigWar = false;
                StateBar.inWar = false;
                Config.ui._radar.openFullEffectCB();
            }
            else if (param1.mapData.type == 11)
            {
                Config.ui._chatUI.bigWar = true;
                StateBar.inWar = true;
                Unit.fullEffect = false;
                Config.ui._radar.closeFullEffectCB();
            }
            else
            {
                Config.ui._chatUI.bigWar = false;
                StateBar.inWar = false;
                Unit.fullEffect = true;
                Config.ui._radar.closeFullEffectCB();
            }
            Config.npcStack = {};
            if (param1.npcData != null && param1.npcData.data != null)
            {
                if (param1.npcData.data is Array)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.npcData.data.length)
                    {
                        
                        _loc_3 = param1.npcData.data[_loc_2];
                        Config.npcStack[_loc_3.x + "_" + _loc_3.y] = _loc_3;
                        _loc_2 = _loc_2 + 1;
                    }
                }
                else
                {
                    _loc_3 = param1.npcData.data;
                    Config.npcStack[_loc_3.x + "_" + _loc_3.y] = _loc_3;
                }
            }
            Config.eventStack = {};
            if (param1.flagData != null && param1.flagData.data != null)
            {
                if (param1.flagData.data is Array)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.flagData.data.length)
                    {
                        
                        _loc_3 = param1.flagData.data[_loc_2];
                        if (_loc_3.type != "jump_sky")
                        {
                            Config.eventStack[_loc_3.x + "_" + _loc_3.y] = _loc_3;
                        }
                        else if (_loc_3.type != "jump_battle_field")
                        {
                            Config.eventStack[_loc_3.x + "_" + _loc_3.y] = _loc_3;
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                }
                else
                {
                    _loc_3 = param1.flagData.data;
                    if (_loc_3.type != "jump_sky")
                    {
                        Config.eventStack[_loc_3.x + "_" + _loc_3.y] = _loc_3;
                    }
                    else if (_loc_3.type != "jump_battle_field")
                    {
                        Config.eventStack[_loc_3.x + "_" + _loc_3.y] = _loc_3;
                    }
                }
            }
            return;
        }// end function

        private function onMapProgress(event:ProgressEvent)
        {
            if (_firstMapLoading)
            {
                Loading.setProgress(event.bytesLoaded, event.bytesTotal);
            }
            else
            {
                Loading.setProgress(event.bytesLoaded, event.bytesTotal);
            }
            var _loc_2:* = event.bytesLoaded / event.bytesTotal;
            return;
        }// end function

        public function onMapComplete(event:Event)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            _firstMapLoading = false;
            Config._mapLoading = false;
            if (String(Config.map.data.name) != "")
            {
                Neon.show(Config.map.data.name);
            }
            Observe.obChangeMap(String(Config.map.data.name));
            if (Config.map._type == 14 || Config.map._type == 24)
            {
                Config.ui._pkUI.enter();
            }
            else if (Config.map._type == 18)
            {
                Config.ui._pkraceUI.enterRace();
            }
            else if (Config.map._type == 25)
            {
                Config.ui._seniorcopy.addbackbtn();
            }
            else
            {
                Config.ui._pkUI.exit();
                Config.ui._pkraceUI.exitRace();
            }
            Config.ui._bagware.close();
            Config.player.display(Config.map);
            Config.ui._quickUI._soulUI.refreshModel();
            Config.player.forcePosition({_x:Player._playerX, _y:Player._playerY});
            Config.player.unLockMove();
            for (_loc_2 in Config.eventStack)
            {
                
                _loc_3 = Config.eventStack[_loc_2];
                if (String(_loc_3.type) == "jump_map")
                {
                    if (Number(_loc_3.mapId) == Config.map.id)
                    {
                        _loc_5 = Config.map._logicalTile[Number(_loc_3.mapX)][Number(_loc_3.mapY)];
                        _loc_4 = Config.map._logicalTile[Number(_loc_3.x)][Number(_loc_3.y)];
                        _loc_4.jumpTile = _loc_5;
                    }
                }
            }
            Loading.close();
            Config.fps = Config.stage.frameRate;
            addChild(Config.ui);
            if (Config.map.id == 343)
            {
                if (GuideUI.testId(37))
                {
                    GuideUI.doId(37);
                }
                else if (GuideUI.testId(101))
                {
                    GuideUI.doId(101);
                }
            }
            else if (Config.map.id == 337)
            {
                GuideUI.testDoId(120);
            }
            if (Config._firstInGame)
            {
                Config._firstInGame = false;
                this.firstInGame();
            }
            Config.ui._cardUI.init();
            if (Config.autoLogin)
            {
                if (Config.mapLineCookie == null || Config.mapLineCookie == Config.mapLine)
                {
                    if (Config.doingCookie != null)
                    {
                        setTimeout(this.autoDoing, 1000);
                    }
                }
                Config.autoLogin = false;
            }
            setTimeout(Config.ui._taskpanel.mapNextGo, 500);
            Config.ui._radar.showGiftBack();
            Config.ui._charUI.redrawFollower();
            if (Config.ui._zoommap.isDesert(Config.mapId))
            {
                GuideUI.testDoId(49, Config.ui._radar._mapBtn, Config.ui._zoommap);
            }
            if (Config.map._type == 16 || Config.map._type == 17)
            {
                GuideUI.testDoId(241);
            }
            trace("Config.ui._monsterIndexUI.hanging", Config.ui._monsterIndexUI.hanging);
            if (Config.map._type == 25)
            {
                if (Hang._expCopyGateLock)
                {
                    if (Hang._preExpCopyHanging)
                    {
                        setTimeout(this.delayExpCopyHang, 500);
                    }
                }
            }
            Hang._preExpCopyHanging = false;
            Hang._expCopyGateLock = false;
            Config.ui._followupui.changeMapRefresh();
            return;
        }// end function

        private function delayExpCopyHang() : void
        {
            if (!Config.ui._monsterIndexUI._hangMode1.selected)
            {
                Config.ui._monsterIndexUI.flagAllMonster();
            }
            Config.ui._monsterIndexUI.hanging = true;
            return;
        }// end function

        public function handleEnterGame() : void
        {
            Config.loginCharIdCookie = null;
            this.tabEnabled = false;
            this.tabChildren = false;
            RollNotice.start();
            Config.ui.alertToLayer4();
            var _loc_1:* = Config._charactorMap[Player.job + (Player.sex - 1) * 12];
            var _loc_2:* = new Player(_loc_1, 0, 0, UNIT_TYPE_ENUM.TYPEID_PLAYER, Player._playerId);
            _loc_2.name = Player.name;
            _loc_2.job = Player.job;
            _loc_2.sex = Player.sex;
            _loc_2.level = Player.level;
            Config.player = _loc_2;
            UnitEffect.avatar(_loc_2);
            Config.ui._skillUI.testAllSkill();
            Config.ui._playerHead.unit = _loc_2;
            Config.ui._charUI.drawPlayerClip(_loc_2);
            Config.ui._charUI.listenPlayer(_loc_2);
            Config.ui._bagUI.listenPlayer(_loc_2);
            Config.ui._charUI.queryChar();
            Config.ui._gildwar.getheachlist();
            Config.ui._landGravePanel.setnewFreshLand();
            Config.ui._skillUI.sendGiftList();
            Config.ui._teamUI.loginInit();
            setTimeout(this.delayInit, 2000);
            Config.ui.handleTaskChange();
            Config.ui._activePanel.showPanel();
            Config.autoMemoryClear = true;
            Config.ui._fbEntranceUI.selectInfo();
            if (Config.player.level >= 20)
            {
                Config.ui._recomPanel.switchOpen();
            }
            Config.ui._mbbPanel.sendQuery();
            Config.player.effectTime = getTimer();
            return;
        }// end function

        public function firstInGame()
        {
            var _loc_1:* = undefined;
            for (_loc_1 in Skill._skillMap)
            {
                
                if (Skill._skillMap[_loc_1]._data == Config.player.attackMode)
                {
                    Config.ui._quickUI._mouseSlot.skill = Skill._skillMap[_loc_1];
                    Config.ui._quickUI.mouseSlotSend();
                    break;
                }
            }
            GuideUI.testDoId(6, Config.ui._taskpanel.taskmate);
            return;
        }// end function

        private function delayInit()
        {
            Config.ui._monsterIndexUI._setupPanel.initCookie();
            return;
        }// end function

    }
}
