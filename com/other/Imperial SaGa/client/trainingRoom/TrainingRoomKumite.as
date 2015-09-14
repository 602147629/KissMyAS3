package trainingRoom
{
    import asset.*;
    import button.*;
    import effect.*;
    import facility.*;
    import flash.display.*;
    import icon.*;
    import item.*;
    import layer.*;
    import message.*;
    import network.*;
    import notice.*;
    import player.*;
    import playerList.*;
    import popup.*;
    import resource.*;
    import skill.*;
    import status.*;
    import tradingPost.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class TrainingRoomKumite extends Object
    {
        private var _phase:int;
        private var _prevPhase:int;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _isoPlayerList:InStayOut;
        private var _isoKumitePlayerList:InStayOut;
        private var _isoInstantBtn:InStayOut;
        private var _btnReturn:ButtonBase;
        private var _instantBtn:InstantButton;
        private var _layer:LayerTrainingRoom;
        private var _effectManager:EffectManager;
        private var _cbClose:Function;
        private var _playerList:TrainingRoomPlayerList;
        private var _kumitePlayerList:KumitePlayerList;
        private var _gotTime:uint;
        private var _waitTime:Number;
        private var _traineePlayer:PlayerDisplay;
        private var _kumitePlayer:PlayerDisplay;
        private var _kumitePlayerData:TrainingRoomKumitePlayerData;
        private var _trainingInfoWindow:TrainingRoomTopInfo;
        private var _userResourceBox:UserResourceBox;
        private var _menu:TrainingRoomKumiteMenu;
        private var _selecter:TrainingRoomSelecter;
        private var _startMessage:TrainingRoomStartSuccessMessage;
        private var _endMessage:TrainingRoomStartSuccessMessage;
        private var _kumiteAction:TrainingRoomKumiteAction;
        private var _aPlayerPersonal:Array;
        private var _aKumitePlayer:Array;
        private var _bNowTraining:Boolean;
        private var _traineePersonal:PlayerPersonal;
        private var _traineeEndPersonal:PlayerPersonal;
        private var _bKumiteEndGreatSuccess:Boolean;
        private var _bUseInstant:Boolean;
        private var _engagedKumiteData:EngagedKumiteData;
        private var _bKumiteActionWait:Boolean;
        private var _bJumpTradingPost:Boolean;
        private var _upgradeDisabled:FacilityUpgradeDisabled;
        private static const _PHASE_OPEN_WAIT:int = 0;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_TRAINEE_SELECT:int = 2;
        private static const _PHASE_SKILL_SELECT:int = 3;
        private static const _PHASE_NEXT_WAIT:int = 4;
        private static const _PHASE_KUMITE_PLAYER_SELECT:int = 5;
        private static const _PHASE_KUMITE_NOW:int = 6;
        private static const _PHASE_KUMITE_END:int = 7;
        private static const _PHASE_CONNECTING:int = 8;
        private static const _PHASE_POPUP:int = 9;
        private static const _PHASE_CLOSE:int = 10;
        private static const _PHASE_CLOWN_UPDATE:int = 9001;

        public function TrainingRoomKumite(param1:LayerTrainingRoom, param2:MovieClip, param3:Array, param4:Array, param5:uint, param6:EngagedKumiteData, param7:Function)
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            Main.GetProcess().topBar.cbConfigWindow(this.cbConfigWindowOpen, this.cbConfigWindowClose);
            this._effectManager = new EffectManager();
            this._layer = param1;
            this._engagedKumiteData = param6;
            this._mcBase = param2;
            this._mcBase.mouseChildren = false;
            this._mcBase.mouseEnabled = false;
            this._layer.getLayer(LayerTrainingRoom.MAIN).addChild(this._mcBase);
            this._cbClose = param7;
            this._isoMain = new InStayOut(this._mcBase);
            this._isoPlayerList = new InStayOut(this._mcBase.charaList1Mc);
            this._isoKumitePlayerList = new InStayOut(this._mcBase.charaList2Mc);
            this._isoInstantBtn = new InStayOut(this._mcBase.payBtnTopMc);
            this._btnReturn = ButtonManager.getInstance().addButton(this._mcBase.returnBtnMc, this.cbReturnButton);
            this._btnReturn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcBase.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._instantBtn = new InstantButton(this._mcBase.payBtnTopMc.btnMc, MessageId.TRAINING_ROOM_BUTTON_KUMITE_INSTANT, this.cbInstantButton);
            this._aPlayerPersonal = param3;
            this._aKumitePlayer = param4;
            this._gotTime = param5;
            this._waitTime = 0;
            this._bNowTraining = false;
            this._traineePersonal = null;
            for each (_loc_8 in this._aPlayerPersonal)
            {
                
                if (this._engagedKumiteData && this._engagedKumiteData.uniqueId == _loc_8.uniqueId)
                {
                    this._bNowTraining = true;
                    this._traineePersonal = _loc_8.clone();
                    break;
                }
            }
            _loc_9 = [];
            for each (_loc_10 in this._aPlayerPersonal)
            {
                
                _loc_9.push(new ListPlayerData(_loc_10));
            }
            this._playerList = new TrainingRoomPlayerList(this._mcBase.charaList1Mc.reserveListMc, _loc_9);
            this._playerList.setPlayerSelectCallback(this.cbPlayerSelectFunc);
            this._playerList.setCaptionText(MessageManager.getInstance().getMessage(MessageId.BARRACKS_SOLDIER_LIST_CAPTION));
            this._playerList.setInformationBarMessage(MessageManager.getInstance().getMessage(MessageId.TRAINING_ROOM_KUMITE_PLAYER_LIST_INFORMATION));
            this._playerList.updateList();
            _loc_9 = [];
            for each (_loc_11 in this._aKumitePlayer)
            {
                
                _loc_9.push(new KumiteListPlayerData(_loc_11));
            }
            this._kumitePlayerList = new KumitePlayerList(this._mcBase.charaList2Mc.reserveListMc, _loc_9);
            this._kumitePlayerList.setPlayerSelectCallback(this.cbKumitePlayerSelectFunc);
            this._kumitePlayerList.setCaptionText(MessageManager.getInstance().getMessage(MessageId.TRAINING_ROOM_KUMITE_PLAYER));
            this._kumitePlayerList.setSelectEnable(false);
            this._kumitePlayerList.updateList();
            this._traineePlayer = new PlayerDisplay(this._mcBase.traningMenu1Mc.charaNull1, Constant.EMPTY_ID, Constant.EMPTY_ID);
            this._kumitePlayer = new PlayerDisplay(this._mcBase.traningMenu1Mc.charaNull2, Constant.EMPTY_ID, Constant.EMPTY_ID);
            this._kumitePlayer.setReverse(true);
            if (this._bNowTraining)
            {
                this.setupTraineePlayer(this._traineePersonal.playerId, this._traineePersonal.uniqueId);
                this.setupKumitePlayer(param6.kumitePlayerId);
            }
            else
            {
                this.setupTraineePlayer(Constant.EMPTY_ID, Constant.EMPTY_ID);
                this.setupKumitePlayer(Constant.EMPTY_ID);
            }
            this._kumitePlayerData = null;
            this._trainingInfoWindow = new TrainingRoomTopInfo(this._mcBase.trainingInfoTopMc);
            this._userResourceBox = new UserResourceBox(this._mcBase.ItemIconBox, AssetId.ASSET_TRAINING);
            this._menu = new TrainingRoomKumiteMenu(this._mcBase.training1ConfTopMc, this.cbMenuDecide, this.cbMenuReset, this.cbMenuSelect);
            this._selecter = null;
            this._startMessage = null;
            this._endMessage = null;
            this._bUseInstant = false;
            this._traineeEndPersonal = null;
            this._bJumpTradingPost = false;
            this.setGuideText("");
            TextControl.setIdText(this._mcBase.trainingMenuTitleMc.textMc.textDt, MessageId.TRAINING_ROOM_TOP_KUMITE_BUTTON);
            this._upgradeDisabled = new FacilityUpgradeDisabled(this._layer.getLayer(LayerTrainingRoom.POPUP));
            this._phase = _PHASE_CLOSE;
            this.setPhase(_PHASE_OPEN_WAIT);
            return;
        }// end function

        public function get bOpenWait() : Boolean
        {
            return this._phase == _PHASE_OPEN_WAIT;
        }// end function

        public function get bClose() : Boolean
        {
            return this._phase == _PHASE_CLOSE && (this._isoMain && this._isoMain.bClosed) && (this._isoPlayerList && this._isoPlayerList.bClosed) && (this._isoKumitePlayerList && this._isoKumitePlayerList.bClosed);
        }// end function

        public function get bJumpTradingPost() : Boolean
        {
            return this._bJumpTradingPost;
        }// end function

        public function get bAnimation() : Boolean
        {
            return this._phase == _PHASE_OPEN || this._phase == _PHASE_KUMITE_END || this._phase == _PHASE_CONNECTING || this._phase == _PHASE_CLOSE;
        }// end function

        public function release() : void
        {
            ButtonManager.getInstance().removeButton(this._btnReturn);
            this._btnReturn = null;
            if (this._instantBtn)
            {
                this._instantBtn.release();
            }
            this._instantBtn = null;
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
            if (this._isoKumitePlayerList)
            {
                this._isoKumitePlayerList.release();
            }
            this._isoKumitePlayerList = null;
            if (this._isoInstantBtn)
            {
                this._isoInstantBtn.release();
            }
            this._isoInstantBtn = null;
            if (this._playerList)
            {
                this._playerList.release();
            }
            this._playerList = null;
            if (this._kumitePlayerList)
            {
                this._kumitePlayerList.release();
            }
            this._kumitePlayerList = null;
            if (this._trainingInfoWindow)
            {
                this._trainingInfoWindow.release();
            }
            this._trainingInfoWindow = null;
            if (this._userResourceBox)
            {
                this._userResourceBox.release();
            }
            this._userResourceBox = null;
            if (this._menu)
            {
                this._menu.release();
            }
            this._menu = null;
            if (this._selecter)
            {
                this._selecter.release();
            }
            this._selecter = null;
            if (this._startMessage)
            {
                this._startMessage.release();
            }
            this._startMessage = null;
            if (this._endMessage)
            {
                this._endMessage.release();
            }
            this._endMessage = null;
            if (this._kumiteAction)
            {
                this._kumiteAction.release();
            }
            this._kumiteAction = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            this._upgradeDisabled.release();
            if (this._effectManager)
            {
                this._effectManager.release();
            }
            this._effectManager = null;
            if (this._layer)
            {
                this._layer.release();
            }
            this._layer = null;
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (this._phase != _PHASE_CONNECTING && this._phase != _PHASE_POPUP)
            {
                this._prevPhase = this._phase;
            }
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_OPEN_WAIT:
                {
                    this.initPhaseOpenWait();
                    break;
                }
                case _PHASE_OPEN:
                {
                    this.initPhaseOpen();
                    break;
                }
                case _PHASE_TRAINEE_SELECT:
                {
                    this.initPhaseTraineeSelect();
                    break;
                }
                case _PHASE_SKILL_SELECT:
                {
                    this.initPhaseSkillSelect();
                    break;
                }
                case _PHASE_NEXT_WAIT:
                {
                    this.initPhaseNextWait();
                    break;
                }
                case _PHASE_KUMITE_PLAYER_SELECT:
                {
                    this.initPhaseKumitePlayerSelect();
                    break;
                }
                case _PHASE_KUMITE_NOW:
                {
                    this.initPhaseKumiteNow();
                    break;
                }
                case _PHASE_KUMITE_END:
                {
                    this.initPhaseKumiteEnd();
                    break;
                }
                case _PHASE_CONNECTING:
                {
                    this.initPhaseConnecting();
                    break;
                }
                case _PHASE_POPUP:
                {
                    this.initPhasePopup();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.initPhaseClose();
                    break;
                }
                case _PHASE_CLOWN_UPDATE:
                {
                    this.initPhaseCrownUpdate();
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
            var t:* = param1;
            this._effectManager.control(t);
            switch(this._phase)
            {
                case _PHASE_NEXT_WAIT:
                {
                    this.controlPhaseNextWait();
                    break;
                }
                case _PHASE_KUMITE_NOW:
                {
                    this.controlPhaseKumiteNow(t);
                    break;
                }
                case _PHASE_KUMITE_END:
                {
                    this.controlPhaseKumiteEnd(t);
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.controlPhaseClose();
                    break;
                }
                case _PHASE_CLOWN_UPDATE:
                {
                    this.controlPhaseCrownUpdate(t);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._playerList)
            {
                this._playerList.control(t);
            }
            if (this._kumitePlayerList)
            {
                this._kumitePlayerList.control(t);
            }
            if (this._trainingInfoWindow)
            {
                this._trainingInfoWindow.control(t);
            }
            if (this._instantBtn)
            {
                this._instantBtn.control(t);
            }
            if (this._menu)
            {
                this._menu.control(t);
            }
            if (this._selecter)
            {
                this._selecter.control(t);
            }
            if (this._upgradeDisabled)
            {
                this._upgradeDisabled.countControl(t);
            }
            if (this._phase == _PHASE_TRAINEE_SELECT || this._phase == _PHASE_KUMITE_PLAYER_SELECT)
            {
                this._waitTime = this._waitTime + t;
                if (this._waitTime >= 60)
                {
                    this._waitTime = this._waitTime - 60;
                    if (this.checkKumitePlayerUpdateTime())
                    {
                        this._gotTime = TimeClock.getNowTime();
                        this.setPhase(_PHASE_CONNECTING);
                        NetManager.getInstance().request(new NetTaskTrainingRoomInfo(function (param1:NetResult) : void
            {
                updateKumitePlayer(param1.data.aKumitePlayerData);
                setPhase(_PHASE_TRAINEE_SELECT);
                return;
            }// end function
            ));
                    }
                }
            }
            return;
        }// end function

        private function initPhaseOpenWait() : void
        {
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            this._kumitePlayerList.setSelectEnable(false);
            return;
        }// end function

        private function initPhaseOpen() : void
        {
            var cbFunc:Function;
            var ownSkillData:OwnSkillData;
            var maxTrainingSec:uint;
            var nowTime:uint;
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            this._kumitePlayerList.setSelectEnable(false);
            this._traineePlayer.setAnimation(PlayerDisplay.LABEL_SIDE_STOP);
            this._kumitePlayer.setAnimation(PlayerDisplay.LABEL_SIDE_STOP);
            this._userResourceBox.updateNum();
            if (!this._bNowTraining)
            {
                this.reset();
                cbFunc = function () : void
            {
                if (_isoMain.bOpened && _isoPlayerList.bOpened)
                {
                    setPhase(_PHASE_TRAINEE_SELECT);
                }
                return;
            }// end function
            ;
                this._isoMain.setInLabel("in", cbFunc);
                this._isoPlayerList.setIn(cbFunc);
            }
            else
            {
                this._isoMain.setInLabel("in2", function () : void
            {
                setPhase(_PHASE_KUMITE_NOW);
                return;
            }// end function
            );
                var _loc_2:* = 0;
                var _loc_3:* = this._traineePersonal.aOwnSkillData;
                while (_loc_3 in _loc_2)
                {
                    
                    ownSkillData = _loc_3[_loc_2];
                    if (ownSkillData.skillId == this._engagedKumiteData.skillId)
                    {
                        maxTrainingSec = TrainingRoomTable.getKumiteTimeSec(ownSkillData);
                        nowTime = TimeClock.getNowTime();
                        this._trainingInfoWindow.setData(ownSkillData, TrainingRoomTable.getParamReinforceText(this._engagedKumiteData.kumiteType), nowTime, this._engagedKumiteData.endTime, maxTrainingSec, TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_6));
                        this._instantBtn.setLearning(TrainingRoomTable.getKumiteInstantLearningNum(this._engagedKumiteData.endTime, nowTime));
                        this._instantBtn.setEndTime(this._engagedKumiteData.endTime);
                        break;
                    }
                }
                this._isoInstantBtn.setIn();
                this._trainingInfoWindow.open();
                this._userResourceBox.setVisible(false);
            }
            return;
        }// end function

        private function initPhaseTraineeSelect() : void
        {
            var cbFunc:Function;
            var cbFunc2:Function;
            this.reset();
            this._playerList.overlayVisible(false);
            this._playerList.checkEmptyInformation();
            if (this._menu.bClose)
            {
                this._menu.reset();
            }
            else
            {
                this._menu.close(function () : void
            {
                _menu.reset();
                return;
            }// end function
            );
            }
            if (this._prevPhase == _PHASE_KUMITE_PLAYER_SELECT)
            {
                this.btnEnable(false);
                this._playerList.setSelectEnable(false);
                this._kumitePlayerList.setSelectEnable(false);
                this._isoKumitePlayerList.setOut();
                cbFunc = function () : void
            {
                if (_isoMain.bOpened && _isoPlayerList.bOpened)
                {
                    btnEnable(true);
                    _playerList.setSelectEnable(true);
                }
                return;
            }// end function
            ;
                this._isoMain.setInLabel("moveBack", cbFunc);
                this._isoPlayerList.setIn(cbFunc);
            }
            else if (this._prevPhase == _PHASE_KUMITE_NOW || this._prevPhase == _PHASE_KUMITE_END)
            {
                this.btnEnable(false);
                this._playerList.setSelectEnable(false);
                this._kumitePlayerList.setSelectEnable(false);
                this._trainingInfoWindow.close();
                this._userResourceBox.setVisible(true);
                cbFunc2 = function () : void
            {
                if (_isoMain.bOpened && _isoPlayerList.bOpened)
                {
                    if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_6))
                    {
                        TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_6, function () : void
                {
                    btnEnable(true);
                    _playerList.setSelectEnable(true);
                    ButtonManager.getInstance().unseal();
                    return;
                }// end function
                );
                    }
                    else
                    {
                        btnEnable(true);
                        _playerList.setSelectEnable(true);
                    }
                }
                return;
            }// end function
            ;
                this._isoMain.setInLabel("back", cbFunc2);
                this._isoPlayerList.setIn(cbFunc2);
            }
            else if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_1))
            {
                this.btnEnable(false);
                this._playerList.setSelectEnable(false);
                this._kumitePlayerList.setSelectEnable(false);
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_1, function () : void
            {
                btnEnable(true);
                _playerList.setSelectEnable(true);
                return;
            }// end function
            );
            }
            else
            {
                this.btnEnable(true);
                this._playerList.setSelectEnable(true);
                this._kumitePlayerList.setSelectEnable(false);
            }
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.TRAINING_ROOM_KUMITE_GUIDE_TEXT01));
            if (this._upgradeDisabled.facilityUpgrade(CommonConstant.FACILITY_ID_TRAINING_ROOM))
            {
                this._playerList.setSelectEnable(false);
                this._playerList.overlayVisible(true);
                this.setGuideText(MessageManager.getInstance().getMessage(MessageId.FACILITY_UPGRADENOW_GUIDE_MESSAGE));
            }
            return;
        }// end function

        private function initPhaseSkillSelect() : void
        {
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            this._menu.btnEnable(false);
            var aOwnSkillData:* = this.getFilteringOwnSkillData(this._traineePersonal.aOwnSkillData);
            this._selecter = new TrainingRoomSelecter(TrainingRoomSelecter.SELECTER_TYPE_SKILL, this._traineePersonal, aOwnSkillData, this._layer.getLayer(LayerTrainingRoom.POPUP), function () : void
            {
                if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_2))
                {
                    TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_2, function () : void
                {
                    if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_3))
                    {
                        TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_3);
                    }
                    return;
                }// end function
                );
                }
                else if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_3))
                {
                    TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_3);
                }
                return;
            }// end function
            , function (param1:OwnSkillData, param2:int) : void
            {
                _selecter.release();
                _selecter = null;
                if (param1 == null)
                {
                    setPhase(_menu.selectSkillData == null ? (_PHASE_TRAINEE_SELECT) : (_PHASE_NEXT_WAIT));
                }
                else
                {
                    _menu.setSelectSkill(param1);
                    _menu.setSelectParam(param2);
                    if (_kumitePlayerList)
                    {
                        _kumitePlayerList.setSelectSkill(param1);
                    }
                    selectCheck();
                }
                return;
            }// end function
            );
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.TRAINING_ROOM_KUMITE_GUIDE_TEXT02));
            return;
        }// end function

        private function selectCheck() : void
        {
            var skillData:OwnSkillData;
            var powerMsgId:int;
            var hitMsgId:int;
            if (this._menu.selectParam == Constant.UNDECIDED || this._menu.selectSkillData == null)
            {
                this.setPhase(_PHASE_TRAINEE_SELECT);
            }
            else
            {
                skillData = this._menu.selectSkillData as OwnSkillData;
                if (skillData.isSpMaxLimit())
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(SkillManager.isMagicSkillInfo(skillData.skillInfo) ? (MessageId.TRAINING_ROOM_KUMITE_REINFORCE_SP_LIMIT_MAGIC) : (MessageId.TRAINING_ROOM_KUMITE_REINFORCE_SP_LIMIT)), function () : void
            {
                setPhase(_PHASE_TRAINEE_SELECT);
                return;
            }// end function
            );
                }
                else if (this._menu.selectParam == CommonConstant.TRAINING_ROOM_KUMITE_TYPE_POWER && (skillData.isPowerMaxLimit() || skillData.isHitMinLimit()))
                {
                    powerMsgId;
                    if (skillData.isPowerMaxLimit())
                    {
                        powerMsgId = MessageId.TRAINING_ROOM_KUMITE_REINFORCE_POWER_LIMIT;
                    }
                    else if (skillData.isHitMinLimit())
                    {
                        powerMsgId = MessageId.TRAINING_ROOM_KUMITE_REINFORCE_POWER_LOWER_LIMIT;
                    }
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(powerMsgId), function () : void
            {
                setPhase(_PHASE_TRAINEE_SELECT);
                return;
            }// end function
            );
                }
                else if (this._menu.selectParam == CommonConstant.TRAINING_ROOM_KUMITE_TYPE_HIT && (skillData.isHitMaxLimit() || skillData.isPowerMinLimit()))
                {
                    hitMsgId;
                    if (skillData.isHitMaxLimit())
                    {
                        hitMsgId = MessageId.TRAINING_ROOM_KUMITE_REINFORCE_HIT_LIMIT;
                    }
                    else if (skillData.isPowerMinLimit())
                    {
                        hitMsgId = MessageId.TRAINING_ROOM_KUMITE_REINFORCE_HIT_LOWER_LIMIT;
                    }
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(hitMsgId), function () : void
            {
                setPhase(_PHASE_TRAINEE_SELECT);
                return;
            }// end function
            );
                }
                else if (UserDataManager.getInstance().userData.kumiteResource < TrainingRoomTable.getKumiteResourceNum(skillData))
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, AssetListManager.getInstance().getAssetLackMessage(AssetId.ASSET_TRAINING), function () : void
            {
                setPhase(_PHASE_TRAINEE_SELECT);
                return;
            }// end function
            );
                }
                else
                {
                    this.setPhase(_PHASE_NEXT_WAIT);
                }
            }
            return;
        }// end function

        private function initPhaseNextWait() : void
        {
            this.btnEnable(true);
            this._playerList.setSelectEnable(false);
            this._kumitePlayerList.setSelectEnable(false);
            this._menu.setTraineePersonal(this._traineePersonal);
            this._menu.setFix(false);
            this._menu.setEnableDecideButton(this._menu.selectSkillData != null && this._menu.selectParam != Constant.UNDECIDED);
            this._menu.btnEnable(true);
            if (this._traineePlayer.uniqueId != this._traineePersonal.uniqueId)
            {
                this.setupTraineePlayer(this._traineePersonal.playerId, this._traineePersonal.uniqueId);
                this._traineePlayer.setAnimation(PlayerDisplay.LABEL_SIDE_STOP);
            }
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.TRAINING_ROOM_KUMITE_GUIDE_TEXT02));
            return;
        }// end function

        private function controlPhaseNextWait() : void
        {
            this.setPhase(_PHASE_KUMITE_PLAYER_SELECT);
            return;
        }// end function

        private function initPhaseKumitePlayerSelect() : void
        {
            this._menu.setFix(true);
            this._menu.setEnableDecideButton(this._kumitePlayer.info != null);
            this._menu.btnEnable(true);
            if (this._menu.bOpenWait)
            {
                this._menu.open();
            }
            this._kumitePlayerList.updateList();
            if (this._prevPhase == _PHASE_NEXT_WAIT || this._prevPhase == _PHASE_KUMITE_NOW || this._prevPhase == _PHASE_KUMITE_END)
            {
                this._isoMain.setInLabel(this._prevPhase == _PHASE_NEXT_WAIT ? ("move") : ("back"));
                this.btnEnable(false);
                this._playerList.setSelectEnable(false);
                this._isoPlayerList.setOut();
                this._kumitePlayerList.setSelectEnable(false);
                this._isoKumitePlayerList.setIn(function () : void
            {
                if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_4))
                {
                    TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_4, function () : void
                {
                    btnEnable(true);
                    _kumitePlayerList.setSelectEnable(true);
                    return;
                }// end function
                );
                }
                else
                {
                    btnEnable(true);
                    _kumitePlayerList.setSelectEnable(true);
                }
                return;
            }// end function
            );
            }
            else
            {
                this.btnEnable(true);
                this._playerList.setSelectEnable(false);
                this._kumitePlayerList.setSelectEnable(true);
            }
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.TRAINING_ROOM_KUMITE_GUIDE_TEXT03));
            return;
        }// end function

        private function initPhaseKumiteNow() : void
        {
            var maxTrainingSec:uint;
            var nowTime:uint;
            if (this._kumiteAction == null)
            {
                this._kumiteAction = new TrainingRoomKumiteAction(this._layer, this._mcBase, this._traineePlayer, this._kumitePlayer, this._effectManager);
                this._kumiteAction.getResources();
            }
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            this._kumitePlayerList.setSelectEnable(false);
            this._userResourceBox.setVisible(false);
            if (this._prevPhase == _PHASE_KUMITE_NOW)
            {
                this.btnEnable(true);
                return;
            }
            var actionFunc:* = function () : void
            {
                _bKumiteActionWait = false;
                if (_phase == _PHASE_KUMITE_NOW)
                {
                    btnEnable(true);
                }
                _traineePlayer.setAnimationWithCallback(PlayerDisplay.LABEL_ACTION_SELECT_START, function () : void
                {
                    _traineePlayer.setAnimation(PlayerDisplay.LABEL_ACTION_SELECT_END);
                    return;
                }// end function
                );
                _kumitePlayer.setAnimationWithCallback(PlayerDisplay.LABEL_ACTION_SELECT_START, function () : void
                {
                    _kumitePlayer.setAnimation(PlayerDisplay.LABEL_ACTION_SELECT_END);
                    return;
                }// end function
                );
                if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_5))
                {
                    TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_5, function () : void
                {
                    TutorialManager.getInstance().setTutorialArrow(_instantBtn.getBtn().getMoveClip());
                    ButtonManager.getInstance().seal([_instantBtn.getBtn()], true);
                    return;
                }// end function
                );
                }
                return;
            }// end function
            ;
            this._bKumiteActionWait = true;
            if (this._prevPhase == _PHASE_KUMITE_PLAYER_SELECT)
            {
                this._isoKumitePlayerList.setOut();
                this._isoMain.setInLabel("out1", actionFunc);
                maxTrainingSec = TrainingRoomTable.getKumiteTimeSec(this._menu.selectSkillData);
                nowTime = TimeClock.getNowTime();
                this._trainingInfoWindow.setData(this._menu.selectSkillData, TrainingRoomTable.getParamReinforceText(this._menu.selectParam), nowTime, this._engagedKumiteData.endTime, maxTrainingSec, TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_6));
                this._trainingInfoWindow.open();
                this._instantBtn.setLearning(TrainingRoomTable.getKumiteInstantLearningNum(this._engagedKumiteData.endTime, nowTime));
                this._instantBtn.setEndTime(this._engagedKumiteData.endTime);
                this._isoInstantBtn.setIn(function () : void
            {
                if (_phase == _PHASE_KUMITE_NOW)
                {
                    btnEnable(true);
                }
                return;
            }// end function
            );
                this._menu.close();
            }
            else
            {
                this.actionFunc();
            }
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_6))
            {
                this._instantBtn.setLearning(0);
                this._instantBtn.setEndTime(uint.MAX_VALUE);
            }
            return;
        }// end function

        private function controlPhaseKumiteNow(param1:Number) : void
        {
            if (ResourceManager.getInstance().isLoaded() == false)
            {
                return;
            }
            if (this._instantBtn && this._engagedKumiteData)
            {
                this._instantBtn.setLearning(TrainingRoomTable.getKumiteInstantLearningNum(this._engagedKumiteData.endTime, TimeClock.getNowTime()));
            }
            if (this._kumiteAction)
            {
                this._kumiteAction.controlAction(param1);
            }
            if (!this._bKumiteActionWait)
            {
                if (!this._bUseInstant && this._trainingInfoWindow.bTimeOver)
                {
                    NetManager.getInstance().request(new NetTaskTrainingRoomKumiteEnd(false, true, 0, this.cbConnectTrainingRoomKumiteEnd));
                    this.setPhase(_PHASE_CONNECTING);
                }
            }
            return;
        }// end function

        private function initPhaseKumiteEnd() : void
        {
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            this._kumitePlayerList.setSelectEnable(false);
            if (this._isoInstantBtn.bOpened)
            {
                this._isoInstantBtn.setOut();
            }
            if (this._kumiteAction)
            {
                this._kumiteAction.release();
            }
            this._kumiteAction = null;
            this._bKumiteActionWait = true;
            this._traineePlayer.setAnimationWithCallback(PlayerDisplay.LABEL_JUMP, function () : void
            {
                _traineePlayer.setAnimationWithCallback(PlayerDisplay.LABEL_ACTION_SELECT_START, function () : void
                {
                    _bKumiteActionWait = false;
                    return;
                }// end function
                );
                return;
            }// end function
            );
            this._kumitePlayer.setAnimation(PlayerDisplay.LABEL_SIDE_STOP);
            return;
        }// end function

        private function controlPhaseKumiteEnd(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            if (!this._bKumiteActionWait)
            {
                if (this._endMessage == null)
                {
                    _loc_2 = [];
                    for each (_loc_3 in this._traineePersonal.aOwnSkillData)
                    {
                        
                        for each (_loc_4 in this._traineeEndPersonal.aOwnSkillData)
                        {
                            
                            if (_loc_3.skillId == _loc_4.skillId)
                            {
                                if (_loc_3.powerChange != _loc_4.powerChange || _loc_3.hitChange != _loc_4.hitChange || _loc_3.spChange != _loc_4.spChange)
                                {
                                    _loc_5 = _loc_3.powerTotal;
                                    _loc_6 = _loc_4.powerTotal;
                                    _loc_7 = _loc_3.hitTotal;
                                    _loc_8 = _loc_4.hitTotal;
                                    _loc_9 = _loc_3.spTotal;
                                    _loc_10 = _loc_4.spTotal;
                                    _loc_2.push(new TrainingSkillParamChange(_loc_4.skillId, _loc_5, _loc_6 - _loc_5, _loc_7, _loc_8 - _loc_7, _loc_9, _loc_10 - _loc_9));
                                }
                                break;
                            }
                        }
                    }
                    this._endMessage = new TrainingRoomStartSuccessMessage(this._bKumiteEndGreatSuccess ? (TrainingRoomStartSuccessMessage.MESSAGE_TYPE_BIG_SUCCESS) : (TrainingRoomStartSuccessMessage.MESSAGE_TYPE_SUCCESS), TrainingRoomStartSuccessMessage.MESSAGE_SUBTYPE_KUMITE, this._layer.getLayer(LayerTrainingRoom.POPUP), _loc_2, this.cbEndMessageClose);
                }
            }
            return;
        }// end function

        private function initPhaseConnecting() : void
        {
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            this._kumitePlayerList.setSelectEnable(false);
            this._menu.btnEnable(false);
            return;
        }// end function

        private function initPhasePopup() : void
        {
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            this._kumitePlayerList.setSelectEnable(false);
            this._menu.btnEnable(false);
            return;
        }// end function

        private function initPhaseClose() : void
        {
            Main.GetProcess().topBar.cbConfigWindow(null, null);
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            this._kumitePlayerList.setSelectEnable(false);
            this._menu.btnEnable(false);
            this._upgradeDisabled.close();
            if (this._prevPhase == _PHASE_KUMITE_NOW)
            {
                this._isoMain.setOutLabel("out4");
            }
            else if (this._prevPhase == _PHASE_KUMITE_PLAYER_SELECT)
            {
                this._isoMain.setOutLabel("out3");
            }
            else
            {
                this._isoMain.setOutLabel("out2");
            }
            if (this._isoPlayerList.bClosed == false && this._isoPlayerList.bAnimetionClose == false)
            {
                this._isoPlayerList.setOut();
            }
            if (this._isoKumitePlayerList.bClosed == false && this._isoKumitePlayerList.bAnimetionClose == false)
            {
                this._isoKumitePlayerList.setOut();
            }
            if (this._isoInstantBtn.bClosed == false && this._isoInstantBtn.bAnimetionClose == false)
            {
                this._isoInstantBtn.setOut();
            }
            if (!this._trainingInfoWindow.bClosing)
            {
                this._trainingInfoWindow.close();
            }
            if (!this._menu.bClosing)
            {
                this._menu.close();
            }
            return;
        }// end function

        private function controlPhaseClose() : void
        {
            if (this._isoMain.bClosed && this._isoPlayerList.bClosed)
            {
                if (this._cbClose != null)
                {
                    this._cbClose(this._engagedKumiteData);
                }
                this.setPhase(_PHASE_OPEN_WAIT);
            }
            return;
        }// end function

        private function initPhaseCrownUpdate() : void
        {
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            this._kumitePlayerList.setSelectEnable(false);
            this._menu.btnEnable(false);
            return;
        }// end function

        public function controlPhaseCrownUpdate(param1:Number) : void
        {
            if (!Main.GetProcess().isCrownUpdateing())
            {
                this.setPhase(_PHASE_KUMITE_NOW);
            }
            return;
        }// end function

        public function open() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = UserDataManager.getInstance().userData;
            var _loc_2:* = [];
            for each (_loc_3 in this._aPlayerPersonal)
            {
                
                if (_loc_3.isUseFacility() || this.getFilteringOwnSkillData(_loc_3.aOwnSkillData).length == 0 || _loc_1.aFormationPlayerUniqueId.indexOf(_loc_3.uniqueId) != -1)
                {
                    _loc_2.push(_loc_3.uniqueId);
                }
            }
            this._playerList.setNotDisplayPlayer(_loc_2);
            this._playerList.updateList();
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function removePlayer(param1:Array) : void
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
            return;
        }// end function

        private function btnEnable(param1:Boolean) : void
        {
            this._btnReturn.setDisable(this._bUseInstant || !param1);
            this._instantBtn.setDisable(!this._isoInstantBtn.bOpened || this._bUseInstant || !param1);
            this._userResourceBox.setMouseOverEnable(!this._bUseInstant && param1);
            return;
        }// end function

        private function setGuideText(param1:String) : void
        {
            TextControl.setText(this._mcBase.captionTopMc.textMc.textDt, param1);
            var _loc_2:* = param1.split("\n");
            this._mcBase.captionTopMc.gotoAndStop("linage" + (_loc_2.length > 1 ? ("2") : ("1")));
            return;
        }// end function

        private function setupTraineePlayer(param1:int, param2:int) : void
        {
            var _loc_3:* = null;
            this._traineePlayer.setId(param1, param2);
            if (param1 == Constant.EMPTY_ID)
            {
                TextControl.setText(this._mcBase.traningMenu1Mc.setCharaName1Mc.textDt, "");
                this._mcBase.traningMenu1Mc.setCharaRank1Mc.visible = false;
            }
            else
            {
                TextControl.setText(this._mcBase.traningMenu1Mc.setCharaName1Mc.textDt, this._traineePlayer.info.name);
                this._mcBase.traningMenu1Mc.setCharaRank1Mc.visible = true;
                _loc_3 = new PlayerRarityIcon(this._mcBase.traningMenu1Mc.setCharaRank1Mc, this._traineePlayer.info.rarity);
            }
            return;
        }// end function

        private function setupKumitePlayer(param1:int) : void
        {
            var _loc_2:* = null;
            this._kumitePlayer.setId(param1, Constant.EMPTY_ID);
            if (param1 == Constant.EMPTY_ID)
            {
                TextControl.setText(this._mcBase.traningMenu1Mc.setCharaName2Mc.textDt, "");
                this._mcBase.traningMenu1Mc.setCharaRank2Mc.visible = false;
            }
            else
            {
                TextControl.setText(this._mcBase.traningMenu1Mc.setCharaName2Mc.textDt, this._kumitePlayer.info.name);
                this._mcBase.traningMenu1Mc.setCharaRank2Mc.visible = true;
                _loc_2 = new PlayerRarityIcon(this._mcBase.traningMenu1Mc.setCharaRank2Mc, this._kumitePlayer.info.rarity);
            }
            return;
        }// end function

        private function reset() : void
        {
            this.setupTraineePlayer(Constant.EMPTY_ID, Constant.EMPTY_ID);
            this.setupKumitePlayer(Constant.EMPTY_ID);
            this._traineePersonal = null;
            this._playerList.resetSelect();
            this._kumitePlayerList.resetSelect();
            return;
        }// end function

        private function updateKumitePlayer(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (param1)
            {
                this._aKumitePlayer.length = 0;
                _loc_4 = [];
                _loc_5 = param1 as Array;
                _loc_6 = 0;
                while (_loc_6 < _loc_5.length)
                {
                    
                    _loc_7 = new TrainingRoomKumitePlayerData(_loc_6, _loc_5[_loc_6]);
                    if (_loc_7.playerId == Constant.EMPTY_ID)
                    {
                    }
                    else
                    {
                        _loc_8 = PlayerManager.getInstance().getPlayerInformation(_loc_7.playerId);
                        if (_loc_8 == null)
                        {
                        }
                        else
                        {
                            this._aKumitePlayer.push(_loc_7);
                            _loc_4.push(ResourcePath.PLAYER_PATH + _loc_8.swf);
                        }
                    }
                    _loc_6++;
                }
                ResourceManager.getInstance().loadArray(_loc_4);
            }
            var _loc_2:* = [];
            for each (_loc_3 in this._aKumitePlayer)
            {
                
                _loc_2.push(new KumiteListPlayerData(_loc_3));
            }
            this._kumitePlayerList.setPlayerList(_loc_2);
            this._kumitePlayerList.updateList();
            this._gotTime = TimeClock.getNowTime();
            this._waitTime = 0;
            return;
        }// end function

        private function checkKumitePlayerUpdateTime() : Boolean
        {
            return false;
        }// end function

        private function getFilteringOwnSkillData(param1:Array) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in param1)
            {
                
                _loc_4 = SkillManager.getInstance().getSkillInformation(_loc_3.skillId);
                if (_loc_4 && _loc_4.bKumitePossible)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        private function cbReturnButton(param1:int) : void
        {
            if (this._phase == _PHASE_TRAINEE_SELECT || this._phase == _PHASE_KUMITE_PLAYER_SELECT)
            {
                this.reset();
            }
            if (this._phase == _PHASE_KUMITE_PLAYER_SELECT)
            {
                this.setPhase(_PHASE_TRAINEE_SELECT);
                return;
            }
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbInstantButton(param1:int) : void
        {
            var numCost:int;
            var instantLearningItemNum:int;
            var id:* = param1;
            numCost = TrainingRoomTable.getKumiteInstantLearningNum(this._engagedKumiteData.endTime, TimeClock.getNowTime());
            var executeKumiteFunc:* = function () : void
            {
                if (_instantBtn.bEnableTime == false)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CONFIRM_ALREADY_USE_ITEM_JEWEL), function () : void
                {
                    setPhase(_PHASE_KUMITE_NOW);
                    return;
                }// end function
                );
                    return;
                }
                _bUseInstant = true;
                NetManager.getInstance().request(new NetTaskTrainingRoomKumiteEnd(true, true, numCost, cbConnectTrainingRoomKumiteEnd));
                setPhase(_PHASE_CONNECTING);
                return;
            }// end function
            ;
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_6))
            {
                numCost;
                TutorialManager.getInstance().hideTutorial();
                this.executeKumiteFunc();
            }
            else
            {
                instantLearningItemNum = UserDataManager.getInstance().userData.getOwnPaymentItemNum(PaymentItemId.ITEM_INSTANT_LEARNING);
                if (instantLearningItemNum >= numCost)
                {
                    CommonPopup.getInstance().openPaymentPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.CONFIRM_USE_ITEM_JEWEL, instantLearningItemNum, numCost), function (param1:Boolean) : void
            {
                if (param1)
                {
                    executeKumiteFunc();
                }
                else
                {
                    setPhase(_PHASE_KUMITE_NOW);
                }
                return;
            }// end function
            );
                }
                else
                {
                    CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.MAGIC_DEVELOP_CONFIRM_GET_ITEM), function (param1:Boolean) : void
            {
                if (param1)
                {
                    _bJumpTradingPost = true;
                    TradingPostStartPageRequest.getInstance().setRequestInstantLearning();
                    setPhase(_PHASE_CLOSE);
                }
                else
                {
                    setPhase(_PHASE_KUMITE_NOW);
                }
                return;
            }// end function
            );
                }
            }
            this.setPhase(_PHASE_POPUP);
            return;
        }// end function

        private function cbPlayerSelectFunc(param1:int, param2:ListPlayerData) : void
        {
            if (this._phase != _PHASE_TRAINEE_SELECT)
            {
                return;
            }
            this._traineePersonal = param2.personal;
            this.setPhase(_PHASE_SKILL_SELECT);
            return;
        }// end function

        private function cbKumitePlayerSelectFunc(param1:int, param2:KumiteListPlayerData) : void
        {
            this._kumitePlayerData = param2.kumitePlayerData;
            this.setupKumitePlayer(this._kumitePlayerData.playerId);
            this._kumitePlayer.setAnimation(PlayerDisplay.LABEL_SIDE_STOP);
            this._menu.setEnableDecideButton(true);
            this.cbMenuDecide();
            return;
        }// end function

        private function cbMenuDecide() : void
        {
            var trainingSec:uint;
            var sec:int;
            var min:int;
            var hour:int;
            var resourceNum:uint;
            if (this._phase == _PHASE_NEXT_WAIT)
            {
                this.setPhase(_PHASE_KUMITE_PLAYER_SELECT);
            }
            else if (this._phase == _PHASE_KUMITE_PLAYER_SELECT)
            {
                trainingSec = TrainingRoomTable.getKumiteTimeSec(this._menu.selectSkillData);
                sec = trainingSec % 60;
                min = trainingSec / 60 % 60;
                hour = trainingSec / 60 / 60;
                resourceNum = TrainingRoomTable.getKumiteResourceNum(this._menu.selectSkillData);
                CommonPopup.getInstance().openConsumePopup(CommonPopup.POPUP_TYPE_NORMAL, AssetId.ASSET_TRAINING, TextControl.formatIdText(MessageId.TRAINING_ROOM_KUMITE_START_CONFIRM, this._traineePlayer.info.name, this._kumitePlayer.info.name, resourceNum.toString(), hour < 10 ? ("0" + hour.toString()) : (hour), min < 10 ? ("0" + min.toString()) : (min), sec < 10 ? ("0" + sec.toString()) : (sec)), function (param1:Boolean) : void
            {
                if (param1)
                {
                    _bUseInstant = false;
                    _engagedKumiteData = new EngagedKumiteData();
                    _engagedKumiteData.uniqueId = _traineePlayer.uniqueId;
                    _engagedKumiteData.skillId = _menu.selectSkillData.skillId;
                    _engagedKumiteData.kumiteType = _menu.selectParam;
                    _engagedKumiteData.kumitePlayerId = _kumitePlayerData.playerId;
                    _engagedKumiteData.userId = _kumitePlayerData.userId;
                    _engagedKumiteData.userName = _kumitePlayerData.userName;
                    NetManager.getInstance().request(new NetTaskTrainingRoomKumite(_traineePlayer.uniqueId, _menu.selectSkillData.skillId, _menu.selectParam, _kumitePlayerData.guestNo, TrainingRoomTable.getKumiteResourceNum(_menu.selectSkillData), cbConnectTrainingRoomKumite));
                    setPhase(_PHASE_CONNECTING);
                }
                else
                {
                    setupKumitePlayer(Constant.EMPTY_ID);
                    _kumitePlayerList.resetSelect();
                    setPhase(_PHASE_KUMITE_PLAYER_SELECT);
                }
                return;
            }// end function
            );
                this.setPhase(_PHASE_POPUP);
            }
            return;
        }// end function

        private function cbMenuReset() : void
        {
            this.setPhase(_PHASE_TRAINEE_SELECT);
            return;
        }// end function

        private function cbMenuSelect(param1:int) : void
        {
            if (this._phase != _PHASE_NEXT_WAIT)
            {
                return;
            }
            switch(param1)
            {
                case TrainingRoomSelecter.SELECTER_TYPE_SKILL:
                case TrainingRoomSelecter.SELECTER_TYPE_PARAM:
                {
                    this.setPhase(_PHASE_SKILL_SELECT);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function cbConnectTrainingRoomKumite(param1:NetResult) : void
        {
            this._traineePersonal = this._traineePersonal.clone();
            this._traineePersonal.setUseFacility(CommonConstant.FACILITY_ID_TRAINING_ROOM, CommonConstant.FACILITY_ID_SUB_TRAINING_KUMITE, param1.data.institutionNotice.time);
            this._engagedKumiteData.endTime = param1.data.institutionNotice.time;
            this._engagedKumiteData.noticeId = param1.data.institutionNotice.uniqueId;
            var _loc_2:* = UserDataManager.getInstance().userData;
            var _loc_3:* = _loc_2.aPlayerPersonal;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                if (_loc_3[_loc_4].uniqueId == this._traineePlayer.uniqueId)
                {
                    (_loc_3[_loc_4] as PlayerPersonal).copyParam(this._traineePersonal);
                    break;
                }
                _loc_4++;
            }
            _loc_2.setOwnPlayer(_loc_3);
            _loc_4 = 0;
            while (_loc_4 < this._aPlayerPersonal.length)
            {
                
                if (this._aPlayerPersonal[_loc_4].uniqueId == this._traineePlayer.uniqueId)
                {
                    (this._aPlayerPersonal[_loc_4] as PlayerPersonal).copyParam(this._traineePersonal);
                    break;
                }
                _loc_4++;
            }
            this._userResourceBox.updateNum();
            NoticeManager.getInstance().addMiniNoticeByObject(param1.data.institutionNotice);
            this._bNowTraining = true;
            this.setPhase(_PHASE_KUMITE_NOW);
            return;
        }// end function

        private function cbConnectTrainingRoomKumiteEnd(param1:NetResult) : void
        {
            var res:* = param1;
            if (res.data.alreadyEnd == 1)
            {
                this._bUseInstant = false;
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CONFIRM_ALREADY_USE_ITEM_JEWEL), function () : void
            {
                setPhase(_PHASE_KUMITE_NOW);
                return;
            }// end function
            );
                return;
            }
            this._bKumiteEndGreatSuccess = res.data.bGreatSuccess;
            this._traineeEndPersonal = new PlayerPersonal();
            this._traineeEndPersonal.setParameter(res.data.playerPersonal);
            this._engagedKumiteData = null;
            var userData:* = UserDataManager.getInstance().userData;
            var aPlayerPersonal:* = userData.aPlayerPersonal;
            var i:int;
            while (i < aPlayerPersonal.length)
            {
                
                if (aPlayerPersonal[i].uniqueId == this._traineeEndPersonal.uniqueId)
                {
                    (aPlayerPersonal[i] as PlayerPersonal).copyParam(this._traineeEndPersonal);
                    break;
                }
                i = (i + 1);
            }
            userData.setOwnPlayer(aPlayerPersonal);
            var listPersonal:* = this._traineeEndPersonal;
            i;
            while (i < this._aPlayerPersonal.length)
            {
                
                if (this._aPlayerPersonal[i].uniqueId == this._traineeEndPersonal.uniqueId)
                {
                    listPersonal = this._aPlayerPersonal[i] as PlayerPersonal;
                    listPersonal.copyParam(this._traineeEndPersonal);
                    break;
                }
                i = (i + 1);
            }
            var listPlayerData:* = new ListPlayerData(listPersonal);
            this._playerList.removePlayer(listPersonal.uniqueId);
            this._playerList.addPlayer(listPlayerData);
            this._playerList.removeNotDisplayPlayer(listPersonal.uniqueId);
            this._playerList.updateList();
            this.updateKumitePlayer(res.data.aKumitePlayerData);
            if (this._bUseInstant && res.data.crownData)
            {
                userData.setCrownTotal(res.data.crownData);
                Main.GetProcess().topBar.update();
            }
            this._trainingInfoWindow.instantEnd();
            NoticeManager.getInstance().crearSimpleNoticeById(res.data.institutionNoticeId);
            this.setPhase(_PHASE_KUMITE_END);
            return;
        }// end function

        private function cbEndMessageClose() : void
        {
            if (this._endMessage)
            {
                this._endMessage.release();
            }
            this._endMessage = null;
            this._bNowTraining = false;
            this._bUseInstant = false;
            this.setPhase(_PHASE_TRAINEE_SELECT);
            return;
        }// end function

        public function cbConfigWindowOpen() : void
        {
            if (this._playerList && this._kumitePlayerList)
            {
                this._playerList.setSelectEnable(false);
                this._kumitePlayerList.setSelectEnable(false);
            }
            return;
        }// end function

        public function cbConfigWindowClose() : void
        {
            if (this._playerList && this._kumitePlayerList)
            {
                this._playerList.setSelectEnable(true);
                this._kumitePlayerList.setSelectEnable(true);
            }
            return;
        }// end function

        private function cbRestEnd(param1:PlayerPersonal) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = param1;
            var _loc_3:* = UserDataManager.getInstance().userData;
            if (_loc_2.isUseFacility() || this.getFilteringOwnSkillData(_loc_2.aOwnSkillData).length == 0 || _loc_3.aFormationPlayerUniqueId.indexOf(_loc_2.uniqueId) != -1)
            {
                return;
            }
            if (this._playerList)
            {
                _loc_4 = new ListPlayerData(_loc_2);
                this._playerList.removePlayer(_loc_2.uniqueId);
                this._playerList.addPlayer(_loc_4);
                this._playerList.removeNotDisplayPlayer(_loc_2.uniqueId);
                this._playerList.updateList();
                this._playerList.checkEmptyInformation();
                this._playerList.setRestEndAction(_loc_2.uniqueId);
            }
            return;
        }// end function

    }
}
