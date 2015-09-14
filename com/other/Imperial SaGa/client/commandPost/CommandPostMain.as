package commandPost
{
    import barracks.*;
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import formation.*;
    import formationSettings.*;
    import layer.*;
    import message.*;
    import network.*;
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

    public class CommandPostMain extends Object
    {
        private var _phase:int;
        private var _parent:DisplayObjectContainer;
        private var _layer:LayerCommandPost;
        private var _isoMain:InStayOut;
        private var _isoCarpet:InStayOut;
        private var _mcBase:MovieClip;
        private var _mcFormationBase:MovieClip;
        private var _user:UserDataPersonal;
        private var _formationSettings:FormationSettings;
        private var _playerList:CommandPostPlayerList;
        private var _simpleStatus:PlayerSimpleStatus;
        private var _aPlayerPersonal:Array;
        private var _aChangedEquipmentPlayerUniqueId:Array;
        private var _restFinishedPopup:BarracksRestFinishedPopup;
        private var _aRestPlayerUniqueId:Array;
        private var _decideButton:ButtonBase;
        private var _closeButton:ButtonBase;
        private var _retireButton:ButtonBase;
        private var _reserveButton:ButtonBase;
        private var _bUpdate:Boolean;
        private var _statusResult:PlayerDetailStatusResult;
        private var _timeCount:Number;
        private var _aChangeSetIcon:Array;
        private var _bShowChangeSetIcon:Boolean;
        private var _nextProcessId:int;
        private static const _PHASE_NONE:int = 0;
        private static const _PHASE_LOADING:int = 1;
        private static const _PHASE_OPEN:int = 2;
        private static const _PHASE_MAIN:int = 3;
        private static const _PHASE_CLOSE:int = 4;
        private static const _PHASE_END:int = 5;
        private static const _PHASE_CONNECTION_SET:int = 10;
        private static const _PHASE_MAINTENANCE:int = 90;
        private static const _SIMPLE_STATUS_DISPLAY_POSITION_X:int = 773;
        private static const _SIMPLE_STATUS_DISPLAY_POSITION_Y_MIN:int = 220;
        private static const _SIMPLE_STATUS_DISPLAY_POSITION_Y_MAX:int = 340;
        private static var _sortId:int = 0;
        private static const _RESTING_CHECK_INTERVAL_SECOND:int = 10;

        public function CommandPostMain(param1:DisplayObjectContainer)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._parent = param1;
            this._layer = null;
            this._nextProcessId = ProcessMain.PROCESS_HOME;
            Main.GetProcess().topBar.cbConfigWindow(this.cbConfigWindowOpen, this.cbConfigWindowClose);
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.FORMATION_PATH + "UI_Formation.swf");
            if (UserDataManager.getInstance().userData.checkBarracksUse())
            {
                ResourceManager.getInstance().loadResource(ResourcePath.FACILITY_PATH + "UI_Barracks.swf");
            }
            CommandPostPlayerList.loadResource();
            FormationSettings.loadResource();
            CommonPopup.getInstance().loadResource();
            TutorialManager.getInstance().loadResource();
            SoundManager.getInstance().loadSound(SoundId.BGM_MYP_QSTART);
            SoundManager.getInstance().loadSoundArray([SoundId.SE_CHARA_SELECT, SoundId.SE_COMPOSE_SUCSESS, SoundId.SE_JUMP2]);
            this._user = UserDataManager.getInstance().userData;
            this._aPlayerPersonal = [];
            for each (_loc_2 in this._user.aPlayerPersonal)
            {
                
                this._aPlayerPersonal.push(_loc_2.clone());
                _loc_3 = PlayerManager.getInstance().getPlayerInformation(_loc_2.playerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_3.swf);
            }
            this._aChangedEquipmentPlayerUniqueId = [];
            this._bUpdate = false;
            this._statusResult = new PlayerDetailStatusResult();
            this._timeCount = 0;
            this.setPhase(_PHASE_LOADING);
            return;
        }// end function

        public function isBusy() : Boolean
        {
            return this._phase != _PHASE_MAIN;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain && this._isoMain.bClosed && (this._isoCarpet && this._isoCarpet.bClosed);
        }// end function

        public function get nextProcessId() : int
        {
            return this._nextProcessId;
        }// end function

        public function get bStay() : Boolean
        {
            return this._phase != _PHASE_OPEN && this._phase != _PHASE_CLOSE && (this._isoMain && this._isoMain.bAnimetion == false);
        }// end function

        private function resourceLoaded() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            this._layer = new LayerCommandPost();
            this._parent.addChild(this._layer);
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.FORMATION_PATH + "UI_Formation.swf", "FormatinMainMc");
            this._layer.getLayer(LayerCommandPost.MAIN).addChild(this._mcBase);
            this._mcFormationBase = this._mcBase.organizationMoveMc;
            if (this._mcFormationBase.emperorCharaMc)
            {
                this._mcFormationBase.emperorCharaMc.visible = false;
            }
            this._formationSettings = new FormationSettings(this._mcFormationBase.formationListMc, this._mcFormationBase.formationMc.formationNull, this._mcFormationBase.formationInfoMc, this._mcFormationBase.formationSkillInfoMc, this._mcFormationBase.commanderSkillSet, this._user.formationId, this._aPlayerPersonal, this._user.aFormationPlayerUniqueId, true, ResourcePath.FORMATION_PATH + "UI_Formation.swf", true);
            this._formationSettings.cbFormationChangedFunc = this.cbFormationChanged;
            this._formationSettings.cbFormationPositionSelectedFunc = this.cbFormationPositionSelected;
            this._formationSettings.cbFormationPlayerOverFunc = this.cbFormationPlayerOver;
            this._formationSettings.cbFormationPlayerOutFunc = this.cbFormationPlayerOut;
            this._formationSettings.cbFormationPositionChangedFunc = this.cbFormationPositionChanged;
            this._formationSettings.setStatusInvisibleFlag(PlayerMiniStatus.INVISIBLE_FLAG_NAME | PlayerMiniStatus.INVISIBLE_FLAG_PICKUP_PARAM);
            this._formationSettings.updateFormation();
            this._simpleStatus = new PlayerSimpleStatus(this._layer.getLayer(LayerCommandPost.MAIN), PlayerSimpleStatus.LABEL_MAIN);
            this._simpleStatus.setEnablePlayerDetail(this.cbDetail, null, false);
            this._simpleStatus.hide();
            var _loc_1:* = [];
            for each (_loc_2 in this._aPlayerPersonal)
            {
                
                _loc_1.push(new CommandPostListPlayerData(_loc_2));
            }
            this._playerList = new CommandPostPlayerList(this._mcFormationBase.reserveListMc, _loc_1, _sortId);
            this._playerList.setCaptionText(MessageManager.getInstance().getMessage(MessageId.FORMATION_SUBMEMBER));
            this._playerList.setNotDisplayPlayer(this._formationSettings.aFormationPlayerUniqueId);
            this._playerList.setPlayerSelectCallback(this.cbReservePlayerSelectFunc);
            this._playerList.setPlayerUnselectCallback(this.cbReservePlayerUnselectFunc);
            this._playerList.setDetailBtnCallback(this.cbDetail);
            this._playerList.setChangeSortCallback(this.cbSort);
            this._playerList.updateList();
            this._isoMain = new InStayOut(this._mcFormationBase);
            this._isoCarpet = new InStayOut(this._mcBase.RollMove);
            this._decideButton = ButtonManager.getInstance().addButton(this._mcFormationBase.decisionBtnMc, this.cbDecide);
            this._decideButton.setDisable(true);
            this._decideButton.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcFormationBase.decisionBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_DECIDE);
            this._closeButton = ButtonManager.getInstance().addButton(this._mcFormationBase.returnBtnMc, this.cbCloseBtn);
            this._closeButton.setDisable(true);
            this._closeButton.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcFormationBase.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._retireButton = ButtonManager.getInstance().addButton(this._mcFormationBase.retreatBtnMc, this.cbRetireBtn);
            this._retireButton.setDisable(true);
            this._retireButton.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcFormationBase.retreatBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_GOTO_RETIREMENT);
            this._aChangeSetIcon = [];
            _loc_5 = this._formationSettings.isCommanderEnable() ? (FormationSetData.FORMATION_INDEX_COMMANDER) : (FormationSetData.FORMATION_INDEX_POSITION_5);
            var _loc_6:* = FormationSetData.FORMATION_INDEX_POSITION_1;
            while (_loc_6 <= _loc_5)
            {
                
                _loc_3 = new FormationChangeSetIcon(this._layer.getLayer(LayerCommandPost.MAIN), FormationChangeSetIcon.TYPE_CHANGE);
                _loc_4 = this._formationSettings.getFormationPosition(_loc_6);
                _loc_3.setPosition(_loc_4.x, _loc_4.y);
                _loc_3.hide();
                this._aChangeSetIcon.push(_loc_3);
                _loc_6++;
            }
            this._bShowChangeSetIcon = false;
            var _loc_7:* = ResourceManager.getInstance().createMovieClip(ResourcePath.FORMATION_PATH + "UI_Formation.swf", "ReserveMoveBtn");
            TextControl.setIdText(_loc_7.textMc.textDt, MessageId.FORMATION_RESERVE_BUTTON);
            this._layer.getLayer(LayerCommandPost.MAIN).addChild(_loc_7);
            this._reserveButton = new ButtonBase(_loc_7, this.cbReserveFunc);
            this._reserveButton.enterSeId = Constant.UNDECIDED;
            ButtonManager.getInstance().addButtonBase(this._reserveButton);
            this._reserveButton.getMoveClip().visible = false;
            this._reserveButton.setDisableFlag(true);
            if (SoundManager.getInstance().bgmId != SoundId.BGM_MYP_QSTART)
            {
                SoundManager.getInstance().playBgm(SoundId.BGM_MYP_QSTART);
            }
            BarracksAutoRestManager.getInstance().updateCheckPlayer();
            BarracksAutoRestManager.getInstance().addCbRest(this.cbRestEnd);
            this._restFinishedPopup = null;
            this._aRestPlayerUniqueId = [];
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function release() : void
        {
            BarracksAutoRestManager.getInstance().delCbRest(this.cbRestEnd);
            this._aRestPlayerUniqueId = null;
            if (this._restFinishedPopup)
            {
                this._restFinishedPopup.release();
            }
            this._restFinishedPopup = null;
            this._statusResult = null;
            if (this._retireButton)
            {
                ButtonManager.getInstance().removeButton(this._retireButton);
            }
            ButtonManager.getInstance().removeButton(this._closeButton);
            ButtonManager.getInstance().removeButton(this._decideButton);
            ButtonManager.getInstance().removeButton(this._reserveButton);
            this._retireButton = null;
            this._closeButton = null;
            this._decideButton = null;
            this._reserveButton = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._isoCarpet)
            {
                this._isoCarpet.release();
            }
            this._isoCarpet = null;
            if (this._formationSettings)
            {
                this._formationSettings.release();
            }
            this._formationSettings = null;
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
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            if (this._layer)
            {
                this._layer.release();
            }
            this._layer = null;
            TutorialManager.getInstance().release();
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_OPEN:
                {
                    this.phaseOpen();
                    break;
                }
                case _PHASE_MAIN:
                {
                    this.phaseMain();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.phaseClose();
                    break;
                }
                case _PHASE_CONNECTION_SET:
                {
                    this.phaseConnectionSet();
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
            BarracksAutoRestManager.getInstance().control(param1);
            if (this._restFinishedPopup)
            {
                if (this._restFinishedPopup.bClose)
                {
                    this._restFinishedPopup.release();
                    this._restFinishedPopup = null;
                }
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
                    break;
                }
            }
            if (this._formationSettings)
            {
                this._formationSettings.control(param1);
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._formationSettings.setSelectEnable(false);
            this._playerList.setPlayerSelectEnable(false);
            this._playerList.setPageDisable(true);
            this._isoCarpet.setIn(function () : void
            {
                _isoMain.setIn(function () : void
                {
                    setPhase(_PHASE_MAINTENANCE);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        private function controlOpen() : void
        {
            return;
        }// end function

        private function phaseMain() : void
        {
            if (this._retireButton)
            {
                this._retireButton.setDisable(false);
            }
            this._closeButton.setDisable(false);
            this._formationSettings.setSelectEnable(true);
            this._playerList.setPlayerSelectEnable(true);
            this._playerList.setPageDisable(false);
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_COMMAND_POST_1))
            {
                ButtonManager.getInstance().seal([], true);
                this._playerList.setSelectEnable(false);
                this._formationSettings.setSelectEnable(false);
                TutorialManager.getInstance().stepReset();
                TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_COMMAND_POST_1, function () : void
            {
                _playerList.setSelectEnable(true);
                _formationSettings.setSelectEnable(true);
                TutorialManager.getInstance().stepChange(0);
                return;
            }// end function
            );
            }
            if (CommanderSkillUtility.isUnlockCommander() && TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_COMMAND_POST_COMMANDER))
            {
                this._playerList.setSelectEnable(false);
                this._formationSettings.setSelectEnable(false);
                with ({})
                {
                    {}.cbClose = function () : void
            {
                _playerList.setSelectEnable(true);
                _formationSettings.setSelectEnable(true);
                return;
            }// end function
            ;
                }
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_COMMAND_POST_COMMANDER, function () : void
            {
                _playerList.setSelectEnable(true);
                _formationSettings.setSelectEnable(true);
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function controlMain(param1:Number) : void
        {
            var pos:Point;
            var t:* = param1;
            this._timeCount = this._timeCount + t;
            if (this._timeCount >= _RESTING_CHECK_INTERVAL_SECOND)
            {
                this._timeCount = 0;
                this._formationSettings.updatePlayerUseFacilityStatus();
                this._playerList.updatePlayerUseFacilityStatus();
            }
            if (!CommonPopup.isUse() && TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_COMMAND_POST_2))
            {
                if (TutorialManager.getInstance().isStepChange())
                {
                    switch(TutorialManager.getInstance().step)
                    {
                        case 0:
                        {
                            pos = this._playerList.getPlayerPosition(0);
                            pos.y = pos.y - 16;
                            TutorialManager.getInstance().setTutorialArrowPos(pos);
                            TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_COMMAND_POST_001), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
                            break;
                        }
                        case 1:
                        {
                            pos = this._formationSettings.getFormationPosition(4);
                            TutorialManager.getInstance().setTutorialArrowPos(pos);
                            TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_COMMAND_POST_002), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
                            break;
                        }
                        case 2:
                        {
                            ButtonManager.getInstance().unseal();
                            ButtonManager.getInstance().seal([this._decideButton], true);
                            TutorialManager.getInstance().setTutorialArrow(this._decideButton.getMoveClip());
                            TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_COMMAND_POST_003), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            if (this._phase == _PHASE_MAIN)
            {
                BarracksAutoRestManager.getInstance().autoRest();
                if (this._aRestPlayerUniqueId.length > 0)
                {
                    if (CommonPopup.isUse() == false && Main.GetProcess().topBar.bConfigWindowOpend == false && this._mcBase.visible)
                    {
                        if (this._restFinishedPopup == null)
                        {
                            this._restFinishedPopup = new BarracksRestFinishedPopup(this._layer.getLayer(LayerCommandPost.EFFECT), function () : void
            {
                return;
            }// end function
            );
                            this.setRestEndAction();
                        }
                    }
                }
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            Main.GetProcess().topBar.cbConfigWindow(null, null);
            if (this._user.isNewFormation())
            {
                this._user.checkedNewFormation();
                NetManager.getInstance().request(new NetTaskNewFormationCheck(function () : void
            {
                return;
            }// end function
            ));
            }
            this.setAllBtnEnable(false);
            this._formationSettings.setSelectEnable(false);
            this._playerList.setSelectEnable(false);
            this.unselect();
            if (this._nextProcessId == ProcessMain.PROCESS_TRADING_POST)
            {
                TradingPostStartPageRequest.getInstance().setRequestGrowthReset();
            }
            this._isoMain.setOut(function () : void
            {
                _isoCarpet.setOut(function () : void
                {
                    setPhase(_PHASE_END);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function phaseConnectionSet() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            this.setAllBtnEnable(false);
            this._playerList.setPlayerSelectEnable(false);
            this._formationSettings.setSelectEnable(false);
            var _loc_1:* = new FormationSetData(this._formationSettings.selectedFormationId, this._formationSettings.aFormationPlayerUniqueId);
            var _loc_2:* = [];
            for each (_loc_3 in this._aChangedEquipmentPlayerUniqueId)
            {
                
                _loc_4 = new Object();
                for each (_loc_5 in this._aPlayerPersonal)
                {
                    
                    if (_loc_5.uniqueId == _loc_3)
                    {
                        _loc_4.uniqueId = _loc_3;
                        _loc_4.aSkill = _loc_5.aSetSkillId;
                        _loc_4.aItem = _loc_5.aSetItemId;
                        break;
                    }
                }
                _loc_2.push(_loc_4);
            }
            NetManager.getInstance().request(new NetTaskFormationSet(_loc_1, _loc_2, this.cbConnect));
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

        private function setAllBtnEnable(param1:Boolean) : void
        {
            this._decideButton.setDisableFlag(!param1);
            this._closeButton.setDisableFlag(!param1);
            if (this._retireButton)
            {
                this._retireButton.setDisableFlag(!param1);
            }
            this._reserveButton.setDisableFlag(!param1);
            if (param1)
            {
                this._decideButton.setDisable(!this.isPossibleUpdate());
            }
            return;
        }// end function

        private function isPossibleUpdate() : Boolean
        {
            if (this._formationSettings.isEmptyFormation())
            {
                return false;
            }
            return this._bUpdate;
        }// end function

        private function showChangeSetIcon(param1:PlayerPersonal) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._bShowChangeSetIcon = true;
            var _loc_2:* = this._formationSettings.selectedFormationMemberMax;
            var _loc_3:* = 0;
            while (_loc_3 < 5)
            {
                
                _loc_5 = this._aChangeSetIcon[_loc_3];
                if (_loc_3 >= _loc_2 || _loc_3 == this._formationSettings.selectedFormationIndex)
                {
                    _loc_5.hide();
                }
                else
                {
                    _loc_6 = this._formationSettings.getPersonalAtFormationIndex(_loc_3);
                    if (FormationSetData.FORMATION_INDEX_COMMANDER == this._formationSettings.selectedFormationIndex)
                    {
                        this.setupChangeSetIconType(_loc_5, this._formationSettings.getFormationPosition(_loc_3), _loc_6, _loc_6 == null ? (true) : (_loc_6.hasCommanderSkill()));
                    }
                    else
                    {
                        this.setupChangeSetIconType(_loc_5, this._formationSettings.getFormationPosition(_loc_3), _loc_6, true);
                    }
                    if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_COMMAND_POST_2))
                    {
                        if (_loc_6)
                        {
                            _loc_5.hide();
                        }
                    }
                }
                _loc_3++;
            }
            var _loc_4:* = this._aChangeSetIcon[FormationSetData.FORMATION_INDEX_COMMANDER];
            if (this._aChangeSetIcon[FormationSetData.FORMATION_INDEX_COMMANDER])
            {
                if (FormationSetData.FORMATION_INDEX_COMMANDER == this._formationSettings.selectedFormationIndex)
                {
                    _loc_4.hide();
                }
                else
                {
                    _loc_7 = this._formationSettings.getPersonalAtFormationIndex(FormationSetData.FORMATION_INDEX_COMMANDER);
                    this.setupChangeSetIconTypeCommander(_loc_4, this._formationSettings.getFormationPosition(FormationSetData.FORMATION_INDEX_COMMANDER), _loc_7, param1.hasCommanderSkill());
                }
            }
            return;
        }// end function

        private function setupChangeSetIconType(param1:FormationChangeSetIcon, param2:Point, param3:PlayerPersonal, param4:Boolean = true) : void
        {
            param1.setPosition(param2.x, param2.y);
            if (param4 == false)
            {
                param1.setType(param3 != null ? (FormationChangeSetIcon.TYPE_CHANGE_NOT) : (FormationChangeSetIcon.TYPE_SET));
            }
            else
            {
                param1.setType(param3 != null ? (FormationChangeSetIcon.TYPE_CHANGE) : (FormationChangeSetIcon.TYPE_SET));
            }
            return;
        }// end function

        private function setupChangeSetIconTypeCommander(param1:FormationChangeSetIcon, param2:Point, param3:PlayerPersonal, param4:Boolean) : void
        {
            param1.setPosition(param2.x, param2.y);
            if (param4 == false)
            {
                param1.setType(param3 != null ? (FormationChangeSetIcon.TYPE_CHANGE_NOT) : (FormationChangeSetIcon.TYPE_SET_NOT));
            }
            else
            {
                param1.setType(param3 != null ? (FormationChangeSetIcon.TYPE_CHANGE) : (FormationChangeSetIcon.TYPE_SET));
            }
            return;
        }// end function

        private function hideChangeSetIcon() : void
        {
            var _loc_2:* = null;
            this._bShowChangeSetIcon = false;
            var _loc_1:* = 0;
            while (_loc_1 < this._aChangeSetIcon.length)
            {
                
                _loc_2 = this._aChangeSetIcon[_loc_1];
                _loc_2.hide();
                _loc_1++;
            }
            return;
        }// end function

        private function mouseOverChangeSetIcon(param1:int) : void
        {
            var _loc_3:* = null;
            if (!this._bShowChangeSetIcon)
            {
                return;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this._aChangeSetIcon.length)
            {
                
                _loc_3 = this._aChangeSetIcon[_loc_2];
                if (param1 == _loc_2)
                {
                    _loc_3.mouseOver();
                }
                else
                {
                    _loc_3.mouseOut();
                }
                _loc_2++;
            }
            return;
        }// end function

        private function unselect() : void
        {
            this._formationSettings.unselectPlayer();
            this._simpleStatus.hide();
            this._formationSettings.setReserveSelect(false);
            this._playerList.resetSelect();
            this.hideChangeSetIcon();
            return;
        }// end function

        private function cbDecide(param1:int) : void
        {
            if (this.isBusy())
            {
                return;
            }
            if (this._playerList.isBalloonHit())
            {
                return;
            }
            this.setPhase(_PHASE_CONNECTION_SET);
            return;
        }// end function

        private function cbCloseBtn(param1:int) : void
        {
            if (this.isBusy())
            {
                return;
            }
            if (this._playerList.isBalloonHit())
            {
                return;
            }
            this.commandPostClose(MessageManager.getInstance().getMessage(MessageId.FORMATION_POPUP_MESSAGE_NOT_REFLECTED), ProcessMain.PROCESS_HOME);
            return;
        }// end function

        private function cbRetireBtn(param1:int) : void
        {
            if (this.isBusy())
            {
                return;
            }
            if (this._playerList.isBalloonHit())
            {
                return;
            }
            this.commandPostClose(MessageManager.getInstance().getMessage(MessageId.FORMATION_POPUP_MESSAGE_GOTO_RETIREMENT), ProcessMain.PROCESS_RETIRE);
            return;
        }// end function

        private function commandPostClose(param1:String, param2:int) : void
        {
            var checkMsg:* = param1;
            var nextProcess:* = param2;
            if (this._bUpdate)
            {
                this.setAllBtnEnable(false);
                this._formationSettings.setSelectEnable(false);
                this._playerList.setSelectEnable(false);
                this.unselect();
                CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, checkMsg, function (param1:Boolean) : void
            {
                if (param1)
                {
                    _nextProcessId = nextProcess;
                    setPhase(_PHASE_CLOSE);
                }
                else
                {
                    setAllBtnEnable(true);
                    _formationSettings.setSelectEnable(true);
                    _playerList.setSelectEnable(true);
                }
                return;
            }// end function
            );
            }
            else
            {
                this._nextProcessId = nextProcess;
                this.setPhase(_PHASE_CLOSE);
            }
            return;
        }// end function

        private function cbReserveFunc(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = this._formationSettings.selectedFormationIndex;
            if (_loc_2 != Constant.UNDECIDED)
            {
                _loc_3 = 0;
                while (_loc_3 < FormationSetData.FORMATION_INDEX_NUM)
                {
                    
                    if (_loc_3 == _loc_2)
                    {
                        _loc_4 = this._formationSettings.getPersonalAtFormationIndex(_loc_2);
                        _loc_4.resetFormationBonus();
                        _loc_4.resetCommanderSkillBonus();
                        this._formationSettings.unselectPlayer();
                        this._formationSettings.setFormationPlayerUniqueId(_loc_3, Constant.EMPTY_ID);
                        this._formationSettings.updateFormation();
                        this._playerList.setNotDisplayPlayer(this._formationSettings.aFormationPlayerUniqueId);
                        this._playerList.updateList();
                        this._simpleStatus.hide();
                        this._formationSettings.setPlayerSelectEnable(true);
                        this._playerList.setPlayerSelectEnable(true);
                        FormationBonusUtility.updateFormationBonus(this._formationSettings.selectedFormationId, this._formationSettings.aFormationPlayerUniqueId, this._aPlayerPersonal);
                        CommanderSkillUtility.updateCommanderSkillBonus(this._formationSettings.aFormationPlayerUniqueId, this._aPlayerPersonal);
                        this._bUpdate = true;
                        this._decideButton.setDisable(!this.isPossibleUpdate());
                        SoundManager.getInstance().playSe(SoundId.SE_CHARA_SELECT);
                        break;
                    }
                    _loc_3++;
                }
            }
            return;
        }// end function

        private function cbDetail(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._statusResult.reset();
            for each (_loc_2 in this._aPlayerPersonal)
            {
                
                if (_loc_2.uniqueId == param1)
                {
                    _loc_3 = StatusManager.getInstance().getOwnItemList(UserDataManager.getInstance().userData.getOwnItem(CommonConstant.ITEM_KIND_ACCESSORIES), this._aPlayerPersonal, _loc_2.uniqueId);
                    StatusManager.getInstance().addStatusDetail(PlayerDetailStatus.STATUS_TYPE_EQUIPMENT, this._layer.getLayer(LayerCommandPost.POPUP), this.cbDetailStatusClose, _loc_2, _loc_3);
                    this._mcBase.visible = false;
                    this.setAllBtnEnable(false);
                    this._formationSettings.setSelectEnable(false);
                    this._playerList.setSelectEnable(false);
                    this.hideChangeSetIcon();
                    break;
                }
            }
            return;
        }// end function

        private function cbDetailStatusClose(param1:int, param2:Boolean = false) : void
        {
            if (StatusManager.getInstance().aDetailLength == 0)
            {
                this.setAllBtnEnable(true);
                this._formationSettings.setSelectEnable(true);
                this._formationSettings.setReserveSelect(false);
                this._playerList.setSelectEnable(true);
                this._mcBase.visible = true;
            }
            if (param2)
            {
                if (this._aChangedEquipmentPlayerUniqueId.indexOf(param1) == -1)
                {
                    this._aChangedEquipmentPlayerUniqueId.push(param1);
                }
                this._bUpdate = true;
                this._decideButton.setDisable(!this.isPossibleUpdate());
            }
            this._statusResult.marj(StatusManager.getInstance().callerDetailStatus.statusResult);
            if (StatusManager.getInstance().aDetailLength == 0)
            {
                if (this._statusResult.bGotoTradingPost)
                {
                    this.commandPostClose(MessageManager.getInstance().getMessage(MessageId.FORMATION_POPUP_MESSAGE_GOTO_TRADINGPOST), ProcessMain.PROCESS_TRADING_POST);
                    return;
                }
                if (this._statusResult.bGrowsReset)
                {
                    this.updateList();
                    BarracksAutoRestManager.getInstance().updateCheckPlayer();
                }
            }
            return;
        }// end function

        private function cbSort(param1:int) : void
        {
            _sortId = param1;
            return;
        }// end function

        private function cbConnect(param1:NetResult) : void
        {
            var res:* = param1;
            this._user.setCurrentFormation(this._formationSettings.selectedFormationId);
            this._user.setFormationPlayer(this._formationSettings.aFormationPlayerUniqueId);
            this._user.setOwnPlayer(this._aPlayerPersonal);
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_COMMAND_POST_2))
            {
                TutorialManager.getInstance().hideTutorialArrow();
                TutorialManager.getInstance().hideTutorialBalloon();
                TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_COMMAND_POST_2, function () : void
            {
                ButtonManager.getInstance().unseal();
                ButtonManager.getInstance().unseal();
                setPhase(_PHASE_CLOSE);
                return;
            }// end function
            );
            }
            else
            {
                this.setPhase(_PHASE_CLOSE);
            }
            return;
        }// end function

        private function cbFormationChanged(param1:int) : void
        {
            this._bUpdate = true;
            this._decideButton.setDisable(!this.isPossibleUpdate());
            FormationBonusUtility.updateFormationBonus(this._formationSettings.selectedFormationId, this._formationSettings.aFormationPlayerUniqueId, this._aPlayerPersonal);
            CommanderSkillUtility.updateCommanderSkillBonus(this._formationSettings.aFormationPlayerUniqueId, this._aPlayerPersonal);
            return;
        }// end function

        private function cbFormationPositionSelected(param1:int, param2:PlayerPersonal) : Boolean
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param1 == Constant.UNDECIDED)
            {
                this._reserveButton.getMoveClip().visible = false;
                this._reserveButton.setDisableFlag(true);
                this._simpleStatus.hide();
                this._playerList.setFrontSelect(false);
                this.hideChangeSetIcon();
                return false;
            }
            var _loc_3:* = this._playerList.getSelectedPlayerData() as CommandPostListPlayerData;
            if (_loc_3 != null)
            {
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_COMMAND_POST_2))
                {
                    if (param1 != 4)
                    {
                        return true;
                    }
                    TutorialManager.getInstance().stepChange(2);
                }
                if (param1 == FormationSetData.FORMATION_INDEX_COMMANDER)
                {
                    if (_loc_3.info.hasCommanderSkill() == false)
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_CANCEL);
                        this.unselect();
                        return true;
                    }
                }
                if (this._formationSettings.getPersonalAtFormationIndex(param1) == null)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_CHARA_SELECT);
                }
                this._formationSettings.setFormationPlayerUniqueId(param1, _loc_3.personal.uniqueId);
                this._formationSettings.updateFormation();
                this._formationSettings.setReserveSelect(false);
                this._formationSettings.setSelect(param1);
                this._playerList.setNotDisplayPlayer(this._formationSettings.aFormationPlayerUniqueId);
                this._playerList.resetSelect();
                this._playerList.updateList();
                this._playerList.setFrontSelect(false);
                FormationBonusUtility.updateFormationBonus(this._formationSettings.selectedFormationId, this._formationSettings.aFormationPlayerUniqueId, this._aPlayerPersonal);
                CommanderSkillUtility.updateCommanderSkillBonus(this._formationSettings.aFormationPlayerUniqueId, this._aPlayerPersonal);
                this._formationSettings.forceCallFormationMouseOver(param1);
                this.cbFormationPlayerOver(param1, _loc_3.personal);
                this._bUpdate = true;
                this._decideButton.setDisable(!this.isPossibleUpdate());
                this.hideChangeSetIcon();
                return false;
            }
            if (param2)
            {
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_COMMAND_POST_2))
                {
                    return true;
                }
                _loc_4 = this._formationSettings.getFormationPlayerCenterPosition(param1);
                this._reserveButton.getMoveClip().x = _loc_4.x - 50;
                this._reserveButton.getMoveClip().y = _loc_4.y - 10;
                this._reserveButton.getMoveClip().visible = true;
                this._reserveButton.setDisableFlag(false);
                _loc_4.x = _SIMPLE_STATUS_DISPLAY_POSITION_X;
                _loc_4.y = Math.min(Math.max(_loc_4.y, _SIMPLE_STATUS_DISPLAY_POSITION_Y_MIN), _SIMPLE_STATUS_DISPLAY_POSITION_Y_MAX);
                this._simpleStatus.setStatus(param2.clone());
                this._simpleStatus.setPosition(_loc_4);
                this._simpleStatus.show();
                _loc_5 = this._formationSettings.getFormationPlayerCenterPosition(param1);
                this._simpleStatus.setArrowTargetPosition(_loc_5);
                this._playerList.setFrontSelect(true);
                this.showChangeSetIcon(param2);
            }
            return false;
        }// end function

        private function cbFormationPlayerOver(param1:int, param2:PlayerPersonal) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this.isBusy())
            {
                return;
            }
            if (param2 && !this._formationSettings.bReserveSelect && !this._playerList.bFrontSelect)
            {
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_COMMAND_POST_2))
                {
                    if (TutorialManager.getInstance().step == 1)
                    {
                        return;
                    }
                }
                _loc_3 = this._formationSettings.getFormationPlayerCenterPosition(param1);
                _loc_3.x = _SIMPLE_STATUS_DISPLAY_POSITION_X;
                _loc_3.y = Math.min(Math.max(_loc_3.y, _SIMPLE_STATUS_DISPLAY_POSITION_Y_MIN), _SIMPLE_STATUS_DISPLAY_POSITION_Y_MAX);
                this._simpleStatus.setStatus(param2.clone());
                this._simpleStatus.setPosition(_loc_3);
                this._simpleStatus.show();
                _loc_4 = this._formationSettings.getFormationPlayerCenterPosition(param1);
                this._simpleStatus.setArrowTargetPosition(_loc_4);
            }
            this.mouseOverChangeSetIcon(param1);
            return;
        }// end function

        private function cbFormationPlayerOut(param1:PlayerPersonal) : void
        {
            if (!this._playerList.bFrontSelect)
            {
                this._formationSettings.unselectPlayer();
                this._simpleStatus.hide();
            }
            this.mouseOverChangeSetIcon(Constant.UNDECIDED);
            return;
        }// end function

        private function cbFormationPositionChanged() : void
        {
            this._bUpdate = true;
            this._decideButton.setDisable(!this.isPossibleUpdate());
            FormationBonusUtility.updateFormationBonus(this._formationSettings.selectedFormationId, this._formationSettings.aFormationPlayerUniqueId, this._aPlayerPersonal);
            CommanderSkillUtility.updateCommanderSkillBonus(this._formationSettings.aFormationPlayerUniqueId, this._aPlayerPersonal);
            return;
        }// end function

        private function cbReservePlayerSelectFunc(param1:int, param2:CommandPostListPlayerData) : void
        {
            this._formationSettings.setReserveSelect(true);
            this.showChangeSetIcon(param2.personal);
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_COMMAND_POST_2))
            {
                TutorialManager.getInstance().stepChange(1);
            }
            return;
        }// end function

        private function cbReservePlayerUnselectFunc() : void
        {
            this._formationSettings.setReserveSelect(false);
            this.hideChangeSetIcon();
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_COMMAND_POST_2))
            {
                if (TutorialManager.getInstance().step == 1)
                {
                    TutorialManager.getInstance().stepChange(0);
                }
            }
            return;
        }// end function

        public function cbConfigWindowOpen() : void
        {
            if (this._formationSettings)
            {
                this._formationSettings.setPlayerSelectEnable(false);
                this._formationSettings.unselectPlayer();
                this._simpleStatus.hide();
            }
            if (this._playerList)
            {
                this._playerList.setSelectEnable(false);
                this._playerList.resetSelect();
            }
            return;
        }// end function

        public function cbConfigWindowClose() : void
        {
            if (!this._mcBase.visible)
            {
                return;
            }
            if (this._formationSettings)
            {
                this._formationSettings.setPlayerSelectEnable(true);
            }
            if (this._playerList)
            {
                this._playerList.setSelectEnable(true);
            }
            return;
        }// end function

        private function cbRestEnd(param1:PlayerPersonal) : void
        {
            this.updatePlayerPersonal(param1);
            this._decideButton.setDisable(!this.isPossibleUpdate());
            this._aRestPlayerUniqueId.push(param1.uniqueId);
            return;
        }// end function

        private function updatePlayerPersonal(param1:PlayerPersonal) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._aPlayerPersonal.length)
            {
                
                if (this._aPlayerPersonal[_loc_2].uniqueId == param1.uniqueId)
                {
                    (this._aPlayerPersonal[_loc_2] as PlayerPersonal).copyParamOnEdit(param1);
                    break;
                }
                _loc_2++;
            }
            this.updateList();
            return;
        }// end function

        private function updateList() : void
        {
            if (this._formationSettings)
            {
                this._formationSettings.unselectPlayer();
                this._formationSettings.updatePlayerUseFacilityStatus();
                this._formationSettings.updateFormation();
            }
            if (this._playerList)
            {
                this._playerList.resetSelect();
                this._playerList.updatePlayerUseFacilityStatus();
                this._playerList.updateList();
            }
            return;
        }// end function

        private function setRestEndAction() : void
        {
            var _loc_1:* = 0;
            for each (_loc_1 in this._aRestPlayerUniqueId)
            {
                
                if (this._formationSettings)
                {
                    this._formationSettings.setRestEndAction(_loc_1);
                }
                if (this._playerList)
                {
                    this._playerList.setRestEndAction(_loc_1);
                }
            }
            this._aRestPlayerUniqueId = [];
            return;
        }// end function

    }
}
