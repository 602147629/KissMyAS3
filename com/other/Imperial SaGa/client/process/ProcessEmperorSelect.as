package process
{
    import emperorSelect.*;
    import flash.display.*;
    import layer.*;
    import network.*;
    import player.*;
    import resource.*;
    import script.*;
    import sound.*;
    import user.*;
    import utility.*;

    public class ProcessEmperorSelect extends ProcessBase
    {
        private var _bConnectionGet:Boolean;
        private var _eventFileName:String;
        private var _eventMc:MovieClip;
        private var _eventTotalFrame:int;
        private var _bgMc:MovieClip;
        private var _decisionMc:MovieClip;
        private var _newEmperorMc:MovieClip;
        private var _aBitmap:Array;
        private var _scriptMain:ScriptMain;
        private var _phase:int;
        private var _emperorSelect:NewEmperorSelect;
        private var _aEmperorPersonal:Array;
        private var _oldUniqueId:int;
        private var _aChapterEmeperorFileName:Array;
        private var _layer:LayerEmperorSelect;
        private const _aNewEmperorSE:Array;
        private static const PHASE_WAIT:int = 0;
        private static const PHASE_BACKGROUND:int = 1;
        private static const PHASE_OPEN:int = 2;
        private static const PHASE_SELECT:int = 10;
        private static const PHASE_RESULT_RECEIVE:int = 20;
        private static const PHASE_RESULT:int = 21;
        private static const PHASE_NEXT_CHAPTER_RESOURCE:int = 50;
        private static const PHASE_NEXT_CHAPTER:int = 51;
        private static const PHASE_NEXT_CHAPTER_EVENT:int = 52;
        private static const PHASE_SCRIPT_CHECK:int = 100;
        private static const PHASE_SCRIPT_EXE:int = 101;
        private static const PHASE_END:int = 999;

        public function ProcessEmperorSelect()
        {
            this._aNewEmperorSE = [null, [{frame:68, soundId:SoundId.SE_MENTAL}, {frame:137, soundId:SoundId.SE_CARD_APPIER2}, {frame:166, soundId:SoundId.SE_BLACKOUT}], [{frame:48, soundId:SoundId.SE_CARD_APPIER2}, {frame:77, soundId:SoundId.SE_MENTAL}, {frame:137, soundId:SoundId.SE_CARD_APPIER2}, {frame:166, soundId:SoundId.SE_BLACKOUT}], [{frame:36, soundId:SoundId.SE_CARD_APPIER2}, {frame:65, soundId:SoundId.SE_CARD_APPIER2}, {frame:112, soundId:SoundId.SE_MENTAL}, {frame:173, soundId:SoundId.SE_CARD_APPIER2}, {frame:202, soundId:SoundId.SE_BLACKOUT}]];
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            super.release();
            if (this._emperorSelect != null)
            {
                this._emperorSelect.release();
            }
            if (this._bgMc && this._bgMc.parent)
            {
                this._bgMc.parent.removeChild(this._bgMc);
            }
            this._bgMc = null;
            if (this._decisionMc && this._decisionMc.parent)
            {
                this._decisionMc.parent.removeChild(this._decisionMc);
            }
            this._decisionMc = null;
            for each (_loc_1 in this._aBitmap)
            {
                
                if (_loc_1 != null && _loc_1.parent != null)
                {
                    _loc_1.parent.removeChild(_loc_1);
                }
            }
            this._aBitmap = null;
            return;
        }// end function

        override public function init() : void
        {
            super.init();
            this._bConnectionGet = false;
            this._aChapterEmeperorFileName = [];
            var _loc_1:* = UserDataManager.getInstance().userData.getEmperorPlayerPersonal();
            this._oldUniqueId = _loc_1 ? (_loc_1.uniqueId) : (Constant.EMPTY_ID);
            var _loc_2:* = true;
            if (_loc_2)
            {
                NetManager.getInstance().request(new NetTaskEmperorSelectStart(this.cbStartReceive));
            }
            else
            {
                this._bConnectionGet = false;
            }
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Popup.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            ScriptManager.getInstance().loadScript(ScriptManager.SCRIPT_PATH + "EmperorSelect/script_emperor_select.xml", ScriptScreen.SCREEN_EMPEROR_SELECT, false);
            SoundManager.getInstance().loadSound(SoundId.BGM_DEM_SUCCESSION_LOOP);
            SoundManager.getInstance().loadSound(SoundId.BGM_DEM_SUCCESSION_DECIDE);
            SoundManager.getInstance().loadSoundArray([SoundId.SE_MENTAL, SoundId.SE_CARD_APPIER2, SoundId.SE_BLACKOUT, SoundId.SE_POPUP]);
            bResourceLoadWait = true;
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            if (this._bConnectionGet == false || ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false)
            {
                return;
            }
            this._layer = new LayerEmperorSelect();
            addChild(this._layer);
            UserDataManager.getInstance().userData.setEmperorData(Constant.EMPTY_ID, Constant.EMPTY_ID, 0);
            bResourceLoadWait = false;
            this.setPhase(PHASE_BACKGROUND);
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case PHASE_BACKGROUND:
                {
                    this.controlBackground();
                    break;
                }
                case PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case PHASE_SELECT:
                {
                    this.controlSelect();
                    break;
                }
                case PHASE_RESULT:
                {
                    this.controlResult();
                    break;
                }
                case PHASE_NEXT_CHAPTER_RESOURCE:
                {
                    this.controlNextChapterResource();
                    break;
                }
                case PHASE_NEXT_CHAPTER:
                {
                    this.controlNextChapter();
                    break;
                }
                case PHASE_NEXT_CHAPTER_EVENT:
                {
                    this.controlNextChapterEvent();
                    break;
                }
                case PHASE_SCRIPT_CHECK:
                {
                    this.controlScriptCheck(param1);
                    break;
                }
                case PHASE_SCRIPT_EXE:
                {
                    this.controlScriptExe(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._emperorSelect)
            {
                this._emperorSelect.control(param1);
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case PHASE_BACKGROUND:
                    {
                        this.phaseBackground();
                        break;
                    }
                    case PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case PHASE_SELECT:
                    {
                        this.phaseSelect();
                        break;
                    }
                    case PHASE_RESULT_RECEIVE:
                    {
                        this.phaseResultReceive();
                        break;
                    }
                    case PHASE_RESULT:
                    {
                        this.phaseResult();
                        break;
                    }
                    case PHASE_NEXT_CHAPTER:
                    {
                        this.phaseNextChapter();
                        break;
                    }
                    case PHASE_NEXT_CHAPTER_EVENT:
                    {
                        this.phaseNextChapterEvent();
                        break;
                    }
                    case PHASE_SCRIPT_CHECK:
                    {
                        this.phaseScriptCheck();
                        break;
                    }
                    case PHASE_SCRIPT_EXE:
                    {
                        this.phaseScriptExe();
                        break;
                    }
                    case PHASE_END:
                    {
                        this.phaseEnd();
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

        private function phaseBackground() : void
        {
            this._bgMc = ResourceManager.getInstance().createMovieClip(ResourcePath.EMPEROR_SELECT_PATH + "UI_EmperorSelect.swf", "SuccessorSelectStartMc");
            this._layer.getLayer(LayerEmperorSelect.BACKGROUND).addChild(this._bgMc);
            SoundManager.getInstance().playBgm(SoundId.BGM_DEM_SUCCESSION_LOOP);
            var _loc_1:* = Main.GetProcess().fade;
            if (_loc_1.isFade())
            {
                _loc_1.setFadeIn(Constant.FADE_IN_TIME);
            }
            return;
        }// end function

        private function controlBackground() : void
        {
            if (this._bgMc.currentLabel == "end")
            {
                this._bgMc.gotoAndStop("end");
                this.setPhase(PHASE_OPEN);
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            if (Main.GetProcess().fade.isFade())
            {
                Main.GetProcess().fade.setFadeIn(0.2);
            }
            this._emperorSelect = new NewEmperorSelect(this._layer, this._aEmperorPersonal);
            return;
        }// end function

        private function controlOpen() : void
        {
            this.setPhase(PHASE_SELECT);
            return;
        }// end function

        private function phaseSelect() : void
        {
            return;
        }// end function

        private function controlSelect() : void
        {
            if (this._emperorSelect.bClose)
            {
                this.setPhase(PHASE_RESULT_RECEIVE);
            }
            return;
        }// end function

        private function phaseResultReceive() : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = this._emperorSelect.selectPlayerPersonal;
            var _loc_2:* = [];
            var _loc_3:* = this._emperorSelect.aUpdatePlayerUniqueId;
            if (_loc_1 == null)
            {
                Assert.print("指定された皇帝情報を取得できませんでした。");
            }
            for each (_loc_4 in _loc_3)
            {
                
                _loc_6 = new Object();
                for each (_loc_7 in this._aEmperorPersonal)
                {
                    
                    if (_loc_7.uniqueId == _loc_4)
                    {
                        _loc_6.uniqueId = _loc_4;
                        _loc_6.aSkill = _loc_7.aSetSkillId;
                        _loc_6.aItem = _loc_7.aSetItemId;
                        break;
                    }
                }
                _loc_2.push(_loc_6);
            }
            _loc_5 = ScriptManager.getInstance().getOnFlag(CommonConstant.QUEST_RESULT_CLEAR);
            NetManager.getInstance().request(new NetTaskEmperorSelectEnd(_loc_1.uniqueId, _loc_2, _loc_5, this.cbEndReceive));
            return;
        }// end function

        private function phaseResult() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            UserDataManager.getInstance().userData.statusType = CommonConstant.USER_STATE_PLAY;
            var _loc_1:* = UserDataManager.getInstance().userData.chapter - 1;
            this._aBitmap = [];
            this._decisionMc = ResourceManager.getInstance().createMovieClip(ResourcePath.EMPEROR_SELECT_PATH + "UI_EmperorSelect.swf", "SuccessorDecisionMc");
            this._decisionMc.gotoAndStop("chapter" + _loc_1.toString());
            this._newEmperorMc = this._decisionMc.getChildByName("decision" + _loc_1.toString()) as MovieClip;
            var _loc_2:* = 1;
            while (_loc_2 < this._aChapterEmeperorFileName.length)
            {
                
                _loc_3 = this._aChapterEmeperorFileName[_loc_2];
                _loc_4 = this._newEmperorMc.getChildByName("charaNull" + String((_loc_2 + 1))) as MovieClip;
                _loc_5 = ResourceManager.getInstance().createBitmap(_loc_3);
                _loc_5.smoothing = true;
                _loc_5.x = _loc_5.x - _loc_5.width / 2;
                _loc_5.y = _loc_5.y - _loc_5.height;
                _loc_4.addChild(_loc_5);
                this._aBitmap.push(_loc_5);
                _loc_2++;
            }
            this._layer.getLayer(LayerEmperorSelect.MAIN).addChild(this._decisionMc);
            SoundManager.getInstance().playBgm(SoundId.BGM_DEM_SUCCESSION_DECIDE);
            this._newEmperorMc.gotoAndPlay("start");
            return;
        }// end function

        private function controlResult() : void
        {
            var _loc_1:* = this._aNewEmperorSE[(UserDataManager.getInstance().userData.chapter - 1)];
            if (_loc_1 && _loc_1.length > 0)
            {
                if (this._newEmperorMc.isPlaying && this._newEmperorMc.currentFrame == _loc_1[0].frame)
                {
                    SoundManager.getInstance().playSe(_loc_1[0].soundId);
                    _loc_1.splice(0, 1);
                }
            }
            if (this._newEmperorMc.currentLabel == "end")
            {
                this._newEmperorMc.gotoAndStop("end");
                this.setPhase(PHASE_SCRIPT_CHECK);
            }
            return;
        }// end function

        private function controlNextChapterResource() : void
        {
            if (ResourceManager.getInstance().isLoaded() && this._emperorSelect.bClose)
            {
                this.setPhase(PHASE_RESULT);
            }
            return;
        }// end function

        private function phaseNextChapter() : void
        {
            return;
        }// end function

        private function controlNextChapter() : void
        {
            this.setPhase(PHASE_NEXT_CHAPTER_EVENT);
            return;
        }// end function

        private function phaseNextChapterEvent() : void
        {
            return;
        }// end function

        private function controlNextChapterEvent() : void
        {
            this.setPhase(PHASE_END);
            return;
        }// end function

        private function phaseScriptCheck() : void
        {
            this._scriptMain = ScriptManager.getInstance().getScript(ScriptScreen.SCREEN_EMPEROR_SELECT, ScriptComConstant.TRIGGER_EMPEROR_SELECT);
            if (this._scriptMain != null)
            {
                ResourceManager.getInstance().loadResource(ScriptManager.getResourcePath());
            }
            return;
        }// end function

        private function controlScriptCheck(param1:Number) : void
        {
            if (ResourceManager.getInstance().isLoaded())
            {
                if (this._scriptMain != null)
                {
                    this.setPhase(PHASE_SCRIPT_EXE);
                }
                else
                {
                    this.setPhase(PHASE_END);
                }
            }
            return;
        }// end function

        private function phaseScriptExe() : void
        {
            ScriptManager.getInstance().initScript(this._scriptMain, this._layer.getLayer(LayerEmperorSelect.SCRIPT));
            ScriptManager.getInstance().commandInit(UserDataManager.getInstance().userData.cycle != 1);
            return;
        }// end function

        private function controlScriptExe(param1:Number) : void
        {
            ScriptManager.getInstance().commandControl(param1);
            if (ScriptManager.getInstance().isScriptEnd())
            {
                this.setPhase(PHASE_SCRIPT_CHECK);
            }
            return;
        }// end function

        private function phaseEnd() : void
        {
            var _loc_1:* = new ScriptParamFlag();
            switch(UserDataManager.getInstance().userData.chapter - 1)
            {
                case 1:
                {
                    _loc_1.setParam(ScriptConstant.FLAG_EMPEROR_SELECT1, false);
                    break;
                }
                case 2:
                {
                    _loc_1.setParam(ScriptConstant.FLAG_EMPEROR_SELECT2, false);
                    break;
                }
                case 3:
                {
                    _loc_1.setParam(ScriptConstant.FLAG_EMPEROR_SELECT3, false);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_1.id > 0)
            {
                ScriptManager.getInstance().setFlag(_loc_1);
            }
            Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
            return;
        }// end function

        private function cbStartReceive(param1:NetResult) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._aEmperorPersonal = [];
            for each (_loc_2 in param1.data.aPlayerPersonal)
            {
                
                _loc_3 = PlayerManager.getInstance().getPlayerInformation(_loc_2.playerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_3.swf);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_BUSTUP_PATH + _loc_3.bustUpFileName);
                _loc_4 = new PlayerPersonal();
                _loc_4.setParameter(_loc_2);
                this._aEmperorPersonal.push(_loc_4);
            }
            ResourceManager.getInstance().loadResource(ResourcePath.EMPEROR_SELECT_PATH + "UI_EmperorSelect.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Correlation.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf");
            this._bConnectionGet = true;
            return;
        }// end function

        private function cbEndReceive(param1:NetResult) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = this._emperorSelect.selectPlayerPersonal;
            if (_loc_2 == null)
            {
                Assert.print("選択された皇帝情報を取得できませんでした。");
            }
            UserDataManager.getInstance().userData.removePlayerPersonalWithClearNotice(this._oldUniqueId);
            if (_loc_2.uniqueId < 0)
            {
                _loc_2.emperorUniqueIdOverride(param1.data.emperorData.uniqueId);
                UserDataManager.getInstance().userData.addPlayerPersonal(_loc_2);
                UserDataManager.getInstance().userData.updateCorrelation(_loc_2.playerId);
            }
            UserDataManager.getInstance().userData.updatePlayerPersonal(this._aEmperorPersonal, false);
            UserDataManager.getInstance().userData.setEmperorData(param1.data.emperorData.uniqueId, param1.data.emperorData.emperorId, param1.data.emperorData.bonus);
            UserDataManager.getInstance().updateFormationPlayer();
            this._eventFileName = param1.data.eventFileName;
            var _loc_3:* = [];
            this._aChapterEmeperorFileName = [];
            for each (_loc_4 in param1.data.aEmperorId)
            {
                
                _loc_6 = PlayerManager.getInstance().getPlayerInformation(_loc_4);
                if (_loc_6 != null)
                {
                    _loc_7 = ResourcePath.PLAYER_BUSTUP_PATH + _loc_6.bustUpFileName;
                    ResourceManager.getInstance().loadResource(_loc_7);
                    this._aChapterEmeperorFileName.push(_loc_7);
                }
                _loc_3.push(_loc_4);
            }
            _loc_5 = PlayerManager.getInstance().getPlayerInformation(_loc_2.playerId);
            this._aChapterEmeperorFileName.push(ResourcePath.PLAYER_BUSTUP_PATH + _loc_5.bustUpFileName);
            _loc_3.push(_loc_2.playerId);
            UserDataManager.getInstance().userData.setSuccessiveEmperor(_loc_3);
            this.setPhase(PHASE_NEXT_CHAPTER_RESOURCE);
            return;
        }// end function

    }
}
