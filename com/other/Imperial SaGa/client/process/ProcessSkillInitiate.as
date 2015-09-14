package process
{
    import facility.*;
    import flash.display.*;
    import home.*;
    import item.*;
    import network.*;
    import player.*;
    import popup.*;
    import resource.*;
    import skillInitiate.*;
    import sound.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class ProcessSkillInitiate extends ProcessBase
    {
        private var _rootMc:MovieClip;
        private var _baseMc:MovieClip;
        private var _titleMc:MovieClip;
        private var _isoTitle:InStayOut;
        private var _skillInitiateMain:SkillInitiateMain;
        private var _skillInitiateManager:SkillInitiateManager;
        private var _bConnecting:Boolean;

        public function ProcessSkillInitiate()
        {
            return;
        }// end function

        override public function release() : void
        {
            if (this._skillInitiateMain)
            {
                this._skillInitiateMain.release();
            }
            this._skillInitiateMain = null;
            if (this._isoTitle)
            {
                this._isoTitle.release();
            }
            this._isoTitle = null;
            this._titleMc = null;
            this._baseMc = null;
            if (this._rootMc && this._rootMc.parent)
            {
                this._rootMc.parent.removeChild(this._rootMc);
            }
            this._rootMc = null;
            TutorialManager.getInstance().release();
            super.release();
            return;
        }// end function

        override public function init() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.init();
            ResourceManager.getInstance().loadResource(ResourcePath.FACILITY_PATH + "UI_SkillInitiate.swf");
            FacilityUpgrade.loadResource();
            SICharacterList.loadResource();
            ResourceManager.getInstance().loadResource(ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_REVISION_PROBABILITY));
            SoundManager.getInstance().loadSound(SoundId.BGM_INS_DOJO);
            SoundManager.getInstance().loadSoundArray([SoundId.SE_COMPOSE_SUCSESS, SoundId.SE_COMPOSE_FALE, SoundId.SE_GACHA_DISABLE, SoundId.SE_JUMP1, SoundId.SE_LANDING1016B, SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK, SoundId.SE_REV_DOUJYOU_HIT_2ND, SoundId.SE_REV_DOUJYOU_TITLE, SoundId.SE_REV_DOUJYOU_AURA, SoundId.SE_REV_DOUJYOU_FALL, SoundId.SE_REV_DOUJYOU_RISE, SoundId.SE_REV_DOUJYOU_DWELL, SoundId.SE_REV_INN_SPIN, SoundId.SE_REV_DOUJYOU_SUCCESS]);
            CommonPopup.getInstance().loadResource();
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_5) || TutorialManager.getInstance().isFacilityUpgradeGuide())
            {
                TutorialManager.getInstance().loadResource();
            }
            ResourceManager.getInstance().loadResource(PlayerDisplay.getAnimResource());
            for each (_loc_1 in UserDataManager.getInstance().userData.aPlayerPersonal)
            {
                
                _loc_2 = PlayerManager.getInstance().getPlayerInformation(_loc_1.playerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_2.swf);
            }
            this._skillInitiateManager = new SkillInitiateManager();
            SkillInitiateUtility.init();
            this._bConnecting = false;
            bResourceLoadWait = true;
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            if (!ResourceManager.getInstance().isLoaded() || !SoundManager.getInstance().isLoaded())
            {
                return;
            }
            SoundManager.getInstance().playBgm(SoundId.BGM_INS_DOJO);
            super.controlResourceWait();
            this._rootMc = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_SkillInitiate.swf", "SkillInitiateMainMc");
            this._baseMc = this._rootMc.skillInitiateMainMc;
            this._titleMc = this._rootMc.skillInitiateTitleMc;
            this._isoTitle = new InStayOut(this._titleMc);
            this._skillInitiateMain = new SkillInitiateMain(this._baseMc, this._skillInitiateManager);
            this.addChild(this._rootMc);
            if (this._titleMc.gradeUpBtnMc)
            {
                this._titleMc.gradeUpBtnMc.visible = false;
            }
            this._titleMc.taitleGradeRankMc.gotoAndStop((UserDataManager.getInstance().userData.getInstitutionInfo(CommonConstant.FACILITY_ID_SKILL_INITIATE).grade + 1));
            this._titleMc.taitleGradeRankMc.visible = false;
            this._skillInitiateMain.openMain();
            this._isoTitle.setIn();
            bResourceLoadWait = false;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            this._skillInitiateMain.control(param1);
            if (this._skillInitiateMain.bAnimetion == false)
            {
                _bTopbarButtonDisable = false;
            }
            else
            {
                _bTopbarButtonDisable = true;
            }
            if (this._skillInitiateMain.bEnd)
            {
                if (this._skillInitiateMain.bGoTradingPost)
                {
                    Main.GetProcess().SetProcessId(ProcessMain.PROCESS_TRADING_POST);
                }
                else
                {
                    Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
                }
            }
            super.control(param1);
            return;
        }// end function

        private function cbFacilityGradeUp() : void
        {
            var _loc_1:* = UserDataManager.getInstance().userData;
            var _loc_2:* = _loc_1.getInstitutionInfo(CommonConstant.FACILITY_ID_SKILL_INITIATE);
            this._titleMc.taitleGradeRankMc.gotoAndStop((_loc_2.grade + 1));
            return;
        }// end function

        private function cbReceive(param1:NetResult) : void
        {
            SkillInitiateUtility.setBonusDataList(param1.data.aBonusPriceData);
            SkillInitiateUtility.setBasePriceList(param1.data.aBasePriceData);
            this._bConnecting = false;
            return;
        }// end function

    }
}
