package 
{
    import flash.display.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;
    import gs.*;
    import lovefox.buffer.*;
    import lovefox.gameUI.*;
    import lovefox.isometric.*;
    import lovefox.unit.*;
    import lovefox.util.compiler.*;
    import org.gif.encoder.*;

    public class Config extends Object
    {
        public static var ver_zhanhun:Boolean = true;
        public static var ver_zhufu:Boolean = true;
        public static var ver_yuansu:Boolean = true;
        public static var ver_zuoji:Boolean = true;
        public static var ver_chibang:Boolean = true;
        public static var ver_emo:Boolean = true;
        public static var ver_kongju:Boolean = true;
        public static var ver_yabiao:Boolean = true;
        public static var _flagList:Object = {};
        public static var _winflag:int;
        public static var _replace1:RegExp = /&""&/g;
        public static var _replace2:RegExp = /#""#/g;
        public static var _switchMobage:Boolean = false;
        public static var _switchHttpHead:Boolean = false;
        public static var _switchEnglish:Boolean = false;
        public static var _switchCustomTitle:Boolean = false;
        public static var _switchLoadingNumber:int = 3;
        public static var _switchNameLength:Boolean = false;
        public static var _switchRandName:Boolean = true;
        public static var _firstInGame:Boolean = false;
        public static var _firstInGameSession:Boolean = false;
        public static var _autoEnterGameIn30:Boolean = false;
        private static var _enterframeListenerArray:Array = [];
        private static var _ping:uint;
        private static var _map:Object;
        private static var _mapId:Object;
        public static var _mapLoading:Boolean = false;
        private static var _player:Object;
        private static var _account:int = 0;
        private static var _loginName:String;
        private static var _loginPass:String;
        private static var _loginIp:String;
        private static var _loginPort:uint;
        private static var _ui:Object;
        private static var _eventStack:Object = [];
        private static var _npcStack:Object = [];
        private static var _loginUI:Object;
        private static var _stage:Stage;
        private static var _main:Object;
        private static var _mainScene:Object;
        private static var _editor:Object;
        public static var _point0:Object = new Point();
        public static var _fpsTimer:Object;
        public static var _fpsCount:Object;
        public static var _fps:Object = 30;
        private static var _fpsFreezed:Boolean = false;
        private static var _gravity:Number = 2;
        public static var temp:Object = 0;
        public static var temp1:Object = 0;
        private static var _clock:Date;
        private static var _preClockTime:Object;
        private static var _stageFocus:Boolean = false;
        private static var _stageMouseOver:Boolean = true;
        public static var _port:Number = 9527;
        public static var _linked:Boolean = false;
        public static var _shadowMask:Boolean = true;
        private static var _buttonLock:Object = false;
        private static var _buttonLockTimer:Number;
        public static var _bmpdDict:Dictionary = new Dictionary(true);
        public static var cookie:Cookie = new Cookie();
        public static var _model:Object = {};
        public static var _unitModel:Object = {};
        public static var _itemModel:Object = {};
        public static var _effectModel:Object = {};
        public static var _flyPropModel:Object = {};
        public static var _iconModel:Object = {};
        public static var _obstacleModel:Object = {};
        public static var _tileModel:Object = {};
        public static var _itemType:Object = {};
        public static var _itemIndexType:Object = {};
        public static var _bardSong:Object = {};
        public static var _bIAttribute:Object = {};
        public static var _produceAttr:Object = {};
        public static var _giftMap:Object = {};
        public static var _giftNpcMap:Object = {};
        public static var _taskMap:Object = {};
        public static var _newtaskMap:Object = {};
        public static var _activMap:Object = {};
        public static var _ubbMap:Object = {};
        public static var _npcMap:Object = {};
        public static var _portalMap:Object = {};
        public static var _guideMap:Object = {};
        public static var _loadingTipMap:Object = {};
        public static var _rollTipMap:Object = {};
        public static var _petMap:Object = {};
        public static var _effectMap:Object = {};
        public static var _mapMap:Object = {};
        public static var _flyPropMap:Object = {};
        public static var _itemMap:Object = {};
        public static var _monsterMap:Object = {};
        public static var _monsterGroupMap:Object = {};
        public static var _gatherMap:Object = {};
        public static var _gatherGroupMap:Object = {};
        public static var _charactorMap:Object = {};
        public static var _skillMap:Object = {};
        public static var _giftSkillMap:Object = {};
        public static var _giftAttachMap:Object = {};
        public static var _buffMap:Object = {};
        public static var _passiveMap:Object = {};
        public static var _enchantMap:Object = {};
        public static var _affixMap:Object = {};
        public static var _itemPropMap:Object = {};
        public static var _soulMap:Object = {};
        public static var _guildExpendMap:Object = {};
        public static var _ListExp:Object = {};
        public static var _locaTions:Object = {};
        public static var _formula:Object = {};
        public static var _warplist:Object = {};
        public static var _proRevise:Object = {};
        public static var _territoryMap:Object = {};
        public static var _equipfineprobability:Object = {};
        public static var _equipUpgradeAttr:Object = {};
        public static var _wingRidelucky:Object = {};
        public static var _wingProperty:Object = {};
        public static var _rideProperty:Object = {};
        public static var _dropMap:Object = {};
        public static var _sonMap:Object = {};
        public static var _eliteToMap:Object = {};
        public static var _toEliteMap:Object = {};
        public static var _fbGuideMap:Object = {};
        public static var _petGift:Object = {};
        public static var _petCombine:Object = {};
        public static var _buy:Object = {};
        public static var _codeWords:Object = {};
        public static var _language:Object = {};
        public static var _straction:Object = "";
        public static var _xmlMap:Object = {};
        public static var _Listgradexp:Object = {};
        public static var _recomList:Object = {};
        public static var _newRecom:Object = {};
        public static var _dayRecomList:Object = {};
        public static var _titleMap:Object = {};
        public static var _playerPropMap:Object = {};
        public static var _nameMap:Object = {};
        public static var _moneyActivityNameMap:Object = {};
        public static var _mapCost:Object = {};
        public static var _fbInfo:Object = {};
        public static var _outfit:Object = {};
        public static var _hairMap:Object = {};
        public static var _mounts:Object = {};
        public static var _escortPanel:Object = {};
        public static var _belss:Object = {};
        public static var _book:XML;
        public static var _fightsprit:Object = {};
        public static var _toair2prize:Object = {};
        public static var _hflist:Object = {};
        public static var _ridewingid:Object = {};
        public static var _equproduceid:Object = {};
        public static var _sellCultivation:Object = {};
        public static var _actEvent:Object = {};
        public static var _godAttribute:Object = {};
        public static var _expcopymap:Object = {};
        public static var _followUpMap:Object = {};
        public static var _crowdskytower:Object = {};
        public static var _jobTitleMap:Object = [];
        public static var _operatingActivityMap:Object = [];
        public static var _quizMap:Object = [];
        public static var _elementMap:Object = [];
        public static var _actorMsg:Object = [];
        private static var _disturbMode:Boolean = false;
        private static var _chatMode:Boolean = false;
        public static var _chatWidth:uint = 305;
        private static var _paused:Boolean = false;
        private static var _sourceURL:String = "";
        private static var _replayURL:String = "";
        private static var _bardURL:String = "";
        private static var _navURL:String = "";
        private static var _payURL:String = "";
        private static var _vipURL:String = "";
        private static var _serverName:String = "";
        public static var _ogfs:String = "";
        public static var _credits:String = "";
        public static var _bandemail:String = "";
        public static var _bandmobile:String = "";
        private static var _mapLine:uint = 0;
        private static var _autoLogin:Boolean = false;
        private static var _ver:String = "20110721_1";
        private static var _dataVer:String = "";
        private static var _normalQuit:Boolean = false;
        private static var _serverTimeOffset:Number = 0;
        public static var _serverTimeZoneOffset:Number = 0;
        private static var _gameId:Number = 21;
        private static var _regionId:Number = 0;
        private static var _jEncoder:JPEGEncoder;
        private static var _gEncoder:GIFEncoder;
        private static var _debug:Boolean = false;
        private static var _autoMemoryClear:Boolean = false;
        private static var _autoMemoryClearTimer:Number;
        private static var _verObj:Object = {};
        private static var _timezoneOffset:Object;
        private static var _serverID:uint;
        public static var _lanVersion:String;
        public static var _QQInfo:Object = {is_yellow_vip:false, is_yellow_year_vip:false};
        public static var _qqVipItem:Object = {};

        public function Config()
        {
            return;
        }// end function

        public static function set serverID(param1:uint)
        {
            _serverID = param1;
            if (player != null)
            {
                player.id = Player._playerId;
            }
            return;
        }// end function

        public static function get serverID()
        {
            return _serverID;
        }// end function

        public static function get timezoneOffset()
        {
            var _loc_1:* = null;
            if (_timezoneOffset == null)
            {
                _loc_1 = new Date();
                _timezoneOffset = _loc_1.getTimezoneOffset() / 60;
            }
            return _timezoneOffset;
        }// end function

        public static function get chatWidth()
        {
            return _chatWidth - Math.max(0, Math.min(100, 1000 - stage.stageWidth));
        }// end function

        public static function set verObj(param1)
        {
            _verObj = param1;
            return;
        }// end function

        public static function get verObj()
        {
            return _verObj;
        }// end function

        public static function set gameId(param1)
        {
            var _loc_2:* = Number(param1);
            if (!isNaN(_loc_2))
            {
                _gameId = Number(_loc_2);
            }
            return;
        }// end function

        public static function get gameId()
        {
            return _gameId;
        }// end function

        public static function set regionId(param1)
        {
            var _loc_2:* = Number(param1);
            if (!isNaN(_loc_2))
            {
                _regionId = Number(_loc_2);
            }
            return;
        }// end function

        public static function get regionId()
        {
            return _regionId;
        }// end function

        public static function set autoMemoryClear(param1)
        {
            _autoMemoryClear = param1;
            if (_autoMemoryClear)
            {
                subMemoryClear();
            }
            else
            {
                clearTimeout(_autoMemoryClearTimer);
            }
            return;
        }// end function

        private static function subMemoryClear()
        {
            clearTimeout(_autoMemoryClearTimer);
            if (Hang.hanging && map._state == "ready")
            {
                BitmapLoader.clearBuff(true);
                gc();
                if (debug)
                {
                    ui._chatUI.showSys("autoMemoryClear:" + bytesToString(System.totalMemory));
                }
            }
            _autoMemoryClearTimer = setTimeout(subMemoryClear, 120000);
            return;
        }// end function

        public static function get autoMemoryClear()
        {
            return _autoMemoryClear;
        }// end function

        public static function set debug(param1)
        {
            _debug = param1;
            return;
        }// end function

        public static function get debug()
        {
            return _debug;
        }// end function

        public static function get jEncoder()
        {
            if (_jEncoder == null)
            {
                _jEncoder = new JPEGEncoder();
            }
            return _jEncoder;
        }// end function

        public static function get gEncoder()
        {
            if (_gEncoder == null)
            {
                _gEncoder = new GIFEncoder();
            }
            return _gEncoder;
        }// end function

        public static function get buttonLock() : Boolean
        {
            return _buttonLock;
        }// end function

        public static function set buttonLock(param1:Boolean)
        {
            clearTimeout(_buttonLockTimer);
            _buttonLock = param1;
            if (_buttonLock)
            {
                _buttonLockTimer = setTimeout(buttonLockRelease, 10000);
            }
            return;
        }// end function

        private static function buttonLockRelease()
        {
            clearTimeout(_buttonLockTimer);
            _buttonLock = false;
            return;
        }// end function

        public static function copyBytes(param1)
        {
            var _loc_2:* = null;
            _loc_2 = new ByteArray();
            _loc_2.endian = Endian.LITTLE_ENDIAN;
            _loc_2.writeBytes(param1, 0, param1.length);
            _loc_2.position = 0;
            return _loc_2;
        }// end function

        public static function get normalQuit()
        {
            return _normalQuit;
        }// end function

        public static function set normalQuit(param1)
        {
            _normalQuit = param1;
            return;
        }// end function

        public static function get ver()
        {
            return _ver;
        }// end function

        public static function set ver(param1)
        {
            _ver = param1;
            return;
        }// end function

        public static function set dataVer(param1)
        {
            _dataVer = param1;
            return;
        }// end function

        public static function get dataVer()
        {
            return _dataVer;
        }// end function

        public static function set mapLine(param1)
        {
            _mapLine = param1;
            return;
        }// end function

        public static function get mapLine()
        {
            return _mapLine;
        }// end function

        public static function set autoLogin(param1)
        {
            _autoLogin = param1;
            return;
        }// end function

        public static function get autoLogin()
        {
            return _autoLogin;
        }// end function

        public static function set doingCookie(param1)
        {
            if (param1 == null)
            {
                cookie.remove("doingCookie");
            }
            else
            {
                cookie.put("doingCookie", param1);
            }
            return;
        }// end function

        public static function get doingCookie()
        {
            return cookie.get("doingCookie");
        }// end function

        public static function set loginCharIdCookie(param1)
        {
            if (param1 == null)
            {
                cookie.remove("loginCharId");
            }
            else
            {
                cookie.put("loginCharId", {charId:param1});
            }
            return;
        }// end function

        public static function get loginCharIdCookie()
        {
            if (cookie.contains("loginCharId"))
            {
                return cookie.get("loginCharId").charId;
            }
            return null;
        }// end function

        public static function set mapLineCookie(param1)
        {
            if (param1 == null)
            {
                cookie.remove("mapLineCookie");
            }
            else
            {
                cookie.put("mapLineCookie", {mapLine:param1});
            }
            return;
        }// end function

        public static function get mapLineCookie()
        {
            if (cookie.contains("mapLineCookie"))
            {
                return cookie.get("mapLineCookie").mapLine;
            }
            return null;
        }// end function

        public static function set replayURL(param1)
        {
            _replayURL = param1;
            return;
        }// end function

        public static function get replayURL()
        {
            return _replayURL;
        }// end function

        public static function set bardURL(param1)
        {
            _bardURL = param1;
            return;
        }// end function

        public static function get bardURL()
        {
            return _bardURL;
        }// end function

        public static function set serverName(param1)
        {
            _serverName = param1;
            return;
        }// end function

        public static function get serverName()
        {
            return _serverName;
        }// end function

        public static function set navURL(param1)
        {
            _navURL = param1;
            return;
        }// end function

        public static function get navURL()
        {
            return _navURL;
        }// end function

        public static function set payURL(param1)
        {
            _payURL = param1;
            return;
        }// end function

        public static function get payURL()
        {
            return _payURL;
        }// end function

        public static function set vipURL(param1)
        {
            _vipURL = param1;
            return;
        }// end function

        public static function get vipURL()
        {
            return _vipURL;
        }// end function

        public static function set sourceURL(param1)
        {
            _sourceURL = param1;
            return;
        }// end function

        public static function get sourceURL()
        {
            return _sourceURL;
        }// end function

        public static function set chatMode(param1)
        {
            _chatMode = param1;
            if (_chatMode)
            {
                ui._chatUI.mode = 1;
            }
            else
            {
                ui._chatUI.mode = 0;
            }
            main.resize();
            ui._gamesystem._chatCB.selected = _chatMode;
            ui._gamesystem.setCookie();
            return;
        }// end function

        public static function get chatMode()
        {
            return _chatMode;
        }// end function

        public static function set disturbMode(param1)
        {
            _disturbMode = param1;
            ui._alertUI._disturbCB.selected = _disturbMode;
            ui._gamesystem._disturbCB.selected = _disturbMode;
            ui._gamesystem.setCookie();
            return;
        }// end function

        public static function get disturbMode()
        {
            return _disturbMode;
        }// end function

        public static function gc()
        {
            var lc1:LocalConnection;
            var lc2:LocalConnection;
            try
            {
                lc1 = new LocalConnection();
                lc2 = new LocalConnection();
                lc1.connect("name");
                lc2.connect("name2");
            }
            catch (e:Error)
            {
                try
                {
                }
                lc1 = new LocalConnection();
                lc2 = new LocalConnection();
                lc1.connect("name");
                lc2.connect("name2");
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public static function error()
        {
            var _loc_1:* = new LocalConnection();
            var _loc_2:* = new LocalConnection();
            _loc_1.connect("name");
            _loc_2.connect("name2");
            return;
        }// end function

        public static function set stageFocus(param1)
        {
            if (_stageFocus != param1)
            {
                _stageFocus = param1;
                Music.on = Music.on;
            }
            return;
        }// end function

        public static function set ping(param1:uint)
        {
            _ping = param1;
            return;
        }// end function

        public static function get ping()
        {
            return _ping;
        }// end function

        public static function get stageFocus()
        {
            return _stageFocus;
        }// end function

        public static function set stageMouseOver(param1)
        {
            if (_stageMouseOver != param1)
            {
                _stageMouseOver = param1;
            }
            return;
        }// end function

        public static function get stageMouseOver()
        {
            return _stageMouseOver;
        }// end function

        public static function get minute()
        {
            if (_clock == null)
            {
                _clock = now;
                _preClockTime = getTimer();
            }
            else
            {
                _clock.time = _clock.time + (getTimer() - _preClockTime);
                _preClockTime = getTimer();
            }
            return (_clock.getHours() * 60 + _clock.getMinutes()) % 240;
        }// end function

        public static function get time()
        {
            if (_clock == null)
            {
                _clock = now;
                _preClockTime = getTimer();
            }
            else
            {
                _clock.time = _clock.time + (getTimer() - _preClockTime);
                _preClockTime = getTimer();
            }
            return _clock.getTime();
        }// end function

        public static function get npcStack()
        {
            return _npcStack;
        }// end function

        public static function set npcStack(param1)
        {
            _npcStack = param1;
            return;
        }// end function

        public static function get eventStack()
        {
            return _eventStack;
        }// end function

        public static function set eventStack(param1)
        {
            _eventStack = param1;
            return;
        }// end function

        public static function get loginUI()
        {
            return _loginUI;
        }// end function

        public static function set loginUI(param1)
        {
            _loginUI = param1;
            return;
        }// end function

        public static function get account()
        {
            return _account;
        }// end function

        public static function set account(param1)
        {
            _account = param1;
            return;
        }// end function

        public static function get loginName()
        {
            return _loginName;
        }// end function

        public static function set loginName(param1)
        {
            _loginName = param1;
            return;
        }// end function

        public static function get loginPass()
        {
            return _loginPass;
        }// end function

        public static function set loginPass(param1)
        {
            _loginPass = param1;
            return;
        }// end function

        public static function get loginIp()
        {
            return _loginIp;
        }// end function

        public static function set loginIp(param1)
        {
            _loginIp = param1;
            return;
        }// end function

        public static function get loginPort()
        {
            return _loginPort;
        }// end function

        public static function set loginPort(param1)
        {
            _loginPort = param1;
            return;
        }// end function

        public static function get gravity() : Number
        {
            return _gravity;
        }// end function

        public static function set gravity(param1)
        {
            _gravity = param1;
            return;
        }// end function

        public static function get map() : Map
        {
            return _map;
        }// end function

        public static function set map(param1)
        {
            _map = param1;
            return;
        }// end function

        public static function get mapId() : uint
        {
            return _mapId;
        }// end function

        public static function set mapId(param1)
        {
            _mapId = param1;
            return;
        }// end function

        public static function get player() : Player
        {
            return _player;
        }// end function

        public static function set player(param1)
        {
            _player = param1;
            return;
        }// end function

        public static function get ui() : GameUI
        {
            return _ui;
        }// end function

        public static function set ui(param1)
        {
            _ui = param1;
            return;
        }// end function

        public static function get main()
        {
            return _main;
        }// end function

        public static function set main(param1)
        {
            _main = param1;
            _mainScene = param1;
            return;
        }// end function

        public static function get editor()
        {
            return _editor;
        }// end function

        public static function set editor(param1)
        {
            _editor = param1;
            _mainScene = param1;
            return;
        }// end function

        public static function get stage() : Stage
        {
            return _stage;
        }// end function

        public static function set stage(param1)
        {
            clearInterval(_fpsTimer);
            if (_stage != null)
            {
                _stage.removeEventListener(Event.ENTER_FRAME, frameCount);
            }
            _stage = param1;
            _fps = _stage.frameRate;
            _fpsCount = 0;
            _fpsTimer = setInterval(testFps, 1000);
            _stage.addEventListener(Event.ENTER_FRAME, frameCount);
            _stage.addEventListener(Event.ACTIVATE, handleFocusIn);
            _stage.addEventListener(Event.DEACTIVATE, handleFocusOut);
            _stage.addEventListener(Event.MOUSE_LEAVE, handleMouseLeave);
            _stage.addEventListener(MouseEvent.MOUSE_OVER, handleMouseOver);
            _stage.scaleMode = StageScaleMode.NO_SCALE;
            _stage.align = StageAlign.TOP_LEFT;
            return;
        }// end function

        private static function handleMouseLeave(param1)
        {
            stageMouseOver = false;
            return;
        }// end function

        private static function handleMouseOver(param1)
        {
            stageMouseOver = true;
            return;
        }// end function

        private static function handleFocusIn(param1)
        {
            stageFocus = true;
            return;
        }// end function

        private static function handleFocusOut(param1)
        {
            stageFocus = false;
            return;
        }// end function

        private static function testFps()
        {
            _fps = Math.max(25, Math.round(_fpsCount));
            _fpsCount = 0;
            return;
        }// end function

        private static function frameCount(param1)
        {
            var _loc_3:* = _fpsCount + 1;
            _fpsCount = _loc_3;
            return;
        }// end function

        public static function get fps()
        {
            return _fps;
        }// end function

        public static function set fps(param1)
        {
            clearInterval(_fpsTimer);
            _fpsCount = 0;
            if (!_fpsFreezed)
            {
                clearInterval(_fpsTimer);
                _fpsTimer = setInterval(testFps, 1000);
            }
            _fps = param1;
            return;
        }// end function

        public static function freezeFps(param1)
        {
            _fpsFreezed = true;
            clearInterval(_fpsTimer);
            _fps = param1;
            return;
        }// end function

        public static function findIconURL(param1)
        {
            if (param1 == null)
            {
                param1 = "default";
            }
            var _loc_2:* = "stuff/icon/" + String(param1) + ".png";
            return _loc_2;
        }// end function

        public static function findIcon(param1, param2 = 32, param3 = 32)
        {
            var _loc_6:* = null;
            if (param1 == null)
            {
                param1 = "default";
            }
            var _loc_4:* = "stuff/icon/" + String(param1) + ".png";
            var _loc_5:* = BitmapLoader.pick(_loc_4);
            if (BitmapLoader.pick(_loc_4) != null)
            {
                _loc_6 = new BitmapData(param2, param3, true, 0);
                _loc_6.copyPixels(_loc_5, _loc_5.rect, new Point(Math.floor((_loc_6.width - _loc_5.width) / 2), Math.floor((_loc_6.height - _loc_5.height) / 2)), null, null);
                _loc_5.dispose();
                return _loc_6;
            }
            var _loc_7:* = [_loc_4];
            var _loc_8:* = BitmapLoader.newBitmapLoader();
            _loc_6 = new BitmapData(param2, param3, true, 0);
            _loc_8.addEventListener("complete", handleBmpdLoadIcon);
            _loc_8.load(_loc_7);
            _bmpdDict[_loc_8] = {bmp:_loc_6, url:_loc_4};
            return _loc_6;
        }// end function

        private static function handleBmpdLoadIcon(param1)
        {
            var event:* = param1;
            event.target.removeEventListener("complete", handleBmpdLoadIcon);
            var obj:* = _bmpdDict[event.target];
            var bmp:* = obj.bmp;
            var bmpd:* = BitmapLoader.pick(obj.url);
            delete _bmpdDict[event.target];
            try
            {
                bmp.copyPixels(bmpd, bmpd.rect, new Point(Math.floor((bmp.width - bmpd.width) / 2), Math.floor((bmp.height - bmpd.height) / 2)), null, null);
                bmpd.dispose();
            }
            catch (e)
            {
            }
            return;
        }// end function

        public static function findHead(param1, param2 = 64, param3 = 64)
        {
            var _loc_4:* = "stuff/pic/head/" + String(param1) + ".png";
            var _loc_5:* = BitmapLoader.pick(_loc_4);
            if (BitmapLoader.pick(_loc_4) != null)
            {
                return _loc_5;
            }
            var _loc_6:* = [_loc_4];
            var _loc_7:* = BitmapLoader.newBitmapLoader();
            var _loc_8:* = new BitmapData(param2, param3, true, 0);
            _loc_7.addEventListener("complete", handleBmpdLoad);
            _loc_7.load(_loc_6);
            _bmpdDict[_loc_7] = {bmp:_loc_8, url:_loc_4};
            return _loc_8;
        }// end function

        public static function findsysUI(param1:String, param2:uint = 64, param3:uint = 64, param4:String = ".png") : BitmapData
        {
            var _loc_5:* = "stuff/ui/" + param1 + param4;
            var _loc_6:* = BitmapLoader.pick(_loc_5);
            if (BitmapLoader.pick(_loc_5) != null)
            {
                return _loc_6;
            }
            var _loc_7:* = [_loc_5];
            var _loc_8:* = BitmapLoader.newBitmapLoader();
            var _loc_9:* = new BitmapData(param2, param3, true, 0);
            _loc_8.addEventListener("complete", handleBmpdLoad);
            _loc_8.load(_loc_7);
            _bmpdDict[_loc_8] = {bmp:_loc_9, url:_loc_5};
            return _loc_9;
        }// end function

        public static function findFigure(param1)
        {
            var _loc_2:* = "stuff/pic/figure/" + String(param1) + ".png";
            var _loc_3:* = BitmapLoader.pick(_loc_2);
            if (_loc_3 != null)
            {
                return _loc_3;
            }
            var _loc_4:* = [_loc_2];
            var _loc_5:* = BitmapLoader.newBitmapLoader();
            var _loc_6:* = new BitmapData(200, 300, true, 0);
            _loc_5.addEventListener("complete", handleBmpdLoad);
            _loc_5.load(_loc_4);
            _bmpdDict[_loc_5] = {bmp:_loc_6, url:_loc_2};
            return _loc_6;
        }// end function

        public static function findPaint(param1, param2, param3, param4, param5, param6)
        {
            var _loc_7:* = "stuff/pic/paint/" + String(param1) + ".png";
            var _loc_8:* = BitmapLoader.pick(_loc_7);
            if (BitmapLoader.pick(_loc_7) != null)
            {
                return _loc_8;
            }
            var _loc_9:* = [_loc_7];
            var _loc_10:* = BitmapLoader.newBitmapLoader();
            var _loc_11:* = new BitmapData(param2, param3, true, 0);
            _loc_10.addEventListener("complete", handleBmpdLoadPaint);
            _loc_10.load(_loc_9);
            _bmpdDict[_loc_10] = {bmp:_loc_11, url:_loc_7, scale:param4, tx:param5, ty:param6};
            return _loc_11;
        }// end function

        private static function handleBmpdLoadPaint(param1)
        {
            var matrix:Matrix;
            var event:* = param1;
            event.target.removeEventListener("complete", handleBmpdLoadPaint);
            var obj:* = _bmpdDict[event.target];
            var bmp:* = obj.bmp;
            var bmpd:* = BitmapLoader.pick(obj.url);
            delete _bmpdDict[event.target];
            try
            {
                matrix = new Matrix();
                matrix.scale(obj.scale, obj.scale);
                matrix.translate(obj.tx, obj.ty);
                bmp.draw(bmpd, matrix, null, null, null, true);
                bmpd.dispose();
            }
            catch (e)
            {
            }
            return;
        }// end function

        private static function handleBmpdLoad(param1)
        {
            var event:* = param1;
            event.target.removeEventListener("complete", handleBmpdLoad);
            var obj:* = _bmpdDict[event.target];
            var bmp:* = obj.bmp;
            var bmpd:* = BitmapLoader.pick(obj.url);
            delete _bmpdDict[event.target];
            try
            {
                bmp.copyPixels(bmpd, bmp.rect, new Point());
                bmpd.dispose();
            }
            catch (e)
            {
            }
            return;
        }// end function

        public static function findUI(param1)
        {
            return _xmlMap["ui.xml"][param1];
        }// end function

        public static function message(param1:String, param2:uint = 0, param3:Object = null) : void
        {
            if (ui != null)
            {
                ui._messagetips.addmessage(param1, param2, param3);
            }
            return;
        }// end function

        public static function addHistory(param1:String) : void
        {
            ui._mesHistoryPanel.addHistory(param1);
            return;
        }// end function

        public static function get Alert()
        {
            return ui._alertUI;
        }// end function

        public static function set Alert(param1) : void
        {
            ui._alertUI = param1;
            return;
        }// end function

        public static function stopAuto()
        {
            DistrictMap.stop();
            Hang.stop();
            if (ui != null)
            {
                ui._taskpanel.stopAuto();
            }
            return;
        }// end function

        public static function set MouseShape(param1:String) : void
        {
            if (ui != null)
            {
                ui._mousepointer.MouseShape(param1);
                ui._mousepointer.mouseTip = "";
            }
            return;
        }// end function

        public static function get MouseShape() : String
        {
            return ui._mousepointer.getMouseShape();
        }// end function

        public static function setMouseState(param1:String, param2:Boolean) : void
        {
            ui._mousepointer.setMouseState(param1, param2);
            return;
        }// end function

        public static function getMouseState() : String
        {
            return ui._mousepointer.getMouseState();
        }// end function

        public static function create(param1:Function, ... args) : Function
        {
            args = new activation;
            var F:Boolean;
            var _f:Function;
            var f:* = param1;
            var arg:* = args;
            F;
            _f = function (param1) : void
            {
                var _loc_2:* = arg;
                if (!F)
                {
                    F = true;
                    _loc_2.unshift(param1);
                    if (f.length == (_loc_2.length + 1))
                    {
                        _loc_2.push(_f);
                    }
                }
                f.apply(null, _loc_2);
                return;
            }// end function
            ;
            return ;
        }// end function

        public static function clearMap(param1 = false)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            for (_loc_2 in Dummy._deadMonsterPosBuff)
            {
                
                delete Dummy._deadMonsterPosBuff[_loc_2];
            }
            Bard.clear();
            Dummy._deadMonsterPosBuff = {};
            Effect.destroyAll();
            Item.destroyMap();
            Missle.destroyAll();
            Shell.destroyAll();
            Rocket.destroyAll();
            BitmapLoader.clearBuff();
            Picset.clearBuff();
            Tileset.clearBuff();
            Npc._skyNpcStack = {};
            if (_player != null)
            {
                _player.stopBinding();
            }
            if (param1)
            {
                Unit.destroyAll(null, _player);
            }
            else
            {
                Skill.selectedSkill = null;
                Unit.destroyAll(null, _player);
                UnitClip.clearBuff();
                if (player != null)
                {
                    _loc_3 = {};
                    for (_loc_2 in player._buffEffect)
                    {
                        
                        _loc_3[_loc_2] = player._buffEffect[_loc_2].count;
                    }
                    player.destroy();
                    Unit._unitStack[UNIT_TYPE_ENUM.TYPEID_PLAYER][player.id] = player;
                    var _loc_4:* = Unit;
                    var _loc_5:* = Unit._allCount + 1;
                    _loc_4._allCount = _loc_5;
                    for (_loc_2 in _loc_3)
                    {
                        
                        player.addBuff(_loc_2, _loc_3[_loc_2]);
                    }
                }
                clearDisplayList(map._footMap);
                clearDisplayList(map._rootMap);
                clearDisplayList(map._textMap);
                gc();
            }
            return;
        }// end function

        public static function clearDisplayList(param1:DisplayObjectContainer) : void
        {
            var _loc_2:* = undefined;
            if (param1 == null || param1 is StateBar)
            {
                return;
            }
            while (param1.numChildren > 0)
            {
                
                _loc_2 = param1.getChildAt(0);
                if (_loc_2 is DisplayObjectContainer)
                {
                    clearDisplayList(DisplayObjectContainer(_loc_2));
                }
                if (_loc_2 is Sprite || _loc_2 is Shape)
                {
                    _loc_2.graphics.clear();
                }
                param1.removeChildAt(0);
            }
            return;
        }// end function

        public static function coinShow(param1:Number) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = String(param1);
            var _loc_4:* = 0;
            var _loc_5:* = int((_loc_3.length - 1));
            while (_loc_5 >= 0)
            {
                
                _loc_4++;
                if (_loc_5 == 0)
                {
                    if (_loc_2 == "")
                    {
                        _loc_2 = _loc_3.substr(_loc_5, _loc_4);
                    }
                    else
                    {
                        _loc_2 = _loc_3.substr(_loc_5, _loc_4) + "," + _loc_2;
                    }
                }
                else if (_loc_4 == 3)
                {
                    if (_loc_2 == "")
                    {
                        _loc_2 = _loc_3.substr(_loc_5, 3);
                    }
                    else
                    {
                        _loc_2 = _loc_3.substr(_loc_5, 3) + "," + _loc_2;
                    }
                    _loc_4 = 0;
                }
                _loc_5 = _loc_5 - 1;
            }
            return _loc_2;
        }// end function

        public static function backcoin(param1:String) : Number
        {
            var _loc_2:* = param1;
            var _loc_3:* = /,"",/g;
            _loc_2 = param1.replace(_loc_3, "");
            return Number(_loc_2);
        }// end function

        public static function startLoop(param1:Function)
        {
            stopLoop(param1);
            _mainScene.addEventListener(Event.ENTER_FRAME, param1);
            return;
        }// end function

        public static function stopLoop(param1:Function)
        {
            _mainScene.removeEventListener(Event.ENTER_FRAME, param1);
            return;
        }// end function

        public static function set paused(param1)
        {
            _paused = param1;
            return;
        }// end function

        public static function get paused()
        {
            return _paused;
        }// end function

        public static function showTime(param1:Number, param2:Boolean = false, param3:String = ":", param4:String = ":") : String
        {
            var _loc_5:* = param1 / 60 / 60 >> 0;
            var _loc_6:* = param1 / 60 % 60;
            var _loc_7:* = param1 % 60;
            var _loc_8:* = "";
            if (param2)
            {
                _loc_8 = _loc_8 + ((_loc_5 > 100 ? (_loc_5.toString()) : ((100 + _loc_5).toString().substr(1))) + param3);
            }
            _loc_8 = _loc_8 + ((_loc_6 < 10 ? ("0" + _loc_6.toString()) : (_loc_6.toString())) + param4);
            _loc_8 = _loc_8 + (_loc_7 < 10 ? ("0" + _loc_7.toString()) : (_loc_7.toString()));
            return _loc_8;
        }// end function

        public static function checkVersion() : uint
        {
            var _loc_1:* = Capabilities.version;
            var _loc_2:* = _loc_1.split(/[,\ ]""[,\ ]/);
            var _loc_3:* = Number(_loc_2[1]);
            var _loc_4:* = Number(_loc_2[3]);
            return _loc_3;
        }// end function

        public static function set serverTime(param1)
        {
            var _loc_2:* = new Date();
            _serverTimeOffset = param1 * 1000 - _loc_2.getTime();
            var _loc_3:* = new Date();
            _loc_3.setTime(param1 * 1000);
            return;
        }// end function

        public static function get now() : Date
        {
            var _loc_1:* = new Date();
            _loc_1.setTime(_loc_1.getTime() + _serverTimeOffset + _serverTimeZoneOffset);
            return _loc_1;
        }// end function

        public static function timeShow(param1:int = 0, param2:int = 3) : String
        {
            var _loc_3:* = "";
            var _loc_4:* = String(Math.floor(param1 / 3600));
            var _loc_5:* = String(Math.floor(param1 % 3600 / 60));
            var _loc_6:* = String(param1 % 60);
            if (int(_loc_4) < 0)
            {
                _loc_4 = "0";
            }
            if (int(_loc_5) > 0)
            {
                if (int(_loc_4) > 0 && int(_loc_5) < 10)
                {
                    _loc_5 = "0" + _loc_5;
                }
            }
            else if (int(_loc_4) > 0)
            {
                _loc_5 = "00";
            }
            else
            {
                _loc_5 = "0";
            }
            if (int(_loc_6) > 0)
            {
                if (int(_loc_6) < 10)
                {
                    _loc_6 = "0" + _loc_6;
                }
            }
            else
            {
                _loc_6 = "00";
            }
            switch(param2)
            {
                case 1:
                {
                    if (int(_loc_4) == 0 && int(_loc_5) == 0)
                    {
                        _loc_3 = _loc_6;
                    }
                    else if (int(_loc_4) == 0)
                    {
                        _loc_3 = _loc_5 + " : " + _loc_6;
                    }
                    else
                    {
                        _loc_3 = _loc_4 + " : " + _loc_5 + " : " + _loc_6;
                    }
                    break;
                }
                case 2:
                {
                    if (int(_loc_4) == 0 && int(_loc_5) == 0)
                    {
                        _loc_3 = language("Config", 1, _loc_6);
                    }
                    else if (int(_loc_4) == 0)
                    {
                        _loc_3 = language("Config", 2, _loc_5, _loc_6);
                    }
                    else
                    {
                        _loc_3 = language("Config", 3, _loc_4, _loc_5, _loc_6);
                    }
                    break;
                }
                case 3:
                {
                    if (int(_loc_4) > 0)
                    {
                        _loc_3 = _loc_4 + " : " + _loc_5 + " : " + _loc_6;
                    }
                    else
                    {
                        _loc_3 = _loc_5 + " : " + _loc_6;
                    }
                    break;
                }
                default:
                {
                    if (int(_loc_4) == 0 && int(_loc_5) == 0)
                    {
                        _loc_3 = _loc_6;
                    }
                    else if (int(_loc_4) == 0)
                    {
                        _loc_3 = _loc_5 + " : " + _loc_6;
                    }
                    else
                    {
                        _loc_3 = _loc_4 + " : " + _loc_5 + ":" + _loc_6;
                    }
                    break;
                    break;
                }
            }
            return _loc_3;
        }// end function

        public static function timePoint(param1:int = 0, param2:int = 3) : String
        {
            if (param1 >= now.getTime() / 1000)
            {
                return timeShow(int(param1 - now.getTime() / 1000), param2);
            }
            return timeShow(0, param2);
        }// end function

        public static function bytesToString(param1:uint) : String
        {
            var _loc_2:* = null;
            if (param1 < 1024)
            {
                _loc_2 = String(param1) + "b";
            }
            else if (param1 < 10240)
            {
                _loc_2 = Number(param1 / 1024).toFixed(2) + "kb";
            }
            else if (param1 < 102400)
            {
                _loc_2 = Number(param1 / 1024).toFixed(1) + "kb";
            }
            else if (param1 < 1048576)
            {
                _loc_2 = int(param1 / 1024) + "kb";
            }
            else if (param1 < 10485760)
            {
                _loc_2 = Number(param1 / 1048576).toFixed(2) + "mb";
            }
            else if (param1 < 104857600)
            {
                _loc_2 = Number(param1 / 1048576).toFixed(1) + "mb";
            }
            else
            {
                _loc_2 = int(param1 / 1048576) + "mb";
            }
            return _loc_2;
        }// end function

        public static function language(param1:String, param2:int, ... args) : String
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            args = "";
            if (_language.hasOwnProperty(param1))
            {
                if (_language[param1].hasOwnProperty(param2))
                {
                    args = _language[param1][param2];
                }
            }
            var _loc_5:* = args;
            if (args != null)
            {
                _loc_6 = 0;
                while (_loc_6 < _loc_5.length)
                {
                    
                    _loc_7 = "%p" + int((_loc_6 + 1));
                    _loc_8 = new RegExp(_loc_7, "g");
                    args = args.replace(_loc_8, _loc_5[_loc_6]);
                    _loc_6 = _loc_6 + 1;
                }
            }
            return args;
        }// end function

        public static function set jobTitleMap(param1)
        {
            _jobTitleMap = param1;
            return;
        }// end function

        public static function get jobTitleMap()
        {
            return _jobTitleMap;
        }// end function

        public static function getSimpleTextField()
        {
            var _loc_1:* = new TextField();
            _loc_1.selectable = false;
            _loc_1.autoSize = TextFieldAutoSize.LEFT;
            _loc_1.mouseEnabled = false;
            if (_switchEnglish)
            {
                _loc_1.defaultTextFormat = new TextFormat("Tahoma", 12);
            }
            return _loc_1;
        }// end function

    }
}
