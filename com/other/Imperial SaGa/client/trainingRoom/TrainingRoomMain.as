package trainingRoom
{
    import asset.*;
    import button.*;
    import facility.*;
    import flash.display.*;
    import home.*;
    import layer.*;
    import message.*;
    import network.*;
    import player.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class TrainingRoomMain extends Object
    {
        private var _phase:int;
        private var _parent:DisplayObjectContainer;
        private var _layer:LayerTrainingRoom;
        private var _mcBase:MovieClip;
        private var _mcHeader:MovieClip;
        private var _mcTopMenu:MovieClip;
        private var _mcKumite:MovieClip;
        private var _mcTraining:MovieClip;
        private var _mcFinishedKumite:MovieClip;
        private var _mcFinishedTraining:MovieClip;
        private var _isoHeader:InStayOut;
        private var _isoTopMenu:InStayOut;
        private var _isoNaviBalloon:InStayOut;
        private var _btnClose:ButtonBase;
        private var _btnMenuKumite:ButtonBase;
        private var _btnMenuTraining:ButtonBase;
        private var _kumite:TrainingRoomKumite;
        private var _training:TrainingRoomTraining;
        private var _facilityInfo:InstitutionInfo;
        private var _aPlayerPersonal:Array;
        private var _engagedKumiteData:EngagedKumiteData;
        private var _engagedTrainingData:EngagedTrainingData;
        private var _aKumitePlayer:Array;
        private var _bTrainingRoomInfoLoaded:Boolean;
        private var _bBtnEnable:Boolean;
        private var _gotTime:uint;
        private var _upgradeDisabled:FacilityUpgradeDisabled;
        private var _bJumpTradingPost:Boolean;
        private static const _PHASE_LOADING:int = 0;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_TOP_MENU:int = 2;
        private static const _PHASE_KUMITE:int = 3;
        private static const _PHASE_TRAINING:int = 4;
        private static const _PHASE_BUSY:int = 6;
        private static const _PHASE_CLOSE:int = 7;
        private static const _PHASE_MAINTENANCE:int = 90;

        public function TrainingRoomMain(param1:DisplayObjectContainer)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._parent = param1;
            this._layer = null;
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.FACILITY_PATH + "UI_Training.swf");
            CommonPopup.getInstance().loadResource([CommonPopup.POPUP_TYPE_NAVI, CommonPopup.POPUP_TYPE_NAVI_SEKISHUSAI]);
            ResourceManager.getInstance().loadResource(AssetListManager.getInstance().getAssetPng(AssetId.ASSET_TRAINING));
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM) || TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_6) || TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_4) || TutorialManager.getInstance().isFacilityUpgradeGuide())
            {
                TutorialManager.getInstance().loadResource();
            }
            KumitePlayerList.loadResource();
            TrainingRoomPlayerList.loadResource();
            FacilityUpgrade.loadResource();
            SoundManager.getInstance().loadSound(SoundId.BGM_INS_TRANING);
            SoundManager.getInstance().loadSoundArray([SoundId.SE_COMPOSE_SUCSESS]);
            var _loc_2:* = UserDataManager.getInstance().userData;
            this._aPlayerPersonal = [];
            for each (_loc_3 in _loc_2.aPlayerPersonal)
            {
                
                this._aPlayerPersonal.push(_loc_3);
                _loc_4 = PlayerManager.getInstance().getPlayerInformation(_loc_3.playerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_4.swf);
            }
            this._aKumitePlayer = [];
            this._facilityInfo = _loc_2.getInstitutionInfo(CommonConstant.FACILITY_ID_TRAINING_ROOM);
            this._bTrainingRoomInfoLoaded = false;
            NetManager.getInstance().request(new NetTaskTrainingRoomInfo(this.cbConnectTrainingRoomInfo));
            this._bJumpTradingPost = false;
            this._phase = _PHASE_LOADING;
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._phase == _PHASE_CLOSE && (this._isoHeader == null || this._isoHeader.bClosed) && (this._isoTopMenu == null || this._isoTopMenu.bClosed);
        }// end function

        public function get bStay() : Boolean
        {
            return this._phase != _PHASE_OPEN && this._phase != _PHASE_CLOSE && (this._isoHeader && this._isoHeader.bAnimetion == false) && (this._isoTopMenu && this._isoTopMenu.bAnimetion == false) && (this._kumite == null || this._kumite.bAnimation == false) && (this._training == null || this._training.bAnimation == false);
        }// end function

        public function get bJumpTradingPost() : Boolean
        {
            return this._bJumpTradingPost;
        }// end function

        private function cbConnectTrainingRoomInfo(param1:NetResult) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            if (param1.data.aKumitePlayerData)
            {
                this._aKumitePlayer = [];
                _loc_5 = param1.data.aKumitePlayerData as Array;
                _loc_6 = 0;
                while (_loc_6 < _loc_5.length)
                {
                    
                    _loc_7 = new TrainingRoomKumitePlayerData(_loc_6, _loc_5[_loc_6]);
                    if (_loc_7.playerId != Constant.EMPTY_ID && PlayerManager.getInstance().getPlayerInformation(_loc_7.playerId) != null)
                    {
                        this._aKumitePlayer.push(_loc_7);
                    }
                    _loc_6++;
                }
            }
            for each (_loc_4 in this._aKumitePlayer)
            {
                
                _loc_3 = PlayerManager.getInstance().getPlayerInformation(_loc_4.playerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_3.swf);
            }
            this._gotTime = TimeClock.getNowTime();
            this._engagedKumiteData = param1.data.engagedKumiteData ? (new EngagedKumiteData(param1.data.engagedKumiteData)) : (null);
            this._engagedTrainingData = param1.data.engagedTrainingData ? (new EngagedTrainingData(param1.data.engagedTrainingData)) : (null);
            if (this._engagedKumiteData != null)
            {
                _loc_3 = PlayerManager.getInstance().getPlayerInformation(this._engagedKumiteData.kumitePlayerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_3.swf);
            }
            this._bTrainingRoomInfoLoaded = true;
            return;
        }// end function

        private function resourceLoaded() : void
        {
            if (!this._bTrainingRoomInfoLoaded)
            {
                return;
            }
            this._layer = new LayerTrainingRoom();
            this._parent.addChild(this._layer);
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_Training.swf", "TrainingMainMc");
            this._layer.getLayer(LayerTrainingRoom.MAIN).addChild(this._mcBase);
            this._mcHeader = this._mcBase.trainingTitleMc;
            this._layer.getLayer(LayerTrainingRoom.HEADER).addChild(this._mcHeader);
            this._mcTopMenu = this._mcBase.trainingMenuSelectMc;
            this._mcKumite = this._mcBase.trainingMenu1MainMc;
            this._mcKumite.visible = false;
            this._mcTraining = this._mcBase.trainingMenu2MainMc;
            this._mcTraining.visible = false;
            this._mcFinishedKumite = this._mcTopMenu.FinisheMark1Mc;
            this._mcFinishedKumite.visible = false;
            this._mcFinishedTraining = this._mcTopMenu.FinisheMark2Mc;
            this._mcFinishedTraining.visible = false;
            this._isoHeader = new InStayOut(this._mcHeader);
            this._isoTopMenu = new InStayOut(this._mcTopMenu);
            this._isoNaviBalloon = new InStayOut(this._mcTopMenu.chrInfoBalloonTopMc);
            if (this._mcHeader.gradeUpBtnMc)
            {
                this._mcHeader.gradeUpBtnMc.visible = false;
            }
            this._btnClose = ButtonManager.getInstance().addButton(this._mcTopMenu.returnBtnMc, this.cbCloseButton);
            this._btnClose.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcTopMenu.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._btnMenuKumite = new ButtonBase(this._mcTopMenu.training1BtnMc, this.cbMenuKumiteButton, this.cbOverMenuKumiteButton, this.cbOutMenuKumiteButton);
            this._btnMenuKumite.enterSeId = ButtonBase.SE_DECIDE_ID;
            ButtonManager.getInstance().addButtonBase(this._btnMenuKumite);
            TextControl.setIdText(this._mcTopMenu.training1BtnMc.textMc.textDt, MessageId.TRAINING_ROOM_TOP_KUMITE_BUTTON);
            this._btnMenuTraining = new ButtonBase(this._mcTopMenu.training2BtnMc, this.cbMenuTrainingButton, this.cbOverMenuTrainingButton, this.cbOutMenuTrainingButton);
            this._btnMenuTraining.enterSeId = ButtonBase.SE_DECIDE_ID;
            ButtonManager.getInstance().addButtonBase(this._btnMenuTraining);
            TextControl.setIdText(this._mcTopMenu.training2BtnMc.textMc.textDt, MessageId.TRAINING_ROOM_TOP_TRAINING_BUTTON);
            TextControl.setIdText(this._mcTopMenu.FinisheMark1Mc.textMc.textDt, MessageId.TRAINING_ROOM_KUMITE_END);
            TextControl.setIdText(this._mcTopMenu.FinisheMark2Mc.textMc.textDt, MessageId.TRAINING_ROOM_TRAINING_END);
            TextControl.setIdText(this._mcTopMenu.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.TRAINING_ROOM_TOP_GUIDE_TEXT01);
            this._kumite = null;
            this._training = null;
            this._mcBase.trainingTitleMc.taitleGradeRankMc.gotoAndStop((this._facilityInfo.grade + 1));
            this._mcBase.trainingTitleMc.taitleGradeRankMc.visible = false;
            if (SoundManager.getInstance().bgmId != SoundId.BGM_INS_TRANING)
            {
                SoundManager.getInstance().playBgm(SoundId.BGM_INS_TRANING);
            }
            this._upgradeDisabled = new FacilityUpgradeDisabled(this._layer.getLayer(LayerTrainingRoom.MAIN));
            this._bBtnEnable = true;
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function release() : void
        {
            ButtonManager.getInstance().removeButton(this._btnClose);
            this._btnClose = null;
            ButtonManager.getInstance().removeButton(this._btnMenuKumite);
            this._btnMenuKumite = null;
            ButtonManager.getInstance().removeButton(this._btnMenuTraining);
            this._btnMenuTraining = null;
            if (this._isoHeader)
            {
                this._isoHeader.release();
            }
            this._isoHeader = null;
            if (this._isoTopMenu)
            {
                this._isoTopMenu.release();
            }
            this._isoTopMenu = null;
            if (this._isoNaviBalloon)
            {
                this._isoNaviBalloon.release();
            }
            this._isoNaviBalloon = null;
            if (this._kumite)
            {
                this._kumite.release();
            }
            this._kumite = null;
            if (this._training)
            {
                this._training.release();
            }
            this._training = null;
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
            this._upgradeDisabled.release();
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
                    this.initPhaseOpen();
                    break;
                }
                case _PHASE_TOP_MENU:
                {
                    this.initPhaseTopMenu();
                    break;
                }
                case _PHASE_KUMITE:
                {
                    this.initPhaseKumite();
                    break;
                }
                case _PHASE_TRAINING:
                {
                    this.initPhaseTraining();
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
            switch(this._phase)
            {
                case _PHASE_LOADING:
                {
                    this.resourceLoaded();
                    break;
                }
                case _PHASE_TOP_MENU:
                {
                    this.controlPhaseTopMenu(param1);
                    break;
                }
                case _PHASE_KUMITE:
                {
                    this.controlPhaseKumite(param1);
                    break;
                }
                case _PHASE_TRAINING:
                {
                    this.controlPhaseTraining(param1);
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
            if (this._kumite)
            {
                this._kumite.control(param1);
            }
            if (this._training)
            {
                this._training.control(param1);
            }
            return;
        }// end function

        private function initPhaseOpen() : void
        {
            var p:PlayerPersonal;
            this.btnEnable(false);
            this._isoTopMenu.setIn(function () : void
            {
                setPhase(_PHASE_MAINTENANCE);
                return;
            }// end function
            );
            if (!this._isoHeader.bOpened)
            {
                this._isoHeader.setIn();
            }
            this._isoNaviBalloon.setIn();
            var nowTime:* = TimeClock.getNowTime();
            this._mcFinishedKumite.visible = false;
            if (!TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_6))
            {
                var _loc_2:* = 0;
                var _loc_3:* = this._aPlayerPersonal;
                while (_loc_3 in _loc_2)
                {
                    
                    p = _loc_3[_loc_2];
                    if (this._engagedKumiteData && this._engagedKumiteData.uniqueId == p.uniqueId && this._engagedKumiteData.endTime <= nowTime)
                    {
                        this._mcFinishedKumite.visible = true;
                        break;
                    }
                }
            }
            this._mcFinishedTraining.visible = false;
            if (!TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_4))
            {
                var _loc_2:* = 0;
                var _loc_3:* = this._aPlayerPersonal;
                while (_loc_3 in _loc_2)
                {
                    
                    p = _loc_3[_loc_2];
                    if (this._engagedTrainingData && this._engagedTrainingData.uniqueId == p.uniqueId && this._engagedTrainingData.endTime <= nowTime)
                    {
                        this._mcFinishedTraining.visible = true;
                        break;
                    }
                }
            }
            return;
        }// end function

        private function initPhaseTopMenu() : void
        {
            this.btnEnable(true);
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM);
            }
            return;
        }// end function

        private function controlPhaseTopMenu(param1:Number) : void
        {
            if (this._upgradeDisabled)
            {
                this._upgradeDisabled.popUpControl(param1, CommonConstant.FACILITY_ID_TRAINING_ROOM);
                if (this._upgradeDisabled.popUpEnd())
                {
                    if (this._btnMenuKumite != null)
                    {
                        this._btnMenuKumite.setDisable(true);
                    }
                    if (this._btnMenuTraining != null)
                    {
                        this._btnMenuTraining.setDisable(true);
                    }
                }
            }
            return;
        }// end function

        private function initPhaseKumite() : void
        {
            this.btnEnable(false);
            if (this._kumite == null)
            {
                this._kumite = new TrainingRoomKumite(this._layer, this._mcKumite, this._aPlayerPersonal, this._aKumitePlayer, this._gotTime, this._engagedKumiteData, this.cbCloseKumite);
            }
            this._isoTopMenu.setOut(function () : void
            {
                _kumite.open();
                return;
            }// end function
            );
            this._isoNaviBalloon.setOut(function () : void
            {
                TextControl.setIdText(_mcTopMenu.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.TRAINING_ROOM_TOP_GUIDE_TEXT01);
                return;
            }// end function
            );
            return;
        }// end function

        private function controlPhaseKumite(param1:Number) : void
        {
            return;
        }// end function

        private function initPhaseTraining() : void
        {
            this.btnEnable(false);
            if (this._training == null)
            {
                this._training = new TrainingRoomTraining(this._layer, this._mcTraining, this._aPlayerPersonal, this._engagedTrainingData, this.cbCloseTraining);
            }
            this._isoTopMenu.setOut();
            this._isoNaviBalloon.setOut(function () : void
            {
                TextControl.setIdText(_mcTopMenu.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.TRAINING_ROOM_TOP_GUIDE_TEXT01);
                return;
            }// end function
            );
            return;
        }// end function

        private function controlPhaseTraining(param1:Number) : void
        {
            if (this._isoTopMenu.bEnd && this._training.bOpenWait)
            {
                this._training.open();
            }
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
                this.setPhase(_PHASE_TOP_MENU);
            }
            return;
        }// end function

        private function controlPhaseMaintenance() : void
        {
            if (Main.GetProcess().maintenance == null)
            {
                this.setPhase(_PHASE_TOP_MENU);
            }
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this.btnEnable(false);
            this._upgradeDisabled.close();
            this._isoTopMenu.setOut();
            this._isoHeader.setOut();
            this._isoNaviBalloon.setOut();
            return;
        }// end function

        private function btnEnable(param1:Boolean) : void
        {
            this._bBtnEnable = param1;
            var _loc_2:* = this._phase == _PHASE_TOP_MENU;
            this._btnClose.setDisable(!_loc_2 || !this._bBtnEnable);
            this._btnMenuKumite.setDisable(!_loc_2 || !this._bBtnEnable);
            this._btnMenuTraining.setDisable(!_loc_2 || !this._bBtnEnable);
            return;
        }// end function

        private function cbCloseButton(param1:int) : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbMenuKumiteButton(param1:int) : void
        {
            this.setPhase(_PHASE_KUMITE);
            return;
        }// end function

        private function cbOverMenuKumiteButton(param1:int) : void
        {
            var id:* = param1;
            this._isoNaviBalloon.setOut(function () : void
            {
                TextControl.setIdText(_mcTopMenu.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.TRAINING_ROOM_KUMITE_NAVI_GUIDE);
                _isoNaviBalloon.setIn();
                return;
            }// end function
            );
            return;
        }// end function

        private function cbOutMenuKumiteButton(param1:int) : void
        {
            var id:* = param1;
            this._isoNaviBalloon.setOut(function () : void
            {
                TextControl.setIdText(_mcTopMenu.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.TRAINING_ROOM_TOP_GUIDE_TEXT01);
                _isoNaviBalloon.setIn();
                return;
            }// end function
            );
            return;
        }// end function

        private function cbMenuTrainingButton(param1:int) : void
        {
            this.setPhase(_PHASE_TRAINING);
            return;
        }// end function

        private function cbOverMenuTrainingButton(param1:int) : void
        {
            var id:* = param1;
            this._isoNaviBalloon.setOut(function () : void
            {
                TextControl.setIdText(_mcTopMenu.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.TRAINING_ROOM_TRAINING_NAVI_GUIDE);
                _isoNaviBalloon.setIn();
                return;
            }// end function
            );
            return;
        }// end function

        private function cbOutMenuTrainingButton(param1:int) : void
        {
            var id:* = param1;
            this._isoNaviBalloon.setOut(function () : void
            {
                TextControl.setIdText(_mcTopMenu.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.TRAINING_ROOM_TOP_GUIDE_TEXT01);
                _isoNaviBalloon.setIn();
                return;
            }// end function
            );
            return;
        }// end function

        private function cbCloseKumite(param1:EngagedKumiteData) : void
        {
            this._engagedKumiteData = param1;
            if (this._kumite.bJumpTradingPost)
            {
                this._bJumpTradingPost = true;
                this.setPhase(_PHASE_CLOSE);
            }
            else
            {
                this.setPhase(_PHASE_OPEN);
            }
            return;
        }// end function

        private function cbCloseTraining(param1:EngagedTrainingData) : void
        {
            this._engagedTrainingData = param1;
            if (this._training.bJumpTradingPost)
            {
                this._bJumpTradingPost = true;
                this.setPhase(_PHASE_CLOSE);
            }
            else
            {
                this.setPhase(_PHASE_OPEN);
            }
            return;
        }// end function

        private function cbClosePopup() : void
        {
            this.setPhase(_PHASE_TOP_MENU);
            return;
        }// end function

    }
}
