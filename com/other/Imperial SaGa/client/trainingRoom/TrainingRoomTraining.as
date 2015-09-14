package trainingRoom
{
    import asset.*;
    import button.*;
    import effect.*;
    import enemy.*;
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

    public class TrainingRoomTraining extends Object
    {
        private var _phase:int;
        private var _prevPhase:int;
        private var _mcBase:MovieClip;
        private var _layer:LayerTrainingRoom;
        private var _effectManager:EffectManager;
        private var _isoMain:InStayOut;
        private var _isoPlayerList:InStayOut;
        private var _isoInstantBtn:InStayOut;
        private var _btnReturn:ButtonBase;
        private var _instantBtn:InstantButton;
        private var _cbClose:Function;
        private var _playerList:TrainingRoomPlayerList;
        private var _trainingInfoWindow:TrainingRoomTopInfo;
        private var _userResourceBox:UserResourceBox;
        private var _menu:TrainingRoomTrainingMenu;
        private var _selecter:TrainingRoomSelecter;
        private var _endMessage:TrainingRoomStartSuccessMessage;
        private var _trainingPlayer1:PlayerDisplay;
        private var _trainingPlayer2:PlayerDisplay;
        private var _enemyArray:Array;
        private var _aEnemyWeaponType:Array;
        private var _trainingAction:TrainingRoomTrainingAction;
        private var _aPlayerPersonal:Array;
        private var _bNowTraining:Boolean;
        private var _trainingPersonal:PlayerPersonal;
        private var _trainingEndPersonal:PlayerPersonal;
        private var _bUseInstant:Boolean;
        private var _engagedTrainingData:EngagedTrainingData;
        private var _bTrainingActionWait:Boolean;
        private var _bResourceLoaded:Boolean;
        private var _bJumpTradingPost:Boolean;
        private var _upgradeDisabled:FacilityUpgradeDisabled;
        private static const _TRAINING_ENEMY_ID:Array = [CommonConstant.TRAINING_ENEMY_ID_1, CommonConstant.TRAINING_ENEMY_ID_2, CommonConstant.TRAINING_ENEMY_ID_3, CommonConstant.TRAINING_ENEMY_ID_4, CommonConstant.TRAINING_ENEMY_ID_5, CommonConstant.TRAINING_ENEMY_ID_6, CommonConstant.TRAINING_ENEMY_ID_7, CommonConstant.TRAINING_ENEMY_ID_8, CommonConstant.TRAINING_ENEMY_ID_9, CommonConstant.TRAINING_ENEMY_ID_10];
        private static const _TRAINING_ENEMY_WEAPON_TYPE:Array = [CommonConstant.TRAINING_ENEMY_WEAPON_TYPE_1, CommonConstant.TRAINING_ENEMY_WEAPON_TYPE_2, CommonConstant.TRAINING_ENEMY_WEAPON_TYPE_3, CommonConstant.TRAINING_ENEMY_WEAPON_TYPE_4, CommonConstant.TRAINING_ENEMY_WEAPON_TYPE_5, CommonConstant.TRAINING_ENEMY_WEAPON_TYPE_6, CommonConstant.TRAINING_ENEMY_WEAPON_TYPE_7, CommonConstant.TRAINING_ENEMY_WEAPON_TYPE_8, CommonConstant.TRAINING_ENEMY_WEAPON_TYPE_9, CommonConstant.TRAINING_ENEMY_WEAPON_TYPE_10];
        private static const _PHASE_LOADING:int = 0;
        private static const _PHASE_OPEN_WAIT:int = 1;
        private static const _PHASE_OPEN:int = 2;
        private static const _PHASE_PLAYER_SELECT:int = 3;
        private static const _PHASE_TIME_SELECT:int = 4;
        private static const _PHASE_NEXT_WAIT:int = 5;
        private static const _PHASE_TRINING_NOW:int = 6;
        private static const _PHASE_TRINING_END:int = 7;
        private static const _PHASE_CONNECTING:int = 8;
        private static const _PHASE_POPUP:int = 9;
        private static const _PHASE_CLOSE:int = 10;

        public function TrainingRoomTraining(param1:LayerTrainingRoom, param2:MovieClip, param3:Array, param4:EngagedTrainingData, param5:Function)
        {
            var _loc_7:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            Main.GetProcess().topBar.cbConfigWindow(this.cbConfigWindowOpen, this.cbConfigWindowClose);
            var _loc_6:* = [];
            for each (_loc_7 in _TRAINING_ENEMY_ID)
            {
                
                _loc_10 = EnemyManager.getInstance().getEnemyInformation(_loc_7);
                if (_loc_10 == null)
                {
                    Assert.print("修行の旅の敵IDが正しくない： enemyID=" + _loc_7);
                    break;
                }
                _loc_6.push(EnemyManager.getInstance().getResourcePath(_loc_10.id));
            }
            ResourceManager.getInstance().loadArray(_loc_6);
            this._effectManager = new EffectManager();
            this._layer = param1;
            this._engagedTrainingData = param4;
            this._mcBase = param2;
            this._mcBase.mouseChildren = false;
            this._mcBase.mouseEnabled = false;
            this._layer.getLayer(LayerTrainingRoom.MAIN).addChild(this._mcBase);
            this._cbClose = param5;
            this._isoMain = new InStayOut(this._mcBase);
            this._isoPlayerList = new InStayOut(this._mcBase.charaList1Mc);
            this._isoInstantBtn = new InStayOut(this._mcBase.payBtnTopMc);
            this._btnReturn = ButtonManager.getInstance().addButton(this._mcBase.returnBtnMc, this.cbReturnButton);
            this._btnReturn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcBase.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._instantBtn = new InstantButton(this._mcBase.payBtnTopMc.btnMc, MessageId.TRAINING_ROOM_BUTTON_TRAINING_INSTANT, this.cbInstantButton);
            this._aPlayerPersonal = param3;
            this._bNowTraining = false;
            this._trainingPersonal = null;
            this._trainingEndPersonal = null;
            if (this._engagedTrainingData)
            {
                for each (_loc_11 in this._aPlayerPersonal)
                {
                    
                    if (_loc_11.uniqueId == this._engagedTrainingData.uniqueId)
                    {
                        this._bNowTraining = true;
                        this._trainingPersonal = _loc_11.clone();
                        break;
                    }
                }
            }
            var _loc_8:* = [];
            for each (_loc_9 in this._aPlayerPersonal)
            {
                
                _loc_8.push(new ListPlayerData(_loc_9));
            }
            this._playerList = new TrainingRoomPlayerList(this._mcBase.charaList1Mc.reserveListMc, _loc_8);
            this._playerList.setPlayerSelectCallback(this.cbPlayerSelectFunc);
            this._playerList.setCaptionText(MessageManager.getInstance().getMessage(MessageId.BARRACKS_SOLDIER_LIST_CAPTION));
            this._playerList.setInformationBarMessage(MessageManager.getInstance().getMessage(MessageId.TRAINING_ROOM_TRAINING_PLAYER_LIST_INFORMATION));
            this._playerList.setSelectEnable(false);
            this._playerList.updateList();
            this._trainingPlayer1 = new PlayerDisplay(this._mcBase.traningMenu2Mc.charaNull1, Constant.EMPTY_ID, Constant.EMPTY_ID);
            this._trainingPlayer2 = new PlayerDisplay(this._mcBase.traningMenu2Mc.charaNull2, Constant.EMPTY_ID, Constant.EMPTY_ID);
            this._enemyArray = [];
            this._aEnemyWeaponType = [];
            this._engagedTrainingData = param4;
            this._trainingInfoWindow = new TrainingRoomTopInfo(this._mcBase.trainingInfoTopMc);
            this._userResourceBox = new UserResourceBox(this._mcBase.ItemIconBox, AssetId.ASSET_TRAINING);
            this._menu = new TrainingRoomTrainingMenu(this._mcBase.training2ConfTopMc, this.cbMenuDecide, this.cbMenuReset, this.cbMenuSelect);
            this._selecter = null;
            this._endMessage = null;
            this._bUseInstant = false;
            this._bResourceLoaded = false;
            this._bJumpTradingPost = false;
            this.setGuideText("");
            TextControl.setIdText(this._mcBase.trainingMenuTitleMc.textMc.textDt, MessageId.TRAINING_ROOM_TOP_TRAINING_BUTTON);
            TextControl.setText(this._mcBase.traningMenu2Mc.setCharaNameMc.textDt, "");
            this._mcBase.traningMenu2Mc.setCharaRankMc.visible = false;
            this._upgradeDisabled = new FacilityUpgradeDisabled(this._layer.getLayer(LayerTrainingRoom.POPUP));
            this._phase = _PHASE_CLOSE;
            this.setPhase(_PHASE_LOADING);
            return;
        }// end function

        public function get bOpenWait() : Boolean
        {
            return this._phase == _PHASE_OPEN_WAIT && this._bResourceLoaded;
        }// end function

        public function get bClose() : Boolean
        {
            return this._phase == _PHASE_CLOSE && (this._isoMain && this._isoMain.bClosed) && (this._isoPlayerList && this._isoPlayerList.bClosed);
        }// end function

        public function get bJumpTradingPost() : Boolean
        {
            return this._bJumpTradingPost;
        }// end function

        public function get bAnimation() : Boolean
        {
            return this._phase == _PHASE_OPEN || this._phase == _PHASE_TRINING_END || this._phase == _PHASE_CONNECTING || this._phase == _PHASE_CLOSE;
        }// end function

        private function resourceLoaded() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (ResourceManager.getInstance().isLoaded())
            {
                for each (_loc_1 in _TRAINING_ENEMY_ID)
                {
                    
                    _loc_3 = new EnemyDisplay(this._mcBase.traningMenu2Mc.monsNull, _loc_1, Constant.EMPTY_ID);
                    _loc_3.mc.visible = false;
                    _loc_3.mc.y = _loc_3.mc.y - 300;
                    this._enemyArray.push(_loc_3);
                }
                for each (_loc_2 in _TRAINING_ENEMY_WEAPON_TYPE)
                {
                    
                    this._aEnemyWeaponType.push(PlayerInformation.convertXmlWeaponTypeToCharacterWeaponType(_loc_2));
                }
                this._bResourceLoaded = true;
                this.setPhase(_PHASE_OPEN_WAIT);
            }
            return;
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
            if (this._endMessage)
            {
                this._endMessage.release();
            }
            this._endMessage = null;
            if (this._trainingAction)
            {
                this._trainingAction.release();
            }
            this._trainingAction = null;
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
                case _PHASE_PLAYER_SELECT:
                {
                    this.initPhasePlayerSelect();
                    break;
                }
                case _PHASE_TIME_SELECT:
                {
                    this.initPhaseTimeSelect();
                    break;
                }
                case _PHASE_NEXT_WAIT:
                {
                    this.initPhaseNextWait();
                    break;
                }
                case _PHASE_TRINING_NOW:
                {
                    this.initPhaseTrainingNow();
                    break;
                }
                case _PHASE_TRINING_END:
                {
                    this.initPhaseTrainingEnd();
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
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            this._effectManager.control(param1);
            switch(this._phase)
            {
                case _PHASE_LOADING:
                {
                    this.resourceLoaded();
                    break;
                }
                case _PHASE_TRINING_NOW:
                {
                    this.controlPhaseTrainingNow(param1);
                    break;
                }
                case _PHASE_TRINING_END:
                {
                    this.controlPhaseTrainingEnd(param1);
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.controlPhaseClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._playerList)
            {
                this._playerList.control(param1);
            }
            if (this._trainingInfoWindow)
            {
                this._trainingInfoWindow.control(param1);
            }
            if (this._instantBtn)
            {
                this._instantBtn.control(param1);
            }
            if (this._menu)
            {
                this._menu.control(param1);
            }
            if (this._selecter)
            {
                this._selecter.control(param1);
            }
            if (this._upgradeDisabled)
            {
                this._upgradeDisabled.countControl(param1);
            }
            return;
        }// end function

        private function initPhaseOpenWait() : void
        {
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            return;
        }// end function

        private function initPhaseOpen() : void
        {
            var cbFunc:Function;
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            this._userResourceBox.updateNum();
            if (!this._bNowTraining)
            {
                this.reset();
                cbFunc = function () : void
            {
                if (_isoMain.bOpened && _isoPlayerList.bOpened)
                {
                    setPhase(_PHASE_PLAYER_SELECT);
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
                setPhase(_PHASE_TRINING_NOW);
                return;
            }// end function
            );
                this.setupTrainingNow();
                this._isoInstantBtn.setIn();
            }
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.TRAINING_ROOM_TRAINING_GUIDE_TEXT01));
            return;
        }// end function

        private function initPhasePlayerSelect() : void
        {
            var cbFunc:Function;
            this.reset();
            this._playerList.resetSelect();
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
            if (this._prevPhase == _PHASE_TRINING_NOW || this._prevPhase == _PHASE_TRINING_END)
            {
                this.btnEnable(false);
                this._playerList.setSelectEnable(false);
                this._trainingInfoWindow.close();
                this._userResourceBox.setVisible(true);
                cbFunc = function () : void
            {
                if (_isoMain.bOpened && _isoPlayerList.bOpened)
                {
                    if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_4))
                    {
                        TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_4, function () : void
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
                this._isoMain.setInLabel("back", cbFunc);
                this._isoPlayerList.setIn(cbFunc);
            }
            else if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_1))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_1, function () : void
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
            }
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.TRAINING_ROOM_TRAINING_GUIDE_TEXT01));
            if (this._upgradeDisabled.facilityUpgrade(CommonConstant.FACILITY_ID_TRAINING_ROOM))
            {
                this._playerList.setSelectEnable(false);
                this._playerList.overlayVisible(true);
                this.setGuideText(MessageManager.getInstance().getMessage(MessageId.FACILITY_UPGRADENOW_GUIDE_MESSAGE));
            }
            return;
        }// end function

        private function initPhaseTimeSelect() : void
        {
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            this._menu.btnEnable(false);
            var aOwnSkillData:* = this.getFilteringOwnSkillData(this._trainingPersonal.aOwnSkillData);
            this._selecter = new TrainingRoomSelecter(TrainingRoomSelecter.SELECTER_TYPE_TIME, this._trainingPersonal, aOwnSkillData, this._layer.getLayer(LayerTrainingRoom.POPUP), function () : void
            {
                if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_2))
                {
                    TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_2);
                }
                return;
            }// end function
            , function (param1:int) : void
            {
                _selecter.release();
                _selecter = null;
                if (param1 == Constant.UNDECIDED)
                {
                    setPhase(_menu.selectSkillNum == Constant.UNDECIDED ? (_PHASE_PLAYER_SELECT) : (_PHASE_NEXT_WAIT));
                }
                else
                {
                    _menu.setSelectSkillNum(param1);
                    selectCheck();
                }
                return;
            }// end function
            );
            this.setGuideText(MessageManager.getInstance().getMessage(MessageId.TRAINING_ROOM_TRAINING_GUIDE_TEXT02));
            return;
        }// end function

        private function selectCheck() : void
        {
            if (UserDataManager.getInstance().userData.kumiteResource < TrainingRoomTable.getTrainingResourceNum(this._trainingPersonal, this._menu.selectSkillNum))
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, AssetListManager.getInstance().getAssetLackMessage(AssetId.ASSET_TRAINING), function () : void
            {
                setPhase(_PHASE_PLAYER_SELECT);
                return;
            }// end function
            );
            }
            else
            {
                this.setPhase(_PHASE_NEXT_WAIT);
            }
            return;
        }// end function

        private function initPhaseNextWait() : void
        {
            this.btnEnable(true);
            this._playerList.setSelectEnable(false);
            this._playerList.overlayVisible(true);
            this._menu.setTraineePersonal(this._trainingPersonal);
            this._menu.setEnableDecideButton(this._menu.selectSkillNum != Constant.UNDECIDED);
            this._menu.btnEnable(true);
            if (this._trainingPlayer1.uniqueId != this._trainingPersonal.uniqueId)
            {
                this._trainingPlayer1.setId(this._trainingPersonal.playerId, this._trainingPersonal.uniqueId);
            }
            this.cbMenuDecide();
            return;
        }// end function

        private function initPhaseTrainingNow() : void
        {
            this._trainingPlayer2.setId(this._trainingPersonal.playerId, this._trainingPersonal.uniqueId);
            if (this._trainingAction == null)
            {
                this._trainingAction = new TrainingRoomTrainingAction(this._layer, this._mcBase, this._trainingPlayer2, this._enemyArray, this._aEnemyWeaponType, this._effectManager);
                this._trainingAction.getResources();
            }
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            if (this._prevPhase == _PHASE_TRINING_NOW)
            {
                this.btnEnable(true);
                return;
            }
            var actionFunc:* = function () : void
            {
                if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_3))
                {
                    TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_3, function () : void
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
            if (this._prevPhase == _PHASE_NEXT_WAIT)
            {
                this._isoPlayerList.setOut();
                this._isoMain.setInLabel("out1", actionFunc);
                this.setupTrainingNow();
                this._isoInstantBtn.setIn(function () : void
            {
                if (_phase == _PHASE_TRINING_NOW)
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
            if (this._trainingInfoWindow.bTimeOver == false)
            {
                this.btnEnable(true);
            }
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_4))
            {
                this._instantBtn.setLearning(0);
                this._instantBtn.setEndTime(uint.MAX_VALUE);
            }
            return;
        }// end function

        private function controlPhaseTrainingNow(param1:Number) : void
        {
            if (ResourceManager.getInstance().isLoaded() == false)
            {
                return;
            }
            if (this._instantBtn && this._engagedTrainingData)
            {
                this._instantBtn.setLearning(TrainingRoomTable.getTrainingInstantLearningNum(this._engagedTrainingData.endTime, TimeClock.getNowTime()));
            }
            if (this._trainingAction)
            {
                this._trainingAction.controlAction(param1);
            }
            if (!this._bTrainingActionWait)
            {
                if (!this._bUseInstant && this._trainingInfoWindow.bTimeOver)
                {
                    NetManager.getInstance().request(new NetTaskTrainingRoomTrainingEnd(false, 0, this.cbConnectTrainingRoomTrainingEnd));
                    this.setPhase(_PHASE_CONNECTING);
                }
            }
            return;
        }// end function

        private function initPhaseTrainingEnd() : void
        {
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            if (this._isoInstantBtn.bOpened)
            {
                this._isoInstantBtn.setOut();
            }
            this.hideEnemy();
            this._bTrainingActionWait = true;
            this._trainingPlayer2.setAnimationWithCallback(PlayerDisplay.LABEL_JUMP, function () : void
            {
                _trainingPlayer2.setAnimationWithCallback(PlayerDisplay.LABEL_ACTION_SELECT_START, function () : void
                {
                    _bTrainingActionWait = false;
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        private function controlPhaseTrainingEnd(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (!this._bTrainingActionWait)
            {
                if (this._endMessage == null)
                {
                    _loc_2 = [];
                    for each (_loc_3 in this._trainingPersonal.aOwnSkillData)
                    {
                        
                        for each (_loc_4 in this._trainingEndPersonal.aOwnSkillData)
                        {
                            
                            if (_loc_3.skillId == _loc_4.skillId)
                            {
                                _loc_5 = _loc_3.spTotal;
                                _loc_6 = _loc_4.spTotal;
                                if (_loc_5 != _loc_6)
                                {
                                    _loc_2.push(new TrainingSkillParamChange(_loc_4.skillId, 0, 0, 0, 0, _loc_5, _loc_6 - _loc_5, true));
                                }
                                break;
                            }
                        }
                    }
                    this._endMessage = new TrainingRoomStartSuccessMessage(TrainingRoomStartSuccessMessage.MESSAGE_TYPE_SUCCESS, TrainingRoomStartSuccessMessage.MESSAGE_SUBTYPE_TRAINING, this._layer.getLayer(LayerTrainingRoom.POPUP), _loc_2, this.cbEndMessageClose);
                }
            }
            return;
        }// end function

        private function initPhaseConnecting() : void
        {
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            this._menu.btnEnable(false);
            return;
        }// end function

        private function initPhasePopup() : void
        {
            this.btnEnable(false);
            this._playerList.setSelectEnable(false);
            this._menu.btnEnable(false);
            return;
        }// end function

        private function initPhaseClose() : void
        {
            Main.GetProcess().topBar.cbConfigWindow(null, null);
            this.btnEnable(false);
            this._upgradeDisabled.close();
            this._playerList.setSelectEnable(false);
            this._menu.btnEnable(false);
            if (this._prevPhase == _PHASE_TRINING_NOW)
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
                this.hideEnemy();
                if (this._cbClose != null)
                {
                    this._cbClose(this._engagedTrainingData);
                }
                this.setPhase(_PHASE_OPEN_WAIT);
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

        private function setupTrainingNow() : void
        {
            var _loc_1:* = TrainingRoomTable.getTrainingTimeSec(this._trainingPersonal, this._engagedTrainingData.trainingType);
            var _loc_2:* = TimeClock.getNowTime();
            this._trainingInfoWindow.setData(null, MessageManager.getInstance().getMessage(MessageId.TRAINING_ROOM_SELECTER_TIME_TRAINING_TIME), _loc_2, this._engagedTrainingData.endTime, _loc_1, TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_4));
            this._trainingInfoWindow.open();
            this._userResourceBox.setVisible(false);
            this._trainingPlayer1.mc.visible = false;
            this._trainingPlayer2.setId(this._trainingPersonal.playerId, this._trainingPersonal.uniqueId);
            this._trainingPlayer2.setAnimation(PlayerDisplay.LABEL_SIDE_WALK);
            this._trainingPlayer2.mc.visible = true;
            TextControl.setText(this._mcBase.traningMenu2Mc.setCharaNameMc.textDt, this._trainingPlayer2.info.name);
            this._mcBase.traningMenu2Mc.setCharaRankMc.visible = true;
            var _loc_3:* = new PlayerRarityIcon(this._mcBase.traningMenu2Mc.setCharaRankMc, this._trainingPlayer2.info.rarity);
            this._instantBtn.setLearning(TrainingRoomTable.getTrainingInstantLearningNum(this._engagedTrainingData.endTime, _loc_2));
            this._instantBtn.setEndTime(this._engagedTrainingData.endTime);
            return;
        }// end function

        private function reset() : void
        {
            this._trainingPlayer1.setId(Constant.EMPTY_ID, Constant.EMPTY_ID);
            this._trainingPlayer2.setId(Constant.EMPTY_ID, Constant.EMPTY_ID);
            TextControl.setText(this._mcBase.traningMenu2Mc.setCharaNameMc.textDt, "");
            this._mcBase.traningMenu2Mc.setCharaRankMc.visible = false;
            this._trainingPersonal = null;
            this._trainingEndPersonal = null;
            this._playerList.resetSelect();
            return;
        }// end function

        private function getFilteringOwnSkillData(param1:Array) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in param1)
            {
                
                _loc_4 = SkillManager.getInstance().getSkillInformation(_loc_3.skillId);
                if (_loc_4 && _loc_4.bTrainingPossible)
                {
                    if (_loc_3.isSpMinLimit() == false)
                    {
                        _loc_2.push(_loc_3);
                    }
                }
            }
            return _loc_2;
        }// end function

        private function hideEnemy() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._enemyArray)
            {
                
                _loc_1.mc.visible = false;
            }
            if (this._trainingAction)
            {
                this._trainingAction.release();
            }
            this._trainingAction = null;
            return;
        }// end function

        private function cbReturnButton(param1:int) : void
        {
            if (this._phase == _PHASE_PLAYER_SELECT || this._phase == _PHASE_TIME_SELECT)
            {
                this.reset();
            }
            this._upgradeDisabled.close();
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbInstantButton(param1:int) : void
        {
            var numCost:int;
            var instantLearningItemNum:int;
            var id:* = param1;
            numCost = TrainingRoomTable.getTrainingInstantLearningNum(this._engagedTrainingData.endTime, TimeClock.getNowTime());
            var executeTrainingFunc:* = function () : void
            {
                if (_instantBtn.bEnableTime == false)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CONFIRM_ALREADY_USE_ITEM_JEWEL), function () : void
                {
                    setPhase(_PHASE_TRINING_NOW);
                    return;
                }// end function
                );
                    return;
                }
                _bUseInstant = true;
                NetManager.getInstance().request(new NetTaskTrainingRoomTrainingEnd(true, numCost, cbConnectTrainingRoomTrainingEnd));
                setPhase(_PHASE_CONNECTING);
                return;
            }// end function
            ;
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_4))
            {
                numCost;
                TutorialManager.getInstance().hideTutorial();
                this.executeTrainingFunc();
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
                    executeTrainingFunc();
                }
                else
                {
                    setPhase(_PHASE_TRINING_NOW);
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
                    setPhase(_PHASE_TRINING_NOW);
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
            if (this._phase != _PHASE_PLAYER_SELECT)
            {
                return;
            }
            this._trainingPersonal = param2.personal;
            this.setPhase(_PHASE_TIME_SELECT);
            return;
        }// end function

        private function cbMenuDecide() : void
        {
            var trainingSec:uint;
            var sec:int;
            var min:int;
            var hour:int;
            var ResourceNum:int;
            if (this._phase == _PHASE_NEXT_WAIT)
            {
                if (this._trainingPersonal.aOwnSkillData.length <= 0)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.TRAINING_ROOM_TRAINING_NOT_OWN_SKILL, this._trainingPlayer1.info.name), function () : void
            {
                cbMenuReset();
                return;
            }// end function
            );
                }
                else if (UserDataManager.getInstance().userData.kumiteResource < TrainingRoomTable.getTrainingResourceNum(this._trainingPersonal, this._menu.selectSkillNum))
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, AssetListManager.getInstance().getAssetLackMessage(AssetId.ASSET_TRAINING), function () : void
            {
                cbMenuReset();
                return;
            }// end function
            );
                }
                else
                {
                    trainingSec = TrainingRoomTable.getTrainingTimeSec(this._trainingPersonal, this._menu.selectSkillNum);
                    sec = trainingSec % 60;
                    min = trainingSec / 60 % 60;
                    hour = trainingSec / 60 / 60;
                    ResourceNum = TrainingRoomTable.getTrainingResourceNum(this._trainingPersonal, this._menu.selectSkillNum);
                    CommonPopup.getInstance().openConsumePopup(CommonPopup.POPUP_TYPE_NORMAL, AssetId.ASSET_TRAINING, TextControl.formatIdText(MessageId.TRAINING_ROOM_TRAINING_START_CONFIRM, this._trainingPlayer1.info.name, ResourceNum, hour < 10 ? ("0" + hour.toString()) : (hour), min < 10 ? ("0" + min.toString()) : (min), sec < 10 ? ("0" + sec.toString()) : (sec), this._menu.selectSkillNum.toString(), TrainingRoomTable.getReduceSpText()), function (param1:Boolean) : void
            {
                if (param1)
                {
                    _bUseInstant = false;
                    _engagedTrainingData = new EngagedTrainingData();
                    _engagedTrainingData.uniqueId = _trainingPlayer1.uniqueId;
                    _engagedTrainingData.trainingType = _menu.selectSkillNum;
                    NetManager.getInstance().request(new NetTaskTrainingRoomTraining(_trainingPlayer1.uniqueId, _menu.selectSkillNum, TrainingRoomTable.getTrainingResourceNum(_trainingPersonal, _menu.selectSkillNum), cbConnectTrainingRoomTraining));
                    setPhase(_PHASE_CONNECTING);
                }
                else
                {
                    cbMenuReset();
                }
                return;
            }// end function
            );
                }
                this.setPhase(_PHASE_POPUP);
            }
            return;
        }// end function

        private function cbMenuReset() : void
        {
            this._trainingPlayer1.setId(Constant.EMPTY_ID, Constant.EMPTY_ID);
            this._playerList.resetSelect();
            this.setPhase(_PHASE_PLAYER_SELECT);
            return;
        }// end function

        private function cbMenuSelect() : void
        {
            if (this._phase != _PHASE_NEXT_WAIT)
            {
                return;
            }
            this.setPhase(_PHASE_TIME_SELECT);
            return;
        }// end function

        private function cbConnectTrainingRoomTraining(param1:NetResult) : void
        {
            this._trainingPersonal = new PlayerPersonal();
            this._trainingPersonal.setParameter(param1.data.playerPersonal);
            this._engagedTrainingData.endTime = param1.data.institutionNotice.time;
            this._engagedTrainingData.noticeId = param1.data.institutionNotice.uniqueId;
            var _loc_2:* = UserDataManager.getInstance().userData;
            var _loc_3:* = _loc_2.aPlayerPersonal;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                if (_loc_3[_loc_4].uniqueId == this._trainingPersonal.uniqueId)
                {
                    (_loc_3[_loc_4] as PlayerPersonal).copyParam(this._trainingPersonal);
                    break;
                }
                _loc_4++;
            }
            _loc_2.setOwnPlayer(_loc_3);
            var _loc_5:* = this._trainingPersonal;
            _loc_4 = 0;
            while (_loc_4 < this._aPlayerPersonal.length)
            {
                
                if (this._aPlayerPersonal[_loc_4].uniqueId == this._trainingPersonal.uniqueId)
                {
                    _loc_5 = this._aPlayerPersonal[_loc_4] as PlayerPersonal;
                    _loc_5.copyParam(this._trainingPersonal);
                    break;
                }
                _loc_4++;
            }
            var _loc_6:* = new ListPlayerData(_loc_5);
            this._playerList.removePlayer(_loc_5.uniqueId);
            this._playerList.addPlayer(_loc_6);
            this._playerList.addNotDisplayPlayer(_loc_5.uniqueId);
            this._playerList.updateList();
            this._userResourceBox.updateNum();
            NoticeManager.getInstance().addMiniNoticeByObject(param1.data.institutionNotice);
            this._bNowTraining = true;
            this.setPhase(_PHASE_TRINING_NOW);
            return;
        }// end function

        private function cbConnectTrainingRoomTrainingEnd(param1:NetResult) : void
        {
            var res:* = param1;
            if (res.data.alreadyEnd == 1)
            {
                this._bUseInstant = false;
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CONFIRM_ALREADY_USE_ITEM_JEWEL), function () : void
            {
                setPhase(_PHASE_TRINING_NOW);
                return;
            }// end function
            );
                return;
            }
            this._trainingEndPersonal = new PlayerPersonal();
            this._trainingEndPersonal.setParameter(res.data.playerPersonal);
            this._engagedTrainingData = null;
            var userData:* = UserDataManager.getInstance().userData;
            var aPlayerPersonal:* = userData.aPlayerPersonal;
            var i:int;
            while (i < aPlayerPersonal.length)
            {
                
                if (aPlayerPersonal[i].uniqueId == this._trainingEndPersonal.uniqueId)
                {
                    (aPlayerPersonal[i] as PlayerPersonal).copyParam(this._trainingEndPersonal);
                    break;
                }
                i = (i + 1);
            }
            userData.setOwnPlayer(aPlayerPersonal);
            var listPersonal:* = this._trainingEndPersonal;
            i;
            while (i < this._aPlayerPersonal.length)
            {
                
                if (this._aPlayerPersonal[i].uniqueId == this._trainingEndPersonal.uniqueId)
                {
                    listPersonal = this._aPlayerPersonal[i] as PlayerPersonal;
                    listPersonal.copyParam(this._trainingEndPersonal);
                    break;
                }
                i = (i + 1);
            }
            var listPlayerData:* = new ListPlayerData(listPersonal);
            this._playerList.removePlayer(listPersonal.uniqueId);
            this._playerList.addPlayer(listPlayerData);
            if (this.getFilteringOwnSkillData(listPersonal.aOwnSkillData).length > 0)
            {
                this._playerList.removeNotDisplayPlayer(listPersonal.uniqueId);
            }
            this._playerList.updateList();
            this._trainingInfoWindow.instantEnd();
            NoticeManager.getInstance().crearSimpleNoticeById(res.data.institutionNoticeId);
            this._bNowTraining = true;
            this.setPhase(_PHASE_TRINING_END);
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
            this.reset();
            this.setPhase(_PHASE_PLAYER_SELECT);
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
