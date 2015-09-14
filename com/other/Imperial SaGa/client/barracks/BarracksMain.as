package barracks
{
    import asset.*;
    import button.*;
    import facility.*;
    import flash.display.*;
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
    import status.*;
    import tradingPost.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class BarracksMain extends Object
    {
        private var _phase:int;
        private var _parent:DisplayObjectContainer;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _isoHeader:InStayOut;
        private var _isoPlayerList:InStayOut;
        private var _btnClose:ButtonBase;
        private var _btnBuyBed:ButtonBase;
        private var _playerList:BarracksPlayerList;
        private var _simpleStatus:PlayerSimpleStatus;
        private var _restFinishedPopup:BarracksRestFinishedPopup;
        private var _aBed:Array;
        private var _aWakeupBed:Array;
        private var _aPlayerPersonal:Array;
        private var _aBarracksData:Array;
        private var _facilityInfo:InstitutionInfo;
        private var _timeCount:Number;
        private var _bBarracksInfoLoaded:Boolean;
        private var _bBedSelectSw:Boolean;
        private var _bBusy:Boolean;
        private var _upgradeDisabled:FacilityUpgradeDisabled;
        private var _provisionCheck:ProvisionChecker;
        private var _healingBox:BarracksHealingBox;
        private var _tutorialHealingNum:int;
        private var _bJumpTradingPost:Boolean;
        private static const _SIMPLE_STATUS_DISPLAY_POSITION_X:int = 773;
        private static const _SIMPLE_STATUS_DISPLAY_POSITION_Y_MIN:int = 220;
        private static const _SIMPLE_STATUS_DISPLAY_POSITION_Y_MAX:int = 340;
        private static const _PHASE_LOADING:int = 0;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_MAIN:int = 2;
        private static const _PHASE_PROVISION_DISP:int = 3;
        private static const _PHASE_CLOSE:int = 4;
        private static const _PHASE_MAINTENANCE:int = 90;

        public function BarracksMain(param1:DisplayObjectContainer)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._parent = param1;
            Main.GetProcess().topBar.cbConfigWindow(this.cbConfigWindowOpen, this.cbConfigWindowClose);
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.FACILITY_PATH + "UI_Barracks.swf");
            BarracksPlayerList.loadResource();
            FacilityUpgrade.loadResource();
            ResourceManager.getInstance().loadResource(ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_INSTANT_HEALING));
            ResourceManager.getInstance().loadResource(AssetListManager.getInstance().getAssetPng(AssetId.ASSET_FREE_HEALING));
            CommonPopup.getInstance().loadResource();
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_3) || TutorialManager.getInstance().isFacilityUpgradeGuide())
            {
                TutorialManager.getInstance().loadResource();
            }
            SoundManager.getInstance().loadSound(SoundId.BGM_INS_RESTROOM);
            SoundManager.getInstance().loadSoundArray([SoundId.SE_POPUP, SoundId.SE_CANCEL, SoundId.SE_COMPOSE_SUCSESS, SoundId.SE_REV_INN_SPIN]);
            var _loc_2:* = UserDataManager.getInstance().userData;
            this._aPlayerPersonal = [];
            for each (_loc_3 in _loc_2.aPlayerPersonal)
            {
                
                this._aPlayerPersonal.push(_loc_3);
                _loc_4 = PlayerManager.getInstance().getPlayerInformation(_loc_3.playerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_4.swf);
            }
            this._facilityInfo = _loc_2.getInstitutionInfo(CommonConstant.FACILITY_ID_BARRACKS);
            this._aBarracksData = _loc_2.aBarracksData;
            this._aBed = [];
            this._aWakeupBed = [];
            this._bBedSelectSw = false;
            this._bJumpTradingPost = false;
            this._bBusy = false;
            this._restFinishedPopup = null;
            this._bBarracksInfoLoaded = true;
            this.setPhase(_PHASE_LOADING);
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain && this._isoMain.bClosed && (this._isoHeader && this._isoHeader.bClosed) && (this._isoPlayerList && this._isoPlayerList.bClosed);
        }// end function

        public function get bStay() : Boolean
        {
            return this._phase != _PHASE_OPEN && this._phase != _PHASE_CLOSE && this._bBusy == false && (this._isoMain && this._isoMain.bAnimetion == false) && (this._isoHeader && this._isoHeader.bAnimetion == false) && (this._isoPlayerList && this._isoPlayerList.bAnimetion == false);
        }// end function

        public function get bJumpTradingPost() : Boolean
        {
            return this._bJumpTradingPost;
        }// end function

        private function cbConnectBarracksInfo(param1:NetResult) : void
        {
            this._bBarracksInfoLoaded = true;
            return;
        }// end function

        private function resourceLoaded() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this._bBarracksInfoLoaded)
            {
                return;
            }
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_Barracks.swf", "BarracksMainMc");
            this._parent.addChild(this._mcBase);
            this._healingBox = new BarracksHealingBox(this._mcBase.barracksListMc.ItemIconBox);
            this._tutorialHealingNum = 0;
            this._btnClose = ButtonManager.getInstance().addButton(this._mcBase.barracksListMc.returnBtnMc, this.cbCloseButton);
            this._btnClose.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcBase.barracksListMc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._btnBuyBed = null;
            if (this._mcBase.barracksTitleMc.gradeUpBtnMc)
            {
                if (UserDataManager.getInstance().checkBedExtendable())
                {
                    this._btnBuyBed = ButtonManager.getInstance().addButton(this._mcBase.barracksTitleMc.gradeUpBtnMc, this.cbBuyBedButton);
                    this._btnBuyBed.enterSeId = ButtonBase.SE_DECIDE_ID;
                    TextControl.setIdText(this._mcBase.barracksTitleMc.gradeUpBtnMc.textMc.textDt, MessageId.BARRACKS_BUTTON_INCRESE_BED);
                    this._mcBase.barracksTitleMc.gradeUpBtnMc.visible = true;
                }
                else
                {
                    this._mcBase.barracksTitleMc.gradeUpBtnMc.visible = false;
                }
            }
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.BARRACKS_HELP_TEXT01));
            this._mcBase.barracksMainMc.barracksMc.gotoAndStop("lv" + getBedCount());
            if (this._mcBase.barracksMainMc.barracksMc.remainingFlameMc1 != null)
            {
                this._aBed.push(new BarracksBed(this._mcBase.barracksMainMc.barracksMc.remainingFlameMc1, 0, this.cbBedOverFunc, this.cbBedOutFunc, this.cbBedInstantRestoreFunc));
            }
            if (this._mcBase.barracksMainMc.barracksMc.remainingFlameMc2 != null)
            {
                this._aBed.push(new BarracksBed(this._mcBase.barracksMainMc.barracksMc.remainingFlameMc2, 1, this.cbBedOverFunc, this.cbBedOutFunc, this.cbBedInstantRestoreFunc));
            }
            if (this._mcBase.barracksMainMc.barracksMc.remainingFlameMc3 != null)
            {
                this._aBed.push(new BarracksBed(this._mcBase.barracksMainMc.barracksMc.remainingFlameMc3, 2, this.cbBedOverFunc, this.cbBedOutFunc, this.cbBedInstantRestoreFunc));
            }
            if (this._mcBase.barracksMainMc.barracksMc.remainingFlameMc4 != null)
            {
                this._aBed.push(new BarracksBed(this._mcBase.barracksMainMc.barracksMc.remainingFlameMc4, 3, this.cbBedOverFunc, this.cbBedOutFunc, this.cbBedInstantRestoreFunc));
            }
            if (this._mcBase.barracksMainMc.barracksMc.remainingFlameMc5 != null)
            {
                this._aBed.push(new BarracksBed(this._mcBase.barracksMainMc.barracksMc.remainingFlameMc5, 4, this.cbBedOverFunc, this.cbBedOutFunc, this.cbBedInstantRestoreFunc));
            }
            if (this._mcBase.barracksTitleMc.taitleGradeRankMc)
            {
                this._mcBase.barracksTitleMc.taitleGradeRankMc.visible = false;
            }
            this.updateBed(true);
            var _loc_1:* = [];
            for each (_loc_2 in this._aPlayerPersonal)
            {
                
                if (_loc_2.isUseFacility() || _loc_2.hp >= _loc_2.hpMax)
                {
                    _loc_1.push(_loc_2.uniqueId);
                }
            }
            _loc_3 = [];
            for each (_loc_4 in this._aPlayerPersonal)
            {
                
                _loc_3.push(new ListPlayerData(_loc_4));
            }
            this._playerList = new BarracksPlayerList(this._mcBase.barracksListMc.reserveListMc, _loc_3);
            this._playerList.setNotDisplayPlayer(_loc_1);
            this._playerList.setPlayerSelectCallback(this.cbPlayerSelectFunc);
            this._playerList.setCaptionText(MessageManager.getInstance().getMessage(MessageId.BARRACKS_SOLDIER_LIST_CAPTION));
            this._playerList.updateList();
            this._simpleStatus = new PlayerSimpleStatus(this._mcBase);
            this._simpleStatus.hide();
            this._isoMain = new InStayOut(this._mcBase.barracksMainMc);
            this._isoHeader = new InStayOut(this._mcBase.barracksTitleMc);
            this._isoPlayerList = new InStayOut(this._mcBase.barracksListMc);
            if (SoundManager.getInstance().bgmId != SoundId.BGM_INS_RESTROOM)
            {
                SoundManager.getInstance().playBgm(SoundId.BGM_INS_RESTROOM);
            }
            this._timeCount = 0;
            this._upgradeDisabled = new FacilityUpgradeDisabled(this._mcBase);
            this._provisionCheck = new ProvisionChecker(ProvisionChecker.CHECK_TARGET_TIME_FREE_HEALING);
            this._playerList.setInformationBarMessage(MessageManager.getInstance().getMessage(MessageId.BARRACKS_PLAYER_LIST_INFORMATION));
            BarracksAutoRestManager.getInstance().clearCheck();
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            if (this._btnBuyBed)
            {
                ButtonManager.getInstance().removeButton(this._btnBuyBed);
            }
            this._btnBuyBed = null;
            ButtonManager.getInstance().removeButton(this._btnClose);
            this._btnClose = null;
            if (this._healingBox)
            {
                this._healingBox.release();
            }
            this._healingBox = null;
            if (this._restFinishedPopup)
            {
                this._restFinishedPopup.release();
            }
            this._restFinishedPopup = null;
            if (this._playerList)
            {
                this._playerList.release();
            }
            this._playerList = null;
            if (this._simpleStatus)
            {
                this._simpleStatus.release();
            }
            this._simpleStatus = null;
            for each (_loc_1 in this._aBed)
            {
                
                _loc_1.release();
            }
            this._aBed = null;
            this._aWakeupBed = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._isoHeader)
            {
                this._isoHeader.release();
            }
            this._isoHeader = null;
            if (this._isoPlayerList)
            {
                this._isoPlayerList.release();
            }
            this._isoPlayerList = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            this._upgradeDisabled.release();
            if (this._provisionCheck)
            {
                this._provisionCheck.release();
            }
            this._provisionCheck = null;
            TutorialManager.getInstance().release();
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
                case _PHASE_PROVISION_DISP:
                {
                    this.initPhaseProvisionDisp();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.initPhaseClose();
                    break;
                }
                case _PHASE_MAINTENANCE:
                {
                    this.initPhaseMaintenance();
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
            var _loc_2:* = null;
            var _loc_3:* = 0;
            this._timeCount = this._timeCount + param1;
            if (this._timeCount >= 1)
            {
                _loc_3 = Math.floor(this._timeCount);
                this._timeCount = this._timeCount - _loc_3;
                for each (_loc_2 in this._aBed)
                {
                    
                    if (_loc_2.isUse())
                    {
                        _loc_2.countTime(_loc_3);
                        if (_loc_2.uniqueId == this._simpleStatus.uniqueId)
                        {
                            this._simpleStatus.updateHp();
                        }
                    }
                }
            }
            for each (_loc_2 in this._aBed)
            {
                
                _loc_2.control(param1);
            }
            if (this._upgradeDisabled)
            {
                this._upgradeDisabled.countControl(param1);
            }
            switch(this._phase)
            {
                case _PHASE_LOADING:
                {
                    this.resourceLoaded();
                    break;
                }
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
                case _PHASE_PROVISION_DISP:
                {
                    this.controlPhaseProvisionDisp();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                case _PHASE_MAINTENANCE:
                {
                    this.controlPhaseMaintenance();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function initPhaseOpen() : void
        {
            this.setBusy(true);
            if (!this._isoHeader.bOpened)
            {
                this._isoHeader.setIn();
            }
            this._isoMain.setIn();
            this._isoPlayerList.setIn();
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoMain.bOpened && this._isoHeader.bOpened && this._isoPlayerList.bOpened)
            {
                this.setPhase(_PHASE_MAINTENANCE);
            }
            return;
        }// end function

        private function initPhaseMain() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = false;
            for each (_loc_2 in this._aBed)
            {
                
                if (_loc_2.isUse() && _loc_2.isFinished())
                {
                    _loc_1 = true;
                    break;
                }
            }
            if (!_loc_1)
            {
                this.setBusy(false);
                this.facilityTutorialCheck();
            }
            if (this._upgradeDisabled.facilityUpgrade(CommonConstant.FACILITY_ID_BARRACKS))
            {
                this._playerList.setSelectEnable(false);
                this._playerList.overlayVisible(true);
                this.setGuideText(MessageManager.getInstance().getMessage(MessageId.FACILITY_UPGRADENOW_GUIDE_MESSAGE));
            }
            else
            {
                this._playerList.checkEmptyInformation();
            }
            return;
        }// end function

        private function controlMain(param1:Number) : void
        {
            var bed:BarracksBed;
            var t:* = param1;
            if (CommonPopup.isUse() || Main.GetProcess().topBar.bConfigWindowOpend)
            {
                return;
            }
            if (!this._bBusy && !TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_3) && this._provisionCheck.check())
            {
                this.setPhase(_PHASE_PROVISION_DISP);
                return;
            }
            if (this._aWakeupBed.length == 0)
            {
                var _loc_3:* = 0;
                var _loc_4:* = this._aBed;
                while (_loc_4 in _loc_3)
                {
                    
                    bed = _loc_4[_loc_3];
                    if (bed.isUse() && bed.isFinished())
                    {
                        this._aWakeupBed.push(bed);
                        if (bed.uniqueId == this._simpleStatus.uniqueId)
                        {
                            this._simpleStatus.hide();
                        }
                    }
                }
                if (this._aWakeupBed.length > 0)
                {
                    this.setBusy(true);
                    this.requestRestEnd();
                }
            }
            if (this._aWakeupBed.length > 0 && this._aWakeupBed.every(function (param1:BarracksBed, param2:int, param3:Array) : Boolean
            {
                return param1.isWakeupEnd();
            }// end function
            ))
            {
                if (this._restFinishedPopup == null)
                {
                    this._restFinishedPopup = new BarracksRestFinishedPopup(this._parent, function () : void
            {
                return;
            }// end function
            );
                }
                if (this._restFinishedPopup.bClose)
                {
                    this._restFinishedPopup.release();
                    this._restFinishedPopup = null;
                    this._aWakeupBed = [];
                    this.updateBed(false);
                    this._playerList.updateList();
                    this.setBusy(false);
                    this.facilityTutorialCheck(true);
                }
            }
            return;
        }// end function

        private function initPhaseProvisionDisp() : void
        {
            this.setBusy(true);
            this._provisionCheck.popup(function () : void
            {
                setBusy(false);
                _healingBox.updateNum();
                setPhase(_PHASE_MAIN);
                return;
            }// end function
            );
            return;
        }// end function

        private function controlPhaseProvisionDisp() : void
        {
            return;
        }// end function

        private function initPhaseClose() : void
        {
            Main.GetProcess().topBar.cbConfigWindow(null, null);
            this._upgradeDisabled.close();
            this.setBusy(true);
            this._isoMain.setOut();
            this._isoHeader.setOut();
            this._isoPlayerList.setOut();
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function initPhaseMaintenance() : void
        {
            if (Main.GetApplicationData().maintenanceData.isMaintenanceTime())
            {
                Main.GetProcess().createMaintenanceWindow();
            }
            else
            {
                this.setPhase(_PHASE_MAIN);
            }
            return;
        }// end function

        private function controlPhaseMaintenance() : void
        {
            if (Main.GetProcess().maintenance == null)
            {
                this.setPhase(_PHASE_MAIN);
            }
            return;
        }// end function

        private function getPlayerPersonal(param1:int) : PlayerPersonal
        {
            var _loc_2:* = null;
            if (param1 == Constant.EMPTY_ID)
            {
                return null;
            }
            for each (_loc_2 in this._aPlayerPersonal)
            {
                
                if (_loc_2.uniqueId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        private function setBusy(param1:Boolean) : void
        {
            this._bBusy = param1;
            this.bedEnable(!param1);
            this._btnClose.setDisable(param1);
            if (this._btnBuyBed)
            {
                this._btnBuyBed.setDisable(param1);
            }
            this._playerList.setSelectEnable(!param1);
            this._healingBox.setMouseOverEnable(!param1);
            if (this._simpleStatus && this._simpleStatus.isShow())
            {
                this._simpleStatus.hide();
            }
            return;
        }// end function

        private function setGuideText(param1:String) : void
        {
            TextControl.setText(this._mcBase.barracksMainMc.captionMc.textMc.textDt, param1);
            var _loc_2:* = param1.split("\n");
            this._mcBase.barracksMainMc.captionMc.gotoAndStop("linage" + (_loc_2.length > 1 ? ("2") : ("1")));
            return;
        }// end function

        private function updateBed(param1:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_2:* = TimeClock.getNowTime();
            var _loc_3:* = 0;
            for each (_loc_4 in this._aBed)
            {
                
                for each (_loc_5 in this._aBarracksData)
                {
                    
                    if (_loc_5.index == _loc_3 && _loc_4.uniqueId != _loc_5.uniqueId)
                    {
                        _loc_6 = this.getPlayerPersonal(_loc_5.uniqueId);
                        if (_loc_6)
                        {
                            _loc_7 = PlayerPersonal.getRestoreTimeSec(_loc_6.restoreStartHp, _loc_6);
                            _loc_4.restStart(_loc_6, _loc_2, _loc_7, param1);
                        }
                    }
                }
                if (_loc_4.isWakeupEnd())
                {
                    _loc_4.restEnd();
                }
                _loc_3++;
            }
            return;
        }// end function

        private function bedEnable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBed)
            {
                
                _loc_2.setDisable(!param1);
            }
            return;
        }// end function

        private function requestRestEnd() : void
        {
            var restFunc:Function;
            if (this._aWakeupBed.length > 0)
            {
                restFunc = function (param1:BarracksBed, param2:int = 0) : void
            {
                var bed:* = param1;
                var count:* = param2;
                NetManager.getInstance().request(new NetTaskBarracksRestEnd(false, false, bed.index, function (param1:NetResult) : void
                {
                    var _loc_2:* = undefined;
                    cbConnectRestEnd(param1);
                    var _loc_4:* = count + 1;
                    count = _loc_4;
                    if (count >= _aWakeupBed.length)
                    {
                        for each (_loc_2 in _aWakeupBed)
                        {
                            
                            _loc_2.wakeup();
                        }
                    }
                    else
                    {
                        restFunc(_aWakeupBed[count], count);
                    }
                    return;
                }// end function
                ));
                return;
            }// end function
            ;
                this.restFunc(this._aWakeupBed[0]);
            }
            return;
        }// end function

        private function facilityTutorialCheck(param1:Boolean = false) : void
        {
            var usingBed:BarracksBed;
            var bed:BarracksBed;
            var bRestEnd:* = param1;
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_1))
            {
                this.setBusy(true);
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_1, function () : void
            {
                setBusy(false);
                return;
            }// end function
            );
            }
            else if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_2))
            {
                usingBed;
                var _loc_3:* = 0;
                var _loc_4:* = this._aBed;
                while (_loc_4 in _loc_3)
                {
                    
                    bed = _loc_4[_loc_3];
                    if (bed.isUse())
                    {
                        usingBed = bed;
                        break;
                    }
                }
                if (usingBed)
                {
                    this.setBusy(true);
                    TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_2, function () : void
            {
                var _loc_2:* = null;
                var _loc_1:* = [];
                _loc_1.push(usingBed.instantRestoreBtn);
                for each (_loc_2 in _aBed)
                {
                    
                    _loc_1.push(_loc_2.bedBtn);
                }
                TutorialManager.getInstance().setTutorialArrow((_loc_1[0] as ButtonBase).getMoveClip());
                ButtonManager.getInstance().seal(_loc_1, true);
                _playerList.setTutorialSelectEnable(false);
                _tutorialHealingNum = 1;
                _healingBox.setMode(BarracksHealingBox.SETUP_ICON_FREE, UserDataManager.getInstance().userData.freeHealingNum + _tutorialHealingNum);
                setBusy(false);
                return;
            }// end function
            );
                }
            }
            else if (bRestEnd && TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_3))
            {
                this.setBusy(true);
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_3, function () : void
            {
                ButtonManager.getInstance().unseal();
                _playerList.setTutorialSelectEnable(true);
                setBusy(false);
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function cbCloseButton(param1:int) : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbBuyBedButton(param1:int) : void
        {
            this._bJumpTradingPost = true;
            TradingPostStartPageRequest.getInstance().setRequestBedIncrease();
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbBedOverFunc(param1:BarracksBed) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1.isUse())
            {
                _loc_2 = this.getPlayerPersonal(param1.uniqueId);
                if (_loc_2)
                {
                    this._simpleStatus.setLabel(PlayerSimpleStatus.LABEL_MAIN);
                    this._simpleStatus.setStatus(_loc_2);
                    _loc_3 = param1.getPlayerNullPosition();
                    _loc_4 = _loc_3.clone();
                    _loc_3.x = _SIMPLE_STATUS_DISPLAY_POSITION_X;
                    _loc_3.y = Math.min(Math.max(_loc_3.y, _SIMPLE_STATUS_DISPLAY_POSITION_Y_MIN), _SIMPLE_STATUS_DISPLAY_POSITION_Y_MAX);
                    this._simpleStatus.setPosition(_loc_3);
                    this._simpleStatus.setArrowTargetPosition(_loc_4);
                    this._simpleStatus.show();
                }
            }
            return;
        }// end function

        private function cbBedOutFunc(param1:BarracksBed) : void
        {
            if (param1.isUse() && param1.uniqueId == this._simpleStatus.uniqueId)
            {
                this._simpleStatus.hide();
            }
            return;
        }// end function

        private function cbPlayerSelectFunc(param1:int, param2:ListPlayerData) : void
        {
            var bed:BarracksBed;
            var personal:PlayerPersonal;
            var listIndex:* = param1;
            var listPlayerData:* = param2;
            var emptyBed:BarracksBed;
            var _loc_4:* = 0;
            var _loc_5:* = this._aBed;
            while (_loc_5 in _loc_4)
            {
                
                bed = _loc_5[_loc_4];
                if (bed.isEmpty())
                {
                    emptyBed = bed;
                    break;
                }
            }
            if (emptyBed == null)
            {
                this._playerList.setBedPopup(true);
                this.setBusy(true);
                if (UserDataManager.getInstance().checkBedExtendable())
                {
                    CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.BARRACKS_POPUP_MESSAGE_BED_FULL02), function (param1:Boolean) : void
            {
                _playerList.setBedPopup(false);
                _playerList.resetSelect();
                setBusy(false);
                if (param1)
                {
                    _bJumpTradingPost = true;
                    TradingPostStartPageRequest.getInstance().setRequestBedIncrease();
                    setPhase(_PHASE_CLOSE);
                }
                return;
            }// end function
            , MessageManager.getInstance().getMessage(MessageId.RETIREMENT_GET_INSIGNIA_POPUP_BUTTON), MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CLOSE));
                }
                else
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.BARRACKS_POPUP_MESSAGE_BED_FULL01), function () : void
            {
                _playerList.setBedPopup(false);
                _playerList.resetSelect();
                setBusy(false);
                return;
            }// end function
            );
                }
                return;
            }
            this._playerList.setBedPopup(true);
            this.setBusy(true);
            var pInfo:* = listPlayerData.info;
            personal = listPlayerData.personal;
            var timeSec:* = PlayerPersonal.getRestoreTimeSec(personal.hp, personal, pInfo);
            var sec:* = timeSec % 60;
            var min:* = timeSec / 60 % 60;
            var hour:* = timeSec / 60 / 60;
            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NAVI, TextControl.formatIdText(MessageId.BARRACKS_POPUP_MESSAGE_RECOVER_CONFIRM, pInfo.name, hour < 10 ? ("0" + hour.toString()) : (hour), min < 10 ? ("0" + min.toString()) : (min), sec < 10 ? ("0" + sec.toString()) : (sec)), function (param1:Boolean) : void
            {
                if (param1)
                {
                    NetManager.getInstance().request(new NetTaskBarracksRest(personal.uniqueId, bed.index, cbConnectRest));
                }
                else
                {
                    _playerList.setBedPopup(false);
                    _playerList.resetSelect();
                    setBusy(false);
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function cbConnectRest(param1:NetResult) : void
        {
            var _loc_2:* = 0;
            var _loc_7:* = null;
            var _loc_3:* = UserDataManager.getInstance().userData;
            var _loc_4:* = new PlayerPersonal();
            new PlayerPersonal().setParameter(param1.data.playerPersonal);
            _loc_4.setUseFacility(CommonConstant.FACILITY_ID_BARRACKS, 0, _loc_4.restoreEndTime);
            var _loc_5:* = _loc_3.aPlayerPersonal;
            _loc_2 = 0;
            while (_loc_2 < _loc_5.length)
            {
                
                if (_loc_5[_loc_2].uniqueId == _loc_4.uniqueId)
                {
                    _loc_5[_loc_2] = _loc_4.clone();
                    break;
                }
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this._aPlayerPersonal.length)
            {
                
                if (this._aPlayerPersonal[_loc_2].uniqueId == _loc_4.uniqueId)
                {
                    this._aPlayerPersonal[_loc_2] = _loc_4;
                    break;
                }
                _loc_2++;
            }
            _loc_3.setOwnPlayer(_loc_5);
            var _loc_6:* = new ListPlayerData(_loc_4);
            this._playerList.removePlayer(_loc_4.uniqueId);
            this._playerList.addPlayer(_loc_6);
            this._playerList.addNotDisplayPlayer(_loc_4.uniqueId);
            for each (_loc_7 in this._aBarracksData)
            {
                
                if (_loc_7.index == param1.data.index)
                {
                    _loc_7.setData(param1.data.barracksData.uniqueId, param1.data.barracksData.restoreTime, param1.data.institutionNotice.uniqueId);
                }
                _loc_3.resetBarracksData(_loc_7.index, _loc_7.uniqueId, _loc_7.restoreTime, _loc_7.noticeId);
            }
            this.updateBed(false);
            this._playerList.updateList();
            this._playerList.setBedPopup(false);
            this._playerList.checkEmptyInformation();
            NoticeManager.getInstance().addMiniNoticeByObject(param1.data.institutionNotice);
            this.setBusy(false);
            this._playerList.resetSelect();
            this.facilityTutorialCheck();
            return;
        }// end function

        private function cbConnectRestEnd(param1:NetResult) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_2:* = null;
            for each (_loc_3 in this._aWakeupBed)
            {
                
                if (_loc_3.index == param1.data.index)
                {
                    _loc_2 = _loc_3;
                    break;
                }
            }
            _loc_5 = UserDataManager.getInstance().userData;
            _loc_6 = new PlayerPersonal();
            _loc_6.setParameter(param1.data.playerPersonal);
            _loc_7 = _loc_5.aPlayerPersonal;
            _loc_4 = 0;
            while (_loc_4 < _loc_7.length)
            {
                
                if (_loc_7[_loc_4].uniqueId == _loc_6.uniqueId)
                {
                    (_loc_7[_loc_4] as PlayerPersonal).copyParam(_loc_6);
                    break;
                }
                _loc_4++;
            }
            _loc_5.setOwnPlayer(_loc_7);
            _loc_4 = 0;
            while (_loc_4 < this._aPlayerPersonal.length)
            {
                
                if (this._aPlayerPersonal[_loc_4].uniqueId == _loc_6.uniqueId)
                {
                    (this._aPlayerPersonal[_loc_4] as PlayerPersonal).copyParam(_loc_6);
                    break;
                }
                _loc_4++;
            }
            for each (_loc_8 in this._aBarracksData)
            {
                
                if (_loc_8.uniqueId == _loc_2.uniqueId)
                {
                    _loc_8.setData(Constant.EMPTY_ID, 0, Constant.EMPTY_ID);
                }
                _loc_5.resetBarracksData(_loc_8.index, _loc_8.uniqueId, _loc_8.restoreTime, _loc_8.noticeId);
            }
            NoticeManager.getInstance().crearSimpleNoticeById(param1.data.institutionNoticeId);
            return;
        }// end function

        private function cbBedInstantRestoreFunc(param1:BarracksBed) : void
        {
            var bed:* = param1;
            this.setBusy(true);
            var instantRestoreItemNum:* = UserDataManager.getInstance().userData.getOwnPaymentItemNum(PaymentItemId.ITEM_INSTANT_HEALING);
            var freeHealingNum:* = UserDataManager.getInstance().userData.freeHealingNum + this._tutorialHealingNum;
            var bFreeEnable:* = this._healingBox.setupedMode == BarracksHealingBox.SETUP_ICON_FREE;
            var useHealingPopup:* = new BarracksUseHealingPopup(instantRestoreItemNum, freeHealingNum, bFreeEnable, function (param1:int) : void
            {
                var popupResult:* = param1;
                switch(popupResult)
                {
                    case BarracksUseHealingPopup.POPUP_RESULT_CLOSE:
                    default:
                    {
                        setBusy(false);
                        break;
                    }
                    case BarracksUseHealingPopup.POPUP_RESULT_USE_FREE_HEALING:
                    {
                        _bJumpTradingPost = true;
                        TradingPostStartPageRequest.getInstance().setRequestInstantHealing();
                        setPhase(_PHASE_CLOSE);
                        break;
                    }
                    case BarracksUseHealingPopup.POPUP_RESULT_USE_INSTANT_HEALING:
                    {
                        if (bed.isInstantEnable() == false)
                        {
                            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.BARRACKS_POPUP_MESSAGE_RECOVER_NOT_NEEDED), function () : void
                {
                    setBusy(false);
                    return;
                }// end function
                );
                            return;
                        }
                        _aWakeupBed.push(bed);
                        NetManager.getInstance().request(new NetTaskBarracksRestEnd(true, _tutorialHealingNum == 0, bed.index, cbConnectInstantRestore));
                        _tutorialHealingNum = 0;
                        break;
                    }
                    case :
                    {
                        if (bed.isInstantEnable() == false)
                        {
                            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.BARRACKS_POPUP_MESSAGE_RECOVER_NOT_NEEDED), function () : void
                {
                    setBusy(false);
                    return;
                }// end function
                );
                            return;
                        }
                        _aWakeupBed.push(bed);
                        NetManager.getInstance().request(new NetTaskBarracksRestEnd(true, false, bed.index, cbConnectInstantRestore));
                        break;
                        break;
                    }
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function cbConnectInstantRestore(param1:NetResult) : void
        {
            var wakeupBed:BarracksBed;
            var i:int;
            var userData:UserDataPersonal;
            var newPersonal:PlayerPersonal;
            var aPlayerPersonal:Array;
            var barracksData:BarracksData;
            var res:* = param1;
            if (res.resultCode != NetId.RESULT_OK)
            {
                this._aWakeupBed = [];
                return;
            }
            if (res.data.alreadyRest == 1)
            {
                this._aWakeupBed = [];
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.BARRACKS_POPUP_MESSAGE_RECOVER_NOT_NEEDED), function () : void
            {
                setBusy(false);
                return;
            }// end function
            );
                return;
            }
            var bed:BarracksBed;
            var _loc_3:* = 0;
            var _loc_4:* = this._aWakeupBed;
            while (_loc_4 in _loc_3)
            {
                
                wakeupBed = _loc_4[_loc_3];
                if (wakeupBed.index == res.data.index)
                {
                    bed = wakeupBed;
                    break;
                }
            }
            userData = UserDataManager.getInstance().userData;
            newPersonal = new PlayerPersonal();
            newPersonal.setParameter(res.data.playerPersonal);
            userData.setOwnPaymentItem(res.data.aOwnPaymentItemData);
            this._healingBox.setMode(BarracksHealingBox.SETUP_ICON_AUTO);
            aPlayerPersonal = userData.aPlayerPersonal;
            i;
            while (i < aPlayerPersonal.length)
            {
                
                if (aPlayerPersonal[i].uniqueId == newPersonal.uniqueId)
                {
                    (aPlayerPersonal[i] as PlayerPersonal).copyParam(newPersonal);
                    break;
                }
                i = (i + 1);
            }
            userData.setOwnPlayer(aPlayerPersonal);
            i;
            while (i < this._aPlayerPersonal.length)
            {
                
                if (this._aPlayerPersonal[i].uniqueId == newPersonal.uniqueId)
                {
                    (this._aPlayerPersonal[i] as PlayerPersonal).copyParam(newPersonal);
                    break;
                }
                i = (i + 1);
            }
            var _loc_3:* = 0;
            var _loc_4:* = this._aBarracksData;
            while (_loc_4 in _loc_3)
            {
                
                barracksData = _loc_4[_loc_3];
                if (barracksData.uniqueId == bed.uniqueId)
                {
                    barracksData.setData(Constant.EMPTY_ID, 0, Constant.EMPTY_ID);
                }
                userData.resetBarracksData(barracksData.index, barracksData.uniqueId, barracksData.restoreTime, barracksData.noticeId);
            }
            NoticeManager.getInstance().crearSimpleNoticeById(res.data.institutionNoticeId);
            bed.wakeup();
            return;
        }// end function

        private function cbFacilityIntesification(param1:Array) : void
        {
            var _loc_2:* = 0;
            _loc_2 = 0;
            while (_loc_2 < this._aPlayerPersonal.length)
            {
                
                if (param1.indexOf(this._aPlayerPersonal[_loc_2].uniqueId) != -1)
                {
                    this._aPlayerPersonal.splice(_loc_2, 1);
                    _loc_2 = _loc_2 - 1;
                    ;
                }
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < param1.length)
            {
                
                this._playerList.removePlayer(param1[_loc_2]);
                _loc_2++;
            }
            this._playerList.updateList();
            return;
        }// end function

        private function cbFacilityGradeUp() : void
        {
            var _loc_1:* = UserDataManager.getInstance().userData;
            this._facilityInfo = _loc_1.getInstitutionInfo(CommonConstant.FACILITY_ID_BARRACKS);
            this._mcBase.barracksMainMc.barracksMc.gotoAndStop("lv" + getBedCount());
            if (this._aBed.length < 1 && this._mcBase.barracksMainMc.barracksMc.remainingFlameMc1 != null)
            {
                this._aBed.push(new BarracksBed(this._mcBase.barracksMainMc.barracksMc.remainingFlameMc1, 0, this.cbBedOverFunc, this.cbBedOutFunc, this.cbBedInstantRestoreFunc));
            }
            if (this._aBed.length < 2 && this._mcBase.barracksMainMc.barracksMc.remainingFlameMc2 != null)
            {
                this._aBed.push(new BarracksBed(this._mcBase.barracksMainMc.barracksMc.remainingFlameMc2, 1, this.cbBedOverFunc, this.cbBedOutFunc, this.cbBedInstantRestoreFunc));
            }
            if (this._aBed.length < 3 && this._mcBase.barracksMainMc.barracksMc.remainingFlameMc3 != null)
            {
                this._aBed.push(new BarracksBed(this._mcBase.barracksMainMc.barracksMc.remainingFlameMc3, 2, this.cbBedOverFunc, this.cbBedOutFunc, this.cbBedInstantRestoreFunc));
            }
            if (this._aBed.length < 4 && this._mcBase.barracksMainMc.barracksMc.remainingFlameMc4 != null)
            {
                this._aBed.push(new BarracksBed(this._mcBase.barracksMainMc.barracksMc.remainingFlameMc4, 3, this.cbBedOverFunc, this.cbBedOutFunc, this.cbBedInstantRestoreFunc));
            }
            if (this._aBed.length < 5 && this._mcBase.barracksMainMc.barracksMc.remainingFlameMc5 != null)
            {
                this._aBed.push(new BarracksBed(this._mcBase.barracksMainMc.barracksMc.remainingFlameMc5, 4, this.cbBedOverFunc, this.cbBedOutFunc, this.cbBedInstantRestoreFunc));
            }
            return;
        }// end function

        private function cbFacilityUpgradeClose() : void
        {
            this.setPhase(_PHASE_OPEN);
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

        private static function getBedCount() : int
        {
            return UserDataManager.getInstance().getCurrentBedNum();
        }// end function

    }
}
