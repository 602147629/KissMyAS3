package process
{
    import ending.*;
    import externalLinkage.*;
    import flash.display.*;
    import item.*;
    import message.*;
    import network.*;
    import notice.*;
    import player.*;
    import popup.*;
    import quest.*;
    import resource.*;
    import sound.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class ProcessEnding extends ProcessBase
    {
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_ENDING_INIT:int = 10;
        private const _PHASE_ENDING_SCRIPT:int = 11;
        private const _PHASE_ENDING_MOVIE:int = 12;
        private const _PHASE_ENDING_END:int = 13;
        private const _PHASE_CHRONOLOGY_INIT:int = 20;
        private const _PHASE_CHRONOLOGY:int = 21;
        private const _PHASE_CHRONOLOGY_END:int = 22;
        private const _PHASE_INTER_CYCLE_INIT:int = 30;
        private const _PHASE_INTER_CYCLE:int = 31;
        private const _PHASE_INTER_CYCLE_END:int = 32;
        private const _PHASE_TUTRIAL_CHECK_INIT:int = 40;
        private const _PHASE_TUTRIAL_CHECK:int = 41;
        private const _PHASE_TUTRIAL_CHECK_END:int = 42;
        private const _PHASE_RETRY_TUTORIAL:int = 50;
        private const _PHASE_CLOSE:int = 99;
        private const _BG_LIST:Array;
        private var _bgMc:MovieClip;
        private var _isoBg:InStayOut;
        private var _img:Bitmap;
        private var _endingScript:EndingScript;
        private var _endingMovie:EndingMovie;
        private var _chronology:EndingChronology;
        private var _interCycle:EndingInterCycle;
        private var _returnEmperor:EndingReturnEmperor;
        private var _phase:int;
        private var _startStateType:int;
        private var _bIsConnecting:Boolean;
        private var _scriptName:String;
        private var _scriptId:int;
        private var _endingUrl:String;
        private var _aEmperorId:Array;
        private var _aChronology:Array;
        private var _aRemuneration:Array;
        private var _goTutrial:Boolean;

        public function ProcessEnding()
        {
            this._BG_LIST = [ResourcePath.EVENT_PATH + "Bg/bg_main_0002_02_op.png", ResourcePath.EVENT_PATH + "Bg/bg_main_0003_01_op.png", ResourcePath.EVENT_PATH + "Bg/bg_sht_0003_op.png", ResourcePath.EVENT_PATH + "Bg/bg_sht_0010_op.png"];
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._isoBg)
            {
                this._isoBg.release();
            }
            if (this._endingScript)
            {
                this._endingScript.release();
            }
            if (this._endingMovie)
            {
                this._endingMovie.release();
            }
            if (this._chronology)
            {
                this._chronology.release();
            }
            if (this._interCycle)
            {
                this._interCycle.release();
            }
            if (this._returnEmperor)
            {
                this._returnEmperor.release();
            }
            if (this._bgMc && this._bgMc.parent)
            {
                this._bgMc.parent.removeChild(this._bgMc);
            }
            this._bgMc = null;
            return;
        }// end function

        override public function init() : void
        {
            super.init();
            SoundManager.getInstance().stopBgm();
            ResourceManager.getInstance().loadResource(ResourcePath.RESULT_PATH + "UI_Result.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.RESULT_PATH + "UI_CycleChange.swf");
            ResourceManager.getInstance().loadArray(this._BG_LIST);
            CommonPopup.getInstance().loadResource();
            SoundManager.getInstance().loadSound(SoundId.BGM_DEM_ENDING_CREDIT);
            SoundManager.getInstance().loadSound(SoundId.BGM_QST_MAP_EVECMN);
            SoundManager.getInstance().loadSound(SoundId.SE_REV_RESULT_REWARD);
            this._startStateType = UserDataManager.getInstance().userData.statusType;
            this.initConnect(this._startStateType);
            _bResourceLoadWait = true;
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            super.controlResourceWait();
            if (!ResourceManager.getInstance().isLoaded() || !SoundManager.getInstance().isLoaded() || this._bIsConnecting)
            {
                return;
            }
            this._bgMc = ResourceManager.getInstance().createMovieClip(ResourcePath.RESULT_PATH + "UI_CycleChange.swf", "bgChange");
            this._img = ResourceManager.getInstance().createBitmap(this._BG_LIST[0]);
            this.addChild(this._bgMc);
            this.addChild(this._img);
            this._isoBg = new InStayOut(this._bgMc, false);
            _bResourceLoadWait = false;
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_ENDING_INIT:
                {
                    this.controlEndingInit();
                    break;
                }
                case this._PHASE_ENDING_SCRIPT:
                {
                    this.controlEndingScript(param1);
                    break;
                }
                case this._PHASE_ENDING_MOVIE:
                {
                    this.controlEndingMovie(param1);
                    break;
                }
                case this._PHASE_ENDING_END:
                {
                    this.controlEndingEnd();
                    break;
                }
                case this._PHASE_CHRONOLOGY_INIT:
                {
                    this.controlChronologyInit();
                    break;
                }
                case this._PHASE_CHRONOLOGY:
                {
                    this.controlChronology(param1);
                    break;
                }
                case this._PHASE_CHRONOLOGY_END:
                {
                    this.controlChronologyEnd();
                    break;
                }
                case this._PHASE_INTER_CYCLE_INIT:
                {
                    this.controlInterCycleInit();
                    break;
                }
                case this._PHASE_INTER_CYCLE:
                {
                    this.controlInterCycle(param1);
                    break;
                }
                case this._PHASE_INTER_CYCLE_END:
                {
                    this.controlInterCycleEnd();
                    break;
                }
                case this._PHASE_TUTRIAL_CHECK_INIT:
                {
                    this.controlTutrialCheckInit();
                    break;
                }
                case this._PHASE_TUTRIAL_CHECK:
                {
                    this.controlTutrialCheck();
                    break;
                }
                case this._PHASE_TUTRIAL_CHECK_END:
                {
                    this.controlTutrialCheckEnd();
                    break;
                }
                case this._PHASE_RETRY_TUTORIAL:
                {
                    this.controlRetryTutorial();
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_ENDING_INIT:
                    {
                        this.phaseEndingInit();
                        break;
                    }
                    case this._PHASE_ENDING_SCRIPT:
                    {
                        this.phaseEndingScript();
                        break;
                    }
                    case this._PHASE_ENDING_MOVIE:
                    {
                        this.phaseEndingMovie();
                        break;
                    }
                    case this._PHASE_ENDING_END:
                    {
                        this.phaseEndingEnd();
                        break;
                    }
                    case this._PHASE_CHRONOLOGY_INIT:
                    {
                        this.phaseChronologyInit();
                        break;
                    }
                    case this._PHASE_CHRONOLOGY:
                    {
                        this.phaseChronology();
                        break;
                    }
                    case this._PHASE_CHRONOLOGY_END:
                    {
                        this.phaseChronologyEnd();
                        break;
                    }
                    case this._PHASE_INTER_CYCLE_INIT:
                    {
                        this.phaseInterCycleInit();
                        break;
                    }
                    case this._PHASE_INTER_CYCLE:
                    {
                        this.phaseInterCycle();
                        break;
                    }
                    case this._PHASE_INTER_CYCLE_END:
                    {
                        this.phaseInterCycleEnd();
                        break;
                    }
                    case this._PHASE_TUTRIAL_CHECK_INIT:
                    {
                        this.phaseTutrialCheckInit();
                        break;
                    }
                    case this._PHASE_TUTRIAL_CHECK:
                    {
                        this.phaseTutrialCheck();
                        break;
                    }
                    case this._PHASE_TUTRIAL_CHECK_END:
                    {
                        this.phaseTutrialCheckEnd();
                        break;
                    }
                    case this._PHASE_RETRY_TUTORIAL:
                    {
                        this.phaseRetryTutorial();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
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

        private function phaseOpen() : void
        {
            this._bTopbarButtonDisable = true;
            Main.GetProcess().topBar.close();
            var _loc_1:* = UserDataManager.getInstance().userData.statusType;
            switch(_loc_1)
            {
                case CommonConstant.USER_STATE_CYCLE_RESET:
                case CommonConstant.USER_STATE_CYCLE_ENDING:
                default:
                {
                    this.setPhase(this._PHASE_ENDING_INIT);
                    break;
                }
                case CommonConstant.USER_STATE_CYCLE_REWARD:
                {
                    this.setPhase(this._PHASE_CHRONOLOGY_INIT);
                    break;
                }
                case CommonConstant.USER_STATE_NEW_CYCLE_TUTORIAL:
                {
                    this.setPhase(this._PHASE_INTER_CYCLE_INIT);
                    break;
                }
                case :
                {
                    this.setPhase(this._PHASE_TUTRIAL_CHECK_INIT);
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function controlOpen() : void
        {
            return;
        }// end function

        private function phaseEndingInit() : void
        {
            if (!Main.GetProcess().fade.isFade())
            {
                Main.GetProcess().fade.setFadeOut(0);
            }
            return;
        }// end function

        private function controlEndingInit() : void
        {
            if (Main.GetProcess().fade.isFadeEnd())
            {
                this.setPhase(this._PHASE_ENDING_SCRIPT);
            }
            return;
        }// end function

        private function phaseEndingScript() : void
        {
            this._img.visible = false;
            if (this._scriptName != null && this._scriptName != "")
            {
                this._endingScript = new EndingScript(this, this._scriptName, this._scriptId);
            }
            else
            {
                this.setPhase(this._PHASE_ENDING_MOVIE);
            }
            return;
        }// end function

        private function controlEndingScript(param1:Number) : void
        {
            if (this._endingScript)
            {
                this._endingScript.control(param1);
                if (this._endingScript.bEnd)
                {
                    this._endingScript.release();
                    this._endingScript = null;
                    this.setPhase(this._PHASE_ENDING_MOVIE);
                }
            }
            return;
        }// end function

        private function phaseEndingMovie() : void
        {
            this._endingMovie = new EndingMovie(this, this._endingUrl);
            return;
        }// end function

        private function controlEndingMovie(param1:Number) : void
        {
            if (this._endingMovie)
            {
                this._endingMovie.control(param1);
                if (this._endingMovie.bEnd)
                {
                    this._img.visible = true;
                    this._endingMovie.release();
                    this._endingMovie = null;
                    this.setPhase(this._PHASE_ENDING_END);
                }
            }
            return;
        }// end function

        private function phaseEndingEnd() : void
        {
            this.connect(CommonConstant.USER_STATE_CYCLE_CHRONOLOGY, this.cbReceiveCycleResetChronology);
            return;
        }// end function

        private function controlEndingEnd() : void
        {
            if (!ResourceManager.getInstance().isLoaded() || !SoundManager.getInstance().isLoaded() || this._bIsConnecting)
            {
                return;
            }
            this.setPhase(this._PHASE_CHRONOLOGY);
            return;
        }// end function

        private function phaseChronologyInit() : void
        {
            if (Main.GetProcess().fade.isFade())
            {
                Main.GetProcess().fade.setFadeIn(0);
            }
            this.setPhase(this._PHASE_CHRONOLOGY);
            return;
        }// end function

        private function controlChronologyInit() : void
        {
            return;
        }// end function

        private function phaseChronology() : void
        {
            if (this._isoBg.bClosed)
            {
                this._isoBg.setIn();
            }
            this._chronology = new EndingChronology(this, this._aChronology, this._aEmperorId);
            return;
        }// end function

        private function controlChronology(param1:Number) : void
        {
            if (this._chronology)
            {
                this._chronology.control(param1);
                if (this._chronology.bEnd)
                {
                    this._chronology.release();
                    this._chronology = null;
                    this.setPhase(this._PHASE_CHRONOLOGY_END);
                }
            }
            return;
        }// end function

        private function phaseChronologyEnd() : void
        {
            this.connect(CommonConstant.USER_STATE_CYCLE_REWARD, this.cbReceiveCycleResetInterCycle);
            return;
        }// end function

        private function controlChronologyEnd() : void
        {
            if (!ResourceManager.getInstance().isLoaded() || !SoundManager.getInstance().isLoaded() || this._bIsConnecting)
            {
                return;
            }
            this.setPhase(this._PHASE_INTER_CYCLE);
            return;
        }// end function

        private function phaseInterCycleInit() : void
        {
            if (!Main.GetProcess().fade.isFade())
            {
                Main.GetProcess().fade.setFadeOut(0);
            }
            this.setPhase(this._PHASE_INTER_CYCLE);
            return;
        }// end function

        private function controlInterCycleInit() : void
        {
            return;
        }// end function

        private function phaseInterCycle() : void
        {
            if (this._isoBg.bOpened)
            {
                this._isoBg.setOut();
            }
            this._interCycle = new EndingInterCycle(this, this._aRemuneration);
            Main.GetProcess().fade.setFadeIn(0);
            return;
        }// end function

        private function controlInterCycle(param1:Number) : void
        {
            if (this._interCycle)
            {
                this._interCycle.control(param1);
                if (this._interCycle.bEnd)
                {
                    this._interCycle.release();
                    this._interCycle = null;
                    this._returnEmperor = new EndingReturnEmperor(this);
                }
            }
            else if (this._returnEmperor)
            {
                this._returnEmperor.control(param1);
                if (this._returnEmperor.bEnd)
                {
                    this._returnEmperor.release();
                    this._returnEmperor = null;
                    this.setPhase(this._PHASE_INTER_CYCLE_END);
                }
            }
            return;
        }// end function

        private function phaseInterCycleEnd() : void
        {
            this.connect(CommonConstant.USER_STATE_NEW_CYCLE_TUTORIAL, this.cbReceiveCycleResetTutrialCheck);
            return;
        }// end function

        private function controlInterCycleEnd() : void
        {
            if (!ResourceManager.getInstance().isLoaded() || !SoundManager.getInstance().isLoaded() || this._bIsConnecting)
            {
                return;
            }
            this.setPhase(this._PHASE_TUTRIAL_CHECK);
            return;
        }// end function

        private function phaseTutrialCheckInit() : void
        {
            if (!Main.GetProcess().fade.isFade())
            {
                Main.GetProcess().fade.setFadeOut(0);
            }
            this.setPhase(this._PHASE_TUTRIAL_CHECK);
            return;
        }// end function

        private function controlTutrialCheckInit() : void
        {
            return;
        }// end function

        private function phaseTutrialCheck() : void
        {
            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.ENDING_CHECK_TUTRIAL_2), this.cbTutrialCheck, MessageManager.getInstance().getMessage(MessageId.ENDING_CHECK_TUTRIAL_BUTTON_YES), MessageManager.getInstance().getMessage(MessageId.ENDING_CHECK_TUTRIAL_BUTTON_NO));
            return;
        }// end function

        private function controlTutrialCheck() : void
        {
            return;
        }// end function

        private function phaseTutrialCheckEnd() : void
        {
            NetManager.getInstance().request(new NetTaskCycleReset(CommonConstant.USER_STATE_PLAY, function (param1:NetResult) : void
            {
                setPhase(_PHASE_CLOSE);
                return;
            }// end function
            ));
            return;
        }// end function

        private function controlTutrialCheckEnd() : void
        {
            return;
        }// end function

        private function phaseRetryTutorial() : void
        {
            NetManager.getInstance().request(new NetTaskCycleResetTutorial(function (param1:NetResult) : void
            {
                setPhase(_PHASE_CLOSE);
                return;
            }// end function
            ));
            return;
        }// end function

        private function controlRetryTutorial() : void
        {
            return;
        }// end function

        private function phaseClose() : void
        {
            if (this._startStateType != CommonConstant.USER_STATE_NEW_CYCLE_TUTORIAL)
            {
                UserDataManager.getInstance().userData.addCycle();
                UserDataManager.getInstance().userData.resetProgress();
                UserDataManager.getInstance().userData.resetChapter();
                UserDataManager.getInstance().userData.setSuccessiveEmperor([UserDataManager.getInstance().userData.emperorId]);
            }
            if (UserDataManager.getInstance().userData.cycle == 2)
            {
                ExternalLinkageJS.callJSRemarketingTag(ExternalLinkageJSConstant.REMARKETING_TAG_START2_CHAPTER1);
            }
            Main.GetProcess().topBar.updateChapter();
            Main.GetProcess().topBar.resetProgress();
            return;
        }// end function

        private function controlClose() : void
        {
            if (this._goTutrial)
            {
                UserDataManager.getInstance().userData.statusType = CommonConstant.USER_STATE_OPENING;
                TutorialManager.getInstance().clearBasicTutorial();
                Main.GetProcess().fade.setFadeIn(Constant.FADE_IN_TIME);
                Main.GetProcess().SetProcessId(ProcessMain.PROCESS_LOGIN_AFTER);
            }
            else
            {
                UserDataManager.getInstance().userData.statusType = CommonConstant.USER_STATE_PLAY;
                Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
            }
            return;
        }// end function

        private function cbTutrialCheck(param1:Boolean) : void
        {
            this._goTutrial = param1;
            if (this._goTutrial)
            {
                this.setPhase(this._PHASE_RETRY_TUTORIAL);
            }
            else
            {
                this.setPhase(this._PHASE_TUTRIAL_CHECK_END);
            }
            return;
        }// end function

        private function initConnect(param1:int) : void
        {
            switch(param1)
            {
                case CommonConstant.USER_STATE_CYCLE_RESET:
                case CommonConstant.USER_STATE_CYCLE_ENDING:
                default:
                {
                    this.connect(CommonConstant.USER_STATE_CYCLE_ENDING, this.cbReceiveCycleResetEnding);
                    break;
                }
                case CommonConstant.USER_STATE_CYCLE_REWARD:
                {
                    this.connect(CommonConstant.USER_STATE_CYCLE_CHRONOLOGY, this.cbReceiveCycleResetChronology);
                    break;
                }
                case CommonConstant.USER_STATE_NEW_CYCLE_TUTORIAL:
                {
                    this.connect(CommonConstant.USER_STATE_CYCLE_REWARD, this.cbReceiveCycleResetInterCycle);
                    break;
                }
                case :
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function connect(param1:int, param2:Function) : void
        {
            this._bIsConnecting = true;
            NetManager.getInstance().request(new NetTaskCycleReset(param1, param2));
            return;
        }// end function

        private function cbReceiveCycleResetEnding(param1:NetResult) : void
        {
            this._scriptName = param1.data.scriptName;
            this._scriptId = param1.data.scriptId;
            this._endingUrl = param1.data.endingUrl;
            if (this._endingUrl.length == 0)
            {
                Assert.print("エンディングムービー名が存在しません");
            }
            this._bIsConnecting = false;
            return;
        }// end function

        private function cbReceiveCycleResetChronology(param1:NetResult) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._aChronology = [];
            for each (_loc_2 in param1.data.aChronology)
            {
                
                _loc_3 = new ChronologyData();
                _loc_3.setChronologyData(_loc_2);
                this._aChronology.push(_loc_3);
            }
            this.readSuccessiveEmperor(param1);
            this.loadSuccessiveEmperor();
            this._bIsConnecting = false;
            return;
        }// end function

        private function cbReceiveCycleResetInterCycle(param1:NetResult) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._aRemuneration = [];
            for each (_loc_2 in param1.data.aRemuneration)
            {
                
                _loc_3 = new QuestRemunerationData();
                _loc_3.setRemunerationData(_loc_2);
                this._aRemuneration.push(_loc_3);
                ResourceManager.getInstance().loadResource(ItemManager.getInstance().getItemPng(_loc_3.categoryId, _loc_3.itemId));
            }
            this._bIsConnecting = false;
            return;
        }// end function

        private function cbReceiveCycleResetTutrialCheck(param1:NetResult) : void
        {
            var _loc_2:* = UserDataManager.getInstance().userData.getEmperorPlayerPersonal();
            var _loc_3:* = _loc_2 ? (_loc_2.uniqueId) : (Constant.EMPTY_ID);
            UserDataManager.getInstance().userData.removePlayerPersonalWithClearNotice(_loc_3);
            UserDataManager.getInstance().userData.setEmperorData(param1.data.emperorData.uniqueId, param1.data.emperorData.emperorId, param1.data.emperorData.bonus);
            UserDataManager.getInstance().updateFormationPlayer();
            if (param1.data.notice)
            {
                NoticeManager.getInstance().addMiniNoticeByObject(param1.data.notice);
            }
            this._bIsConnecting = false;
            return;
        }// end function

        private function readSuccessiveEmperor(param1:NetResult) : void
        {
            if (param1.data.aEmperorId)
            {
                UserDataManager.getInstance().userData.setSuccessiveEmperor(param1.data.aEmperorId);
            }
            this._aEmperorId = UserDataManager.getInstance().userData.aSuccessiveEmperorId;
            return;
        }// end function

        private function loadSuccessiveEmperor() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            for each (_loc_1 in this._aEmperorId)
            {
                
                _loc_2 = PlayerManager.getInstance().getPlayerInformation(_loc_1);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_BUSTUP_PATH + _loc_2.bustUpFileName);
            }
            return;
        }// end function

    }
}
