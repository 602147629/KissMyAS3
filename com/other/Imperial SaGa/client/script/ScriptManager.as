package script
{
    import button.*;
    import develop.*;
    import flash.display.*;
    import layer.*;
    import quest.*;
    import resource.*;
    import sound.*;
    import user.*;
    import utility.*;

    public class ScriptManager extends Object
    {
        private var _aScriptScreen:Array;
        private var _aXmlLoader:Array;
        private var _scriptLoadingCount:int;
        private var _scriptExe:ScriptMain;
        private var _aCommand:Array;
        private var _comIndex:int;
        private var _gotoComIndex:int;
        private var _aCharacter:Array;
        private var _aBackground:Array;
        private var _aBalloon:Array;
        private var _aNarration:Array;
        private var _aSoundBgm:Array;
        private var _aMovie:Array;
        private var _aMonologue:Array;
        private var _aMonologue2:Array;
        private var _fade:ScriptParamFade;
        private var _fadeAlpha:ScriptParamFadeAlpha;
        private var _shake:ScriptParamShake;
        private var _aInformation:Array;
        private var _select:ScriptParamSelect;
        private var _autoSelect:ScriptParamAutoSelect;
        private var _scriptStartBgmId:int;
        private var _mcEvent:MovieClip;
        private var _isoEvent:InStayOut;
        private var _bSkipEnable:Boolean;
        private var _bSkipCtrlStart:Boolean;
        private var _commandSkipCtrl:ScriptSkipControl;
        private var _commandPhase:int;
        private var _commandSkipBgmId:int;
        private var _btnNext:ButtonBase;
        private var _isoNext:InStayOut;
        private var _checkParam:ScriptParamBase;
        private var _layer:LayerEvent;
        private var _layerChr:Sprite;
        private var _layerChrTop:Sprite;
        private var _layerBg:Sprite;
        private var _aOnFlag:Array;
        private var _aChangeFlag:Array;
        private var _aFlagData:Array;
        private var _loader:XmlLoader;
        private static const _COMMAND_PHASE_PLAY:int = 0;
        private static const _COMMAND_PHASE_SKIP_START:int = 1;
        private static const _COMMAND_PHASE_SKIP_WAIT:int = 2;
        private static const _COMMAND_PHASE_SKIP_CANCEL:int = 3;
        public static const SCRIPT_PATH:String = "resource/Script/";
        private static var _instance:ScriptManager = null;

        public function ScriptManager()
        {
            return;
        }// end function

        public function loadResource() : void
        {
            SoundManager.getInstance().loadSoundArray([SoundId.SE_SIGNBOARD, SoundId.SE_SELECT_WINDOW, SoundId.SE_STAGE_APPIER, SoundId.SE_RS3_SYSTEM_CURSOR]);
            return;
        }// end function

        public function isLoaded() : Boolean
        {
            return this._scriptLoadingCount <= 0;
        }// end function

        public function get scriptExe() : ScriptMain
        {
            return this._scriptExe;
        }// end function

        public function getFade() : ScriptParamFade
        {
            if (this._fade == null)
            {
                this._fade = new ScriptParamFade();
            }
            return this._fade;
        }// end function

        public function getFadeAlpha() : ScriptParamFadeAlpha
        {
            if (this._fadeAlpha == null)
            {
                this._fadeAlpha = new ScriptParamFadeAlpha();
            }
            return this._fadeAlpha;
        }// end function

        public function get shake() : ScriptParamShake
        {
            return this._shake;
        }// end function

        public function set shake(param1:ScriptParamShake) : void
        {
            this._shake = param1;
            return;
        }// end function

        public function get mcEvent() : MovieClip
        {
            return this._mcEvent;
        }// end function

        public function get isoEvent() : InStayOut
        {
            return this._isoEvent;
        }// end function

        public function setSkipBgmId(param1:int) : void
        {
            this._commandSkipBgmId = param1;
            return;
        }// end function

        public function init() : void
        {
            this._aScriptScreen = [];
            this._aXmlLoader = [];
            this._aOnFlag = new Array();
            this._aChangeFlag = new Array();
            this._scriptLoadingCount = 0;
            this._fade = null;
            this._fadeAlpha = null;
            return;
        }// end function

        public function defaultResourceLoad() : void
        {
            ResourceManager.getInstance().loadResource(ScriptManager.getResourcePath());
            return;
        }// end function

        public function loadListData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "FlagList.xml", this.cbLoadComplete, false);
            return;
        }// end function

        public function isListLoaded() : Boolean
        {
            if (this._loader != null)
            {
                return this._loader.bLoaded;
            }
            return false;
        }// end function

        private function cbLoadComplete(param1:XML) : void
        {
            var _loc_2:* = null;
            this._aFlagData = [];
            for each (param1 in param1.Flag)
            {
                
                _loc_2 = new FlagInfomation();
                _loc_2.setFlagInfomation(param1);
                this._aFlagData.push(_loc_2);
            }
            this._loader.release();
            this._loader = null;
            return;
        }// end function

        public function releaseProcess() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this._aChangeFlag = [];
            for (_loc_1 in this._aScriptScreen)
            {
                
                _loc_2 = this._aScriptScreen[_loc_1];
                if (_loc_2.bRelease)
                {
                    _loc_2.release();
                    delete this._aScriptScreen[_loc_1];
                }
            }
            return;
        }// end function

        public function loadScript(param1:String, param2:int, param3:Boolean) : void
        {
            var path:* = param1;
            var screen:* = param2;
            var bRelease:* = param3;
            if (this._aScriptScreen[path] != null)
            {
                return;
            }
            DebugLog.print("LoadScript:" + path);
            var scriptScreen:* = new ScriptScreen(screen, bRelease);
            this._aScriptScreen[path] = scriptScreen;
            var xmlLoarder:* = new XmlLoader();
            this._aXmlLoader[path] = xmlLoarder;
            xmlLoarder.load(path, function (param1:XML) : void
            {
                cbScriptLoaded(path, param1);
                return;
            }// end function
            , true);
            var _loc_5:* = this;
            var _loc_6:* = this._scriptLoadingCount + 1;
            _loc_5._scriptLoadingCount = _loc_6;
            return;
        }// end function

        private function cbScriptLoaded(param1:String, param2:XML) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            DebugLog.print("スクリプトの読み込み成功");
            var _loc_3:* = this._aScriptScreen[param1];
            for each (_loc_4 in param2.children())
            {
                
                _loc_6 = new ScriptMain();
                if (_loc_3.screen == ScriptScreen.SCREEN_QUEST_PAYMENT_EVENT)
                {
                    _loc_6.bPayment = true;
                }
                _loc_6.setXmlInformation(_loc_4.Information[0]);
                _loc_6.setXmlStartUp(_loc_4.StartUp[0]);
                _loc_6.setCommandToBinary(_loc_4.Command);
                _loc_3.addScriptMain(_loc_6);
            }
            this._aScriptScreen[param1] = _loc_3;
            _loc_5 = this._aXmlLoader[param1] as XmlLoader;
            _loc_5.release();
            this._aXmlLoader[param1] = null;
            var _loc_7:* = this;
            var _loc_8:* = this._scriptLoadingCount - 1;
            _loc_7._scriptLoadingCount = _loc_8;
            return;
        }// end function

        private function createCommand(param1:XMLList) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in param1.children())
            {
                
                _loc_4 = null;
                _loc_5 = _loc_3.name();
                switch(_loc_5)
                {
                    case ScriptComConstant.SCRIPT_EVENT_START:
                    {
                        _loc_4 = new ScriptComEventStart();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_EVENT_END:
                    {
                        _loc_4 = new ScriptComEventEnd();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_INFORMATION:
                    {
                        _loc_4 = new ScriptComInformation();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_CHARACTER_SET:
                    {
                        _loc_4 = new ScriptComCharacterSet();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_CHARACTER_ANIMATION:
                    {
                        _loc_4 = new ScriptComCharacterAnimation();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_CHARACTER_DISPLAY:
                    {
                        _loc_4 = new ScriptComCharacterDisplay();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_CHARACTER_DISPLAY_TOP:
                    {
                        _loc_4 = new ScriptComCharacterDisplayTop();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_CHARACTER_PRIORITY_TOP:
                    {
                        _loc_4 = new ScriptComCharacterPriorityTop();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_CHARACTER_DIRECTION:
                    {
                        _loc_4 = new ScriptComCharacterDirection();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_CHARACTER_MOVE:
                    {
                        _loc_4 = new ScriptComCharacterMove();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_CHARACTER_MOVE_ALPHA:
                    {
                        _loc_4 = new ScriptComCharacterMoveAlpha();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_CHARACTER_ERASE_FLASH:
                    {
                        _loc_4 = new ScriptComCharacterEraseFlash();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_CHARACTER_FADE_OUT:
                    {
                        _loc_4 = new ScriptComCharacterFadeOut();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_CHARACTER_FADE_IN:
                    {
                        _loc_4 = new ScriptComCharacterFadeIn();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_CHARACTER_ALPHA:
                    {
                        _loc_4 = new ScriptComCharacterAlpha();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BACKGROUND_SET:
                    {
                        _loc_4 = new ScriptComBackgroundSet();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BACKGROUND_DISPLAY:
                    {
                        _loc_4 = new ScriptComBackgroundDisplay();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BACKGROUND_FADE_OUT:
                    {
                        _loc_4 = new ScriptComBackgroundFadeOut();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BACKGROUND_FADE_IN:
                    {
                        _loc_4 = new ScriptComBackgroundFadeIn();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BACKGROUND_SCROLL:
                    {
                        _loc_4 = new ScriptComBackgroundScroll();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BACKGROUND_ALPHA:
                    {
                        _loc_4 = new ScriptComBackgroundAlpha();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BACKGROUND_SCROLL:
                    {
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BGM_SET:
                    {
                        _loc_4 = new ScriptComBgmSet();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BGM_PLAY:
                    {
                        _loc_4 = new ScriptComBgmPlay();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BGM_STOP:
                    {
                        _loc_4 = new ScriptComBgmStop();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_SE_SET:
                    {
                        _loc_4 = new ScriptComSeSet();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_SE_PLAY:
                    {
                        _loc_4 = new ScriptComSePlay();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_MOVIE_SET:
                    {
                        _loc_4 = new ScriptComMovieSet();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_MOVIE_PLAY:
                    {
                        _loc_4 = new ScriptComMoviePlay();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_MOVIE_PLAY_2:
                    {
                        _loc_4 = new ScriptComMoviePlay2();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_LOAD_WAIT:
                    {
                        _loc_4 = new ScriptComLoadWait();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BALLOON_SET:
                    {
                        _loc_4 = new ScriptComBalloonSet();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BALLOON_SET_CHARACTER:
                    {
                        _loc_4 = new ScriptComBalloonSetCharacter();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BALLOON_SET_MESSAGE_SE:
                    {
                        _loc_4 = new ScriptComBalloonSetMessageSe();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BALLOON_SET_MESSAGE_SPEED:
                    {
                        _loc_4 = new ScriptComBalloonSetMessageSpeed();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BALLOON_SET_MESSAGE_WAIT:
                    {
                        _loc_4 = new ScriptComBalloonSetMessageWait();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BALLOON_SPEECH:
                    {
                        _loc_4 = new ScriptComBalloonSpeech();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BALLOON_DISPLAY:
                    {
                        _loc_4 = new ScriptComBalloonDisplay();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_BALLOON_CLOSE:
                    {
                        _loc_4 = new ScriptComBalloonClose();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_NARRATION_SET:
                    {
                        _loc_4 = new ScriptComNarrationSet();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_NARRATION_SET_MESSAGE_SE:
                    {
                        _loc_4 = new ScriptComNarrationSetMessageSe();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_NARRATION_SET_MESSAGE_SPEED:
                    {
                        _loc_4 = new ScriptComNarrationSetMessageSpeed();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_NARRATION_SET_MESSAGE_WAIT:
                    {
                        _loc_4 = new ScriptComNarrationSetMessageWait();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_NARRATION_MESSAGE:
                    {
                        _loc_4 = new ScriptComNarrationMessage();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_NARRATION_DISPLAY:
                    {
                        _loc_4 = new ScriptComNarrationDisplay();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_NARRATION_CLOSE:
                    {
                        _loc_4 = new ScriptComNarrationClose();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_MONOLOGUE:
                    {
                        _loc_4 = new ScriptComMonologue();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_MONOLOGUE2:
                    {
                        _loc_4 = new ScriptComMonologue2();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_MONOLOGUE3:
                    {
                        _loc_4 = new ScriptComMonologue3();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_LABEL:
                    {
                        _loc_4 = new ScriptComLabel();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_WAIT:
                    {
                        _loc_4 = new ScriptComWait();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_SELECT:
                    {
                        _loc_4 = new ScriptComSelect();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_SELECT_PASSIVE:
                    {
                        _loc_4 = new ScriptComSelectPassive();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_AUTO_SELECT:
                    {
                        _loc_4 = new ScriptComAutoSelect();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_DECIDE_SELECT:
                    {
                        _loc_4 = new ScriptComDecideSelect();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_GOTO:
                    {
                        _loc_4 = new ScriptComGoto();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_FADE_OUT:
                    {
                        _loc_4 = new ScriptComFadeOut();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_FADE_IN:
                    {
                        _loc_4 = new ScriptComFadeIn();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_FADE_OUT_ALPHA:
                    {
                        _loc_4 = new ScriptComFadeOutAlpha();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_FADE_IN_ALPHA:
                    {
                        _loc_4 = new ScriptComFadeInAlpha();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_SHAKE:
                    {
                        _loc_4 = new ScriptComShake();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_SHAKE_LOOP:
                    {
                        _loc_4 = new ScriptComShakeLoop();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_SHAKE_END:
                    {
                        _loc_4 = new ScriptComShakeEnd();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_HIPPOPOTAMUS_CHECK:
                    {
                        _loc_4 = new ScriptComHippopotamusCheck();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_IF_FLAG:
                    {
                        _loc_4 = new ScriptComIfFlag();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_IF_FLAG_AND:
                    {
                        _loc_4 = new ScriptComIfFlagAnd();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_IF_FLAG_OR:
                    {
                        _loc_4 = new ScriptComIfFlagOr();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_FLAG:
                    {
                        _loc_4 = new ScriptComFlag();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_IF_QUEST_FLAG_AND:
                    {
                        _loc_4 = new ScriptComIfQuestFlagAnd();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_IF_QUEST_FLAG_OR:
                    {
                        _loc_4 = new ScriptComIfQuestFlagOr();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_QUEST_FLAG:
                    {
                        _loc_4 = new ScriptComQuestFlag();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_PAYMENT_EVENT_SELECT:
                    {
                        if (!this.isPaymentEvent())
                        {
                            Assert.print("少額課金イベント以外のスクリプト内で専用コマンドSCRIPT_PAYMENT_EVENT_SELECTが呼ばれました");
                        }
                        _loc_4 = new ScriptComPaymentEventSelect();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_ROUTE_SELECT:
                    {
                        _loc_4 = new ScriptComRouteSelect();
                        break;
                    }
                    case ScriptComConstant.SCRIPT_PAYMENT_EVENT_END:
                    {
                        _loc_4 = new ScriptComPaymentEventEnd();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (_loc_4 != null)
                {
                    _loc_4.setXml(_loc_3);
                    _loc_2.push(_loc_4);
                }
            }
            return _loc_2;
        }// end function

        public function getScript(param1:int, param2:int) : ScriptMain
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            for (_loc_3 in this._aScriptScreen)
            {
                
                _loc_4 = this._aScriptScreen[_loc_3];
                if (_loc_4.screen != param1)
                {
                    continue;
                }
                for each (_loc_5 in _loc_4.aScriptMain)
                {
                    
                    if (_loc_5.bScriptEnd)
                    {
                        continue;
                    }
                    if (_loc_5.triggerId != param2)
                    {
                        continue;
                    }
                    if (_loc_5.chapter > 0 && _loc_5.chapter != UserDataManager.getInstance().userData.chapter)
                    {
                        continue;
                    }
                    if (_loc_5.progress > 0 && _loc_5.progress != UserDataManager.getInstance().userData.progress)
                    {
                        continue;
                    }
                    if (_loc_5.aEmperorId.length > 0 && _loc_5.aEmperorId.indexOf(UserDataManager.getInstance().userData.emperorId) == -1)
                    {
                        continue;
                    }
                    if (this.isFlagCheck(_loc_5))
                    {
                        return _loc_5;
                    }
                }
            }
            return null;
        }// end function

        private function isFlagCheck(param1:ScriptMain) : Boolean
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = false;
            var _loc_11:* = 0;
            var _loc_12:* = false;
            var _loc_13:* = 0;
            var _loc_14:* = false;
            var _loc_15:* = 0;
            var _loc_3:* = true;
            for each (_loc_4 in param1.aFlagAnd)
            {
                
                _loc_2 = this.getFlag(_loc_4.id);
                if (_loc_2 == null || _loc_2.value == false)
                {
                    _loc_3 = false;
                }
            }
            _loc_5 = param1.aFlagOr.length == 0 ? (true) : (false);
            for each (_loc_6 in param1.aFlagOr)
            {
                
                _loc_2 = this.getFlag(_loc_6.id);
                if (_loc_2 != null && _loc_2.value)
                {
                    _loc_5 = true;
                }
            }
            _loc_7 = true;
            for each (_loc_8 in param1.aFlagOff)
            {
                
                _loc_2 = this.getFlag(_loc_8.id);
                if (_loc_2 == null || _loc_2 != null && _loc_2.value)
                {
                    _loc_7 = false;
                }
            }
            _loc_10 = true;
            for each (_loc_11 in param1.aQuestFlagAnd)
            {
                
                _loc_9 = QuestManager.getInstance().getQuestFlag(_loc_11);
                if (_loc_9 == null || _loc_9.bState == false)
                {
                    _loc_10 = false;
                }
            }
            _loc_12 = param1.aQuestFlagOr.length == 0 ? (true) : (false);
            for each (_loc_13 in param1.aQuestFlagOr)
            {
                
                _loc_9 = QuestManager.getInstance().getQuestFlag(_loc_13);
                if (_loc_9 != null && _loc_9.bState)
                {
                    _loc_12 = true;
                }
            }
            _loc_14 = true;
            for each (_loc_15 in param1.aQuestFlagOff)
            {
                
                _loc_9 = QuestManager.getInstance().getQuestFlag(_loc_15);
                if (_loc_9 == null || _loc_9 != null && _loc_9.bState == true)
                {
                    _loc_14 = false;
                }
            }
            if (_loc_3 && _loc_5 && _loc_7 && _loc_10 && _loc_12 && _loc_14)
            {
                return true;
            }
            return false;
        }// end function

        public function getQuestScript(param1:int, param2:int) : ScriptMain
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = false;
            for (_loc_3 in this._aScriptScreen)
            {
                
                _loc_4 = this._aScriptScreen[_loc_3];
                if (_loc_4.screen != ScriptScreen.SCREEN_QUEST && _loc_4.screen != ScriptScreen.SCREEN_QUEST_PAYMENT_EVENT)
                {
                    continue;
                }
                for each (_loc_5 in _loc_4.aScriptMain)
                {
                    
                    if (_loc_5.bScriptEnd)
                    {
                        continue;
                    }
                    if (_loc_5.triggerId == param1)
                    {
                        _loc_6 = false;
                        switch(param1)
                        {
                            case ScriptComConstant.TRIGGER_BEFORE_OF_TITLE:
                            case ScriptComConstant.TRIGGER_AFTER_OF_TITLE:
                            {
                                _loc_6 = true;
                                break;
                            }
                            case ScriptComConstant.TRIGGER_PIECE_LANDING:
                            case ScriptComConstant.TRIGGER_BEFORE_OF_BATTLE:
                            case ScriptComConstant.TRIGGER_AFTER_OF_BATTLE:
                            case ScriptComConstant.TRIGGER_AFTER_OF_BATTLE_WIN:
                            case ScriptComConstant.TRIGGER_AFTER_OF_BATTLE_LOSE:
                            {
                                if (_loc_5.squareId == param2)
                                {
                                    _loc_6 = true;
                                }
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        if (_loc_6 == false)
                        {
                            continue;
                        }
                        if (this.isFlagCheck(_loc_5))
                        {
                            return _loc_5;
                        }
                    }
                }
            }
            return null;
        }// end function

        public function isQuestScriptSquare(param1:int) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            for (_loc_2 in this._aScriptScreen)
            {
                
                _loc_3 = this._aScriptScreen[_loc_2];
                if (_loc_3.screen != ScriptScreen.SCREEN_QUEST && _loc_3.screen != ScriptScreen.SCREEN_QUEST_PAYMENT_EVENT)
                {
                    continue;
                }
                for each (_loc_4 in _loc_3.aScriptMain)
                {
                    
                    if (_loc_4.squareId == param1)
                    {
                        return true;
                    }
                }
            }
            return false;
        }// end function

        public function getEndingScript(param1:int, param2:int) : ScriptMain
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            for (_loc_3 in this._aScriptScreen)
            {
                
                _loc_4 = this._aScriptScreen[_loc_3];
                if (_loc_4.screen != param1)
                {
                    continue;
                }
                for each (_loc_5 in _loc_4.aScriptMain)
                {
                    
                    if (_loc_5.bScriptEnd)
                    {
                        continue;
                    }
                    if (param2 != Constant.EMPTY_ID && _loc_5.scriptId != param2)
                    {
                        continue;
                    }
                    if (this.isFlagCheck(_loc_5))
                    {
                        return _loc_5;
                    }
                }
            }
            return null;
        }// end function

        public function getQuestEventScript(param1:String, param2:int) : ScriptMain
        {
            var _loc_5:* = null;
            var _loc_3:* = ScriptScreen.SCREEN_QUEST_EVENT;
            var _loc_4:* = this._aScriptScreen[param1];
            if (this._aScriptScreen[param1] && _loc_4.screen == _loc_3)
            {
                for each (_loc_5 in _loc_4.aScriptMain)
                {
                    
                    if (param2 != Constant.EMPTY_ID && _loc_5.scriptId != param2)
                    {
                        continue;
                    }
                    return _loc_5;
                }
            }
            return null;
        }// end function

        public function initScript(param1:ScriptMain, param2:DisplayObjectContainer) : void
        {
            var _loc_3:* = null;
            this._scriptExe = param1;
            this._scriptExe.init();
            this._aCommand = this.createCommand(this._scriptExe.getCommandXmlList());
            this._comIndex = 0;
            this._gotoComIndex = Constant.UNDECIDED;
            this._scriptStartBgmId = SoundManager.getInstance().bgmId;
            this._aCharacter = [];
            this._aBackground = [];
            this._aBalloon = [];
            this._aNarration = [];
            this._aSoundBgm = [];
            this._aMovie = [];
            this._aMonologue = [];
            this._aMonologue2 = [];
            this._aInformation = [];
            if (this._fadeAlpha)
            {
                this._fadeAlpha.release();
            }
            this._fadeAlpha = null;
            this._layer = new LayerEvent();
            param2.addChild(this._layer);
            this._mcEvent = ResourceManager.getInstance().createMovieClip(getResourcePath(), "EventMc");
            this._mcEvent.eventSkipMc.visible = false;
            this._isoEvent = new InStayOut(this._mcEvent);
            this._btnNext = ButtonManager.getInstance().addButton(this._mcEvent.eventNextMc.eventNextBtnMc, this.cbNext);
            this._btnNext.enterSeId = SoundId.SE_RS3_SYSTEM_CURSOR;
            this._btnNext.setDisable(true);
            this._isoNext = new InStayOut(this._mcEvent.eventNextMc);
            if (this._commandSkipCtrl)
            {
                this._commandSkipCtrl.release();
                this._commandSkipCtrl = null;
            }
            this._commandSkipCtrl = new ScriptSkipControl(this._mcEvent.skipBtnAmbit, this._layer.getLayer(LayerEvent.SKIP), this.cbSkipBtn);
            this._layer.getLayer(LayerEvent.SCREEN).addChild(this._mcEvent);
            this._layerChr = new Sprite();
            this._layerChrTop = new Sprite();
            this._mcEvent.charaLayoutNull.addChild(this._layerChr);
            this._mcEvent.charaLayoutNullFront.addChild(this._layerChrTop);
            this._layerBg = new Sprite();
            this._mcEvent.pointBgNull.addChild(this._layerBg);
            this._layerChr.y = 425;
            this._layerChrTop.y = 425;
            _loc_3 = this._layer.getLayer(LayerEvent.BALLOON);
            _loc_3.y = 425;
            _loc_3 = this._layer.getLayer(LayerEvent.NARRATION);
            _loc_3.y = 425;
            return;
        }// end function

        public function releaseScript() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            this._checkParam = null;
            this._scriptExe = null;
            this._aCommand = [];
            if (this._commandSkipCtrl)
            {
                this._commandSkipCtrl.release();
            }
            this._commandSkipCtrl = null;
            if (this._btnNext)
            {
                ButtonManager.getInstance().removeButton(this._btnNext);
            }
            this._btnNext = null;
            if (this._isoNext)
            {
                this._isoNext.release();
            }
            this._isoNext = null;
            if (this._layer)
            {
                this._layer.release();
            }
            this._layer = null;
            if (this._layerChr)
            {
                if (this._layerChr.parent)
                {
                    this._layerChr.parent.removeChild(this._layerChr);
                }
            }
            this._layerChr = null;
            if (this._layerChrTop)
            {
                if (this._layerChrTop.parent)
                {
                    this._layerChrTop.parent.removeChild(this._layerChrTop);
                }
            }
            this._layerChrTop = null;
            if (this._layerBg)
            {
                if (this._layerBg.parent)
                {
                    this._layerBg.parent.removeChild(this._layerBg);
                }
            }
            this._layerBg = null;
            for each (_loc_1 in this._aBalloon)
            {
                
                _loc_1.release();
            }
            this._aBalloon = [];
            for each (_loc_2 in this._aNarration)
            {
                
                _loc_2.release();
            }
            this._aNarration = [];
            for each (_loc_3 in this._aBackground)
            {
                
                _loc_3.release();
            }
            this._aBackground = [];
            for each (_loc_4 in this._aCharacter)
            {
                
                _loc_4.release();
            }
            this._aCharacter = [];
            for each (_loc_5 in this._aSoundBgm)
            {
                
                _loc_5.release();
            }
            this._aSoundBgm = [];
            for each (_loc_6 in this._aMovie)
            {
                
                _loc_6.release();
            }
            this._aMovie = [];
            for each (_loc_7 in this._aMonologue)
            {
                
                _loc_7.release();
            }
            this._aMonologue = [];
            for each (_loc_8 in this._aMonologue2)
            {
                
                _loc_8.release();
            }
            this._aMonologue2 = [];
            if (this._fade != null)
            {
                this._fade.release();
            }
            this._fade = null;
            if (this._fadeAlpha != null)
            {
                this._fadeAlpha.release();
            }
            this._fadeAlpha = null;
            if (this._shake != null)
            {
                this._shake.release();
            }
            this._shake = null;
            for each (_loc_9 in this._aInformation)
            {
                
                _loc_9.release();
            }
            this._aInformation = null;
            if (this._select)
            {
                this._select.release();
            }
            this._select = null;
            if (this._isoEvent)
            {
                this._isoEvent.release();
            }
            this._isoEvent = null;
            if (this._mcEvent)
            {
                if (this._mcEvent.parent)
                {
                    this._mcEvent.parent.removeChild(this._mcEvent);
                }
            }
            this._mcEvent = null;
            return;
        }// end function

        private function cbNext(param1:int) : void
        {
            this.onNextButtonClick();
            return;
        }// end function

        public function onNextButtonClick() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this._checkParam is ScriptParamBalloon)
            {
                _loc_1 = this._checkParam as ScriptParamBalloon;
                _loc_2 = null;
                for each (_loc_3 in this._aBalloon)
                {
                    
                    if (_loc_3.name == _loc_1.name)
                    {
                        _loc_2 = _loc_3;
                        break;
                    }
                }
                if (_loc_2 != null)
                {
                    this._btnNext.setDisable(true);
                    _loc_2.setAdvance();
                }
                _loc_1 = null;
            }
            if (this._checkParam is ScriptParamNarration)
            {
                _loc_4 = this._checkParam as ScriptParamNarration;
                _loc_5 = null;
                for each (_loc_6 in this._aNarration)
                {
                    
                    if (_loc_6.name == _loc_4.name)
                    {
                        _loc_5 = _loc_6;
                        break;
                    }
                }
                if (_loc_5 != null)
                {
                    this._btnNext.setDisable(true);
                    _loc_5.setAdvance();
                }
                _loc_4 = null;
            }
            return;
        }// end function

        public function openNextButton(param1:ScriptParamBase) : void
        {
            this._checkParam = param1;
            if (this._btnNext.isEnable() == false)
            {
                this._btnNext.setDisable(false);
            }
            if (this._isoNext.bClosed)
            {
                this._btnNext.setDisable(false);
                this._isoNext.setIn();
            }
            return;
        }// end function

        public function closeNextButton() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = false;
            for each (_loc_2 in this._aBalloon)
            {
                
                if (_loc_2.bOpen == true)
                {
                    _loc_1 = true;
                    break;
                }
            }
            for each (_loc_3 in this._aNarration)
            {
                
                if (_loc_3.bOpen == true)
                {
                    _loc_1 = true;
                    break;
                }
            }
            if (this._isoNext.bClosed == false && _loc_1 == false)
            {
                this._isoNext.setOut();
            }
            return;
        }// end function

        public function isScriptEnd() : Boolean
        {
            return this._scriptExe == null || this._scriptExe.bScriptEnd;
        }// end function

        public function setReturnBgm(param1:int) : void
        {
            this._scriptStartBgmId = param1;
            return;
        }// end function

        public function commandInit(param1:Boolean = false, param2:Boolean = false) : void
        {
            this._bSkipEnable = param1;
            this._bSkipCtrlStart = false;
            this._commandPhase = _COMMAND_PHASE_PLAY;
            this._commandSkipBgmId = Constant.UNDECIDED;
            var _loc_3:* = null;
            if (this._comIndex < this._aCommand.length)
            {
                _loc_3 = this._aCommand[this._comIndex];
                _loc_3.commandInit();
                this._commandSkipCtrl.setCommandSkipEnable(this._bSkipEnable && _loc_3.isCommandSkipEnable() && _loc_3.bCommandEnd == false);
            }
            if (_loc_3 == null || _loc_3.bCommandEnd)
            {
                this.commandNext();
            }
            if (this._bSkipEnable && this.checkDispCommand() == false)
            {
                this.commandSkipCtrlStart();
            }
            return;
        }// end function

        public function commandControl(param1:Number) : void
        {
            if (this._scriptExe == null || this._scriptExe.bScriptEnd)
            {
                return;
            }
            switch(this._commandPhase)
            {
                case _COMMAND_PHASE_PLAY:
                {
                    this.commandControlPlay(param1);
                    break;
                }
                case _COMMAND_PHASE_SKIP_START:
                {
                    this.commandControlSkipStart(param1);
                    break;
                }
                case _COMMAND_PHASE_SKIP_WAIT:
                {
                    this.commandControlSkipWait(param1);
                    break;
                }
                case _COMMAND_PHASE_SKIP_CANCEL:
                {
                    this.commandControlSkipCancel(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setCommandPhase(param1:int) : void
        {
            if (this._commandPhase != param1)
            {
                this._commandPhase = param1;
                switch(this._commandPhase)
                {
                    case _COMMAND_PHASE_SKIP_START:
                    {
                        this.commandPhaseSkipStart();
                        break;
                    }
                    case _COMMAND_PHASE_SKIP_WAIT:
                    {
                        this.commandPhaseSkipWait();
                        break;
                    }
                    case _COMMAND_PHASE_SKIP_CANCEL:
                    {
                        this.commandPhaseSkipCancel();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function commandControlPlay(param1:Number) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = undefined;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_2:* = this._aCommand[this._comIndex];
            _loc_2.commandControl(param1);
            for (_loc_3 in this._aInformation)
            {
                
                _loc_11 = this._aInformation[_loc_3];
                _loc_11.control(param1);
                if (_loc_11.bEnd)
                {
                    _loc_11.release();
                    delete this._aInformation[_loc_3];
                }
            }
            for each (_loc_4 in this._aBackground)
            {
                
                _loc_4.control(param1);
            }
            for each (_loc_5 in this._aCharacter)
            {
                
                _loc_5.control(param1);
            }
            for each (_loc_6 in this._aBalloon)
            {
                
                _loc_6.control(param1);
            }
            for each (_loc_7 in this._aNarration)
            {
                
                _loc_7.control(param1);
            }
            for each (_loc_8 in this._aMovie)
            {
                
                _loc_8.control(param1);
            }
            for each (_loc_9 in this._aMonologue)
            {
                
                _loc_9.control(param1);
            }
            for (_loc_10 in this._aMonologue2)
            {
                
                _loc_12 = this._aMonologue2[_loc_10];
                _loc_12.control(param1);
                if (_loc_12.bEnd)
                {
                    _loc_12.release();
                    delete this._aMonologue2[_loc_10];
                }
            }
            if (this._fade)
            {
                this._fade.control(param1);
            }
            if (this._fadeAlpha)
            {
                this._fadeAlpha.control(param1);
            }
            if (this._shake)
            {
                this._shake.control(param1);
            }
            if (_loc_2.bCommandEnd)
            {
                this.commandNext();
            }
            return;
        }// end function

        private function commandNext() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = null;
            var _loc_3:* = null;
            do
            {
                
                _loc_1 = false;
                if (this._gotoComIndex == Constant.UNDECIDED)
                {
                    var _loc_4:* = this;
                    var _loc_5:* = this._comIndex + 1;
                    _loc_4._comIndex = _loc_5;
                }
                else
                {
                    this._comIndex = this._gotoComIndex;
                    this._gotoComIndex = Constant.UNDECIDED;
                }
                if (this._comIndex >= this._aCommand.length)
                {
                    this._scriptExe.bScriptEnd = true;
                    if (this._scriptStartBgmId != SoundManager.getInstance().bgmId)
                    {
                        if (this._scriptStartBgmId != Constant.UNDECIDED)
                        {
                            SoundManager.getInstance().playBgm(this._scriptStartBgmId);
                        }
                        else
                        {
                            SoundManager.getInstance().stopBgm();
                        }
                    }
                    this._scriptStartBgmId = Constant.UNDECIDED;
                    this._commandSkipCtrl.closeSkipUI();
                    DebugLog.print("スクリプト終了");
                    break;
                    continue;
                }
                _loc_2 = this._aCommand[this._comIndex];
                _loc_2.commandInit();
                _loc_1 = _loc_2.bCommandEnd;
            }while (this._scriptExe.bScriptEnd == false && _loc_1)
            if (this._scriptExe.bScriptEnd)
            {
                this._commandSkipCtrl.setCommandSkipEnable(false);
            }
            else
            {
                _loc_3 = this._aCommand[this._comIndex];
                this._commandSkipCtrl.setCommandSkipEnable(this._bSkipEnable && _loc_3.isCommandSkipEnable() && _loc_3.bCommandEnd == false);
            }
            return;
        }// end function

        private function commandSkip() : int
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            while (this._scriptExe.bScriptEnd == false)
            {
                
                _loc_1 = this._aCommand[this._comIndex];
                if (_loc_1.bCommandEnd)
                {
                    this.commandNext();
                    continue;
                }
                _loc_2 = _loc_1.commandSkip();
                if (_loc_2 == ScriptComConstant.COMMAND_SKIP_RESULT_FINISH)
                {
                    this.commandNext();
                    continue;
                }
                return _loc_2;
            }
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        private function commandPhaseSkipStart() : void
        {
            this._commandSkipCtrl.closeSkipUI();
            this._commandSkipCtrl.skipIn();
            return;
        }// end function

        private function commandControlSkipStart(param1:Number) : void
        {
            if (this._commandSkipCtrl.bEndMaskIn)
            {
                this.setCommandPhase(_COMMAND_PHASE_SKIP_WAIT);
            }
            return;
        }// end function

        private function commandPhaseSkipWait() : void
        {
            return;
        }// end function

        private function commandControlSkipWait(param1:Number) : void
        {
            if (this.commandSkip() == ScriptComConstant.COMMAND_SKIP_RESULT_DONT)
            {
                this.setCommandPhase(_COMMAND_PHASE_SKIP_CANCEL);
            }
            return;
        }// end function

        private function commandPhaseSkipCancel() : void
        {
            this._commandSkipCtrl.skipOut();
            return;
        }// end function

        private function commandControlSkipCancel(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._commandSkipCtrl.bEndMaskOut)
            {
                this._commandSkipCtrl.openSkipUI();
                if (this._commandSkipBgmId != Constant.UNDECIDED)
                {
                    _loc_2 = this.getSoundBgm(this._commandSkipBgmId);
                    _loc_2.play();
                    this._commandSkipBgmId = Constant.UNDECIDED;
                }
                this.setCommandPhase(_COMMAND_PHASE_PLAY);
            }
            return;
        }// end function

        private function cbSkipBtn(param1:int) : void
        {
            if (this._commandPhase == _COMMAND_PHASE_PLAY)
            {
                this.setCommandPhase(_COMMAND_PHASE_SKIP_START);
            }
            return;
        }// end function

        public function commandSkipCtrlStart() : void
        {
            if (this._bSkipEnable && this._bSkipCtrlStart == false)
            {
                if (this._commandSkipCtrl)
                {
                    this._commandSkipCtrl.openSkipUI();
                }
                this._bSkipCtrlStart = true;
            }
            return;
        }// end function

        public function isCommandPlayPhase() : Boolean
        {
            return this._commandPhase == _COMMAND_PHASE_PLAY;
        }// end function

        public function addCharacter(param1:ScriptParamCharacter) : void
        {
            this._aCharacter.push(param1);
            return;
        }// end function

        public function addBackground(param1:ScriptParamBackground) : void
        {
            this._aBackground.push(param1);
            return;
        }// end function

        public function addBalloon(param1:ScriptParamBalloon) : void
        {
            this._aBalloon.push(param1);
            return;
        }// end function

        public function addNarration(param1:ScriptParamNarration) : void
        {
            this._aNarration.push(param1);
            return;
        }// end function

        public function addSoundBgm(param1:ScriptParamBgm) : void
        {
            this._aSoundBgm.push(param1);
            return;
        }// end function

        public function addMovie(param1:ScriptParamMovie) : void
        {
            this._aMovie.push(param1);
            return;
        }// end function

        public function addMonologue(param1:ScriptParamMonologue) : void
        {
            this._aMonologue.push(param1);
            return;
        }// end function

        public function addMonologue2(param1:String, param2:Number, param3:Number = 0, param4:Number = 0, param5:Boolean = true) : uint
        {
            var _loc_6:* = new ScriptParamMonologue2(this._layer.getLayer(LayerEvent.MONOLOGUE), param5);
            new ScriptParamMonologue2(this._layer.getLayer(LayerEvent.MONOLOGUE), param5).setStart(param1, param2, param3, param4);
            this._aMonologue2[_loc_6.uniquId] = _loc_6;
            return _loc_6.uniquId;
        }// end function

        public function removeMonologue() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aMonologue)
            {
                
                _loc_1.release();
            }
            this._aMonologue = [];
            return;
        }// end function

        public function deleteMonologue2(param1:uint) : void
        {
            var _loc_2:* = null;
            if (this._aMonologue2[param1] != null)
            {
                _loc_2 = this._aMonologue2[param1];
                _loc_2.release();
                delete this._aMonologue2[param1];
            }
            return;
        }// end function

        public function addInformation(param1:String) : uint
        {
            var _loc_2:* = new ScriptInformation(this._layer.getLayer(LayerEvent.INFORMATION));
            _loc_2.setStart(param1);
            this._aInformation[_loc_2.uniquId] = _loc_2;
            return _loc_2.uniquId;
        }// end function

        public function deleteInformation(param1:uint) : void
        {
            var _loc_2:* = null;
            if (this._aInformation[param1] != null)
            {
                _loc_2 = this._aInformation[param1];
                _loc_2.release();
                delete this._aInformation[param1];
            }
            return;
        }// end function

        public function isAliveInformation(param1:uint) : Boolean
        {
            return this._aInformation[param1] != null;
        }// end function

        public function isAliveMonologue2(param1:uint) : Boolean
        {
            return this._aMonologue2[param1] != null;
        }// end function

        public function createSelect() : ScriptParamSelect
        {
            if (this._select != null)
            {
                this._select.release();
                this._select = null;
            }
            this._select = new ScriptParamSelect();
            return this._select;
        }// end function

        public function createAutoSelect() : ScriptParamAutoSelect
        {
            if (this._autoSelect != null)
            {
                this._autoSelect.release();
                this._autoSelect = null;
            }
            this._autoSelect = new ScriptParamAutoSelect();
            return this._autoSelect;
        }// end function

        public function getFlag(param1:int) : ScriptParamFlag
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aOnFlag)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function isFlagOn(param1:int) : Boolean
        {
            var _loc_2:* = this.getFlag(param1);
            if (_loc_2 != null && _loc_2.value == true)
            {
                return true;
            }
            return false;
        }// end function

        public function setFlag(param1:ScriptParamFlag) : void
        {
            this._aChangeFlag.push(param1);
            var _loc_2:* = this.getFlag(param1.id);
            if (_loc_2 != null)
            {
                _loc_2.value = param1.value;
            }
            else if (param1.value == true)
            {
                this.addFlag(param1);
            }
            if (param1.value == false)
            {
                DebugLog.print("フラグ OFF:" + param1.id.toString());
            }
            else
            {
                DebugLog.print("フラグ ON:" + param1.id.toString());
            }
            return;
        }// end function

        private function addFlag(param1:ScriptParamFlag) : void
        {
            this._aOnFlag.push(param1.clone());
            return;
        }// end function

        public function getCharacter(param1:String) : ScriptParamCharacter
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aCharacter)
            {
                
                if (_loc_2.name == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getBackground(param1:String) : ScriptParamBackground
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBackground)
            {
                
                if (_loc_2.name == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getBalloon(param1:String) : ScriptParamBalloon
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBalloon)
            {
                
                if (_loc_2.name == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getNarration(param1:String) : ScriptParamNarration
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aNarration)
            {
                
                if (_loc_2.name == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getSoundBgm(param1:int) : ScriptParamBgm
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aSoundBgm)
            {
                
                if (_loc_2.bgmId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getMovie(param1:String) : ScriptParamMovie
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aMovie)
            {
                
                if (_loc_2.name == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getSelect() : ScriptParamSelect
        {
            return this._select;
        }// end function

        public function getAutoSelect() : ScriptParamAutoSelect
        {
            return this._autoSelect;
        }// end function

        public function getLayerScreen() : Sprite
        {
            return this._layer.getLayer(LayerEvent.SCREEN);
        }// end function

        public function getLayerBg() : Sprite
        {
            return this._layerBg;
        }// end function

        public function getLayerCharacter() : Sprite
        {
            return this._layerChr;
        }// end function

        public function getLayerCharacterTop() : Sprite
        {
            return this._layerChrTop;
        }// end function

        public function getBalloonLayer() : Sprite
        {
            return this._layer.getLayer(LayerEvent.BALLOON);
        }// end function

        public function getNarrationLayer() : Sprite
        {
            return this._layer.getLayer(LayerEvent.NARRATION);
        }// end function

        public function getMovieLayer() : Sprite
        {
            return this._layer.getLayer(LayerEvent.MOVIE);
        }// end function

        public function getFadeLayer() : Sprite
        {
            return this._layer.getLayer(LayerEvent.FADE);
        }// end function

        public function getFadeAlphaLayer() : Sprite
        {
            return this._layer.getLayer(LayerEvent.FADE_ALPHA);
        }// end function

        public function getMonologueLayer() : Sprite
        {
            return this._layer.getLayer(LayerEvent.MONOLOGUE);
        }// end function

        public function setBgmStop() : void
        {
            SoundManager.getInstance().stopBgm();
            this._commandSkipBgmId = Constant.UNDECIDED;
            return;
        }// end function

        public function setBalloonDarkout(param1:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = this.getBalloon(param1);
            for each (_loc_3 in this._aBalloon)
            {
                
                _loc_3.setDarkout(_loc_3 != _loc_2);
            }
            if (_loc_2 != null)
            {
                _loc_4 = this._layer.getLayer(LayerEvent.BALLOON);
                if (_loc_4 == null)
                {
                    return;
                }
                this.topPriority(_loc_4, _loc_2.mc);
            }
            return;
        }// end function

        public function topPriority(param1:DisplayObjectContainer, param2:Sprite) : void
        {
            var _loc_3:* = 0;
            if (param1.numChildren <= 1 || param2.parent == null || param1 != param2.parent)
            {
                return;
            }
            if (param1.numChildren > 1)
            {
                _loc_3 = param1.numChildren - 1;
                param1.setChildIndex(param2, _loc_3);
            }
            return;
        }// end function

        public function gotoLabel(param1:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aCommand.length)
            {
                
                _loc_3 = this._aCommand[_loc_2];
                if (_loc_3 is ScriptComLabel == false)
                {
                }
                else
                {
                    _loc_4 = _loc_3 as ScriptComLabel;
                    if (_loc_4.name != param1)
                    {
                    }
                    else
                    {
                        this._gotoComIndex = _loc_2;
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        public function checkDispCommand() : Boolean
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._aCommand.length)
            {
                
                _loc_2 = this._aCommand[_loc_1];
                if (_loc_2.category == ScriptComConstant.COMMAND_CATEGORY_DISP)
                {
                    return true;
                }
                _loc_1++;
            }
            return false;
        }// end function

        public function getBalloonOpenCount() : int
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            for each (_loc_2 in this._aBalloon)
            {
                
                if (_loc_2.bOpen)
                {
                    _loc_1++;
                }
            }
            return _loc_1;
        }// end function

        public function setDarkoutCharacter(param1:Array) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aCharacter)
            {
                
                _loc_2.bDarkout = param1.indexOf(_loc_2.name) == -1;
            }
            return;
        }// end function

        public function setBrightenCharacterAll() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aCharacter)
            {
                
                _loc_1.bDarkout = false;
            }
            return;
        }// end function

        public function getCurAllFlag() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aOnFlag)
            {
                
                _loc_1.push(_loc_2.clone());
            }
            return _loc_1;
        }// end function

        public function rollbackFlag(param1:Array) : void
        {
            var _loc_2:* = null;
            this._aOnFlag = [];
            for each (_loc_2 in param1)
            {
                
                this.addFlag(_loc_2);
            }
            return;
        }// end function

        public function getOnFlag(param1:int) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = [];
            if (param1 == CommonConstant.QUEST_RESULT_CLEAR)
            {
                for each (_loc_3 in this._aOnFlag)
                {
                    
                    if (this.checkOnFlag(_loc_3.id, param1))
                    {
                        _loc_4 = new Object();
                        _loc_4.id = _loc_3.id;
                        _loc_4.bState = _loc_3.value;
                        _loc_2.push(_loc_4);
                    }
                }
            }
            return _loc_2;
        }// end function

        private function checkOnFlag(param1:int, param2:int) : Boolean
        {
            var _loc_3:* = null;
            for each (_loc_3 in this._aFlagData)
            {
                
                if (_loc_3.id == param1)
                {
                    return _loc_3.checkUpdateCondtion(param2);
                }
            }
            return false;
        }// end function

        public function setPaymentEventSquareId(param1:int, param2:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            for (_loc_3 in this._aScriptScreen)
            {
                
                _loc_4 = this._aScriptScreen[_loc_3];
                if (_loc_4.screen != ScriptScreen.SCREEN_QUEST_PAYMENT_EVENT)
                {
                    continue;
                }
                if (_loc_4.aScriptMain.length >= 2)
                {
                    (_loc_4.aScriptMain[0] as ScriptMain).setSquareId(param1);
                    (_loc_4.aScriptMain[1] as ScriptMain).setSquareId(param2);
                    break;
                }
            }
            return;
        }// end function

        public function isPaymentEvent() : Boolean
        {
            return this._scriptExe != null && this._scriptExe.bPayment;
        }// end function

        public function replaceKeyword(param1:String) : String
        {
            var text:* = param1;
            var exp:* = new RegExp(/(#[^#]+#)""(#[^#]+#)/g);
            var repFunc:* = function () : String
            {
                switch(arguments[0])
                {
                    case "#PAYMENT_EVENT_CROWN#":
                    {
                        return QuestManager.getInstance().paymentEventCrown.toString();
                    }
                    default:
                    {
                        ;
                    }
                }
                return arguments[0];
            }// end function
            ;
            return text.replace(exp, repFunc);
        }// end function

        public static function getResourcePath() : String
        {
            return ResourcePath.EVENT_PATH + "Event.swf";
        }// end function

        public static function getInstance() : ScriptManager
        {
            if (_instance == null)
            {
                _instance = new ScriptManager;
            }
            return _instance;
        }// end function

    }
}
