package process
{
    import asset.*;
    import button.*;
    import facility.*;
    import flash.display.*;
    import home.*;
    import layer.*;
    import magicLaboratory.*;
    import message.*;
    import network.*;
    import player.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import status.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class ProcessMagicLaboratory extends ProcessBase
    {
        private var _layer:LayerMagicLaboratory;
        private var _baseMc:MovieClip;
        private var _title:MagicLaboratoryTitle;
        private var _menuMc:MovieClip;
        private var _isoMenu:InStayOut;
        private var _developBtn:ButtonBase;
        private var _learningBtn:ButtonBase;
        private var _closeBtn:ButtonBase;
        private var _developReturnBtn:ButtonBase;
        private var _upGradeBtn:ButtonBase;
        private var _phase:int;
        private const _PHASE_UPGRADE:int = 40;
        private const _PHASE_UPGRADE_RESOURCE:int = 41;
        private var _NetLoadEnd:Boolean;
        private var _magicDevelop:MagicDevelop;
        private var _mcFinishedMagicLearn:MovieClip;
        private var _mcFinishedMagicDevelop:MovieClip;
        private var _magicLearn:MagicLearn;
        private var _fade:Fade;
        private var _facilityUpgrade:FacilityUpgrade;
        private var _isoNaviBalloon:InStayOut;
        private var _upgradeDisabled:FacilityUpgradeDisabled;
        private var _bMoveTradingPost:Boolean;
        private static const _PHASE_LOAD:int = 0;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_MAIN:int = 2;
        private static const _PHASE_CLOSE:int = 3;
        private static const _PHASE_MAINTENANCE:int = 90;
        private static const _PHASE_UPGRADE_ALL_CLOSE:int = 10;

        public function ProcessMagicLaboratory()
        {
            this._bMoveTradingPost = false;
            return;
        }// end function

        override public function init() : void
        {
            super.init();
            this.setPhase(_PHASE_LOAD);
            ResourceManager.getInstance().loadResource(ResourcePath.FACILITY_PATH + "UI_MagicLaboratory.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf");
            SoundManager.getInstance().loadSound(SoundId.BGM_INS_RESEARCH);
            SoundManager.getInstance().loadSoundArray([SoundId.SE_REV_LAB_DEVFINISH, SoundId.SE_COMPOSE_SUCSESS]);
            CommonPopup.getInstance().loadResource([CommonPopup.POPUP_TYPE_NAVI, CommonPopup.POPUP_TYPE_NAVI_EMERALD]);
            ResourceManager.getInstance().loadResource(AssetListManager.getInstance().getAssetPng(AssetId.ASSET_MAGIC_DEVELOP));
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO) || TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_3) || TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_4) || TutorialManager.getInstance().isFacilityUpgradeGuide())
            {
                TutorialManager.getInstance().loadResource();
            }
            MLearnPlayerList.loadResource();
            FacilityUpgrade.loadResource();
            SkillSimpleStatus.loadResource();
            _bResourceLoadWait = true;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._title)
            {
                this._title.release();
            }
            this._title = null;
            if (this._developBtn != null)
            {
                ButtonManager.getInstance().removeButton(this._developBtn);
                this._developBtn = null;
            }
            if (this._learningBtn != null)
            {
                ButtonManager.getInstance().removeButton(this._learningBtn);
                this._learningBtn = null;
            }
            if (this._closeBtn != null)
            {
                ButtonManager.getInstance().removeButton(this._closeBtn);
                this._closeBtn = null;
            }
            if (this._upGradeBtn != null)
            {
                ButtonManager.getInstance().removeButton(this._upGradeBtn);
                this._upGradeBtn = null;
            }
            if (this._magicDevelop != null)
            {
                this._magicDevelop.release();
                this._magicDevelop = null;
            }
            if (this._magicLearn != null)
            {
                this._magicLearn.release();
            }
            this._magicLearn = null;
            this._upgradeDisabled.release();
            TutorialManager.getInstance().release();
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            if (ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false)
            {
                return;
            }
            SoundManager.getInstance().playBgm(SoundId.BGM_INS_RESEARCH);
            this._layer = new LayerMagicLaboratory();
            addChild(this._layer);
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_MagicLaboratory.swf", "MagicLaboratoryMainMc");
            this._baseMc.magicDevelopMainMc.visible = false;
            this._baseMc.magicLearningMainMc.visible = false;
            this._isoNaviBalloon = new InStayOut(this._baseMc.magicLaboMenuSelectMc.chrInfoBalloonTopMc);
            this._developBtn = new ButtonBase(this._baseMc.magicLaboMenuSelectMc.creatBtnMc, this.cbTopMenuDevelopButtonClick, this.cbOverMenuDevelopButton, this.cbOutMenuDevelopButton);
            this._developBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
            ButtonManager.getInstance().addButtonBase(this._developBtn);
            this._developBtn.setDisableFlag(true);
            TextControl.setIdText(this._baseMc.magicLaboMenuSelectMc.creatBtnMc.textMc.textDt, MessageId.MAGIC_DEVELOP_MENU_DEVELOP);
            this._learningBtn = new ButtonBase(this._baseMc.magicLaboMenuSelectMc.decompoBtnMc, this.cbTopMenuLearningButtonClick, this.cbOverMenuLearningButton, this.cbOutMenuLearningButton);
            this._learningBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._learningBtn.setDisableFlag(true);
            ButtonManager.getInstance().addButtonBase(this._learningBtn);
            TextControl.setIdText(this._baseMc.magicLaboMenuSelectMc.decompoBtnMc.textMc.textDt, MessageId.MAGIC_DEVELOP_MENU_LEARN);
            this._closeBtn = ButtonManager.getInstance().addButton(this._baseMc.magicLaboMenuSelectMc.returnBtnMc, this.cbTopMenuCloseButtonClick);
            this._closeBtn.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._closeBtn.setDisableFlag(true);
            TextControl.setIdText(this._baseMc.magicLaboMenuSelectMc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            TextControl.setText(this._baseMc.magicDevelopMainMc.returnBtnMc.textMc.textDt, "");
            this._mcFinishedMagicLearn = this._baseMc.magicLaboMenuSelectMc.FinisheMark1Mc;
            this._mcFinishedMagicLearn.visible = false;
            TextControl.setIdText(this._baseMc.magicLaboMenuSelectMc.FinisheMark1Mc.textMc.textDt, MessageId.MAGIC_DEVELOP_LEARNING_END);
            this._mcFinishedMagicDevelop = this._baseMc.magicLaboMenuSelectMc.FinisheMark2Mc;
            this._mcFinishedMagicDevelop.visible = false;
            TextControl.setIdText(this._baseMc.magicLaboMenuSelectMc.FinisheMark2Mc.textMc.textDt, MessageId.MAGIC_DEVELOP_DEVELOP_END);
            TextControl.setIdText(this._baseMc.magicLaboTitleMc.gradeUpBtnMc.textMc.textDt, MessageId.FACILITY_BUTTON_GRADE_UP);
            TextControl.setIdText(this._baseMc.magicLaboMenuSelectMc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.MAGIC_DEVELOP_TOP_GUIDE_TEXT01);
            this._layer.getLayer(LayerMagicLaboratory.MAIN).addChild(this._baseMc);
            this._title = new MagicLaboratoryTitle(this._baseMc.magicLaboTitleMc);
            this._menuMc = this._baseMc.magicLaboMenuSelectMc;
            this._isoMenu = new InStayOut(this._menuMc, true);
            this._NetLoadEnd = false;
            NetManager.getInstance().request(new NetTaskMagicLaboratory(this.cbReceive));
            this._upgradeDisabled = new FacilityUpgradeDisabled(this._layer.getLayer(LayerMagicLaboratory.POPUP));
            _bResourceLoadWait = false;
            return;
        }// end function

        private function cbReceive(param1:NetResult) : void
        {
            MagicLabolatoryManager.getInstance().setData(param1.data);
            this._NetLoadEnd = true;
            return;
        }// end function

        private function cbTopMenuDevelopButtonClick(param1:int) : void
        {
            var id:* = param1;
            this.menuClose();
            this._isoNaviBalloon.setOut(function () : void
            {
                TextControl.setIdText(_baseMc.magicLaboMenuSelectMc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.MAGIC_DEVELOP_TOP_GUIDE_TEXT01);
                return;
            }// end function
            );
            this._magicDevelop = new MagicDevelop(this._baseMc, this._layer);
            return;
        }// end function

        private function cbOverMenuDevelopButton(param1:int) : void
        {
            var id:* = param1;
            this._isoNaviBalloon.setOut(function () : void
            {
                TextControl.setIdText(_baseMc.magicLaboMenuSelectMc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.MAGIC_DEVELOP_DEVELOPMENT_NAVI_GUIDE);
                _isoNaviBalloon.setIn();
                return;
            }// end function
            );
            return;
        }// end function

        private function cbOutMenuDevelopButton(param1:int) : void
        {
            var id:* = param1;
            this._isoNaviBalloon.setOut(function () : void
            {
                TextControl.setIdText(_baseMc.magicLaboMenuSelectMc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.MAGIC_DEVELOP_TOP_GUIDE_TEXT01);
                _isoNaviBalloon.setIn();
                return;
            }// end function
            );
            return;
        }// end function

        private function cbTopMenuLearningButtonClick(param1:int) : void
        {
            var id:* = param1;
            this.menuClose();
            this._isoNaviBalloon.setOut(function () : void
            {
                TextControl.setIdText(_baseMc.magicLaboMenuSelectMc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.MAGIC_DEVELOP_TOP_GUIDE_TEXT01);
                return;
            }// end function
            );
            this._magicLearn = new MagicLearn(this._baseMc.magicLearningMainMc, this._layer);
            return;
        }// end function

        private function cbOverMenuLearningButton(param1:int) : void
        {
            var id:* = param1;
            this._isoNaviBalloon.setOut(function () : void
            {
                TextControl.setIdText(_baseMc.magicLaboMenuSelectMc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.MAGIC_DEVELOP_LEARNING_NAVI_GUIDE);
                _isoNaviBalloon.setIn();
                return;
            }// end function
            );
            return;
        }// end function

        private function cbOutMenuLearningButton(param1:int) : void
        {
            var id:* = param1;
            this._isoNaviBalloon.setOut(function () : void
            {
                TextControl.setIdText(_baseMc.magicLaboMenuSelectMc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.MAGIC_DEVELOP_TOP_GUIDE_TEXT01);
                _isoNaviBalloon.setIn();
                return;
            }// end function
            );
            return;
        }// end function

        private function cbTopMenuCloseButtonClick(param1:int) : void
        {
            this._isoNaviBalloon.setOut();
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbFacilityUpgradeButtonClick(param1:int) : void
        {
            return;
        }// end function

        private function menuClose() : void
        {
            if (!this._isoNaviBalloon.bClosed)
            {
                this._isoNaviBalloon.setOut();
            }
            if (!this._isoMenu.bClosed)
            {
                this._isoMenu.setOut();
            }
            this._developBtn.setDisable(true);
            this._learningBtn.setDisable(true);
            this._closeBtn.setDisable(true);
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            if (this._title)
            {
                if (this._phase == _PHASE_MAIN)
                {
                    if (this._title.bUpgrade)
                    {
                        this.setPhase(_PHASE_UPGRADE_ALL_CLOSE);
                    }
                }
            }
            switch(this._phase)
            {
                case _PHASE_LOAD:
                {
                    if (this._NetLoadEnd)
                    {
                        this._NetLoadEnd = false;
                        this.setPhase(_PHASE_OPEN);
                    }
                    break;
                }
                case _PHASE_OPEN:
                {
                    this.setPhase(_PHASE_MAINTENANCE);
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
                case _PHASE_UPGRADE_ALL_CLOSE:
                {
                    this.controlUpgradeAllClose(param1);
                    break;
                }
                case this._PHASE_UPGRADE:
                {
                    this.controlUpgrade(param1);
                    break;
                }
                case this._PHASE_UPGRADE_RESOURCE:
                {
                    this.controlUpgradeResource(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._magicDevelop != null)
            {
                this._magicDevelop.control(param1);
                if (this._magicDevelop.bEnd)
                {
                    this._bMoveTradingPost = this._magicDevelop.bGoTradingPost;
                    this._magicDevelop.release();
                    this._magicDevelop = null;
                    if (this._bMoveTradingPost)
                    {
                        this.setPhase(_PHASE_CLOSE);
                    }
                    else if (this._phase == _PHASE_MAIN)
                    {
                        this.setPhase(_PHASE_OPEN);
                    }
                }
            }
            if (this._magicLearn != null)
            {
                this._magicLearn.control(param1);
                if (this._magicLearn.bEnd)
                {
                    this._bMoveTradingPost = this._magicLearn.bGoTradingPost;
                    this._magicLearn.release();
                    this._magicLearn = null;
                    if (this._bMoveTradingPost)
                    {
                        this.setPhase(_PHASE_CLOSE);
                    }
                    else if (this._phase == _PHASE_MAIN)
                    {
                        this.setPhase(_PHASE_OPEN);
                    }
                }
            }
            if (this._isoMenu.bAnimetion == false && (this._magicLearn == null || this._magicLearn.bAnimetion == false) && (this._magicDevelop == null || this._magicDevelop.bAnimetion == false))
            {
                if (_bTopbarButtonDisable && this._phase != _PHASE_CLOSE)
                {
                    _bTopbarButtonDisable = false;
                    this._title.titleEnable();
                }
            }
            else if (_bTopbarButtonDisable == false)
            {
                _bTopbarButtonDisable = true;
                this._title.titleDisable();
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_LOAD:
                {
                    break;
                }
                case _PHASE_OPEN:
                {
                    this.phaseOpen();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.phaseClose();
                    break;
                }
                case _PHASE_MAINTENANCE:
                {
                    this.initPhaseMaintenance();
                    break;
                }
                case _PHASE_UPGRADE_ALL_CLOSE:
                {
                    this.phaseUpgradeAllClose();
                    break;
                }
                case this._PHASE_UPGRADE:
                {
                    this.phaseUpgrade();
                    break;
                }
                case this._PHASE_UPGRADE_RESOURCE:
                {
                    this.phaseUpgradeResource();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            var _loc_2:* = null;
            this._mcFinishedMagicLearn.visible = false;
            var _loc_1:* = MagicLabolatoryManager.getInstance().aLearningData;
            for each (_loc_2 in _loc_1)
            {
                
                if (MagicLabolatoryManager.getInstance().isLearning(_loc_2) && MagicLabolatoryManager.getInstance().isLearningTimeOut(_loc_2))
                {
                    this._mcFinishedMagicLearn.visible = true;
                    break;
                }
            }
            this._mcFinishedMagicDevelop.visible = MagicLabolatoryManager.getInstance().isDeveloping() && MagicLabolatoryManager.getInstance().isDevelopTimeOut();
            if (this._title.bClosed)
            {
                this._title.open();
            }
            if (this._isoMenu.bClosed)
            {
                this._isoMenu.setIn(this.cbInMenu);
            }
            else
            {
                this._developBtn.setDisable(false);
                this._learningBtn.setDisable(false);
                this._closeBtn.setDisable(false);
            }
            this._isoNaviBalloon.setIn();
            return;
        }// end function

        private function controlMain(param1:Number) : void
        {
            if (this._magicLearn == null && this._magicDevelop == null && this._upgradeDisabled)
            {
                this._upgradeDisabled.popUpControl(param1, CommonConstant.FACILITY_ID_MAGIC_DEVELOP);
                if (this._upgradeDisabled.popUpEnd())
                {
                    if (this._developBtn != null)
                    {
                        this._developBtn.setDisable(true);
                    }
                    if (this._learningBtn != null)
                    {
                        this._learningBtn.setDisable(true);
                    }
                }
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this.menuClose();
            if (!this._title.bClosed)
            {
                this._title.close();
            }
            this._upgradeDisabled.close();
            return;
        }// end function

        private function controlClose() : void
        {
            if (this._isoMenu.bEnd && this._title.bEnd)
            {
                if (this._bMoveTradingPost)
                {
                    Main.GetProcess().SetProcessId(ProcessMain.PROCESS_TRADING_POST);
                }
                else
                {
                    Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
                }
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

        private function phaseUpgradeAllClose() : void
        {
            this.setWindowOpen(false);
            this._upgradeDisabled.close();
            this._developBtn.setDisable(true);
            this._learningBtn.setDisable(true);
            this._closeBtn.setDisable(true);
            if (this._isoMenu)
            {
                if (this._isoMenu.bClosed == false)
                {
                    this._isoMenu.setOut();
                }
                this._isoNaviBalloon.setOut();
            }
            if (this._magicDevelop)
            {
                this._magicDevelop.developClose();
            }
            if (this._magicLearn)
            {
                this._magicLearn.close();
            }
            return;
        }// end function

        private function controlUpgradeAllClose(param1:Number) : void
        {
            if (this._isoMenu.bEnd && this._magicDevelop == null && this._magicLearn == null)
            {
                this.setPhase(this._PHASE_UPGRADE_RESOURCE);
            }
            return;
        }// end function

        private function phaseUpgrade() : void
        {
            this.setWindowOpen(false);
            ButtonManager.getInstance().push();
            var _loc_1:* = UserDataManager.getInstance().userData;
            this._facilityUpgrade = new FacilityUpgrade(this._layer.getLayer(LayerMagicLaboratory.MAIN), CommonConstant.FACILITY_ID_MAGIC_DEVELOP, _loc_1.aPlayerPersonal, this.cbUpgradeClose);
            this._facilityUpgrade.setGradeUpConnectedCallback(this.cbFacilityGradeUpConnected);
            this._facilityUpgrade.setGradeUpCallback(this.cbFacilityGradeUp);
            this._facilityUpgrade.open();
            return;
        }// end function

        private function controlUpgrade(param1:Number) : void
        {
            if (this._facilityUpgrade != null)
            {
                this._facilityUpgrade.control(param1);
            }
            return;
        }// end function

        private function cbUpgradeClose() : void
        {
            this._bMoveTradingPost = this._facilityUpgrade.bGoTradingPost;
            this._facilityUpgrade.release();
            this._facilityUpgrade = null;
            this.setWindowOpen(true);
            ButtonManager.getInstance().pop();
            if (this._bMoveTradingPost)
            {
                this.setPhase(_PHASE_CLOSE);
            }
            else
            {
                this.setPhase(_PHASE_OPEN);
            }
            return;
        }// end function

        private function cbFacilityGradeUp() : void
        {
            var _loc_1:* = UserDataManager.getInstance().userData;
            var _loc_2:* = _loc_1.getInstitutionInfo(CommonConstant.FACILITY_ID_MAGIC_DEVELOP);
            this._baseMc.magicLaboTitleMc.taitleGradeRankMc.gotoAndStop((_loc_2.grade + 1));
            return;
        }// end function

        private function cbFacilityGradeUpConnected(param1:NetResult) : void
        {
            if (param1.protocolId == NetId.PROTOCOL_MAGIC_DEVELOP_UPGRADE_END)
            {
                MagicLabolatoryManager.getInstance().setData(param1.data);
            }
            return;
        }// end function

        private function phaseUpgradeResource() : void
        {
            var _loc_2:* = null;
            FacilityUpgrade.loadResource();
            var _loc_1:* = UserDataManager.getInstance().userData;
            for each (_loc_2 in _loc_1.aPlayerPersonal)
            {
                
                ResourceManager.getInstance().loadArray(PlayerManager.getInstance().getPlayerResourcePath(_loc_2.playerId));
            }
            return;
        }// end function

        private function controlUpgradeResource(param1:Number) : void
        {
            if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_UPGRADE);
            }
            return;
        }// end function

        private function setWindowOpen(param1:Boolean) : void
        {
            if (param1)
            {
                this._title.titleEnable();
            }
            else
            {
                this._title.titleDisable();
            }
            return;
        }// end function

        private function cbInMenu() : void
        {
            this._developBtn.setDisable(false);
            this._learningBtn.setDisable(false);
            this._closeBtn.setDisable(false);
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO);
            }
            else if (TutorialManager.getInstance().isFacilityUpgradeGuide())
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_1, function () : void
            {
                TutorialManager.getInstance().setTutorialArrow(_baseMc.magicLaboTitleMc.gradeUpBtnMc, TutorialManager.TUTORIAL_ARROW_DIRECTION_LEFT);
                return;
            }// end function
            );
            }
            return;
        }// end function

    }
}
