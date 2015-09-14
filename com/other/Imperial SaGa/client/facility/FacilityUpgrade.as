package facility
{
    import button.*;
    import develop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import home.*;
    import input.*;
    import item.*;
    import message.*;
    import network.*;
    import notice.*;
    import player.*;
    import playerList.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import tradingPost.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class FacilityUpgrade extends Object
    {
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _mcMain:MovieClip;
        private var _mcIcon:MovieClip;
        private var _mcEffect:MovieClip;
        private var _mcCaption:MovieClip;
        private var _isoMain:InStayOut;
        private var _isoPlayerList:InStayOut;
        private var _isoInstantBtn:InStayOut;
        private var _btnReturn:ButtonBase;
        private var _btnIntesification:ButtonBase;
        private var _btnUpgrade:ButtonBase;
        private var _instantBtn:InstantButton;
        private var _playerList:FacilityUpgradePlayerList;
        private var _isGaugeMax:Boolean;
        private var _intesificationGauge:Gauge;
        private var _intesificationPreGauge:Gauge;
        private var _numMcSelectedPlayerResource:NumericNumberMc;
        private var _numMcMaxPlayerResource:NumericNumberMc;
        private var _numMcCrown:NumericNumberMc;
        private var _numMcTime:NumericNumberMc;
        private var _aPlayerPersonal:Array;
        private var _aPlayerResourceId:Array;
        private var _aPlayerResourceDisplay:Array;
        private var _facilityInfo:InstitutionInfo;
        private var _cbIntesification:Function;
        private var _cbGradeUp:Function;
        private var _cbGradeUpConnected:Function;
        private var _cbClose:Function;
        private var _nextExp:int;
        private var _bEffectParentChanged:Boolean;
        protected var _mouseOverPlayer:FacilityUpgradePlayerResourceDisplay;
        protected var _mouseDownPlayer:FacilityUpgradePlayerResourceDisplay;
        private var _bGoTradingPost:Boolean;
        private var _information1Mc:MovieClip;
        private var _timeCount:Number;
        private var _endTime:uint;
        private var _instantTtype:int;
        private var _restoreTimeSec:uint;
        private var _maxTimeSec:uint;
        private var _promptlyUpgradeBtn:Boolean;
        private static const _FACILITY_REINFORCE_SELECT_PLAYER_MAX:int = 10;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_MAIN:int = 2;
        private static const _PHASE_BUSY:int = 3;
        private static const _PHASE_REINFORCE_FLASH:int = 4;
        private static const _PHASE_REINFORCE_GAUGE:int = 5;
        private static const _PHASE_UPGRADE_EFFECT:int = 6;
        private static const _PHASE_UPGRADE_EFFECT2:int = 7;
        private static const _PHASE_CLOSE:int = 8;
        private static const _PHASE_END:int = 9;
        private static const _PHASE_UPGRADE_DURING:int = 10;
        private static const _PHASE_UPGRADE:int = 11;

        public function FacilityUpgrade(param1:DisplayObjectContainer, param2:int, param3:Array, param4:Function)
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            Main.GetProcess().topBar.cbConfigWindow(this.cbConfigWindowOpen, this.cbConfigWindowClose);
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_FacilityGradeUp.swf", "FacilityGradeUpMc");
            this._information1Mc = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_FacilityGradeUp.swf", "Information1Mc");
            this._mcMain = this._mcBase.facilityGradeUpMainMc.facilityGradeUpMc;
            this._mcIcon = this._mcMain.menuIconMoveMc;
            this._mcEffect = this._mcMain.expUpEffectMc;
            this._mcCaption = this._mcBase.facilityGradeUpMainMc.captionMc;
            var _loc_5:* = UserDataManager.getInstance().userData;
            this._aPlayerPersonal = param3;
            this._facilityInfo = _loc_5.getInstitutionInfo(param2);
            this._playerList = null;
            this.resetPlayerList();
            this._btnReturn = ButtonManager.getInstance().addButton(this._mcBase.charaListMc.returnBtnMc, this.cbReturnBtn);
            this._btnReturn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcBase.charaListMc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._btnIntesification = ButtonManager.getInstance().addButton(this._mcBase.facilityGradeUpMainMc.gradeUpBtnMc, this.cbIntesificationBtn);
            this._btnIntesification.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcBase.facilityGradeUpMainMc.gradeUpBtnMc.textMc.textDt, MessageId.FACILITY_BUTTON_REINFORCEMENT);
            this._btnUpgrade = ButtonManager.getInstance().addButton(this._mcBase.facilityGradeUpMainMc.extendBtnMc, this.cbUpgradeBtn);
            this._btnUpgrade.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcBase.facilityGradeUpMainMc.extendBtnMc.textMc.textDt, MessageId.FACILITY_BUTTON_EXPANSION);
            this._instantBtn = new InstantButton(this._mcBase.facilityGradeUpMainMc.payBtnTopMc.btnMc, MessageId.FACILITY_UPGRADE_PROMPTLY_BTN, this.cbPromptlyUpgradeBtn);
            this._btnReturn.setDisable(true);
            this._btnIntesification.setDisable(true);
            this._btnUpgrade.setDisable(true);
            this._instantBtn.setDisable(true);
            this._mcIcon.menuIconMc.kentikuNow.visible = false;
            this._isGaugeMax = false;
            this._intesificationGauge = new Gauge(this._mcMain.gradeUpBarMc.barMc, 100, 0);
            this._intesificationPreGauge = new Gauge(this._mcMain.gradeUpBarMc.predictBarMc, 100, 0);
            TextControl.setText(this._mcMain.facilityGradeNumMc.textDt, this._facilityInfo.grade.toString());
            this._mcIcon.menuIconMc.gotoAndStop(FacilityUpgradeUtility.getIconLabel(this._facilityInfo.id, this._facilityInfo.grade));
            this._numMcSelectedPlayerResource = new NumericNumberMc(this._mcMain.serectCharaNumMc.serectCharaNumMc.serectCharaNum2, 0, 0);
            this._numMcMaxPlayerResource = new NumericNumberMc(this._mcMain.serectCharaNumMc.serectCharaNumMc.serectCharaNum1, 10, 0);
            this._isoMain = new InStayOut(this._mcBase.facilityGradeUpMainMc);
            this._isoMain.setEnd();
            this._isoPlayerList = new InStayOut(this._mcBase.charaListMc);
            this._isoPlayerList.setEnd();
            this._isoInstantBtn = new InStayOut(this._mcBase.facilityGradeUpMainMc.payBtnTopMc);
            this._isoInstantBtn.setEnd();
            this._aPlayerResourceDisplay = [];
            var _loc_6:* = 0;
            while (_loc_6 < _FACILITY_REINFORCE_SELECT_PLAYER_MAX)
            {
                
                _loc_9 = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_FacilityGradeUp.swf", "SelectCharaParts");
                this._aPlayerResourceDisplay.push(new FacilityUpgradePlayerResourceDisplay(this._mcBase.facilityGradeUpMainMc.facilityGradeUpMc["SelectCharaNull" + (_loc_6 + 1)], _loc_9));
                _loc_6++;
            }
            TextControl.setIdText(this._mcBase.facilityGradeUpMainMc.facilityGradeUpMc.serectCharaNumMc.textMc.textDt, MessageId.FACILITY_SELECTED_PLAYER_TEXT);
            TextControl.setIdText(this._mcBase.facilityGradeUpMainMc.facilityGradeUpMc.serectCharaNumMc.unitMc.textDt, MessageId.FACILITY_SELECTED_PLAYER_UNIT);
            this._timeCount = 0;
            var _loc_7:* = TimeClock.getNowTime();
            this._endTime = 0;
            this._maxTimeSec = 0;
            for each (_loc_8 in _loc_5.aInstitution)
            {
                
                if (_loc_8.id == this._facilityInfo.id)
                {
                    this._endTime = _loc_8.upgradeEnd;
                    this._maxTimeSec = FacilityUpgradeUtility.getTime(this._facilityInfo.id, _loc_8.grade);
                    break;
                }
            }
            this._restoreTimeSec = this._endTime > _loc_7 ? (this._endTime - _loc_7) : (0);
            this._numMcTime = new NumericNumberMc(this._mcMain.timeWindowMc.remainingTimeMc, this.getTimeCount(), 0);
            TextControl.setIdText(this._mcMain.timeWindowMc.textMc.textDt, MessageId.FACILITY_UPGRADE_ENDTIME_MESSAGE);
            this._instantBtn.setLearning(FacilityUpgradeUtility.getUpgradeInstantLearningNum(this._restoreTimeSec));
            this._instantBtn.setEndTime(this._endTime);
            param1.addChild(this._mcBase);
            this._cbIntesification = null;
            this._cbGradeUp = null;
            this._cbGradeUpConnected = null;
            this._cbClose = param4;
            this._nextExp = 0;
            this._bEffectParentChanged = false;
            this._promptlyUpgradeBtn = false;
            this._mouseOverPlayer = null;
            this._mouseDownPlayer = null;
            this._bGoTradingPost = false;
            this.setPhase(_PHASE_END);
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain && this._isoMain.bClosed && (this._isoPlayerList && this._isoPlayerList.bClosed);
        }// end function

        public function get bAnimetion() : Boolean
        {
            return this._isoMain && this._isoMain.bAnimetion;
        }// end function

        public function get bGoTradingPost() : Boolean
        {
            return this._bGoTradingPost;
        }// end function

        public function getTimeCount() : int
        {
            var _loc_1:* = Math.min(this._maxTimeSec, this._restoreTimeSec);
            var _loc_2:* = _loc_1 % 60;
            var _loc_3:* = _loc_1 / 60 % 60;
            var _loc_4:* = _loc_1 / 60 / 60;
            return _loc_1 / 60 / 60 * 10000 + _loc_3 * 100 + _loc_2;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            ButtonManager.getInstance().removeButton(this._btnReturn);
            ButtonManager.getInstance().removeButton(this._btnUpgrade);
            ButtonManager.getInstance().removeButton(this._btnIntesification);
            this._btnReturn = null;
            this._btnUpgrade = null;
            this._btnIntesification = null;
            if (this._instantBtn)
            {
                this._instantBtn.release();
            }
            this._instantBtn = null;
            for each (_loc_1 in this._aPlayerResourceDisplay)
            {
                
                _loc_1.release();
            }
            _loc_1 = null;
            if (this._playerList)
            {
                this._playerList.release();
            }
            this._playerList = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._isoPlayerList)
            {
                this._isoPlayerList.release();
            }
            this._isoPlayerList = null;
            if (this._isoInstantBtn)
            {
                this._isoInstantBtn.release();
            }
            this._isoInstantBtn = null;
            if (this._intesificationPreGauge)
            {
                this._intesificationPreGauge.release();
            }
            this._intesificationPreGauge = null;
            if (this._intesificationGauge)
            {
                this._intesificationGauge.release();
            }
            this._intesificationGauge = null;
            if (this._information1Mc && this._information1Mc.parent)
            {
                this._information1Mc.parent.removeChild(this._information1Mc);
            }
            this._information1Mc = null;
            if (this._numMcCrown)
            {
                this._numMcCrown.release();
            }
            this._numMcCrown = null;
            if (this._numMcTime)
            {
                this._numMcTime.release();
            }
            this._numMcTime = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            InputManager.getInstance().delMouseCallback(this);
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_OPEN:
                {
                    this.initPhaseOpen();
                    break;
                }
                case _PHASE_MAIN:
                {
                    this.initPhaseMain();
                    break;
                }
                case _PHASE_BUSY:
                {
                    this.initPhaseBusy();
                    break;
                }
                case _PHASE_REINFORCE_FLASH:
                {
                    this.initPhaseIntesificationFlash();
                    break;
                }
                case _PHASE_REINFORCE_GAUGE:
                {
                    this.initPhaseIntesificationGauge();
                    break;
                }
                case _PHASE_UPGRADE_EFFECT:
                {
                    this.initPhaseUpgradeEffect();
                    break;
                }
                case _PHASE_UPGRADE_EFFECT2:
                {
                    this.initPhaseUpgradeEffect2();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.initPhaseClose();
                    break;
                }
                case _PHASE_UPGRADE_DURING:
                {
                    this.initPhaseUpgradeDuring();
                    break;
                }
                case _PHASE_UPGRADE:
                {
                    this.initUpgrade();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case _PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case _PHASE_MAIN:
                {
                    this.controlMain(param1);
                    break;
                }
                case _PHASE_REINFORCE_FLASH:
                {
                    this.controlIntesificationFlash();
                    break;
                }
                case _PHASE_REINFORCE_GAUGE:
                {
                    this.controlIntesificationGauge();
                    break;
                }
                case _PHASE_UPGRADE_EFFECT:
                {
                    this.controlUpgradeEffect();
                    break;
                }
                case _PHASE_UPGRADE_EFFECT2:
                {
                    this.controlUpgradeEffect2();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                case _PHASE_UPGRADE_DURING:
                {
                    this._timeCount = this._timeCount + param1;
                    this.controlUpgradeDuring(param1);
                    break;
                }
                case _PHASE_UPGRADE:
                {
                    this.controlUpgrade();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._instantBtn)
            {
                this._instantBtn.control(param1);
            }
            return;
        }// end function

        public function initPhaseOpen() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            TutorialManager.getInstance().hideTutorialArrow();
            this._playerList.setSelectEnable(false);
            this._isoMain.setIn();
            this._isoPlayerList.setIn();
            var _loc_1:* = TimeClock.getNowTime();
            var _loc_2:* = UserDataManager.getInstance().userData;
            for each (_loc_3 in _loc_2.aInstitution)
            {
                
                if (_loc_3.id == this._facilityInfo.id)
                {
                    _loc_4 = _loc_3;
                    break;
                }
            }
            if (_loc_4.upgradeEnd != 0 && _loc_4.upgradeEnd < _loc_1)
            {
                this.changeModeUpgradeDuringExpansion();
            }
            else if (_loc_4.upgradeEnd >= _loc_1)
            {
                this._endTime = _loc_4.upgradeEnd;
                this._restoreTimeSec = this._endTime > _loc_1 ? (this._endTime - _loc_1) : (0);
                this._maxTimeSec = FacilityUpgradeUtility.getTime(this._facilityInfo.id, _loc_4.grade);
                this.changeModeUpgradeExtension();
            }
            else if (FacilityUpgradeUtility.isMaxExp(this._facilityInfo.id, this._facilityInfo.grade, this._facilityInfo.exp))
            {
                this.changeModeUpgrade();
            }
            else
            {
                this.changeModeIntesification();
            }
            this.initIntesificationGauge();
            return;
        }// end function

        public function controlOpen() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._isoMain.bOpened)
            {
                if (!this._bEffectParentChanged)
                {
                    _loc_1 = this._mcEffect.localToGlobal(new Point());
                    this._mcBase.addChild(this._mcEffect);
                    _loc_2 = this._mcBase.globalToLocal(_loc_1);
                    this._mcEffect.x = _loc_2.x;
                    this._mcEffect.y = _loc_2.y;
                    this._bEffectParentChanged = true;
                }
                this.setPhase(_PHASE_MAIN);
            }
            return;
        }// end function

        public function initPhaseMain() : void
        {
            var bTutorialPopup:* = TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_2);
            var b:* = this.isModeUpgrade();
            this._playerList.setSelectEnable(!b && !bTutorialPopup);
            this._playerList.overlayVisible(b);
            this._btnIntesification.setDisable(b || this._playerList.getMultiSelectNum() == 0);
            this._btnUpgrade.setDisable(!b || FacilityUpgradeUtility.isMaxGrade(this._facilityInfo.id, this._facilityInfo.grade));
            this._btnReturn.setDisable(false);
            if (bTutorialPopup)
            {
                this._playerList.setSelectEnable(false);
                with ({})
                {
                    {}.close = function () : void
            {
                _playerList.setSelectEnable(true);
                return;
            }// end function
            ;
                }
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_2, function () : void
            {
                _playerList.setSelectEnable(true);
                return;
            }// end function
            );
                return;
            }
            return;
        }// end function

        public function controlMain(param1:Number) : void
        {
            return;
        }// end function

        public function initPhaseBusy() : void
        {
            this._playerList.setSelectEnable(false);
            this._btnIntesification.setDisable(true);
            this._btnUpgrade.setDisable(true);
            this._btnReturn.setDisable(true);
            return;
        }// end function

        public function initPhaseUpgradeDuring() : void
        {
            return;
        }// end function

        public function controlUpgradeDuring(param1:Number) : void
        {
            var _loc_2:* = 0;
            if (Main.GetProcess().isCrownUpdateing())
            {
                return;
            }
            if (!this._promptlyUpgradeBtn)
            {
                if (this._restoreTimeSec > 0 && this._timeCount >= 1)
                {
                    _loc_2 = Math.floor(this._timeCount);
                    this.countTime(_loc_2);
                    this._timeCount = this._timeCount - _loc_2;
                }
                this._instantTtype = FacilityUpgradeUtility.getType(this._restoreTimeSec);
                this._instantBtn.setLearning(FacilityUpgradeUtility.getUpgradeInstantLearningNum(this._restoreTimeSec));
                if (this._restoreTimeSec <= 0)
                {
                    this._mcMain.timeWindowMc.gotoAndPlay("out");
                    this._isoInstantBtn.setOut();
                    this._information1Mc.gotoAndPlay("out");
                    this._mcIcon.menuIconMc.kentikuNow.visible = false;
                    this._btnReturn.setDisable(true);
                    this.setPhase(_PHASE_UPGRADE);
                }
            }
            return;
        }// end function

        private function countTime(param1:int) : void
        {
            var _loc_2:* = TimeClock.getNowTime();
            this._restoreTimeSec = this._endTime > _loc_2 ? (this._endTime - _loc_2) : (0);
            var _loc_3:* = Math.min(this._maxTimeSec, this._restoreTimeSec);
            var _loc_4:* = _loc_3 % 60;
            var _loc_5:* = _loc_3 / 60 % 60;
            var _loc_6:* = _loc_3 / 60 / 60;
            var _loc_7:* = _loc_3 / 60 / 60 * 10000 + _loc_5 * 100 + _loc_4;
            this._numMcTime.setNum(_loc_7);
            return;
        }// end function

        public function initPhaseIntesificationFlash() : void
        {
            this._playerList.resetSelect();
            this._playerList.setSelectEnable(false);
            var _loc_1:* = 0;
            while (_loc_1 < this._aPlayerResourceDisplay.length)
            {
                
                (this._aPlayerResourceDisplay[_loc_1] as FacilityUpgradePlayerResourceDisplay).play();
                _loc_1++;
            }
            this._mcEffect.gotoAndPlay("expUp");
            SoundManager.getInstance().playSe(SoundId.SE_EFFECT);
            return;
        }// end function

        public function controlIntesificationFlash() : void
        {
            if (this._mcEffect.currentFrameLabel == "end")
            {
                this.setPhase(_PHASE_REINFORCE_GAUGE);
            }
            return;
        }// end function

        public function initPhaseIntesificationGauge() : void
        {
            var loopFunc:Function;
            this._intesificationGauge.setTargetGauge(this._nextExp);
            this._mcMain.gradeUpBarMc.barMc.berAnimeMc.gotoAndPlay("blink");
            loopFunc = function () : void
            {
                if (_intesificationGauge.isStop() == false)
                {
                    SoundManager.getInstance().playSeCallBack(SoundId.SE_GAGE, loopFunc);
                }
                return;
            }// end function
            ;
            this.loopFunc();
            return;
        }// end function

        public function controlIntesificationGauge() : void
        {
            var i:int;
            if (this._intesificationGauge.isStop())
            {
                this.setSelectedPlayerResourceInfo(0, 0);
                this._playerList.createPlayerList();
                this._playerList.updateList();
                if (FacilityUpgradeUtility.isMaxExp(this._facilityInfo.id, this._facilityInfo.grade, this._facilityInfo.exp))
                {
                    this.setPhase(_PHASE_BUSY);
                    if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_4))
                    {
                        TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_4, function () : void
            {
                setPhase(_PHASE_MAIN);
                changeModeUpgrade();
                return;
            }// end function
            );
                        return;
                    }
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.FACILITY_POPUP_MESSAGE_REINFORCE_GAUGE_MAX), function () : void
            {
                setPhase(_PHASE_MAIN);
                changeModeUpgrade();
                return;
            }// end function
            );
                    return;
                }
                i;
                while (i < this._aPlayerResourceDisplay.length)
                {
                    
                    (this._aPlayerResourceDisplay[i] as FacilityUpgradePlayerResourceDisplay).reset();
                    i = (i + 1);
                }
                this.setPhase(_PHASE_MAIN);
            }
            return;
        }// end function

        private function initUpgrade() : void
        {
            switch(this._facilityInfo.id)
            {
                case CommonConstant.FACILITY_ID_BARRACKS:
                {
                    NetManager.getInstance().request(new NetTaskBarracksUpgradeEnd(this._instantTtype, 0, this.cbConnectUpgradeEnd));
                    break;
                }
                case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                {
                    NetManager.getInstance().request(new NetTaskSkillInitiateUpgradeEnd(this._instantTtype, 0, this.cbConnectUpgradeEnd));
                    break;
                }
                case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                {
                    NetManager.getInstance().request(new NetTaskMagicDevelopUpgradeEnd(this._instantTtype, 0, this.cbConnectUpgradeEnd));
                    break;
                }
                case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                {
                    NetManager.getInstance().request(new NetTaskTrainingRoomUpgradeEnd(this._instantTtype, 0, this.cbConnectUpgradeEnd));
                    break;
                }
                case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                {
                    NetManager.getInstance().request(new NetTaskMakeEquipUpgradeEnd(this._instantTtype, 0, this.cbConnectUpgradeEnd));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function controlUpgrade() : void
        {
            return;
        }// end function

        public function initPhaseUpgradeEffect() : void
        {
            this._mcIcon.gotoAndPlay("start");
            this._mcIcon.menuIconMc.kentikuNow.visible = false;
            return;
        }// end function

        public function controlUpgradeEffect() : void
        {
            var _loc_1:* = 0;
            switch(this._mcIcon.currentFrameLabel)
            {
                case "iconChange":
                {
                    _loc_1 = UserFacilityLv.getFacilityLv(this._facilityInfo.grade);
                    this._mcIcon.menuIconMc.gotoAndStop(FacilityUpgradeUtility.getIconLabel(this._facilityInfo.id, this._facilityInfo.grade));
                    TextControl.setText(this._mcMain.facilityGradeNumMc.textDt, this._facilityInfo.grade.toString());
                    if (this._cbGradeUp != null)
                    {
                        this._cbGradeUp();
                    }
                    break;
                }
                case "end":
                {
                    this.setPhase(_PHASE_UPGRADE_EFFECT2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._mcIcon.isPlaying && this._mcIcon.currentFrameLabel == "se1001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_GRADEUP_GATHER);
            }
            if (this._mcIcon.isPlaying && this._mcIcon.currentFrame == 45)
            {
                SoundManager.getInstance().playSe(SoundId.SE_BRANCH);
            }
            return;
        }// end function

        public function initPhaseUpgradeEffect2() : void
        {
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NAVI, MessageManager.getInstance().getMessage(MessageId.FACILITY_UPGRADENOW_END), function () : void
            {
                setPhase(_PHASE_CLOSE);
                return;
            }// end function
            );
            return;
        }// end function

        public function controlUpgradeEffect2() : void
        {
            return;
        }// end function

        public function initPhaseClose() : void
        {
            Main.GetProcess().topBar.cbConfigWindow(null, null);
            this._instantBtn.setDisable(false);
            this._btnIntesification.setDisable(false);
            this._playerList.resetSelect();
            this._playerList.setSelectEnable(false);
            var _loc_1:* = 0;
            while (_loc_1 < this._aPlayerResourceDisplay.length)
            {
                
                (this._aPlayerResourceDisplay[_loc_1] as FacilityUpgradePlayerResourceDisplay).reset();
                _loc_1++;
            }
            this._isoMain.setOut();
            this._isoPlayerList.setOut();
            this._btnReturn.setDisable(true);
            this._btnIntesification.setDisable(true);
            this._btnUpgrade.setDisable(true);
            if (this._mcMain.timeWindowMc.currentFrameLabel == "stay")
            {
                this._mcMain.timeWindowMc.gotoAndPlay("out");
            }
            if (this._isoInstantBtn.bOpened)
            {
                this._isoInstantBtn.setOut();
            }
            if (this._information1Mc.currentFrameLabel == "stay")
            {
                this._information1Mc.gotoAndPlay("out");
            }
            this._instantBtn.setDisable(true);
            return;
        }// end function

        public function controlClose() : void
        {
            if (this._isoMain.bClosed && this._isoPlayerList.bClosed)
            {
                if (this._cbClose != null)
                {
                    this._cbClose();
                }
                this.setPhase(_PHASE_END);
            }
            return;
        }// end function

        public function open() : void
        {
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function setIntesificationCallback(param1:Function) : void
        {
            this._cbIntesification = param1;
            return;
        }// end function

        public function setGradeUpCallback(param1:Function) : void
        {
            this._cbGradeUp = param1;
            return;
        }// end function

        public function setGradeUpConnectedCallback(param1:Function) : void
        {
            this._cbGradeUpConnected = param1;
            return;
        }// end function

        public function resetPlayerList() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aPlayerPersonal)
            {
                
                if (_loc_2.isUseFacility() || UserDataManager.getInstance().userData.aFormationPlayerUniqueId.indexOf(_loc_2.uniqueId) != -1 || _loc_2.isEmperor())
                {
                    _loc_1.push(_loc_2.uniqueId);
                }
            }
            if (this._playerList == null)
            {
                _loc_3 = [];
                for each (_loc_4 in this._aPlayerPersonal)
                {
                    
                    _loc_3.push(new ListPlayerData(_loc_4));
                }
                this._playerList = new FacilityUpgradePlayerList(this._mcBase.charaListMc.reserveListMc, _loc_3, _FACILITY_REINFORCE_SELECT_PLAYER_MAX);
                this._playerList.setNotDisplayPlayer(_loc_1);
                this._playerList.setPlayerSelectCallback(this.cbPlayerSelectFunc);
                this._playerList.setPlayerUnselectCallback(this.cbPlayerUnselectFunc);
                this._playerList.setSelectCountOverCallback(this.cbSelectCountOverFunc);
                this._playerList.setExpOverCallback(this.cbSelectCountOverFunc);
                this._playerList.setRemainPlayerNumCallback(this.cbRemainPlayerNumFunc);
                this._playerList.setCaptionText(MessageManager.getInstance().getMessage(MessageId.BARRACKS_SOLDIER_LIST_CAPTION));
                this._playerList.setSelectEnable(false);
                this._playerList.setExpMaxState(this._isGaugeMax);
                this._playerList.updateList();
            }
            else
            {
                this._playerList.setNotDisplayPlayer(_loc_1);
                this._playerList.setExpMaxState(this._isGaugeMax);
                this._playerList.updateList();
            }
            return;
        }// end function

        public function notDisplayPlayer(param1:int) : void
        {
            this._playerList.addNotDisplayPlayer(param1);
            this._playerList.updateList();
            return;
        }// end function

        public function displayPlayer(param1:int) : void
        {
            this._playerList.removeNotDisplayPlayer(param1);
            this._playerList.updateList();
            return;
        }// end function

        private function changeModeIntesification() : void
        {
            this._btnUpgrade.getMoveClip().visible = false;
            this._btnIntesification.getMoveClip().visible = true;
            this._mcMain.paymentCRMc.visible = false;
            this._mcMain.serectCharaNumMc.visible = true;
            this._btnIntesification.setDisable(true);
            this._btnUpgrade.setDisable(true);
            this._playerList.overlayVisible(false);
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.BARRACKS_HELP_TEXT02));
            this.initEfficacyText();
            return;
        }// end function

        private function changeModeUpgrade() : void
        {
            this._btnUpgrade.getMoveClip().visible = true;
            this._btnIntesification.getMoveClip().visible = false;
            this._mcMain.paymentCRMc.visible = false;
            this._mcMain.serectCharaNumMc.visible = false;
            this._btnIntesification.setDisable(true);
            this._btnUpgrade.setDisable(FacilityUpgradeUtility.isMaxGrade(this._facilityInfo.id, this._facilityInfo.grade));
            this._playerList.overlayVisible(true);
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.BARRACKS_HELP_TEXT03));
            this.initEfficacyText();
            return;
        }// end function

        private function changeModeUpgradeExtension() : void
        {
            this._btnUpgrade.getMoveClip().visible = false;
            this._btnIntesification.getMoveClip().visible = false;
            this._mcMain.paymentCRMc.visible = false;
            this._mcMain.serectCharaNumMc.visible = false;
            this._btnIntesification.setDisable(true);
            this._btnUpgrade.setDisable(true);
            this._playerList.overlayVisible(true);
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.FACILITY_UPGRADE_GUIDE_UPGRADE));
            this.initEfficacyText();
            this._mcMain.timeWindowMc.gotoAndPlay("in");
            this._isoInstantBtn.setIn();
            this._information1Mc.gotoAndPlay("in");
            this._instantBtn.setDisable(false);
            this._playerList.setSelectEnable(false);
            this._btnReturn.setDisable(false);
            this._mcIcon.menuIconMc.kentikuNow.visible = true;
            this.setPhase(_PHASE_UPGRADE_DURING);
            return;
        }// end function

        private function changeModeUpgradeDuringExpansion() : void
        {
            this._btnUpgrade.getMoveClip().visible = false;
            this._btnIntesification.getMoveClip().visible = false;
            this._mcMain.paymentCRMc.visible = false;
            this._mcMain.serectCharaNumMc.visible = false;
            this._btnIntesification.setDisable(true);
            this._btnUpgrade.setDisable(true);
            this._playerList.overlayVisible(true);
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.FACILITY_UPGRADE_GUIDE_UPGRADE));
            this.initEfficacyText();
            this._instantBtn.setDisable(true);
            this._playerList.setSelectEnable(false);
            this._btnReturn.setDisable(true);
            this._mcIcon.menuIconMc.kentikuNow.visible = false;
            this._instantTtype = 0;
            this.setPhase(_PHASE_UPGRADE);
            return;
        }// end function

        private function initEfficacyText() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (FacilityUpgradeUtility.isMaxGrade(this._facilityInfo.id, this._facilityInfo.grade))
            {
                TextControl.setText(this._mcMain.GradeUpTextMc5.textDt, "");
                TextControl.setText(this._mcMain.GradeUpTextMc4.textDt, "");
                TextControl.setText(this._mcMain.GradeUpTextMc3.textDt, "");
                TextControl.setText(this._mcMain.GradeUpTextMc2.textDt, "");
                TextControl.setText(this._mcMain.GradeUpTextMc1.textDt, "");
            }
            else
            {
                _loc_1 = FacilityUpgradeUtility.getEfficacyText(this._facilityInfo.id, this._facilityInfo.grade);
                _loc_2 = _loc_1.split("\n");
                TextControl.setText(this._mcMain.GradeUpTextMc5.textDt, _loc_2.length > 0 ? (_loc_2[0]) : (""));
                TextControl.setText(this._mcMain.GradeUpTextMc4.textDt, _loc_2.length > 1 ? (_loc_2[1]) : (""));
                TextControl.setText(this._mcMain.GradeUpTextMc3.textDt, _loc_2.length > 2 ? (_loc_2[2]) : (""));
                TextControl.setText(this._mcMain.GradeUpTextMc2.textDt, _loc_2.length > 3 ? (_loc_2[3]) : (""));
                TextControl.setText(this._mcMain.GradeUpTextMc1.textDt, _loc_2.length > 4 ? (_loc_2[4]) : (""));
            }
            return;
        }// end function

        private function initIntesificationGauge() : void
        {
            this._numMcSelectedPlayerResource.setNum(0);
            if (FacilityUpgradeUtility.isMaxGrade(this._facilityInfo.id, this._facilityInfo.grade))
            {
                this._intesificationGauge.setMaxGauge(100);
                this._intesificationPreGauge.setMaxGauge(100);
                this._intesificationGauge.setGauge(100);
                this._intesificationPreGauge.setGauge(100);
                this._mcMain.gradeUpBarMc.gotoAndStop("normale");
                this._isGaugeMax = true;
            }
            else
            {
                this._intesificationGauge.setMaxGauge(FacilityUpgradeUtility.getMaxExp(this._facilityInfo.id, this._facilityInfo.grade));
                this._intesificationPreGauge.setMaxGauge(FacilityUpgradeUtility.getMaxExp(this._facilityInfo.id, this._facilityInfo.grade));
                this._intesificationGauge.setGauge(this._facilityInfo.exp);
                this._intesificationPreGauge.setGauge(this._facilityInfo.exp);
                this._mcMain.gradeUpBarMc.gotoAndStop(this._intesificationGauge.gaugeNow >= this._intesificationGauge.gaugeMax ? ("blink") : ("normale"));
                this._isGaugeMax = this._intesificationGauge.gaugeNow >= this._intesificationGauge.gaugeMax;
            }
            return;
        }// end function

        private function updatePlayerResource() : void
        {
            var id:int;
            var i:int;
            var pp:PlayerPersonal;
            var ppInfo:PlayerInformation;
            var userData:* = UserDataManager.getInstance().userData;
            var aId:* = this._playerList.getMultiSelectPlayerUniqueIdArray();
            var increaseExp:Number;
            var aInfo:Array;
            var _loc_2:* = 0;
            var _loc_3:* = aId;
            while (_loc_3 in _loc_2)
            {
                
                id = _loc_3[_loc_2];
                pp = userData.getPlayerPersonal(id);
                ppInfo = PlayerManager.getInstance().getPlayerInformation(pp.playerId);
                increaseExp = increaseExp + FacilityUpgradeUtility.getIntesificationExp(ppInfo.rarity, pp.getGrowthTotal());
                aInfo.push({info:ppInfo, uniqueId:id});
            }
            aInfo.sort(function (param1:Object, param2:Object) : int
            {
                return PlayerManager.getInstance().cmpRarityValue(param2.info.rarity, param1.info.rarity);
            }// end function
            );
            i;
            while (i < this._aPlayerResourceDisplay.length)
            {
                
                if (i < aInfo.length)
                {
                    (this._aPlayerResourceDisplay[i] as FacilityUpgradePlayerResourceDisplay).setPlayer(aInfo[i].info.id, aInfo[i].uniqueId, aInfo[i].info.rarity);
                }
                else
                {
                    (this._aPlayerResourceDisplay[i] as FacilityUpgradePlayerResourceDisplay).reset();
                }
                i = (i + 1);
            }
            this.setSelectedPlayerResourceInfo(this._playerList.getMultiSelectNum(), int(increaseExp));
            return;
        }// end function

        private function setSelectedPlayerResourceInfo(param1:int, param2:int) : void
        {
            this._btnIntesification.setDisable(param1 <= 0);
            this._numMcSelectedPlayerResource.setNum(param1);
            this._intesificationPreGauge.setGauge(this._intesificationGauge.gaugeNow + param2);
            this._mcMain.gradeUpBarMc.gotoAndStop(this._intesificationGauge.gaugeNow + param2 >= this._intesificationPreGauge.gaugeMax ? ("blink") : ("normale"));
            this._isGaugeMax = this._intesificationPreGauge.gaugeNow >= this._intesificationGauge.gaugeMax;
            if (this._playerList)
            {
                this._playerList.setExpMaxState(this._isGaugeMax);
            }
            return;
        }// end function

        private function setGuideText(param1:String) : void
        {
            TextControl.setText(this._mcCaption.textMc.textDt, param1);
            var _loc_2:* = param1.split("\n");
            this._mcCaption.gotoAndStop("linage" + (_loc_2.length > 1 ? ("2") : ("1")));
            return;
        }// end function

        private function isModeUpgrade() : Boolean
        {
            return this._btnUpgrade.getMoveClip().visible;
        }// end function

        private function cbReturnBtn(param1:int) : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbIntesificationBtn(param1:int) : void
        {
            var personal:PlayerPersonal;
            var pInfo:PlayerInformation;
            var id:* = param1;
            this.setPhase(_PHASE_BUSY);
            var bContainRare:Boolean;
            var _loc_3:* = 0;
            var _loc_4:* = this._playerList.getMultiSelectPlayerUniqueIdArray();
            while (_loc_4 in _loc_3)
            {
                
                id = _loc_4[_loc_3];
                var _loc_5:* = 0;
                var _loc_6:* = this._aPlayerPersonal;
                while (_loc_6 in _loc_5)
                {
                    
                    personal = _loc_6[_loc_5];
                    if (personal.uniqueId == id)
                    {
                        pInfo = PlayerManager.getInstance().getPlayerInformation(personal.playerId);
                        if (pInfo && PlayerManager.getInstance().needDeleteCheckRarity(pInfo.rarity))
                        {
                            bContainRare;
                            break;
                        }
                    }
                }
                if (bContainRare)
                {
                    break;
                }
            }
            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, bContainRare ? (MessageManager.getInstance().getMessage(MessageId.FACILITY_POPUP_MESSAGE_REINFORCE_CONFIRM_RARE)) : (MessageManager.getInstance().getMessage(MessageId.FACILITY_POPUP_MESSAGE_REINFORCE_CONFIRM)), function (param1:Boolean) : void
            {
                switch(_facilityInfo.id)
                {
                    case CommonConstant.FACILITY_ID_BARRACKS:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function cbConnectIntesification(param1:NetResult) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_2:* = UserDataManager.getInstance().userData;
            for each (_loc_3 in _loc_2.aInstitution)
            {
                
                if (_loc_3.id == this._facilityInfo.id)
                {
                    _loc_3.setFacilityInfo(param1.data.institution);
                    break;
                }
            }
            this._facilityInfo.setFacilityInfo(param1.data.institution);
            _loc_4 = _loc_2.aPlayerPersonal;
            _loc_5 = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                if (this._aPlayerResourceId.indexOf(_loc_4[_loc_5].uniqueId) != -1)
                {
                    _loc_4.splice(_loc_5, 1);
                    _loc_5 = _loc_5 - 1;
                    ;
                }
                _loc_5++;
            }
            _loc_2.setOwnPlayer(_loc_4);
            _loc_5 = 0;
            while (_loc_5 < this._aPlayerPersonal.length)
            {
                
                if (this._aPlayerResourceId.indexOf(this._aPlayerPersonal[_loc_5].uniqueId) != -1)
                {
                    this._aPlayerPersonal.splice(_loc_5, 1);
                    _loc_5 = _loc_5 - 1;
                    ;
                }
                _loc_5++;
            }
            _loc_5 = 0;
            while (_loc_5 < this._aPlayerResourceId.length)
            {
                
                this._playerList.removePlayer(this._aPlayerResourceId[_loc_5]);
                _loc_5++;
            }
            if (this._cbIntesification != null)
            {
                this._cbIntesification(this._aPlayerResourceId);
            }
            this._nextExp = this._facilityInfo.exp;
            this.setPhase(_PHASE_REINFORCE_FLASH);
            return;
        }// end function

        private function cbUpgradeBtn(param1:int) : void
        {
            var id:* = param1;
            this.setPhase(_PHASE_BUSY);
            var upgradeSec:* = FacilityUpgradeUtility.getTime(this._facilityInfo.id, this._facilityInfo.grade);
            var sec:* = upgradeSec % 60;
            var min:* = upgradeSec / 60 % 60;
            var hour:* = upgradeSec / 60 / 60;
            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NAVI, TextControl.formatIdText(MessageId.FACILITY_UPGRADE_PROMPTLY_MESSAGE, hour < 10 ? ("0" + hour.toString()) : (hour), min < 10 ? ("0" + min.toString()) : (min), sec < 10 ? ("0" + sec.toString()) : (sec)), function (param1:Boolean) : void
            {
                switch(_facilityInfo.id)
                {
                    case CommonConstant.FACILITY_ID_BARRACKS:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }// end function
            , MessageManager.getInstance().getMessage(MessageId.FACILITY_UPGRADE_BTN), MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_QUIT));
            return;
        }// end function

        private function cbConnectUpgrade(param1:NetResult) : void
        {
            var info:InstitutionInfo;
            var res:* = param1;
            var userData:* = UserDataManager.getInstance().userData;
            var facilityFound:Boolean;
            var _loc_3:* = 0;
            var _loc_4:* = userData.aInstitution;
            while (_loc_4 in _loc_3)
            {
                
                info = _loc_4[_loc_3];
                if (info.id == this._facilityInfo.id)
                {
                    info.setFacilityInfo(res.data.institution);
                    facilityFound;
                    break;
                }
            }
            if (facilityFound == false)
            {
                userData.addFacility(res.data.institution);
            }
            this._facilityInfo.setFacilityInfo(res.data.institution);
            NoticeManager.getInstance().addMiniNoticeByObject(res.data.institutionNotice);
            var nowTime:* = TimeClock.getNowTime();
            this._endTime = this._facilityInfo.upgradeEnd;
            this._restoreTimeSec = this._endTime > nowTime ? (this._endTime - nowTime) : (0);
            this._maxTimeSec = FacilityUpgradeUtility.getTime(this._facilityInfo.id, this._facilityInfo.grade);
            this._instantBtn.setLearning(FacilityUpgradeUtility.getUpgradeInstantLearningNum(this._restoreTimeSec));
            this._instantBtn.setEndTime(this._endTime);
            if (this._cbGradeUpConnected != null)
            {
                this._cbGradeUpConnected(res);
            }
            this.changeModeUpgradeExtension();
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_5))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_5, function () : void
            {
                setPhase(_PHASE_UPGRADE_DURING);
                return;
            }// end function
            );
            }
            else
            {
                this.setPhase(_PHASE_UPGRADE_DURING);
            }
            return;
        }// end function

        private function cbPromptlyUpgradeBtn(param1:int) : void
        {
            var numCost:int;
            var id:* = param1;
            this._promptlyUpgradeBtn = true;
            this._instantBtn.setDisable(true);
            this._btnIntesification.setDisable(true);
            numCost = FacilityUpgradeUtility.getUpgradeInstantLearningNum(this._restoreTimeSec);
            var instantLearningItemNum:* = UserDataManager.getInstance().userData.getOwnPaymentItemNum(PaymentItemId.ITEM_INSTANT_LEARNING);
            if (instantLearningItemNum >= numCost)
            {
                CommonPopup.getInstance().openPaymentPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.CONFIRM_USE_ITEM_JEWEL, instantLearningItemNum, numCost), function (param1:Boolean) : void
            {
                var nowTime:uint;
                var instantTtype:int;
                var isPositive:* = param1;
                if (nowTime >= _endTime)
                {
                }
                switch(_facilityInfo.id)
                {
                    case CommonConstant.FACILITY_ID_BARRACKS:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }// end function
            );
            }
            else
            {
                CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.FACILITY_POPUP_MESSAGE_CROWN_NOT_ENOUGH2), function (param1:Boolean) : void
            {
                if (param1)
                {
                    _bGoTradingPost = true;
                    TradingPostStartPageRequest.getInstance().setRequestInstantLearning();
                    setPhase(_PHASE_CLOSE);
                }
                else
                {
                    promptlyUpgradeClose();
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function promptlyUpgradeClose() : void
        {
            this._promptlyUpgradeBtn = false;
            this._instantBtn.setDisable(false);
            this._btnIntesification.setDisable(false);
            return;
        }// end function

        private function cbConnectUpgradeEnd(param1:NetResult) : void
        {
            var info:InstitutionInfo;
            var res:* = param1;
            if (res.data.alreadyEnd == 1)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CONFIRM_ALREADY_USE_ITEM_JEWEL), function () : void
            {
                promptlyUpgradeClose();
                return;
            }// end function
            );
                return;
            }
            if (this._instantTtype > 0)
            {
                this._mcMain.timeWindowMc.gotoAndPlay("out");
                this._isoInstantBtn.setOut();
                this._information1Mc.gotoAndPlay("out");
                this._mcIcon.menuIconMc.kentikuNow.visible = false;
                this._btnReturn.setDisable(true);
            }
            var userData:* = UserDataManager.getInstance().userData;
            if (res.data.crownData)
            {
                userData.setCrownTotal(res.data.crownData);
                Main.GetProcess().topBar.update();
            }
            var facilityFound:Boolean;
            var _loc_3:* = 0;
            var _loc_4:* = userData.aInstitution;
            while (_loc_4 in _loc_3)
            {
                
                info = _loc_4[_loc_3];
                if (info.id == this._facilityInfo.id)
                {
                    info.setFacilityInfo(res.data.institution);
                    facilityFound;
                    break;
                }
            }
            if (facilityFound == false)
            {
                userData.addFacility(res.data.institution);
            }
            this._facilityInfo.setFacilityInfo(res.data.institution);
            if (this._cbGradeUpConnected != null)
            {
                this._cbGradeUpConnected(res);
            }
            NoticeManager.getInstance().crearSimpleNoticeById(res.data.institutionNoticeId);
            this.setPhase(_PHASE_UPGRADE_EFFECT);
            return;
        }// end function

        private function cbPlayerSelectFunc(param1:int, param2:ListPlayerData) : void
        {
            this.updatePlayerResource();
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_3))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_3);
                return;
            }
            return;
        }// end function

        private function cbPlayerUnselectFunc(param1:int, param2:ListPlayerData) : void
        {
            this.updatePlayerResource();
            return;
        }// end function

        private function cbSelectCountOverFunc(param1:int, param2:ListPlayerData) : void
        {
            SoundManager.getInstance().playSe(SoundId.SE_GACHA_DISABLE);
            return;
        }// end function

        private function cbRemainPlayerNumFunc(param1:int, param2:ListPlayerData) : void
        {
            var listIndex:* = param1;
            var listPLayerData:* = param2;
            SoundManager.getInstance().playSe(SoundId.SE_GACHA_DISABLE);
            this.cbConfigWindowOpen();
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.MINIMUM_NUMBER_CHECK_MESSAGE), function () : void
            {
                cbConfigWindowClose();
                return;
            }// end function
            );
            return;
        }// end function

        private function cbMouseMove(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_5:* = false;
            var _loc_3:* = -1;
            var _loc_4:* = 0;
            for each (_loc_2 in this._aPlayerResourceDisplay)
            {
                
                if (_loc_2.bShow && _loc_2.playerDisplay.isHitTest())
                {
                    _loc_3 = _loc_4;
                    break;
                }
                _loc_4++;
            }
            if (_loc_3 == -1)
            {
                this._mouseOverPlayer = null;
            }
            _loc_4 = 0;
            for each (_loc_2 in this._aPlayerResourceDisplay)
            {
                
                if (_loc_2.bShow)
                {
                    _loc_5 = _loc_4 == _loc_3;
                    if (_loc_2.bMouseOver != _loc_5)
                    {
                        _loc_2.bMouseOver = _loc_5;
                        if (_loc_5)
                        {
                            this._mouseOverPlayer = _loc_2;
                            SoundManager.getInstance().playSe(ButtonBase.SE_SELECT_ID);
                        }
                        _loc_2.playerDisplay.setSelect(_loc_5);
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        private function cbMouseDown(event:MouseEvent) : void
        {
            this._mouseDownPlayer = this._mouseOverPlayer;
            return;
        }// end function

        private function cbMouseClick(event:MouseEvent) : void
        {
            if (this._mouseDownPlayer)
            {
                this._playerList.unselectPlayer(this._mouseDownPlayer.playerDisplay.uniqueId);
                this.updatePlayerResource();
            }
            return;
        }// end function

        public function cbConfigWindowOpen() : void
        {
            if (this._playerList)
            {
                this._playerList.setSelectEnable(false);
            }
            return;
        }// end function

        public function cbConfigWindowClose() : void
        {
            if (this._playerList)
            {
                this._playerList.setSelectEnable(true);
            }
            return;
        }// end function

        private function cbRestEnd(param1:PlayerPersonal) : void
        {
            if (this._playerList)
            {
                this.resetPlayerList();
                this._playerList.setRestEndAction(param1.uniqueId);
            }
            return;
        }// end function

        public static function loadResource() : void
        {
            ResourceManager.getInstance().loadResource(ResourcePath.FACILITY_PATH + "UI_FacilityGradeUp.swf");
            FacilityUpgradePlayerList.loadResource();
            SoundManager.getInstance().loadSoundArray([SoundId.SE_GACHA_DISABLE, SoundId.SE_EFFECT, SoundId.SE_GAGE, SoundId.SE_BRANCH, SoundId.SE_REV_GRADEUP_GATHER]);
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_5))
            {
                TutorialManager.getInstance().loadResource();
            }
            return;
        }// end function

    }
}
