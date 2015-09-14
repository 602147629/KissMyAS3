package employment
{
    import PlayerCard.*;
    import asset.*;
    import button.*;
    import flash.display.*;
    import flash.geom.*;
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

    public class EmploymentMain extends Object
    {
        private var _phase:int;
        private var _parent:DisplayObjectContainer;
        private var _layer:LayerEmployment;
        private var _mcBase:MovieClip;
        private var _mcBG:MovieClip;
        private var _employHeader:EmploymentTitleHeader;
        private var _employNavi:EmploymentNaviCharacter;
        private var _employNormalMenu:EmploymentNormalMenu;
        private var _employHighClassMenu:EmploymentHighClassMenu;
        private var _employSpecialMenu:EmploymentSpecialMenu;
        private var _employLimitedMenu:EmploymentHighClassMenu;
        private var _employBanner:EmploymentBanner;
        private var _isoBase:InStayOut;
        private var _isoFirstPop:InStayOut;
        private var _freeNumBalloon:EmploymentSummonFreeNumBalloon;
        private var _btnClose:ButtonBase;
        private var _btnBuildNormal:EmploymentBuildingBtn;
        private var _btnBuildHigh:EmploymentBuildingBtn;
        private var _btnBuildSpecial:EmploymentBuildingBtn;
        private var _btnBuildLimited:EmploymentBuildingBtn;
        private var _bEmploymentInfoLoaded:Boolean;
        private var _aProbabilityTable:Array;
        private var _aFeaturedPlayer:Array;
        private var _highEmploymentData:EmploymentHighClassData;
        private var _specialEmploymentData:EmploymentSpecialData;
        private var _limitedEmploymentData:EmploymentLimitedData;
        private var _aEmploymentBannerData:Array;
        private var _limitedEmperorInfo:PlayerInformation;
        private var _featuredPlayer:EmploymentFeaturedPlayer;
        private var _bHighFirstEmployed:Boolean;
        private var _bGoTradingPost:Boolean;
        private var _bGoRetire:Boolean;
        private static const _PHASE_LOADING:int = 0;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_HOME:int = 2;
        private static const _PHASE_EMPLOYMENT_NORMAL:int = 3;
        private static const _PHASE_EMPLOYMENT_HIGH:int = 4;
        private static const _PHASE_EMPLOYMENT_SPECIAL:int = 5;
        private static const _PHASE_EMPLOYMENT_LIMITED:int = 6;
        private static const _PHASE_POPUP:int = 7;
        private static const _PHASE_CONNECTING:int = 8;
        private static const _PHASE_CLOSE:int = 9;
        private static const _PHASE_MAINTENANCE:int = 90;
        private static const _PHASE_FORCE_CLOSE:int = 99;

        public function EmploymentMain(param1:DisplayObjectContainer)
        {
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.GACHA_PATH + "UI_SummonMenu.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.GACHA_PATH + "UI_SummonFree.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.GACHA_PATH + "UI_SummonProduction.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.NAVI_CHARACTER_PATH);
            PlayerBigCard.loadResource();
            PlayerSmallCard.loadResource();
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Balloon.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            ResourceManager.getInstance().loadResource(AssetListManager.getInstance().getAssetPng(AssetId.ASSET_GACHA_POINT));
            CommonPopup.getInstance().loadResource();
            if (TutorialManager.getInstance().isTutorial())
            {
                TutorialManager.getInstance().loadResource();
            }
            SoundManager.getInstance().loadSound(SoundId.BGM_BGM_INS_DRAFT);
            SoundManager.getInstance().loadSoundArray([SoundId.SE_DECIDE, SoundId.SE_GACHA_RESULT, SoundId.SE_REV_FLASHGATHER, SoundId.SE_SELECT_WINDOW, SoundId.SE_ANTICIPATE, SoundId.SE_GACHA_DISABLE, SoundId.SE_REV_TRAIN_ATTACK, SoundId.SE_REV_TRAIN_FINALATTACK, SoundId.SE_REV_TRAIN_034JUMP, SoundId.SE_REV_TRAIN_SPINLONG, SoundId.SE_REV_TRAIN_SUNAKEMURI, SoundId.SE_REV_TRAIN_SPINSHORT, SoundId.SE_REV_TRAIN_MANYPUNCH, SoundId.SE_REV_TRAIN_BIGPUNCH, SoundId.SE_REV_TRAIN_RUN, SoundId.SE_REV_TRAIN_EXPSMALL, SoundId.SE_REV_TRAIN_EXPBIG, SoundId.SE_REV_TRAIN_SPIN, SoundId.SE_REV_TRAIN_SYOUBU, SoundId.SE_REV_TRAIN_CARDINCIDENT_MANY, SoundId.SE_REV_TRAIN_CARDINCIDENT_ONE]);
            SoundManager.getInstance().loadSoundArray(EmploymentRunner.getSeIdList());
            this._parent = param1;
            this._layer = null;
            this._employHeader = null;
            this._employNavi = null;
            this._employNormalMenu = null;
            this._employHighClassMenu = null;
            this._employSpecialMenu = null;
            this._employLimitedMenu = null;
            this._employBanner = null;
            this._btnBuildNormal = null;
            this._btnBuildHigh = null;
            this._btnBuildSpecial = null;
            this._btnBuildLimited = null;
            this._limitedEmperorInfo = null;
            this._featuredPlayer = null;
            this._bHighFirstEmployed = true;
            this._bGoTradingPost = false;
            this._bGoRetire = false;
            this._bEmploymentInfoLoaded = false;
            NetManager.getInstance().request(new NetTaskEmployment(this.cbConnectEmployment));
            this._phase = _PHASE_LOADING;
            return;
        }// end function

        public function get bGoTradingPost() : Boolean
        {
            return this._bGoTradingPost;
        }// end function

        public function get bGoRetire() : Boolean
        {
            return this._bGoRetire;
        }// end function

        public function get bClose() : Boolean
        {
            return this._phase == _PHASE_FORCE_CLOSE || this._isoBase && this._isoBase.bClosed && (this._employHeader && this._employHeader.bClose) && (this._employNavi && this._employNavi.bClose);
        }// end function

        public function get bStay() : Boolean
        {
            return this._phase != _PHASE_OPEN && this._phase != _PHASE_CLOSE && (this._isoBase && this._isoBase.bAnimetion == false) && (this._employHeader && this._employHeader.bAnimetion == false) && this._employNavi.bAnimetion == false && (this._employNormalMenu == null || this._employNormalMenu && this._employNormalMenu.bStay) && (this._employHighClassMenu == null || this._employHighClassMenu && this._employHighClassMenu.bStay) && (this._employSpecialMenu == null || this._employSpecialMenu.bStay) && (this._employLimitedMenu == null || this._employLimitedMenu.bStay);
        }// end function

        private function cbConnectEmployment(param1:NetResult) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._highEmploymentData = new EmploymentHighClassData(param1.data.highClassEmploymentData.price);
            if (param1.data.highClassEmploymentBoxData)
            {
                this._highEmploymentData.bBoxFirstBonus = Boolean(param1.data.highClassEmploymentBoxData.bFirstBonus);
            }
            this._specialEmploymentData = new EmploymentSpecialData(param1.data.specialEmploymentData.price);
            this._limitedEmploymentData = null;
            if (param1.data.limitedEmploymentData != null)
            {
                _loc_2 = UserDataManager.getInstance().userData.emperorId;
                this._limitedEmploymentData = new EmploymentLimitedData(param1.data.limitedEmploymentData.starttime, param1.data.limitedEmploymentData.endtime, param1.data.limitedEmploymentData.endDispFlag, param1.data.limitedEmploymentData.bannerUrl, param1.data.limitedEmploymentData.bannerFileName, param1.data.limitedEmploymentData.price, param1.data.limitedEmploymentData.boxFlag, param1.data.limitedEmploymentData.boxPrice, _loc_2);
                _loc_3 = PlayerManager.getInstance().getPlayerInformation(_loc_2);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_BUSTUP_PATH + _loc_3.bustUpFileName);
            }
            this._aEmploymentBannerData = null;
            if (param1.data.aEmploymentBannerData != null)
            {
                this._aEmploymentBannerData = [];
                param1.data.aEmploymentBannerData.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
                _loc_4 = TimeClock.getNowTime();
                for each (_loc_5 in param1.data.aEmploymentBannerData)
                {
                    
                    _loc_6 = new EmploymentBannerData();
                    _loc_6.setReceiveData(_loc_5);
                    if (_loc_6 && _loc_4 >= _loc_6.startTime && _loc_4 <= _loc_6.endTime)
                    {
                        this._aEmploymentBannerData.push(_loc_6);
                    }
                }
                if (this._aEmploymentBannerData)
                {
                    for each (_loc_7 in this._aEmploymentBannerData)
                    {
                        
                        if (_loc_7.bannerFileName.indexOf("http:") == 0)
                        {
                            ResourceManager.getInstance().loadResourceUrl(_loc_7.bannerFileName);
                            continue;
                        }
                        if (_loc_7.bannerFileName != "")
                        {
                            ResourceManager.getInstance().loadResource(_loc_7.bannerFileName);
                        }
                    }
                }
            }
            if (this._limitedEmploymentData && param1.data.limitedEmploymentBoxData)
            {
                this._limitedEmploymentData.bBoxFirstBonus = Boolean(param1.data.limitedEmploymentBoxData.bFirstBonus);
            }
            this.updateEmploymentInfo(param1.data.aProbabilityTable);
            this._bEmploymentInfoLoaded = true;
            return;
        }// end function

        private function resourceLoaded() : void
        {
            if (!this._bEmploymentInfoLoaded)
            {
                return;
            }
            if (ResourceManager.getInstance().isLoaded() == false)
            {
                return;
            }
            this._layer = new LayerEmployment();
            this._parent.addChild(this._layer);
            var _loc_1:* = ResourcePath.GACHA_PATH + "UI_SummonMenu.swf";
            this._mcBG = ResourceManager.getInstance().createMovieClip(_loc_1, "summonBG");
            this._mcBase = ResourceManager.getInstance().createMovieClip(_loc_1, "summonMainMc");
            this._layer.getLayer(LayerEmployment.BG).addChild(this._mcBG);
            this._layer.getLayer(LayerEmployment.MAIN).addChild(this._mcBase);
            this._employNavi = new EmploymentNaviCharacter(this._layer.getLayer(LayerEmployment.NAVI));
            this._employHeader = new EmploymentTitleHeader(this._layer.getLayer(LayerEmployment.HEADER));
            this._isoBase = new InStayOut(this._mcBase);
            this._isoFirstPop = new InStayOut(this._mcBase.infoScrollMc);
            this._freeNumBalloon = new EmploymentSummonFreeNumBalloon(this._mcBase.freeNumMc);
            this._freeNumBalloon.setVisible(false);
            TextControl.setText(this._mcBase.infoScrollMc.textMc.textDt, TextControl.formatIdText(MessageId.EMPLOYMENT_HIGH_EMPLOY_FIRST_PROBABILITY_UP, PlayerManager.getInstance().getRarityText(CommonConstant.CHARACTER_RARITY_SUPERRARE)));
            this._btnClose = ButtonManager.getInstance().addButton(this._mcBase.returnBtnMc, this.cbCloseButton);
            this._btnClose.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcBase.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._btnBuildNormal = new EmploymentBuildingBtn(this._mcBase.summonSoldierIconMc, this.cbBuildingButton, this.cbBuildingButtonMouseOver, this.cbBuildingButtonMouseOut);
            this._btnBuildNormal.setId(CommonConstant.EMPLOYMENT_TYPE_NORMAL);
            ButtonManager.getInstance().addButtonBase(this._btnBuildNormal);
            this._btnBuildNormal.setBoardText(MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_BUILDING_NAME_NORMAL));
            this._btnBuildNormal.setHitMovieClip(this._mcBase.summonSoldierIconMc.collisionMc);
            this._btnBuildNormal.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._btnBuildHigh = new EmploymentBuildingBtn(this._mcBase.summonHighGradeIconMc, this.cbBuildingButton, this.cbBuildingButtonMouseOver, this.cbBuildingButtonMouseOut);
            this._btnBuildHigh.setId(CommonConstant.EMPLOYMENT_TYPE_HIGH);
            ButtonManager.getInstance().addButtonBase(this._btnBuildHigh);
            this._btnBuildHigh.setBoardText(MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_BUILDING_NAME_HIGH));
            this._btnBuildHigh.setHitMovieClip(this._mcBase.summonHighGradeIconMc.collisionMc);
            this._btnBuildHigh.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._btnBuildSpecial = new EmploymentBuildingBtn(this._mcBase.summonSpecialIconMc, this.cbBuildingButton, this.cbBuildingButtonMouseOver, this.cbBuildingButtonMouseOut);
            this._btnBuildSpecial.setId(CommonConstant.EMPLOYMENT_TYPE_SPECIAL);
            ButtonManager.getInstance().addButtonBase(this._btnBuildSpecial);
            this._btnBuildSpecial.setBoardText(MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_BUILDING_NAME_SPECIAL));
            this._btnBuildSpecial.setHitMovieClip(this._mcBase.summonSpecialIconMc.collisionMc);
            this._btnBuildSpecial.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._btnBuildLimited = new EmploymentBuildingBtn(this._mcBase.summonLimitIconMc, this.cbBuildingButton, this.cbBuildingButtonMouseOver, this.cbBuildingButtonMouseOut);
            this._btnBuildLimited.setId(CommonConstant.EMPLOYMENT_TYPE_LIMITED);
            ButtonManager.getInstance().addButtonBase(this._btnBuildLimited);
            this._btnBuildLimited.setBoardText(MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_BUILDING_NAME_LIMITED));
            this._btnBuildLimited.setHitMovieClip(this._mcBase.summonLimitIconMc.collisionMc);
            this._btnBuildLimited.enterSeId = ButtonBase.SE_DECIDE_ID;
            var _loc_2:* = TimeClock.getNowTime();
            if (this._limitedEmploymentData && _loc_2 >= this._limitedEmploymentData.startTime && _loc_2 <= this._limitedEmploymentData.endTime)
            {
                if (this._limitedEmploymentData && this._limitedEmploymentData.endDispFlag)
                {
                    TextControl.setText(this._mcBase.periodNumMc.textMc.textDt, this.getEndTimeText(this._limitedEmploymentData.endTime));
                    this._mcBase.periodNumMc.visible = true;
                }
                else
                {
                    this._mcBase.periodNumMc.visible = false;
                }
            }
            else
            {
                this._btnBuildLimited.bAvailable = false;
                this._btnBuildLimited.setDisable(true);
                this._btnBuildLimited.setVisible(false);
                this._mcBase.periodNumMc.visible = false;
            }
            this._featuredPlayer = new EmploymentFeaturedPlayer(this._mcBase.charaNull, this._mcBase.CharaInfoMc, this._mcBase.CharaStatusMC, this._btnBuildNormal.getMoveClip().localToGlobal(new Point()), this._btnBuildHigh.getMoveClip().localToGlobal(new Point()), this._btnBuildSpecial.getMoveClip().localToGlobal(new Point()), this._btnBuildLimited.getMoveClip().localToGlobal(new Point()), this._aFeaturedPlayer, this._aProbabilityTable);
            if (SoundManager.getInstance().bgmId != SoundId.BGM_BGM_INS_DRAFT)
            {
                SoundManager.getInstance().playBgm(SoundId.BGM_BGM_INS_DRAFT);
            }
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function release() : void
        {
            ButtonManager.getInstance().removeButton(this._btnClose);
            this._btnClose = null;
            ButtonManager.getInstance().removeButton(this._btnBuildNormal);
            this._btnBuildNormal = null;
            ButtonManager.getInstance().removeButton(this._btnBuildHigh);
            this._btnBuildHigh = null;
            ButtonManager.getInstance().removeButton(this._btnBuildSpecial);
            this._btnBuildSpecial = null;
            ButtonManager.getInstance().removeButton(this._btnBuildLimited);
            this._btnBuildLimited = null;
            if (this._freeNumBalloon)
            {
                this._freeNumBalloon.release();
            }
            this._freeNumBalloon = null;
            if (this._isoFirstPop)
            {
                this._isoFirstPop.release();
            }
            this._isoFirstPop = null;
            if (this._isoBase)
            {
                this._isoBase.release();
            }
            this._isoBase = null;
            if (this._employHeader)
            {
                this._employHeader.release();
            }
            this._employHeader = null;
            if (this._employNavi)
            {
                this._employNavi.release();
            }
            this._employNavi = null;
            if (this._employNormalMenu)
            {
                this._employNormalMenu.release();
            }
            this._employNormalMenu = null;
            if (this._employHighClassMenu)
            {
                this._employHighClassMenu.release();
            }
            this._employHighClassMenu = null;
            if (this._employSpecialMenu)
            {
                this._employSpecialMenu.release();
            }
            this._employSpecialMenu = null;
            if (this._employLimitedMenu)
            {
                this._employLimitedMenu.release();
            }
            this._employLimitedMenu = null;
            if (this._employBanner)
            {
                this._employBanner.release();
            }
            this._employBanner = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            if (this._mcBG && this._mcBG.parent)
            {
                this._mcBG.parent.removeChild(this._mcBG);
            }
            this._mcBG = null;
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
                    this.initPhaseOpen();
                    break;
                }
                case _PHASE_HOME:
                {
                    this.initPhaseHome();
                    break;
                }
                case _PHASE_EMPLOYMENT_NORMAL:
                {
                    this.initPhaseEmploymentNormal();
                    break;
                }
                case _PHASE_EMPLOYMENT_HIGH:
                {
                    this.initPhaseEmploymentHigh();
                    break;
                }
                case _PHASE_EMPLOYMENT_SPECIAL:
                {
                    this.initPhaseEmploymentSpecial();
                    break;
                }
                case _PHASE_EMPLOYMENT_LIMITED:
                {
                    this.initPhaseEmploymentLimited();
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
            if (this._featuredPlayer)
            {
                this._featuredPlayer.control(param1);
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
                    this.controlPhaseOpen(param1);
                    break;
                }
                case _PHASE_HOME:
                {
                    this.controlPhaseHome(param1);
                    break;
                }
                case _PHASE_EMPLOYMENT_NORMAL:
                {
                    this.controlPhaseEmploymentNormal(param1);
                    break;
                }
                case _PHASE_EMPLOYMENT_HIGH:
                {
                    this.controlPhaseEmploymentHighClass(param1);
                    break;
                }
                case _PHASE_EMPLOYMENT_SPECIAL:
                {
                    this.controlPhaseEmploymentSpecial(param1);
                    break;
                }
                case _PHASE_EMPLOYMENT_LIMITED:
                {
                    this.controlPhaseEmploymentLimited(param1);
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.controlPhaseClose(param1);
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
            var aBtn:Array;
            if (this._aEmploymentBannerData && this._aEmploymentBannerData.length > 0)
            {
                this._mcBase.bannerMc.visible = true;
                this._employBanner = new EmploymentBanner(this._mcBase.bannerMc, this._aEmploymentBannerData);
            }
            else
            {
                this._mcBase.bannerMc.visible = false;
            }
            if (TutorialManager.getInstance().isTutorial())
            {
                aBtn;
                this._btnBuildNormal.bAvailable = false;
                this._btnBuildSpecial.bAvailable = false;
                this._btnBuildLimited.bAvailable = false;
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_EMPLOY_1))
                {
                    aBtn.push(this._btnBuildHigh);
                }
                else
                {
                    this._btnBuildHigh.bAvailable = false;
                    this._btnClose.setDisable(false);
                    aBtn.push(this._btnClose);
                }
                ButtonManager.getInstance().seal(aBtn, true);
            }
            this.btnEnable(false);
            this.openDisplay(function () : void
            {
                setPhase(_PHASE_MAINTENANCE);
                return;
            }// end function
            , this._employHeader.bClose);
            this._employHeader.subClose();
            return;
        }// end function

        private function controlPhaseOpen(param1:Number) : void
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
                this.setPhase(_PHASE_HOME);
            }
            return;
        }// end function

        private function controlPhaseMaintenance() : void
        {
            if (Main.GetProcess().maintenance == null)
            {
                this.setPhase(_PHASE_HOME);
            }
            return;
        }// end function

        private function initPhaseHome() : void
        {
            this.btnEnable(true);
            if (!this._bHighFirstEmployed && !this._isoFirstPop.bOpened)
            {
                this._isoFirstPop.setIn();
            }
            if (this._featuredPlayer)
            {
                this._featuredPlayer.setEnable(true);
            }
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_EMPLOY_1))
            {
                TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_EMPLOY_1, function () : void
            {
                TutorialManager.getInstance().setTutorialArrow(_btnBuildHigh.getMoveClip(), TutorialManager.TUTORIAL_ARROW_DIRECTION_DOWN, TutorialManager.TUTORIAL_ARROW_POS_LEFT_UP_2);
                TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_EMPLOYMENT_001), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
                return;
            }// end function
            );
            }
            var nowTime:* = TimeClock.getNowTime();
            if (this._limitedEmploymentData && this._limitedEmploymentData.endDispFlag)
            {
                TextControl.setText(this._mcBase.periodNumMc.textMc.textDt, this.getEndTimeText(this._limitedEmploymentData.endTime));
                this._mcBase.periodNumMc.visible = true;
            }
            else
            {
                this._mcBase.periodNumMc.visible = false;
            }
            return;
        }// end function

        private function controlPhaseHome(param1:Number) : void
        {
            if (this._employBanner)
            {
                this._employBanner.control(param1);
            }
            return;
        }// end function

        private function initPhaseEmploymentNormal() : void
        {
            this.btnEnable(false);
            this.closeDisplay(function () : void
            {
                var _loc_1:* = null;
                if (_employNormalMenu)
                {
                    _employNormalMenu.release();
                }
                _employNormalMenu = null;
                for each (_loc_1 in _aProbabilityTable)
                {
                    
                    if (_loc_1.type == CommonConstant.EMPLOYMENT_TYPE_NORMAL_DS)
                    {
                        _employNormalMenu = new EmploymentNormalMenu(_layer, [], _loc_1.aProbabilityContent, cbNormalMenuClose);
                        break;
                    }
                }
                _employHeader.setSubTitle(MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_BUILDING_NAME_NORMAL));
                _employHeader.subOpen();
                return;
            }// end function
            , false);
            return;
        }// end function

        private function controlPhaseEmploymentNormal(param1:Number) : void
        {
            if (this._employNormalMenu)
            {
                this._employNormalMenu.control(param1);
            }
            return;
        }// end function

        private function initPhaseEmploymentHigh() : void
        {
            this.btnEnable(false);
            this.closeDisplay(function () : void
            {
                var _loc_3:* = null;
                if (_employHighClassMenu)
                {
                    _employHighClassMenu.release();
                }
                _employHighClassMenu = null;
                var _loc_1:* = null;
                var _loc_2:* = null;
                for each (_loc_3 in _aProbabilityTable)
                {
                    
                    if (_loc_3.type == CommonConstant.EMPLOYMENT_TYPE_HIGH)
                    {
                        _loc_1 = _loc_3;
                        if (_bHighFirstEmployed)
                        {
                            break;
                        }
                    }
                    else if (_loc_3.type == CommonConstant.EMPLOYMENT_TYPE_HIGH_FIRST)
                    {
                        _loc_2 = _loc_3;
                    }
                    if (_loc_1 && _loc_2)
                    {
                        break;
                    }
                }
                _employHighClassMenu = new EmploymentHighClassMenu(_layer, CommonConstant.EMPLOYMENT_TYPE_HIGH, _highEmploymentData.price, _highEmploymentData.boxPrice, _highEmploymentData.bBoxFirstBonus, _loc_1.aProbabilityContent, _loc_2 && !_bHighFirstEmployed ? (_loc_2.aProbabilityContent) : (null), cbHighMenuClose);
                _employHeader.setSubTitle(MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_BUILDING_NAME_HIGH));
                _employHeader.subOpen();
                return;
            }// end function
            , false);
            return;
        }// end function

        private function initPhaseEmploymentSpecial() : void
        {
            this.btnEnable(false);
            this.closeDisplay(function () : void
            {
                var _loc_1:* = null;
                if (_employSpecialMenu)
                {
                    _employSpecialMenu.release();
                }
                _employSpecialMenu = null;
                for each (_loc_1 in _aProbabilityTable)
                {
                    
                    if (_loc_1.type == CommonConstant.EMPLOYMENT_TYPE_SPECIAL)
                    {
                        _employSpecialMenu = new EmploymentSpecialMenu(_layer, CommonConstant.EMPLOYMENT_TYPE_SPECIAL, _specialEmploymentData.price, _loc_1.aProbabilityContent, cbSpecialMenuClose);
                        break;
                    }
                }
                _employHeader.setSubTitle(MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_BUILDING_NAME_SPECIAL));
                _employHeader.subOpen();
                return;
            }// end function
            , false);
            return;
        }// end function

        private function initPhaseEmploymentLimited() : void
        {
            this.btnEnable(false);
            this.closeDisplay(function () : void
            {
                var _loc_1:* = null;
                if (_employLimitedMenu)
                {
                    _employLimitedMenu.release();
                }
                _employLimitedMenu = null;
                for each (_loc_1 in _aProbabilityTable)
                {
                    
                    if (_loc_1.type == CommonConstant.EMPLOYMENT_TYPE_LIMITED)
                    {
                        _employLimitedMenu = new EmploymentHighClassMenu(_layer, CommonConstant.EMPLOYMENT_TYPE_LIMITED, _limitedEmploymentData.price, _limitedEmploymentData.boxPrice, _limitedEmploymentData.bBoxFirstBonus, _loc_1.aProbabilityContent, null, cbLimitedMenuClose, _limitedEmploymentData);
                        break;
                    }
                }
                _employHeader.setSubTitle(MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_BUILDING_NAME_LIMITED));
                _employHeader.subOpen();
                return;
            }// end function
            , false);
            return;
        }// end function

        private function controlPhaseEmploymentHighClass(param1:Number) : void
        {
            if (this._employHighClassMenu)
            {
                this._employHighClassMenu.control(param1);
            }
            return;
        }// end function

        private function controlPhaseEmploymentSpecial(param1:Number) : void
        {
            if (this._employSpecialMenu)
            {
                this._employSpecialMenu.control(param1);
            }
            return;
        }// end function

        private function controlPhaseEmploymentLimited(param1:Number) : void
        {
            if (this._employLimitedMenu)
            {
                this._employLimitedMenu.control(param1);
            }
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this.btnEnable(false);
            if (this._featuredPlayer)
            {
                this._featuredPlayer.setEnable(false);
            }
            this.closeDisplay();
            return;
        }// end function

        private function controlPhaseClose(param1:Number) : void
        {
            return;
        }// end function

        private function btnEnable(param1:Boolean) : void
        {
            this.buildingBtnEnable(param1);
            this._btnClose.setDisableFlag(!param1);
            return;
        }// end function

        private function buildingBtnEnable(param1:Boolean) : void
        {
            this._btnBuildNormal.setDisableFlag(!param1 || !this._btnBuildNormal.bAvailable);
            this._btnBuildHigh.setDisableFlag(!param1 || !this._btnBuildHigh.bAvailable);
            this._btnBuildSpecial.setDisableFlag(!param1 || !this._btnBuildSpecial.bAvailable);
            this._btnBuildLimited.setDisableFlag(!param1 || !this._btnBuildLimited.bAvailable);
            return;
        }// end function

        private function openDisplay(param1:Function = null, param2:Boolean = true) : void
        {
            var cbOpen:* = param1;
            var bHeaderOpen:* = param2;
            (this._mcBase.newWindMc as MovieClip).visible = false;
            this._freeNumBalloon.update();
            if (this._employBanner)
            {
                this._employBanner.openBanner();
            }
            this._isoBase.setIn(function () : void
            {
                _employNavi.open();
                _employNavi.openBalloon();
                if (cbOpen != null)
                {
                    cbOpen();
                }
                return;
            }// end function
            );
            if (bHeaderOpen)
            {
                this._employHeader.open();
            }
            return;
        }// end function

        private function closeDisplay(param1:Function = null, param2:Boolean = true) : void
        {
            var cbClose:* = param1;
            var bHeaderClose:* = param2;
            this._employNavi.close(function () : void
            {
                _isoBase.setOut(function () : void
                {
                    _mcBase.freeNumMc.visible = false;
                    _mcBase.periodNumMc.visible = false;
                    if (cbClose != null)
                    {
                        cbClose();
                    }
                    return;
                }// end function
                );
                if (!_isoFirstPop.bClosed)
                {
                    _isoFirstPop.setOut();
                }
                if (bHeaderClose)
                {
                    _employHeader.close();
                }
                return;
            }// end function
            );
            if (this._employBanner)
            {
                this._employBanner.closeBanner();
            }
            return;
        }// end function

        private function calcVolunteerUnlockTimeSec() : uint
        {
            var _loc_1:* = 60 * 60 * 24;
            var _loc_2:* = 60 * 60 * 9;
            var _loc_3:* = TimeClock.getNowTime() + _loc_2;
            return _loc_1 - _loc_3 % _loc_1;
        }// end function

        private function updateEmploymentInfo(param1:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            this._aProbabilityTable = [];
            this._aFeaturedPlayer = [];
            var _loc_2:* = false;
            var _loc_3:* = TimeClock.getNowTime();
            if (this._limitedEmploymentData && _loc_3 >= this._limitedEmploymentData.startTime && _loc_3 <= this._limitedEmploymentData.endTime)
            {
                _loc_2 = true;
            }
            for each (_loc_4 in param1)
            {
                
                _loc_5 = [];
                for each (_loc_6 in _loc_4.aProbabilityTableContent)
                {
                    
                    _loc_5.push(new EmploymentProbabilityTableContent(_loc_6.rarity, _loc_6.ratio));
                }
                _loc_7 = new EmploymentProbabilityTable(_loc_4.type, _loc_5, _loc_4.msg);
                if (_loc_7.type == CommonConstant.EMPLOYMENT_TYPE_HIGH_FIRST && TutorialManager.getInstance().isTutorial())
                {
                    continue;
                }
                this._aProbabilityTable.push(_loc_7);
                if (_loc_7.type == CommonConstant.EMPLOYMENT_TYPE_HIGH_FIRST)
                {
                    this._bHighFirstEmployed = false;
                    continue;
                }
                if (!TutorialManager.getInstance().isTutorial())
                {
                    for each (_loc_9 in _loc_4.aFeatured)
                    {
                        
                        _loc_8 = new EmploymentFeaturedPlayerData(_loc_4.type, EmploymentFeaturedPlayerData.FEATURED_TYPE_FEATURED, _loc_9);
                        if (_loc_8.employmentType != CommonConstant.EMPLOYMENT_TYPE_LIMITED || _loc_2)
                        {
                            this._aFeaturedPlayer.push(_loc_8);
                        }
                    }
                    for each (_loc_9 in _loc_4.aNewcomer)
                    {
                        
                        _loc_8 = new EmploymentFeaturedPlayerData(_loc_4.type, EmploymentFeaturedPlayerData.FEATURED_TYPE_NEW_COMER, _loc_9);
                        if (_loc_8.employmentType != CommonConstant.EMPLOYMENT_TYPE_LIMITED || _loc_2)
                        {
                            this._aFeaturedPlayer.push(_loc_8);
                        }
                    }
                    for each (_loc_9 in _loc_4.aSrare)
                    {
                        
                        _loc_8 = new EmploymentFeaturedPlayerData(_loc_4.type, EmploymentFeaturedPlayerData.FEATURED_TYPE_MORE_SR, _loc_9);
                        if (_loc_8.employmentType != CommonConstant.EMPLOYMENT_TYPE_LIMITED || _loc_2)
                        {
                            this._aFeaturedPlayer.push(_loc_8);
                        }
                    }
                }
            }
            return;
        }// end function

        private function resetEmploymentInfo() : void
        {
            this._btnBuildLimited.bAvailable = false;
            this._btnBuildLimited.setDisable(true);
            this._btnBuildLimited.setVisible(false);
            NetManager.getInstance().request(new NetTaskEmployment(function (param1:NetResult) : void
            {
                cbConnectEmployment(param1);
                updateEmploymentInfo(param1.data.aProbabilityTable);
                if (_featuredPlayer)
                {
                    _featuredPlayer.resetFeaturedPlayer(_aFeaturedPlayer, _aProbabilityTable);
                }
                setPhase(_PHASE_OPEN);
                return;
            }// end function
            ));
            return;
        }// end function

        private function cbCloseButton(param1:int) : void
        {
            if (this._phase == _PHASE_HOME)
            {
                this.setPhase(_PHASE_CLOSE);
            }
            return;
        }// end function

        private function cbBuildingButtonMouseOver(param1:int) : void
        {
            var msg:String;
            var id:* = param1;
            msg;
            switch(id)
            {
                case CommonConstant.EMPLOYMENT_TYPE_NORMAL:
                {
                    msg = TextControl.formatIdText(MessageId.EMPLOYMENT_NAVI_MESSAGE_NORMAL);
                    break;
                }
                case CommonConstant.EMPLOYMENT_TYPE_HIGH:
                {
                    msg = TextControl.formatIdText(MessageId.EMPLOYMENT_NAVI_MESSAGE_HIGH);
                    break;
                }
                case CommonConstant.EMPLOYMENT_TYPE_SPECIAL:
                {
                    msg = TextControl.formatIdText(MessageId.EMPLOYMENT_NAVI_MESSAGE_SPECIAL);
                    break;
                }
                case CommonConstant.EMPLOYMENT_TYPE_LIMITED:
                {
                    msg = TextControl.formatIdText(MessageId.EMPLOYMENT_NAVI_MESSAGE_LIMITED);
                    break;
                }
                default:
                {
                    msg = MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_NAVI_MESSAGE);
                    break;
                    break;
                }
            }
            if (this._employNavi)
            {
                this._employNavi.closeBalloon(function () : void
            {
                _employNavi.setText(msg);
                _employNavi.openBalloon();
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function cbBuildingButtonMouseOut(param1:int) : void
        {
            var id:* = param1;
            if (this._employNavi)
            {
                this._employNavi.closeBalloon(function () : void
            {
                _employNavi.setText(MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_NAVI_MESSAGE));
                _employNavi.openBalloon();
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function cbBuildingButton(param1:int) : void
        {
            TutorialManager.getInstance().hideTutorial();
            if (this._featuredPlayer)
            {
                this._featuredPlayer.setEnable(false);
            }
            switch(param1)
            {
                case CommonConstant.EMPLOYMENT_TYPE_NORMAL:
                {
                    this.setPhase(_PHASE_EMPLOYMENT_NORMAL);
                    break;
                }
                case CommonConstant.EMPLOYMENT_TYPE_HIGH:
                {
                    this.setPhase(_PHASE_EMPLOYMENT_HIGH);
                    break;
                }
                case CommonConstant.EMPLOYMENT_TYPE_SPECIAL:
                {
                    this.setPhase(_PHASE_EMPLOYMENT_SPECIAL);
                    break;
                }
                case CommonConstant.EMPLOYMENT_TYPE_LIMITED:
                {
                    this.setPhase(_PHASE_EMPLOYMENT_LIMITED);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function cbNormalMenuClose() : void
        {
            if (this._employNormalMenu)
            {
                this._bGoTradingPost = this._employNormalMenu.bGoTradingPost;
                this._bGoRetire = this._employNormalMenu.bGoRetire;
                this._employNormalMenu.release();
            }
            this._employNormalMenu = null;
            if (this._bGoTradingPost || this._bGoRetire)
            {
                this._phase = _PHASE_FORCE_CLOSE;
            }
            else
            {
                this.setPhase(_PHASE_OPEN);
            }
            return;
        }// end function

        private function cbHighMenuClose() : void
        {
            var _loc_1:* = this._employHighClassMenu.bReset;
            this._bHighFirstEmployed = this._employHighClassMenu.isFirstEmployed();
            if (this._employHighClassMenu)
            {
                this._highEmploymentData.bBoxFirstBonus = this._employHighClassMenu.bBoxFirstBonus;
                this._bGoTradingPost = this._employHighClassMenu.bGoTradingPost;
                this._bGoRetire = this._employHighClassMenu.bGoRetire;
                this._employHighClassMenu.release();
            }
            this._employHighClassMenu = null;
            if (TutorialManager.getInstance().isTutorial() || this._bGoTradingPost || this._bGoRetire)
            {
                this._phase = _PHASE_FORCE_CLOSE;
                return;
            }
            if (_loc_1)
            {
                this.resetEmploymentInfo();
                return;
            }
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        private function cbSpecialMenuClose() : void
        {
            var _loc_1:* = this._employSpecialMenu.bReset;
            if (this._employSpecialMenu)
            {
                this._bGoTradingPost = this._employSpecialMenu.bGoTradingPost;
                this._bGoRetire = this._employSpecialMenu.bGoRetire;
                this._employSpecialMenu.release();
            }
            this._employSpecialMenu = null;
            if (this._bGoTradingPost || this._bGoRetire)
            {
                this._phase = _PHASE_FORCE_CLOSE;
                return;
            }
            if (_loc_1)
            {
                this.resetEmploymentInfo();
                return;
            }
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        private function cbLimitedMenuClose() : void
        {
            var _loc_1:* = this._employLimitedMenu.bReset;
            if (this._employLimitedMenu)
            {
                this._limitedEmploymentData.bBoxFirstBonus = this._employLimitedMenu.bBoxFirstBonus;
                this._bGoTradingPost = this._employLimitedMenu.bGoTradingPost;
                this._bGoRetire = this._employLimitedMenu.bGoRetire;
                this._employLimitedMenu.release();
            }
            this._employLimitedMenu = null;
            if (this._bGoTradingPost || this._bGoRetire)
            {
                this._phase = _PHASE_FORCE_CLOSE;
                return;
            }
            if (_loc_1)
            {
                this.resetEmploymentInfo();
                return;
            }
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        private function getEndTimeText(param1:uint) : String
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_2:* = "";
            var _loc_3:* = TimeClock.getNowTime();
            var _loc_4:* = param1 - _loc_3;
            if (param1 < _loc_3)
            {
                _loc_4 = 0;
            }
            var _loc_5:* = _loc_4 / 86400;
            var _loc_6:* = _loc_4 / 3600;
            var _loc_7:* = _loc_4 / 60;
            if (_loc_4 / 60 < 0)
            {
                _loc_7 = 0;
            }
            if (_loc_4 >= 86400)
            {
                _loc_8 = new Date();
                _loc_8.setTime(param1 * 1000);
                _loc_9 = new Date(_loc_8.fullYear, _loc_8.month, _loc_8.date);
                _loc_10 = new Date();
                _loc_10.setTime(_loc_3 * 1000);
                _loc_11 = new Date(_loc_10.fullYear, _loc_10.month, _loc_10.date);
                _loc_12 = Math.ceil((_loc_9.time - _loc_11.time) / (24 * 60 * 60 * 1000));
                _loc_2 = TextControl.formatIdText(MessageId.EMPLOYMENT_LIMITED_BALOON_TEXT_DAYS, _loc_12);
            }
            else if (_loc_4 >= 3600)
            {
                _loc_2 = TextControl.formatIdText(MessageId.EMPLOYMENT_LIMITED_BALOON_TEXT_HOURS, _loc_6);
            }
            else
            {
                _loc_2 = TextControl.formatIdText(MessageId.EMPLOYMENT_LIMITED_BALOON_TEXT_MINUTES, _loc_7);
            }
            return _loc_2;
        }// end function

    }
}
