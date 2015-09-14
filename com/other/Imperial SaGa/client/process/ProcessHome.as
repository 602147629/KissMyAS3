package process
{
    import asset.*;
    import background.*;
    import barracks.*;
    import button.*;
    import character.*;
    import cooperateCode.*;
    import credit.*;
    import crownHistory.*;
    import develop.*;
    import employment.*;
    import externalLinkage.*;
    import flash.display.*;
    import flash.geom.*;
    import history.*;
    import home.*;
    import item.*;
    import layer.*;
    import loginBonus.*;
    import message.*;
    import network.*;
    import notice.*;
    import player.*;
    import popup.*;
    import resource.*;
    import script.*;
    import sound.*;
    import storage.*;
    import subdualPoint.*;
    import topbar.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class ProcessHome extends ProcessBase
    {
        private const _PHASE_OPEN:int = 10;
        private const _PHASE_CLOSE:int = 11;
        private const _PHASE_MAINTENANCE:int = 20;
        private const _PHASE_NOTICE:int = 21;
        private const _PHASE_ALREADY_MANAGEMENT_NOTICE:int = 210;
        private const _PHASE_LOGIN_BONUS:int = 30;
        private const _PHASE_LOGIN_BONUS2:int = 31;
        private const _PHASE_LOGIN_BONUS_DISP:int = 32;
        private const _PHASE_CAMPAIGN_RECEIVE:int = 33;
        private const _PHASE_SPECIAL_NOTICE:int = 40;
        private const _PHASE_SPECIAL_NOTICE_RECEIVE:int = 41;
        private const _PHASE_LOST_NOTICE:int = 42;
        private const _PHASE_LOST_NOTICE_RECEIVE:int = 43;
        private const _PHASE_STORAGE_NOTICE:int = 44;
        private const _PHASE_STORAGE_NOTICE_RECEIVE:int = 45;
        private const _PHASE_THROUGH_NOTICE:int = 46;
        private const _PHASE_THROUGH_NOTICE_RECEIVE:int = 47;
        private const _PHASE_SIMPLE_NOTICE:int = 48;
        private const _PHASE_SIMPLE_NOTICE_RECEIVE:int = 49;
        private const _PHASE_PROVISION:int = 50;
        private const _PHASE_LATER_NOTICE:int = 51;
        private const _PHASE_LATER_NOTICE_RECEIVE:int = 52;
        private const _PHASE_LOCAL_NOTICE:int = 53;
        private const _PHASE_LOST_CHARM:int = 54;
        private const _PHASE_CHARACTER_LIST_EMPTY_CHECK:int = 60;
        private const _PHASE_FORMATION_EMPTY_CHECK:int = 61;
        private const _PHASE_EMPEROR_SELECT_CHECK:int = 90;
        private const _PHASE_EMEPROR_SELECT:int = 91;
        private const _PHASE_ROUTE_SELECT:int = 92;
        private const _PHASE_SCRIPT_CHECK:int = 100;
        private const _PHASE_SCRIPT_EXE:int = 101;
        private const _PHASE_DIRECT_RECOVERY_CHECK:int = 102;
        private const _PHASE_RECOVERY_EFFECT:int = 103;
        private const _PHASE_MAIN:int = 500;
        private const _PHASE_MY_PAGE:int = 501;
        private const _PHASE_RE_OPEN:int = 502;
        private const _PHASE_ALBUM:int = 503;
        private const _PHASE_CHRONOLOGY:int = 504;
        private const _PHASE_CODE_INPUT:int = 505;
        private const _PHASE_CROWN_HISTORY:int = 506;
        private const _PHASE_CREDIT:int = 507;
        private const _PHASE_COOPERATE_CODE:int = 508;
        private const _PHASE_NAME_ENTRY:int = 509;
        private const _PHASE_END:int = 999;
        private const _HOME_DARKEN:Number = 0.5;
        private var _bConnectionGet:Boolean;
        private var _phase:int;
        private var _layer:LayerHome;
        private var _baseMc:MovieClip;
        private var _isoMain:InStayOut;
        private var _bEmperorSelect:Boolean;
        private var _emperor:Emperor;
        private var _curParty:HomeCurrentParty;
        private var _institution:InstitutionMenu;
        private var _palace:Palace;
        private var _album:Album;
        private var _history:HistoryMain;
        private var _crownHistory:CrownHistoryWindow;
        private var _credit:CreditMain;
        private var _cooperateCodeMain:CooperateCodeMain;
        private var _nameEntry:HomeNameEntryMain;
        private var _loginNotice:LoginNoticeWindow;
        private var _simpleNotice:SimpleNoticeWindow;
        private var _lostNotice:LostNoticeWindow;
        private var _aThroughId:Array;
        private var _scriptMain:ScriptMain;
        private var _loginBonus:LoginBonusMain;
        private var _loginBonusData:LoginBonusData;
        private var _subdualPointReward:SubdualPointRewardReceivePopup;
        private var _provisionCheck:ProvisionChecker;
        private var _nextProcessId:int;
        private var _bgmId:int;
        private var _sortieChecker:HomeSortieChecker;
        private var _bHomeDarken:Boolean;
        private var _waitHomeDarken:Number;
        private var _gotoFormationMessageId:int;
        private var _restFinishedPopup:BarracksRestFinishedPopup;
        private var _aRestPlayerUniqueId:Array;
        private var _infoBtn:ButtonBase;
        private var _dailyMissionIcon:HomeDailyMissionIcon;
        private var _freeNumBalloon:EmploymentSummonFreeNumBalloon;
        private var _facilityInfo:InstitutionInfo;
        private var _facilityGradeup:Lv0FacilityUpgrade;
        private var _facilityHomeGradeup:HomeFacilityUpGradeCount;
        private var _codeInput:CodeInput;

        public function ProcessHome()
        {
            this._scriptMain = null;
            this._palace = null;
            this._album = null;
            this._crownHistory = null;
            this._bHomeDarken = false;
            this._waitHomeDarken = 0;
            this._loginBonus = null;
            this._loginBonusData = null;
            this._subdualPointReward = null;
            bTopbarButtonDisable = true;
            this._gotoFormationMessageId = Constant.EMPTY_ID;
            return;
        }// end function

        override public function release() : void
        {
            if (this._freeNumBalloon)
            {
                this._freeNumBalloon.release();
            }
            this._freeNumBalloon = null;
            if (this._dailyMissionIcon)
            {
                this._dailyMissionIcon.release();
            }
            this._dailyMissionIcon = null;
            if (this._infoBtn)
            {
                ButtonManager.getInstance().removeButton(this._infoBtn);
            }
            this._infoBtn = null;
            BarracksAutoRestManager.getInstance().delCbRest(this.cbRestEnd);
            this._aRestPlayerUniqueId = null;
            if (this._restFinishedPopup)
            {
                this._restFinishedPopup.release();
            }
            this._restFinishedPopup = null;
            if (this._sortieChecker)
            {
                this._sortieChecker.release();
            }
            this._sortieChecker = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._institution)
            {
                this._institution.release();
            }
            this._institution = null;
            if (this._emperor)
            {
                this._emperor.release();
            }
            this._emperor = null;
            if (this._curParty)
            {
                this._curParty.release();
            }
            this._curParty = null;
            if (this._palace)
            {
                this._palace.release();
            }
            this._palace = null;
            if (this._album)
            {
                this._album.release();
            }
            this._album = null;
            if (this._history)
            {
                this._history.release();
            }
            this._history = null;
            if (this._crownHistory)
            {
                this._crownHistory.release();
            }
            this._crownHistory = null;
            if (this._credit)
            {
                this._credit.release();
            }
            this._credit = null;
            if (this._cooperateCodeMain)
            {
                this._cooperateCodeMain.release();
            }
            this._cooperateCodeMain = null;
            if (this._nameEntry)
            {
                this._nameEntry.release();
            }
            this._nameEntry = null;
            if (this._loginNotice)
            {
                this._loginNotice.release();
            }
            this._loginNotice = null;
            if (this._simpleNotice)
            {
                this._simpleNotice.release();
            }
            this._simpleNotice = null;
            if (this._lostNotice)
            {
                this._lostNotice.release();
            }
            this._lostNotice = null;
            if (this._subdualPointReward)
            {
                this._subdualPointReward.release();
            }
            this._subdualPointReward = null;
            if (this._loginBonus)
            {
                this._loginBonus.release();
            }
            this._loginBonus = null;
            if (this._provisionCheck)
            {
                this._provisionCheck.release();
            }
            this._provisionCheck = null;
            ScriptManager.getInstance().releaseProcess();
            TutorialManager.getInstance().release();
            super.release();
            return;
        }// end function

        override public function init() : void
        {
            var loginNoticeInfo:ManagementNoticeInfo;
            var playerInfo:PlayerInformation;
            var lostData:PlayerLostData;
            var aPlayerUniqueId:Array;
            var uniqueId:int;
            var playerPersonal:PlayerPersonal;
            super.init();
            this._layer = new LayerHome();
            addChild(this._layer);
            var backLoader:* = ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_BackGround.swf");
            backLoader.bRemoveLock = true;
            ResourceManager.getInstance().loadResource(ResourcePath.HOME_PATH + "UI_Home.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.HOME_PATH + "UI_Chronology.swf");
            ResourceManager.getInstance().loadArray(CreditMain.getResource());
            var emperorId:* = UserDataManager.getInstance().userData.emperorId;
            var emperorInfo:* = PlayerManager.getInstance().getPlayerInformation(emperorId);
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_BUSTUP_PATH + emperorInfo.bustUpFileName);
            ResourceManager.getInstance().loadResource(ResourcePath.NAVI_CHARACTER_PATH);
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Balloon.swf");
            var _loc_2:* = 0;
            var _loc_3:* = NoticeManager.getInstance().aManagementNotice;
            while (_loc_3 in _loc_2)
            {
                
                loginNoticeInfo = _loc_3[_loc_2];
                if (loginNoticeInfo.type == 4)
                {
                    if (loginNoticeInfo.param2.indexOf("http") >= 0)
                    {
                        ResourceManager.getInstance().loadResourceUrl(loginNoticeInfo.param2);
                    }
                }
            }
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf");
            var _loc_2:* = 0;
            var _loc_3:* = NoticeManager.getInstance().aCharacterLost;
            while (_loc_3 in _loc_2)
            {
                
                lostData = _loc_3[_loc_2];
                playerInfo = PlayerManager.getInstance().getPlayerInformation(lostData.playerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + playerInfo.swf);
                ResourceManager.getInstance().loadResource(ResourcePath.CARD_SMALL_PATH + CharacterConstant.ID_CARD + playerInfo.cardFileName);
            }
            NoticeManager.getInstance().loadRemunerationResource();
            ProvisionChecker.loadResource();
            ResourceManager.getInstance().loadArray([ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_INSTANT_HEALING), ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_FREE_HEALING)]);
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            aPlayerUniqueId = UserDataManager.getInstance().userData.aFormationPlayerUniqueId;
            var _loc_2:* = 0;
            var _loc_3:* = aPlayerUniqueId;
            while (_loc_3 in _loc_2)
            {
                
                uniqueId = _loc_3[_loc_2];
                playerPersonal = UserDataManager.getInstance().userData.getPlayerPersonal(uniqueId);
                if (playerPersonal == null)
                {
                    continue;
                }
                playerInfo = PlayerManager.getInstance().getPlayerInformation(playerPersonal.playerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + playerInfo.swf);
            }
            this._bEmperorSelect = false;
            CommonPopup.getInstance().loadResource();
            if (TutorialManager.getInstance().isTutorial())
            {
                TutorialManager.getInstance().loadResource();
            }
            ScriptManager.getInstance().loadScript(ScriptManager.SCRIPT_PATH + "Home/script_home.xml", ScriptScreen.SCREEN_HOME, false);
            ResourceManager.getInstance().loadResource(ResourcePath.FACILITY_PATH + "UI_Barracks.swf");
            this._bgmId = SoundId.BGM_BGM_MYP_ADEL_1;
            switch(UserDataManager.getInstance().userData.chapter)
            {
                case 2:
                {
                    this._bgmId = SoundId.BGM_BGM_MYP_ADEL_2;
                    break;
                }
                case 3:
                {
                    this._bgmId = SoundId.BGM_BGM_MYP_ADEL_3;
                    break;
                }
                case 4:
                {
                    this._bgmId = SoundId.BGM_BGM_MYP_ADEL_4;
                    break;
                }
                default:
                {
                    break;
                }
            }
            SoundManager.getInstance().loadSound(this._bgmId);
            SoundManager.getInstance().loadSound(SoundId.BGM_BGM_INS_PALCE);
            SoundManager.getInstance().loadSoundArray([SoundId.SE_BRANCH, SoundId.SE_COMPOSE_SUCSESS, SoundId.SE_BED, SoundId.SE_REV_ROGINBONUS_TITLE, SoundId.SE_REV_GRADEUP_GATHER, SoundId.SE_REV_LOST_SENSHI]);
            this._bConnectionGet = true;
            if (TutorialManager.getInstance().isTutorial() && TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_HOME_4) && !TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_WORLD_MAP))
            {
                this._bConnectionGet = false;
                NetManager.getInstance().request(new NetTaskTutorialEnd(function (param1:NetResult) : void
            {
                TutorialManager.getInstance().bTutorialProtocol = false;
                UserDataManager.getInstance().tutorialEndPlayerSpReset();
                _bConnectionGet = true;
                return;
            }// end function
            ));
            }
            bResourceLoadWait = true;
            return;
        }// end function

        private function homeStartInit() : void
        {
            if (Main.GetProcess().fade.isFade())
            {
                Main.GetProcess().fade.setFadeIn(0.2);
            }
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            if (this._bConnectionGet == false || ResourceManager.getInstance().isLoaded() == false || ScriptManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false)
            {
                return;
            }
            if (Main.GetProcess().isNowLoading())
            {
                Main.GetProcess().closeLoadingScreen();
                return;
            }
            bResourceLoadWait = false;
            if (TutorialManager.getInstance().isTutorial())
            {
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_HOME_1))
                {
                    UserDataManager.getInstance().userData.setTutorialFormationPlayer();
                }
            }
            Main.GetProcess().createBackGround();
            Main.GetProcess().setBackGroundVisible(true);
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Home.swf", "HomeMain");
            this._baseMc.infoBtnMc.visible = false;
            this._baseMc.summonFreeNumMc.visible = false;
            this._layer.getLayer(LayerHome.MAIN).addChild(this._baseMc);
            this._isoMain = new InStayOut(this._baseMc, true);
            var _loc_1:* = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Home.swf", "HomeEmperor");
            this._emperor = new Emperor(this._layer, _loc_1, UserDataManager.getInstance().userData.emperorId);
            var _loc_2:* = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Home.swf", "HomePartyInfo");
            this._curParty = new HomeCurrentParty(this._layer, _loc_2, this.cbDirectHealingStart, this.cbDirectHealingEnd);
            this._dailyMissionIcon = new HomeDailyMissionIcon(this._baseMc.dailyMissionBtnMc, this._baseMc.FinisheMark12Mc, this.cbDailyMissionBtn, !TutorialManager.getInstance().isTutorial());
            this._sortieChecker = new HomeSortieChecker();
            this._facilityGradeup = new Lv0FacilityUpgrade(this._baseMc);
            this._facilityInfo = new InstitutionInfo();
            this.homeStartInit();
            BarracksAutoRestManager.getInstance().updateCheckPlayer(BarracksAutoRestManager.CHECK_TARGET_PARTY);
            BarracksAutoRestManager.getInstance().addCbRest(this.cbRestEnd);
            this._restFinishedPopup = null;
            this._aRestPlayerUniqueId = [];
            this.setPhase(this._PHASE_MAINTENANCE);
            return;
        }// end function

        private function changeHomeDarken(param1:Number) : void
        {
            var _loc_2:* = 1 - 0.5 * param1 / this._HOME_DARKEN;
            var _loc_3:* = this._layer.getLayer(LayerHome.MAIN);
            _loc_3.transform.colorTransform = new ColorTransform(_loc_2, _loc_2, _loc_2);
            var _loc_4:* = Main.GetProcess().background;
            Main.GetProcess().background.setColorTransform(new ColorTransform(_loc_2, _loc_2, _loc_2));
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            if (this._bHomeDarken)
            {
                if (this._waitHomeDarken < this._HOME_DARKEN)
                {
                    this._waitHomeDarken = this._waitHomeDarken + param1;
                    if (this._waitHomeDarken > this._HOME_DARKEN)
                    {
                        this._waitHomeDarken = this._HOME_DARKEN;
                    }
                    this.changeHomeDarken(this._waitHomeDarken);
                }
            }
            else if (this._waitHomeDarken > 0)
            {
                this._waitHomeDarken = this._waitHomeDarken - param1;
                if (this._waitHomeDarken < 0)
                {
                    this._waitHomeDarken = 0;
                }
                this.changeHomeDarken(this._waitHomeDarken);
            }
            if (this._institution != null)
            {
                this._institution.countControl(param1, this._phase == this._PHASE_MAIN);
            }
            if (this._phase != this._PHASE_MAIN)
            {
                this._curParty.setMouseEnable(false);
            }
            BarracksAutoRestManager.getInstance().control(param1);
            if (this._phase == this._PHASE_MAIN || this._phase == this._PHASE_ALBUM || this._phase == this._PHASE_CHRONOLOGY || this._phase == this._PHASE_CROWN_HISTORY || this._phase == this._PHASE_MY_PAGE)
            {
                if (this._isoMain != null && this._isoMain.bAnimetion == false && (this._palace == null || this._palace != null && this._palace.bAnimetion == false) && (this._album == null || this._album != null && this._album.bOpened) && (this._crownHistory == null || this._crownHistory != null && this._crownHistory.bAnimetion == false) && (this._history == null || this._history != null && this._history.bOpened))
                {
                    bTopbarButtonDisable = false;
                }
                else
                {
                    bTopbarButtonDisable = true;
                }
            }
            else
            {
                bTopbarButtonDisable = true;
            }
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                case this._PHASE_NOTICE:
                {
                    this.controlNotice(param1);
                    break;
                }
                case this._PHASE_ALREADY_MANAGEMENT_NOTICE:
                {
                    this.controlAlreadyManagementNotice(param1);
                    break;
                }
                case this._PHASE_MAINTENANCE:
                {
                    this.controlMaintenance();
                    break;
                }
                case this._PHASE_EMPEROR_SELECT_CHECK:
                {
                    this.controlEmperorSelectCheck();
                    break;
                }
                case this._PHASE_LOGIN_BONUS:
                {
                    this.controlLoginBonus(param1);
                    break;
                }
                case this._PHASE_LOGIN_BONUS2:
                {
                    this.controlLoginBonus2(param1);
                    break;
                }
                case this._PHASE_LOGIN_BONUS_DISP:
                {
                    this.controlLoginBonusDisp(param1);
                    break;
                }
                case this._PHASE_CAMPAIGN_RECEIVE:
                {
                    this.controlCampaignReceive(param1);
                    break;
                }
                case this._PHASE_SPECIAL_NOTICE:
                {
                    this.controlSpecialNotice();
                    break;
                }
                case this._PHASE_LOST_NOTICE:
                {
                    this.controlLostNotice(param1);
                    break;
                }
                case this._PHASE_LOST_NOTICE_RECEIVE:
                {
                    this.controlLostNoticeReceive(param1);
                    break;
                }
                case this._PHASE_SIMPLE_NOTICE:
                {
                    this.controlMiniNotice();
                    break;
                }
                case this._PHASE_PROVISION:
                {
                    this.controlProvision(param1);
                    break;
                }
                case this._PHASE_LATER_NOTICE:
                {
                    this.controlLaterNotice();
                    break;
                }
                case this._PHASE_LOCAL_NOTICE:
                {
                    this.controlLocalNotice();
                    break;
                }
                case this._PHASE_CHARACTER_LIST_EMPTY_CHECK:
                {
                    this.controlCharacterListEmptyCheck(param1);
                    break;
                }
                case this._PHASE_FORMATION_EMPTY_CHECK:
                {
                    this.controlFormationCheck(param1);
                    break;
                }
                case this._PHASE_MAIN:
                {
                    this.controlMain(param1);
                    break;
                }
                case this._PHASE_MY_PAGE:
                {
                    this.controlMyPage(param1);
                    break;
                }
                case this._PHASE_ALBUM:
                {
                    this.controlAlbum(param1);
                    break;
                }
                case this._PHASE_CHRONOLOGY:
                {
                    this.controlChronology(param1);
                    break;
                }
                case this._PHASE_CODE_INPUT:
                {
                    this.controlCodeInput(param1);
                    break;
                }
                case this._PHASE_CROWN_HISTORY:
                {
                    this.controlCrownHistory(param1);
                    break;
                }
                case this._PHASE_CREDIT:
                {
                    this.controlCredit(param1);
                    break;
                }
                case this._PHASE_COOPERATE_CODE:
                {
                    this.controlCooperateCode(param1);
                    break;
                }
                case this._PHASE_NAME_ENTRY:
                {
                    this.controlNameEntry(param1);
                    break;
                }
                case this._PHASE_RE_OPEN:
                {
                    this.controlReOpen();
                    break;
                }
                case this._PHASE_SCRIPT_CHECK:
                {
                    this.controlScriptCheck(param1);
                    break;
                }
                case this._PHASE_SCRIPT_EXE:
                {
                    this.controlScriptExe(param1);
                    break;
                }
                case this._PHASE_DIRECT_RECOVERY_CHECK:
                {
                    this.controlDirectRecoveryCheck();
                    break;
                }
                case this._PHASE_RECOVERY_EFFECT:
                {
                    this.controlRecoveryEffect();
                    break;
                }
                case this._PHASE_END:
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

        private function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    case this._PHASE_MAINTENANCE:
                    {
                        this.phaseMaintenance();
                        break;
                    }
                    case this._PHASE_SPECIAL_NOTICE:
                    {
                        this.phaseSpecialNotice();
                        break;
                    }
                    case this._PHASE_SPECIAL_NOTICE_RECEIVE:
                    {
                        this.phaseSpecialNoticeReceive();
                        break;
                    }
                    case this._PHASE_NOTICE:
                    {
                        this.phaseNotice();
                        break;
                    }
                    case this._PHASE_ALREADY_MANAGEMENT_NOTICE:
                    {
                        this.phaseAlreadyManagementNotice();
                        break;
                    }
                    case this._PHASE_LOGIN_BONUS:
                    {
                        this.phaseLoginBonus();
                        break;
                    }
                    case this._PHASE_LOGIN_BONUS2:
                    {
                        this.phaseLoginBonus2();
                        break;
                    }
                    case this._PHASE_LOGIN_BONUS_DISP:
                    {
                        this.phaseLoginBonusDisp();
                        break;
                    }
                    case this._PHASE_CAMPAIGN_RECEIVE:
                    {
                        this.phaseCampaignReceive();
                        break;
                    }
                    case this._PHASE_LOST_NOTICE:
                    {
                        this.phaseLostNotice();
                        break;
                    }
                    case this._PHASE_LOST_NOTICE_RECEIVE:
                    {
                        this.phaseLostNoticeReceive();
                        break;
                    }
                    case this._PHASE_STORAGE_NOTICE:
                    {
                        this.phaseStorageNotice();
                        break;
                    }
                    case this._PHASE_STORAGE_NOTICE_RECEIVE:
                    {
                        this.phaseStorageNoticeReceive();
                        break;
                    }
                    case this._PHASE_THROUGH_NOTICE:
                    {
                        this.phaseThroughNotice();
                        break;
                    }
                    case this._PHASE_THROUGH_NOTICE_RECEIVE:
                    {
                        this.phaseThroughNoticeReceive();
                        break;
                    }
                    case this._PHASE_SIMPLE_NOTICE:
                    {
                        this.phaseSimpleNotice();
                        break;
                    }
                    case this._PHASE_SIMPLE_NOTICE_RECEIVE:
                    {
                        this.phaseSimpleNoticeReceive();
                        break;
                    }
                    case this._PHASE_PROVISION:
                    {
                        this.phaseProvision();
                        break;
                    }
                    case this._PHASE_LATER_NOTICE:
                    {
                        this.phaseLaterNotice();
                        break;
                    }
                    case this._PHASE_LATER_NOTICE_RECEIVE:
                    {
                        this.phaseLaterNoticeReceive();
                        break;
                    }
                    case this._PHASE_LOCAL_NOTICE:
                    {
                        this.phaseLocalNotice();
                        break;
                    }
                    case this._PHASE_LOST_CHARM:
                    {
                        this.phaseLostCharm();
                        break;
                    }
                    case this._PHASE_CHARACTER_LIST_EMPTY_CHECK:
                    {
                        this.phaseCharacterListEmptyCheck();
                        break;
                    }
                    case this._PHASE_FORMATION_EMPTY_CHECK:
                    {
                        this.phaseFormationCheck();
                        break;
                    }
                    case this._PHASE_MAIN:
                    {
                        this.phaseMain();
                        break;
                    }
                    case this._PHASE_MY_PAGE:
                    {
                        this.phaseMyPage();
                        break;
                    }
                    case this._PHASE_ALBUM:
                    {
                        this.phaseAlbum();
                        break;
                    }
                    case this._PHASE_CHRONOLOGY:
                    {
                        this.phaseChronology();
                        break;
                    }
                    case this._PHASE_CODE_INPUT:
                    {
                        this.phaseCodeInput();
                        break;
                    }
                    case this._PHASE_CROWN_HISTORY:
                    {
                        this.phaseCrownHistory();
                        break;
                    }
                    case this._PHASE_CREDIT:
                    {
                        this.phaseCredit();
                        break;
                    }
                    case this._PHASE_COOPERATE_CODE:
                    {
                        this.phaseCooperateCode();
                        break;
                    }
                    case this._PHASE_NAME_ENTRY:
                    {
                        this.phaseNameEntry();
                        break;
                    }
                    case this._PHASE_RE_OPEN:
                    {
                        this.phaseReOpen();
                        break;
                    }
                    case this._PHASE_EMPEROR_SELECT_CHECK:
                    {
                        this.phaseEmperorSelectCheck();
                        break;
                    }
                    case this._PHASE_EMEPROR_SELECT:
                    {
                        this.phaseEmperorSelect();
                        break;
                    }
                    case this._PHASE_ROUTE_SELECT:
                    {
                        this.phaseRouteSelect();
                        break;
                    }
                    case this._PHASE_SCRIPT_CHECK:
                    {
                        this.phaseScriptCheck();
                        break;
                    }
                    case this._PHASE_SCRIPT_EXE:
                    {
                        this.phaseScriptExe();
                        break;
                    }
                    case this._PHASE_DIRECT_RECOVERY_CHECK:
                    {
                        this.phaseDirectRecoveryCheck();
                        break;
                    }
                    case this._PHASE_RECOVERY_EFFECT:
                    {
                        this.phaseRecoveryEffect();
                        break;
                    }
                    case this._PHASE_END:
                    {
                        this.phaseEnd();
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
            var _loc_1:* = Main.GetProcess().topBar;
            _loc_1.open();
            var _loc_2:* = Main.GetProcess().background;
            _loc_2.open();
            this.playBgm();
            this.checkSortie();
            this._institution = new InstitutionMenu(this._layer, this._baseMc);
            this._dailyMissionIcon.update();
            this._isoMain.setIn();
            this._emperor.open();
            this._curParty.open();
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoMain.bOpened)
            {
                this.setPhase(this._PHASE_SCRIPT_CHECK);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            var _loc_1:* = Main.GetProcess().topBar;
            _loc_1.cbConfigWindow(null, null);
            this._isoMain.setOut();
            if (this._institution)
            {
                this._institution.iconDisable(true);
                this._institution.close();
            }
            if (this._emperor)
            {
                this._emperor.close();
            }
            if (this._curParty)
            {
                this._curParty.close();
            }
            bTopbarButtonDisable = true;
            TutorialManager.getInstance().hideTutorial();
            return;
        }// end function

        private function controlClose() : void
        {
            if (this._isoMain.bEnd)
            {
                this.setPhase(this._PHASE_END);
            }
            return;
        }// end function

        private function phaseMaintenance() : void
        {
            if (Main.GetApplicationData().maintenanceData.isMaintenanceTime())
            {
                Main.GetProcess().createMaintenanceWindow();
            }
            else
            {
                this.setPhase(this._PHASE_EMPEROR_SELECT_CHECK);
            }
            return;
        }// end function

        private function controlMaintenance() : void
        {
            if (Main.GetProcess().maintenance == null && Main.GetProcess().fade.isFadeEnd())
            {
                this.setPhase(this._PHASE_EMPEROR_SELECT_CHECK);
            }
            return;
        }// end function

        private function phaseNotice() : void
        {
            if (this._institution)
            {
                this._institution.open();
                this._institution.iconDisable(true);
            }
            var _loc_1:* = TutorialManager.getInstance().isTutorial();
            if (!_loc_1 && NoticeManager.getInstance().bShowManagementNotice() == true)
            {
                this._loginNotice = new LoginNoticeWindow(this._layer, NoticeManager.getInstance().aManagementNotice);
                this._bHomeDarken = true;
            }
            else
            {
                this.setPhase(this._PHASE_LOGIN_BONUS);
            }
            return;
        }// end function

        private function controlNotice(param1:Number) : void
        {
            if (this._loginNotice)
            {
                this._loginNotice.control(param1);
                if (this._loginNotice.bEnd == true)
                {
                    NoticeManager.getInstance().crearManagementNotice();
                    this._loginNotice.release();
                    this._bHomeDarken = false;
                    this.setPhase(this._PHASE_LOGIN_BONUS);
                }
            }
            return;
        }// end function

        private function phaseAlreadyManagementNotice() : void
        {
            if (this._institution)
            {
                this._institution.open();
                this._institution.iconDisable(true);
            }
            if (NoticeManager.getInstance().bShowAlreadyManagementNotice() == true)
            {
                if (this._infoBtn)
                {
                    this._infoBtn.setDisable(true);
                }
                if (this._dailyMissionIcon)
                {
                    this._dailyMissionIcon.setEnable(false);
                }
                this._loginNotice = new LoginNoticeWindow(this._layer, NoticeManager.getInstance().aManagementNotice);
                this._bHomeDarken = true;
            }
            else
            {
                this.setPhase(this._PHASE_MAIN);
            }
            return;
        }// end function

        private function controlAlreadyManagementNotice(param1:Number) : void
        {
            if (this._loginNotice)
            {
                this._loginNotice.control(param1);
                if (this._loginNotice.bEnd == true)
                {
                    this._loginNotice.release();
                    this._bHomeDarken = false;
                    this.setPhase(this._PHASE_MAIN);
                }
            }
            return;
        }// end function

        private function phaseLoginBonus() : void
        {
            var _loc_1:* = Main.GetApplicationData().loginBonusGetTime;
            var _loc_2:* = TutorialManager.getInstance().isTutorial();
            if (_loc_2 && TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_HOME_4) && !TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_WORLD_MAP))
            {
                _loc_2 = false;
            }
            if (_loc_2 || TimeClock.bProgressTime(_loc_1) == false)
            {
                this.setPhase(this._PHASE_CAMPAIGN_RECEIVE);
            }
            else
            {
                NetManager.getInstance().request(new NetTaskLoginBonus(this.cbLoginBonus));
                this._bHomeDarken = true;
            }
            return;
        }// end function

        private function controlLoginBonus(param1:Number) : void
        {
            if (this._loginBonusData != null && ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_LOGIN_BONUS2);
            }
            return;
        }// end function

        private function phaseLoginBonus2() : void
        {
            ResourceManager.getInstance().loadArray(LoginBonusMain.getLoginBonusGridPath(this._loginBonusData));
            return;
        }// end function

        private function controlLoginBonus2(param1:Number) : void
        {
            if (this._loginBonusData != null && ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_LOGIN_BONUS_DISP);
            }
            return;
        }// end function

        private function cbLoginBonus(param1:NetResult) : void
        {
            this._loginBonusData = new LoginBonusData();
            this._loginBonusData.setReceiveData(param1.data);
            if (this._loginBonusData.aLoginBonus == null || this._loginBonusData.aLoginBonus.length == 0)
            {
                this.setPhase(this._PHASE_CAMPAIGN_RECEIVE);
                return;
            }
            ResourceManager.getInstance().loadArray(LoginBonusMain.getResource());
            ResourceManager.getInstance().loadArray(LoginBonusMain.getBonusResource(this._loginBonusData));
            SoundManager.getInstance().loadSoundArray(LoginBonusMain.getSound());
            return;
        }// end function

        private function phaseLoginBonusDisp() : void
        {
            this._loginBonus = new LoginBonusMain(this._layer.getLayer(LayerHome.NOTICE), this._loginBonusData);
            return;
        }// end function

        private function controlLoginBonusDisp(param1:Number) : void
        {
            if (this._loginBonus != null)
            {
                this._loginBonus.control(param1);
                if (this._loginBonus.bEnd)
                {
                    this._loginBonus.release();
                    this._loginBonus = null;
                    this._bHomeDarken = false;
                    this.setPhase(this._PHASE_CAMPAIGN_RECEIVE);
                }
            }
            return;
        }// end function

        private function phaseCampaignReceive() : void
        {
            if (TutorialManager.getInstance().isTutorial() == false && SubdualPointManager.getInstance().bAnyReward)
            {
                this._subdualPointReward = new SubdualPointRewardReceivePopup(SubdualPointManager.getInstance().bIndividualReward, SubdualPointManager.getInstance().bWholeReward);
                this._bHomeDarken = true;
            }
            else
            {
                this.setPhase(this._PHASE_SPECIAL_NOTICE);
            }
            return;
        }// end function

        private function controlCampaignReceive(param1:Number) : void
        {
            if (this._subdualPointReward != null)
            {
                this._subdualPointReward.control(param1);
                if (this._subdualPointReward.bEnd)
                {
                    this._subdualPointReward.release();
                    this._subdualPointReward = null;
                    this._bHomeDarken = false;
                    this.setPhase(this._PHASE_SPECIAL_NOTICE);
                }
            }
            return;
        }// end function

        private function phaseProvision() : void
        {
            if (this._provisionCheck == null)
            {
                this._provisionCheck = new ProvisionChecker(ProvisionChecker.CHECK_TARGET_ALL, [ProvisionChecker.CHECK_TARGET_LVUP_FREE_HEALING, ProvisionChecker.CHECK_TARGET_TIME_FREE_HEALING, ProvisionChecker.CHECK_TARGET_FREE_WHOLE_ARMY_ASSAULT]);
            }
            if (this._provisionCheck.check())
            {
                this._provisionCheck.popup(function () : void
            {
                if (_provisionCheck)
                {
                    _provisionCheck.release();
                }
                _provisionCheck = null;
                provisionNext();
                return;
            }// end function
            );
            }
            else
            {
                this._provisionCheck.release();
                this._provisionCheck = null;
                this.provisionNext();
            }
            return;
        }// end function

        private function controlProvision(param1:Number) : void
        {
            return;
        }// end function

        private function provisionNext() : void
        {
            if (TutorialManager.getInstance().isTutorial() && TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_HOME_4) && !TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_WORLD_MAP))
            {
                this.setPhase(this._PHASE_MAIN);
            }
            else
            {
                this.setPhase(this._PHASE_LATER_NOTICE);
            }
            return;
        }// end function

        private function phaseThroughNotice() : void
        {
            var _loc_2:* = null;
            if (this._institution)
            {
                this._institution.iconDisable(true);
            }
            this._aThroughId = null;
            var _loc_1:* = NoticeManager.getInstance().aThroughNotice;
            if (_loc_1.length > 0)
            {
                this._aThroughId = new Array();
                for each (_loc_2 in _loc_1)
                {
                    
                    this._aThroughId.push(_loc_2.uniqueId);
                }
                this._bHomeDarken = this._waitHomeDarken >= this._HOME_DARKEN / 2;
                this.setPhase(this._PHASE_THROUGH_NOTICE_RECEIVE);
            }
            else
            {
                this._bHomeDarken = false;
                this.setPhase(this._PHASE_SIMPLE_NOTICE);
            }
            return;
        }// end function

        private function phaseThroughNoticeReceive() : void
        {
            NetManager.getInstance().request(new NetTaskNoticeCheck(this._aThroughId, this.cbThroughNotice));
            return;
        }// end function

        private function phaseSimpleNotice() : void
        {
            if (this._institution)
            {
                this._institution.iconDisable(true);
            }
            if (NoticeManager.getInstance().bShowNotice() == false)
            {
                this._bHomeDarken = false;
                this.setPhase(this._PHASE_PROVISION);
                return;
            }
            this.createMiniNotice(NoticeManager.NORMAL_NOTICE);
            this._bHomeDarken = true;
            if (this._simpleNotice == null)
            {
                this._bHomeDarken = false;
                this.setPhase(this._PHASE_PROVISION);
            }
            return;
        }// end function

        private function controlMiniNotice() : void
        {
            if (this._simpleNotice && this._simpleNotice.bEnd() == true)
            {
                this.setPhase(this._PHASE_SIMPLE_NOTICE_RECEIVE);
            }
            return;
        }// end function

        private function phaseSimpleNoticeReceive() : void
        {
            var _loc_1:* = NoticeManager.getInstance().aEndNoticeUniqueId(this._simpleNotice.noticeType);
            NetManager.getInstance().request(new NetTaskNoticeCheck(_loc_1, this.cbMiniNotice));
            return;
        }// end function

        private function phaseLaterNotice() : void
        {
            if (this._institution)
            {
                this._institution.iconDisable(true);
            }
            if (NoticeManager.getInstance().bShowNotice() == false)
            {
                this._bHomeDarken = false;
                this.setPhase(this._PHASE_LOCAL_NOTICE);
                return;
            }
            this.createMiniNotice(NoticeManager.LATER_NOTICE);
            this._bHomeDarken = true;
            if (this._simpleNotice == null)
            {
                this._bHomeDarken = false;
                this.setPhase(this._PHASE_LOCAL_NOTICE);
            }
            return;
        }// end function

        private function controlLaterNotice() : void
        {
            if (this._simpleNotice && this._simpleNotice.bEnd() == true)
            {
                this.setPhase(this._PHASE_LATER_NOTICE_RECEIVE);
            }
            return;
        }// end function

        private function phaseLaterNoticeReceive() : void
        {
            var _loc_1:* = null;
            if (this._simpleNotice.noticeType == CommonConstant.NOTICE_COOPERATE_SERIAL)
            {
                _loc_1 = [this._simpleNotice.noticeUniqueId];
            }
            else
            {
                _loc_1 = NoticeManager.getInstance().aEndNoticeUniqueId(this._simpleNotice.noticeType);
            }
            NetManager.getInstance().request(new NetTaskNoticeCheck(_loc_1, this.cbLaterNotice));
            return;
        }// end function

        private function phaseSpecialNotice() : void
        {
            if (this._institution)
            {
                this._institution.iconDisable(true);
            }
            this.createMiniNotice(NoticeManager.SPECIAL_NOTICE);
            this._bHomeDarken = true;
            if (this._simpleNotice == null)
            {
                this._bHomeDarken = false;
                this.setPhase(this._PHASE_LOST_NOTICE);
            }
            return;
        }// end function

        private function controlSpecialNotice() : void
        {
            if (this._simpleNotice && this._simpleNotice.bEnd() == true)
            {
                this.setPhase(this._PHASE_SIMPLE_NOTICE_RECEIVE);
            }
            return;
        }// end function

        private function phaseSpecialNoticeReceive() : void
        {
            var _loc_1:* = NoticeManager.getInstance().aEndNoticeUniqueId(this._simpleNotice.noticeType);
            NetManager.getInstance().request(new NetTaskNoticeCheck(_loc_1, this.cbSpecialMiniNotice));
            return;
        }// end function

        private function phaseStorageNotice() : void
        {
            if (this._institution)
            {
                this._institution.iconDisable(true);
            }
            if (StorageManager.getInstance().isWarehouseGiftDleted())
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, StorageManager.getInstance().getWarehouseGiftDletedText(), this.cbStorageNoticePopup);
                this._institution.iconDisable(true);
            }
            else
            {
                this.setPhase(this._PHASE_THROUGH_NOTICE);
            }
            return;
        }// end function

        private function phaseStorageNoticeReceive() : void
        {
            NetManager.getInstance().request(new NetTaskWareHouseNoticeCheck(this.cbStorageNoticeReceive));
            return;
        }// end function

        private function phaseLostNotice() : void
        {
            if (this._institution)
            {
                this._institution.iconDisable(true);
            }
            var _loc_1:* = NoticeManager.getInstance().aCharacterLost;
            if (_loc_1.length == 0)
            {
                this.setPhase(this._PHASE_STORAGE_NOTICE);
                return;
            }
            this._lostNotice = new LostNoticeWindow(this._layer.getLayer(LayerHome.NOTICE));
            this._bHomeDarken = true;
            return;
        }// end function

        private function controlLostNotice(param1:Number) : void
        {
            if (this._lostNotice != null)
            {
                this._lostNotice.control(param1);
                if (this._lostNotice.bEnd)
                {
                    this._lostNotice.release();
                    this._lostNotice = null;
                    this.setPhase(this._PHASE_LOST_NOTICE_RECEIVE);
                }
            }
            return;
        }// end function

        private function phaseLostNoticeReceive() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in NoticeManager.getInstance().aCharacterLost)
            {
                
                _loc_1.push(_loc_2.uniqueId);
            }
            NetManager.getInstance().request(new NetTaskLostNoticeCheck(_loc_1, this.cbLostNoticeCheck));
            return;
        }// end function

        private function controlLostNoticeReceive(param1:Number) : void
        {
            return;
        }// end function

        private function cbLostNoticeCheck(param1:NetResult) : void
        {
            this._bHomeDarken = false;
            this.setPhase(this._PHASE_STORAGE_NOTICE);
            return;
        }// end function

        private function createMiniNotice(param1:Array) : void
        {
            if (this._simpleNotice != null)
            {
                this._simpleNotice.release();
            }
            this._simpleNotice = null;
            this._simpleNotice = NoticeManager.getInstance().createMiniNotice(this._layer.getLayer(LayerHome.NOTICE), param1);
            return;
        }// end function

        private function phaseEmperorSelectCheck() : void
        {
            if (this._scriptMain != null)
            {
                this._scriptMain.release();
            }
            this._scriptMain = null;
            if (UserDataManager.getInstance().userData.statusType == CommonConstant.USER_STATE_EMPEROR_SELECT)
            {
                this._bEmperorSelect = true;
                this._scriptMain = ScriptManager.getInstance().getScript(ScriptScreen.SCREEN_HOME, ScriptComConstant.TRIGGER_EMPEROR_SELECT);
                if (this._scriptMain == null)
                {
                    Assert.print("イベントを再生できませんでした");
                }
            }
            if (this._scriptMain != null && this._bEmperorSelect)
            {
                ResourceManager.getInstance().loadResource(ScriptManager.getResourcePath());
            }
            else
            {
                this.setPhase(this._PHASE_ROUTE_SELECT);
            }
            return;
        }// end function

        private function controlEmperorSelectCheck() : void
        {
            if (ResourceManager.getInstance().isLoaded())
            {
                if (this._scriptMain != null)
                {
                    this.setPhase(this._PHASE_SCRIPT_EXE);
                }
                else
                {
                    this.setPhase(this._PHASE_OPEN);
                }
            }
            return;
        }// end function

        private function phaseEmperorSelect() : void
        {
            if (UserDataManager.getInstance().userData.statusType == CommonConstant.USER_STATE_EMPEROR_SELECT)
            {
                this._nextProcessId = ProcessMain.PROCESS_EMPEROR_SELECT;
                this.setPhase(this._PHASE_END);
            }
            else
            {
                DebugLog.print("皇帝継承のステータスでないため皇帝継承のプロセスへ切り替えを行いませんでした。");
                this.setPhase(this._PHASE_OPEN);
            }
            return;
        }// end function

        private function phaseRouteSelect() : void
        {
            if (UserDataManager.getInstance().checkSpecialEvent())
            {
                this._nextProcessId = ProcessMain.PROCESS_SPECIAL_EVENT;
                this.setPhase(this._PHASE_END);
            }
            else
            {
                this.setPhase(this._PHASE_OPEN);
            }
            return;
        }// end function

        private function phaseScriptCheck() : void
        {
            if (this._scriptMain != null)
            {
                this._scriptMain.release();
            }
            this._scriptMain = null;
            this._scriptMain = ScriptManager.getInstance().getScript(ScriptScreen.SCREEN_HOME, ScriptComConstant.TRIGGER_IN_SCREEN);
            if (this._scriptMain != null)
            {
                ResourceManager.getInstance().loadResource(ScriptManager.getResourcePath());
            }
            else
            {
                this.setPhase(this._PHASE_NOTICE);
            }
            return;
        }// end function

        private function controlScriptCheck(param1:Number) : void
        {
            if (ResourceManager.getInstance().isLoaded())
            {
                if (this._scriptMain != null)
                {
                    this.setPhase(this._PHASE_SCRIPT_EXE);
                }
                else
                {
                    this.setPhase(this._PHASE_NOTICE);
                }
            }
            return;
        }// end function

        private function phaseScriptExe() : void
        {
            ScriptManager.getInstance().initScript(this._scriptMain, this._layer.getLayer(LayerHome.SCRIPT));
            ScriptManager.getInstance().commandInit(UserDataManager.getInstance().userData.cycle != 1);
            return;
        }// end function

        private function controlScriptExe(param1:Number) : void
        {
            ScriptManager.getInstance().commandControl(param1);
            if (ScriptManager.getInstance().isScriptEnd())
            {
                ScriptManager.getInstance().releaseScript();
                if (this._bEmperorSelect == false)
                {
                    this.setPhase(this._PHASE_SCRIPT_CHECK);
                }
                else
                {
                    this.setPhase(this._PHASE_EMEPROR_SELECT);
                }
            }
            return;
        }// end function

        private function phaseLocalNotice() : void
        {
            var aLocalNotice:Array;
            if (this._institution)
            {
                this._institution.iconDisable(true);
            }
            aLocalNotice = NoticeManager.getInstance().aLocalNotice;
            if (aLocalNotice.length == 0)
            {
                this.setPhase(this._PHASE_LOST_CHARM);
                return;
            }
            this._bHomeDarken = true;
            var localPopupFunc:* = function (param1:int = 0) : void
            {
                var count:* = param1;
                var localNotice:* = aLocalNotice[count];
                count = (count + 1);
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, localNotice.getMessage(), count < aLocalNotice.length ? (function () : void
                {
                    localPopupFunc(count);
                    return;
                }// end function
                ) : (cbLocalNoticeClose));
                return;
            }// end function
            ;
            this.localPopupFunc();
            return;
        }// end function

        private function controlLocalNotice() : void
        {
            return;
        }// end function

        private function cbLocalNoticeClose() : void
        {
            NoticeManager.getInstance().clearLocalNotice();
            this._bHomeDarken = false;
            this.setPhase(this._PHASE_LOST_CHARM);
            return;
        }// end function

        private function phaseLostCharm() : void
        {
            if (UserDataManager.getInstance().userData.aLostCharmId.length > 0)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.NOTICE_ITEM_LOST), this.cbLostCharm);
            }
            else
            {
                this.setPhase(this._PHASE_CHARACTER_LIST_EMPTY_CHECK);
            }
            return;
        }// end function

        private function phaseCharacterListEmptyCheck() : void
        {
            if (UserDataManager.getInstance().isPlayerLack() == false)
            {
                this.setPhase(this._PHASE_FORMATION_EMPTY_CHECK);
                return;
            }
            NetManager.getInstance().request(new NetTaskCharacterListEmpty(this.cbCharacterListEmpty));
            return;
        }// end function

        private function controlCharacterListEmptyCheck(param1:Number) : void
        {
            return;
        }// end function

        private function cbCharacterListEmpty(param1:NetResult) : void
        {
            this._gotoFormationMessageId = MessageId.CHARACTER_LIST_EMPTY_GOTO_FORMATION;
            this.setPhase(this._PHASE_FORMATION_EMPTY_CHECK);
            return;
        }// end function

        private function phaseFormationCheck() : void
        {
            if (this._gotoFormationMessageId == Constant.EMPTY_ID && UserDataManager.getInstance().isFormationEmpty())
            {
                this._gotoFormationMessageId = MessageId.FORMATION_EMPTY_GOTO_FORMATION;
            }
            if (this._gotoFormationMessageId != Constant.EMPTY_ID)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NAVI, MessageManager.getInstance().getMessage(this._gotoFormationMessageId), function () : void
            {
                setPhase(_PHASE_MAIN);
                return;
            }// end function
            );
                return;
            }
            this.setPhase(this._PHASE_MAIN);
            return;
        }// end function

        private function controlFormationCheck(param1:Number) : void
        {
            return;
        }// end function

        private function phaseMain() : void
        {
            var bar:* = Main.GetProcess().topBar;
            bar.cbConfigWindow(this.cbConfigWindowOpen, this.cbConfigWindowClose);
            this._institution.iconDisable(false);
            if (this._infoBtn == null && NoticeManager.getInstance().bShowAlreadyManagementNotice())
            {
                this._infoBtn = ButtonManager.getInstance().addButton(this._baseMc.infoBtnMc, this.cbInfoBtn);
                this._infoBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
            }
            if (this._infoBtn)
            {
                this._infoBtn.setVisible(true);
            }
            if (this._freeNumBalloon == null)
            {
                this._freeNumBalloon = new EmploymentSummonFreeNumBalloon(this._baseMc.summonFreeNumMc);
            }
            else
            {
                this._freeNumBalloon.update();
            }
            var bTutorial:Boolean;
            if (TutorialManager.getInstance().isTutorial())
            {
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_HOME_1))
                {
                    bTutorial;
                    TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_HOME_1, function () : void
            {
                TutorialManager.getInstance().setTutorialArrow(_institution.getFacilityIcon(CommonConstant.FACILITY_ID_PRACTICE), TutorialManager.TUTORIAL_ARROW_DIRECTION_DOWN, TutorialManager.TUTORIAL_ARROW_POS_LEFT_UP);
                TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_HOME_001), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
                return;
            }// end function
            );
                }
                else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_HOME_2))
                {
                    bTutorial;
                    TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_HOME_2, function () : void
            {
                TutorialManager.getInstance().setTutorialArrow(_institution.getFacilityIcon(CommonConstant.FACILITY_ID_COMMAND_ROOM), TutorialManager.TUTORIAL_ARROW_DIRECTION_DOWN, TutorialManager.TUTORIAL_ARROW_POS_LEFT_UP);
                TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_HOME_002), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
                return;
            }// end function
            );
                }
                else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_HOME_3))
                {
                    bTutorial;
                    TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_HOME_3, function () : void
            {
                TutorialManager.getInstance().setTutorialArrow(_institution.getFacilityIcon(CommonConstant.FACILITY_ID_SORTIE), TutorialManager.TUTORIAL_ARROW_DIRECTION_DOWN, TutorialManager.TUTORIAL_ARROW_POS_LEFT_UP);
                TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_HOME_003), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
                return;
            }// end function
            );
                }
                else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_HOME_4))
                {
                    bTutorial;
                    TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_HOME_4, function () : void
            {
                UserDataManager.getInstance().userData.statusType = CommonConstant.USER_STATE_PLAY;
                if (UserDataManager.getInstance().userData.cycle == 1)
                {
                    ExternalLinkageJS.callJSRemarketingTag(ExternalLinkageJSConstant.REMARKETING_TAG_TUTORIAL);
                }
                _institution.emperReCheak();
                _dailyMissionIcon.setVisible(true);
                Main.GetProcess().topBar.setButtonUpdate(ProcessMain.PROCESS_HOME);
                setPhase(_PHASE_SCRIPT_CHECK);
                return;
            }// end function
            );
                }
            }
            else if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_FIRST) && UserDataManager.getInstance().isPlayerFullHp() == false)
            {
                bTutorial;
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_FIRST, function () : void
            {
                _nextProcessId = ProcessMain.PROCESS_BARRACKS;
                setPhase(_PHASE_CLOSE);
                return;
            }// end function
            );
            }
            this._curParty.setMouseEnable(bTutorial == false);
            if (this._infoBtn)
            {
                this._infoBtn.setDisable(bTutorial);
            }
            if (this._dailyMissionIcon)
            {
                this._dailyMissionIcon.setEnable(bTutorial == false);
            }
            if (this._freeNumBalloon && bTutorial)
            {
                this._freeNumBalloon.setVisible(false);
            }
            return;
        }// end function

        private function controlMain(param1:Number) : void
        {
            var facilityId:int;
            var userData:UserDataPersonal;
            var iInfo:InstitutionInfo;
            var t:* = param1;
            this._curParty.control(t);
            if (this._dailyMissionIcon)
            {
                this._dailyMissionIcon.control(t);
            }
            if (!this._curParty.bBusy && this._institution != null && this._institution.control(t) == true)
            {
                if (this._institution.nextProcessId != Constant.UNDECIDED)
                {
                    switch(this._institution.nextProcessId)
                    {
                        case ProcessMain.PROCESS_MY_PAGE:
                        {
                            this.setPhase(this._PHASE_MY_PAGE);
                            break;
                        }
                        case ProcessMain.PROCESS_QUEST_SELECT:
                        {
                            if (this._sortieChecker.bSortie == false)
                            {
                                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, this._sortieChecker.getSortieErrorMessage(), this.cbCommonPopup);
                                this._institution.iconDisable(true);
                                this._facilityGradeup._viewFlag = true;
                            }
                            else if (this._sortieChecker.sortieWarning != HomeSortieChecker.SORTIE_WARNING_OK)
                            {
                                this._institution.iconDisable(true);
                                this._facilityGradeup._viewFlag = true;
                                CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, this._sortieChecker.getSortieWarningMessage(), function (param1:Boolean) : void
            {
                if (param1)
                {
                    _nextProcessId = ProcessMain.PROCESS_QUEST_SELECT;
                    setPhase(_PHASE_CLOSE);
                }
                else
                {
                    cbCommonPopup();
                }
                return;
            }// end function
            );
                            }
                            else
                            {
                                this._nextProcessId = this._institution.nextProcessId;
                                this.setPhase(this._PHASE_CLOSE);
                            }
                            break;
                        }
                        case ProcessMain.PROCESS_EMPLOYMENT:
                        case ProcessMain.PROCESS_TRADING_POST:
                        {
                            this._nextProcessId = this._institution.nextProcessId;
                            this.setPhase(this._PHASE_CLOSE);
                            break;
                        }
                        case ProcessMain.PROCESS_MAKE_EQUIP:
                        case ProcessMain.PROCESS_BARRACKS:
                        case ProcessMain.PROCESS_SKILL_INITIATE:
                        case ProcessMain.PROCESS_MAGIC_DEVELOP:
                        case ProcessMain.PROCESS_TRAINING_ROOM:
                        {
                            facilityId;
                            switch(this._institution.nextProcessId)
                            {
                                case ProcessMain.PROCESS_MAKE_EQUIP:
                                {
                                    facilityId;
                                    break;
                                }
                                case ProcessMain.PROCESS_BARRACKS:
                                {
                                    facilityId;
                                    break;
                                }
                                case ProcessMain.PROCESS_SKILL_INITIATE:
                                {
                                    facilityId;
                                    break;
                                }
                                case ProcessMain.PROCESS_MAGIC_DEVELOP:
                                {
                                    facilityId;
                                    break;
                                }
                                case ProcessMain.PROCESS_TRAINING_ROOM:
                                {
                                    facilityId;
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                            userData = UserDataManager.getInstance().userData;
                            var _loc_3:* = 0;
                            var _loc_4:* = userData.aInstitution;
                            while (_loc_4 in _loc_3)
                            {
                                
                                iInfo = _loc_4[_loc_3];
                                if (iInfo.id == facilityId)
                                {
                                    this._facilityInfo = iInfo;
                                    break;
                                }
                            }
                            if (this._facilityInfo.grade == 0)
                            {
                                this._institution.iconDisable(true);
                                this._institution.informationIconDisable(facilityId, false);
                                if (this._facilityInfo.upgradeEnd == 0 && this._facilityInfo.bBusy == false)
                                {
                                    this._facilityGradeup.LvCheck(facilityId, this.cbCloseLv0PopUp);
                                }
                                else
                                {
                                    this._institution.iconDisable(false);
                                }
                            }
                            else
                            {
                                this._nextProcessId = this._institution.nextProcessId;
                                this.setPhase(this._PHASE_CLOSE);
                            }
                            break;
                        }
                        default:
                        {
                            this._nextProcessId = this._institution.nextProcessId;
                            this.setPhase(this._PHASE_CLOSE);
                            break;
                            break;
                        }
                    }
                    this._institution.resetNextProcessId();
                }
            }
            if (this._phase == this._PHASE_MAIN)
            {
                BarracksAutoRestManager.getInstance().autoRest();
                if (this._aRestPlayerUniqueId.length > 0)
                {
                    this.setPhase(this._PHASE_RECOVERY_EFFECT);
                }
            }
            return;
        }// end function

        private function phaseMyPage() : void
        {
            if (this._emperor != null)
            {
                this._emperor.open();
            }
            if (this._album != null)
            {
                this._album.release();
                this._album = null;
            }
            if (this._isoMain.bOpened)
            {
                this._isoMain.setOut();
            }
            if (this._infoBtn)
            {
                this._infoBtn.setDisable(true);
            }
            if (this._dailyMissionIcon)
            {
                this._dailyMissionIcon.setEnable(false);
            }
            if (this._curParty)
            {
                this._curParty.close();
            }
            if (this._institution != null)
            {
                this._institution.iconDisable(true);
                this._institution.close();
            }
            if (this._palace == null)
            {
                this._palace = new Palace(this._layer);
            }
            this._palace.open();
            return;
        }// end function

        private function controlMyPage(param1:Number) : void
        {
            if (this._palace != null)
            {
                this._palace.control(param1);
                if (this._palace.bEnd && this._palace.nextScene != Palace.NOT_SELECTED)
                {
                    switch(this._palace.nextScene)
                    {
                        case Palace.MYPAGE_CLOSE:
                        {
                            this.setPhase(this._PHASE_RE_OPEN);
                            break;
                        }
                        case Palace.MYPAGE_LIST:
                        {
                            this.setPhase(this._PHASE_ALBUM);
                            break;
                        }
                        case Palace.MYPAGE_CHRONOLOGY:
                        {
                            this.setPhase(this._PHASE_CHRONOLOGY);
                            break;
                        }
                        case Palace.MYPAGE_CODE_INPUT:
                        {
                            this.setPhase(this._PHASE_CODE_INPUT);
                            break;
                        }
                        case Palace.MYPAGE_CROWN_HISTORY:
                        {
                            this.setPhase(this._PHASE_CROWN_HISTORY);
                            break;
                        }
                        case Palace.MYPAGE_CREDIT:
                        {
                            this.setPhase(this._PHASE_CREDIT);
                            break;
                        }
                        case Palace.MYPAGE_COOPERATE_CODE:
                        {
                            this.setPhase(this._PHASE_COOPERATE_CODE);
                            break;
                        }
                        case Palace.MYPAGE_NAME_ENTRY:
                        {
                            this.setPhase(this._PHASE_NAME_ENTRY);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            return;
        }// end function

        private function phaseAlbum() : void
        {
            if (this._palace != null)
            {
                this._palace.close();
            }
            if (this._emperor != null)
            {
                this._emperor.close();
            }
            var _loc_1:* = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Home.swf", "Album");
            this._album = new Album(this._layer, _loc_1);
            return;
        }// end function

        private function controlAlbum(param1:Number) : void
        {
            if (this._album != null)
            {
                this._album.control(param1);
                if (this._album.bLoadEnd)
                {
                    this._album.open();
                    this._album.bLoadEnd = false;
                }
                if (this._album.bEnd)
                {
                    this._album.release();
                    this._album = null;
                    this.setPhase(this._PHASE_MY_PAGE);
                }
            }
            return;
        }// end function

        private function phaseChronology() : void
        {
            this._history = new HistoryMain(this._layer, this._emperor, this.cbOpenEmperor, this.cbCloseEmperor);
            return;
        }// end function

        private function controlChronology(param1:Number) : void
        {
            if (this._history != null)
            {
                this._history.control(param1);
                if (this._history.bEnd)
                {
                    this._history.release();
                    this._history = null;
                    this.setPhase(this._PHASE_MY_PAGE);
                }
            }
            return;
        }// end function

        private function phaseCodeInput() : void
        {
            if (this._palace != null)
            {
                this._palace.close(false);
            }
            if (this._emperor != null)
            {
                this._emperor.close();
            }
            if (this._codeInput == null)
            {
                this._codeInput = new CodeInput(this._layer);
            }
            return;
        }// end function

        private function controlCodeInput(param1:Number) : void
        {
            if (this._codeInput != null)
            {
                this._codeInput.control(param1);
                if (this._codeInput.bEnd)
                {
                    this._codeInput.release();
                    this._codeInput = null;
                    this.setPhase(this._PHASE_MY_PAGE);
                }
            }
            return;
        }// end function

        private function phaseCrownHistory() : void
        {
            if (this._palace != null)
            {
                this._palace.close();
            }
            if (this._emperor != null)
            {
                this._emperor.close();
            }
            if (this._crownHistory == null)
            {
                this._crownHistory = new CrownHistoryWindow(this._layer);
            }
            return;
        }// end function

        private function controlCrownHistory(param1:Number) : void
        {
            if (this._crownHistory)
            {
                this._crownHistory.control(param1);
                if (this._crownHistory.bLoaded)
                {
                    if (this._crownHistory.bOpenWait)
                    {
                        this._crownHistory.open();
                    }
                    if (this._crownHistory.bClose)
                    {
                        this._crownHistory.release();
                        this._crownHistory = null;
                        this.setPhase(this._PHASE_MY_PAGE);
                    }
                }
            }
            return;
        }// end function

        private function phaseCredit() : void
        {
            if (this._palace != null)
            {
                this._palace.close();
            }
            if (this._emperor != null)
            {
                this._emperor.close();
            }
            if (this._credit == null)
            {
                this._credit = new CreditMain(this._layer);
            }
            return;
        }// end function

        private function controlCredit(param1:Number) : void
        {
            if (this._credit)
            {
                this._credit.control(param1);
                if (this._credit.bClose)
                {
                    this._credit.release();
                    this._credit = null;
                    this.setPhase(this._PHASE_MY_PAGE);
                }
            }
            return;
        }// end function

        private function phaseCooperateCode() : void
        {
            if (this._palace != null)
            {
                this._palace.close();
            }
            if (this._emperor != null)
            {
                this._emperor.close();
            }
            if (this._cooperateCodeMain == null)
            {
                this._cooperateCodeMain = new CooperateCodeMain(this._layer);
            }
            return;
        }// end function

        private function controlCooperateCode(param1:Number) : void
        {
            if (this._cooperateCodeMain)
            {
                this._cooperateCodeMain.control(param1);
                if (this._cooperateCodeMain.bClose)
                {
                    this._cooperateCodeMain.release();
                    this._cooperateCodeMain = null;
                    this.setPhase(this._PHASE_MY_PAGE);
                }
            }
            return;
        }// end function

        private function phaseNameEntry() : void
        {
            if (this._palace != null)
            {
                this._palace.close();
            }
            if (this._emperor != null)
            {
                this._emperor.close();
            }
            if (this._nameEntry == null)
            {
                this._nameEntry = new HomeNameEntryMain(this._layer);
                this._nameEntry.open();
                Main.GetProcess().topBar.close();
            }
            return;
        }// end function

        private function controlNameEntry(param1:Number) : void
        {
            if (this._nameEntry)
            {
                this._nameEntry.control(param1);
                if (this._nameEntry.bClose)
                {
                    this._nameEntry.release();
                    this._nameEntry = null;
                    if (this._palace)
                    {
                        this._palace.updateUserName();
                    }
                    Main.GetProcess().topBar.updateEmperorName();
                    Main.GetProcess().topBar.open();
                    this.setPhase(this._PHASE_MY_PAGE);
                }
            }
            return;
        }// end function

        private function phaseReOpen() : void
        {
            if (this._palace != null)
            {
                this._palace.close();
            }
            this.playBgm();
            this._isoMain.setIn();
            this._curParty.open();
            this._institution.emperReCheak();
            return;
        }// end function

        private function controlReOpen() : void
        {
            if (this._isoMain.bOpened)
            {
                this._institution.open();
                this.setPhase(this._PHASE_MAIN);
            }
            return;
        }// end function

        private function phaseDirectRecoveryCheck() : void
        {
            this._institution.iconDisable(true);
            return;
        }// end function

        private function controlDirectRecoveryCheck() : void
        {
            return;
        }// end function

        private function phaseRecoveryEffect() : void
        {
            this._institution.iconDisable(true);
            return;
        }// end function

        private function controlRecoveryEffect() : void
        {
            if (this._restFinishedPopup)
            {
                if (this._restFinishedPopup.bClose)
                {
                    this._restFinishedPopup.release();
                    this._restFinishedPopup = null;
                }
                else
                {
                    return;
                }
            }
            if (this._aRestPlayerUniqueId.length > 0)
            {
                if (CommonPopup.isUse() == false && Main.GetProcess().topBar.bConfigWindowOpend == false)
                {
                    if (this._restFinishedPopup == null)
                    {
                        this._restFinishedPopup = new BarracksRestFinishedPopup(this._layer.getLayer(LayerHome.NOTICE), function () : void
            {
                return;
            }// end function
            );
                        this.setRestEndAction();
                    }
                }
            }
            else
            {
                if (this._curParty)
                {
                    this._curParty.setRestEndEffectWait(false);
                }
                this.setPhase(this._PHASE_MAIN);
            }
            return;
        }// end function

        private function phaseEnd() : void
        {
            Main.GetProcess().SetProcessId(this._nextProcessId);
            return;
        }// end function

        private function checkSortie() : void
        {
            this._sortieChecker.checkSortie();
            return;
        }// end function

        private function playBgm() : void
        {
            if (SoundManager.getInstance().bgmId != this._bgmId)
            {
                SoundManager.getInstance().playBgm(this._bgmId);
            }
            return;
        }// end function

        private function cbSpecialMiniNotice(param1:NetResult) : void
        {
            NoticeManager.getInstance().crearSimpleNoticeByType(this._simpleNotice.noticeType);
            this._simpleNotice.release();
            this._simpleNotice = null;
            if (NoticeManager.getInstance().bShowNotice() == true)
            {
                this.setPhase(this._PHASE_SPECIAL_NOTICE);
            }
            else
            {
                this._bHomeDarken = false;
                this.setPhase(this._PHASE_LOST_NOTICE);
            }
            return;
        }// end function

        private function cbThroughNotice(param1:NetResult) : void
        {
            var _loc_2:* = 0;
            if (this._aThroughId)
            {
                for each (_loc_2 in this._aThroughId)
                {
                    
                    NoticeManager.getInstance().clearThroughNoticeById(_loc_2);
                }
                this._aThroughId = null;
            }
            this.setPhase(this._PHASE_SIMPLE_NOTICE);
            return;
        }// end function

        private function cbMiniNotice(param1:NetResult) : void
        {
            NoticeManager.getInstance().crearSimpleNoticeByType(this._simpleNotice.noticeType);
            var _loc_2:* = this._simpleNotice.bProcess;
            this._nextProcessId = this._simpleNotice.nextProcessId;
            this._simpleNotice.release();
            this._simpleNotice = null;
            if (_loc_2)
            {
                this._bHomeDarken = false;
                this.setPhase(this._PHASE_CLOSE);
            }
            else if (NoticeManager.getInstance().bShowNotice() == true)
            {
                this.setPhase(this._PHASE_SIMPLE_NOTICE);
            }
            else
            {
                this._bHomeDarken = false;
                this.setPhase(this._PHASE_SCRIPT_CHECK);
            }
            return;
        }// end function

        private function cbLaterNotice(param1:NetResult) : void
        {
            if (this._simpleNotice.noticeType == CommonConstant.NOTICE_COOPERATE_SERIAL)
            {
                NoticeManager.getInstance().crearSimpleNoticeById(this._simpleNotice.noticeUniqueId);
            }
            else
            {
                NoticeManager.getInstance().crearSimpleNoticeByType(this._simpleNotice.noticeType);
            }
            var _loc_2:* = this._simpleNotice.bProcess;
            this._nextProcessId = this._simpleNotice.nextProcessId;
            this._simpleNotice.release();
            this._simpleNotice = null;
            if (NoticeManager.getInstance().bShowNotice() == true)
            {
                this.setPhase(this._PHASE_LATER_NOTICE);
            }
            else
            {
                this._bHomeDarken = false;
                this.setPhase(this._PHASE_LOCAL_NOTICE);
            }
            return;
        }// end function

        private function cbLostCharm() : void
        {
            UserDataManager.getInstance().userData.resetLostCharmId();
            this.setPhase(this._PHASE_CHARACTER_LIST_EMPTY_CHECK);
            return;
        }// end function

        private function cbCommonPopup() : void
        {
            this._institution.iconDisable(this._phase != this._PHASE_MAIN);
            return;
        }// end function

        private function cbCloseEmperor() : void
        {
            if (this._emperor)
            {
                this._emperor.close();
            }
            return;
        }// end function

        private function cbOpenEmperor() : void
        {
            if (this._emperor)
            {
                this._emperor.open();
            }
            return;
        }// end function

        private function cbCloseLv0PopUp() : void
        {
            if (this._institution)
            {
                this._institution.iconDisable(this._phase != this._PHASE_MAIN);
            }
            return;
        }// end function

        private function cbStorageNoticePopup() : void
        {
            this.setPhase(this._PHASE_STORAGE_NOTICE_RECEIVE);
            return;
        }// end function

        private function cbStorageNoticeReceive(param1:NetResult) : void
        {
            this.setPhase(this._PHASE_THROUGH_NOTICE);
            return;
        }// end function

        private function cbConfigWindowOpen() : void
        {
            if (this._institution)
            {
                this._institution.iconDisable(true);
            }
            return;
        }// end function

        private function cbConfigWindowClose() : void
        {
            if (this._institution)
            {
                this._institution.iconDisable(this._phase != this._PHASE_MAIN);
            }
            return;
        }// end function

        private function cbRestEnd(param1:PlayerPersonal) : void
        {
            if (this._institution)
            {
                this._institution.barracksReCheak();
                this.checkSortie();
            }
            if (this._curParty)
            {
                this._curParty.setRestEndEffectWait(true);
                this._curParty.updatePartyCharacter();
            }
            ArrayUtil.uniquePushId(this._aRestPlayerUniqueId, param1.uniqueId);
            if (this._phase == this._PHASE_MAIN)
            {
                this.setPhase(this._PHASE_RECOVERY_EFFECT);
            }
            return;
        }// end function

        private function setRestEndAction() : void
        {
            var _loc_1:* = 0;
            if (this._curParty)
            {
                for each (_loc_1 in this._aRestPlayerUniqueId)
                {
                    
                    this._curParty.setRestEndAction(_loc_1);
                }
            }
            this._aRestPlayerUniqueId = [];
            return;
        }// end function

        private function cbDirectHealingStart(param1:int) : void
        {
            this.setPhase(this._PHASE_DIRECT_RECOVERY_CHECK);
            return;
        }// end function

        private function cbDirectHealingEnd(param1:int) : void
        {
            if (param1 != Constant.EMPTY_ID)
            {
                BarracksAutoRestManager.getInstance().updateCheckPlayer(BarracksAutoRestManager.CHECK_TARGET_PARTY);
                if (this._institution)
                {
                    this._institution.barracksReCheak();
                    this.checkSortie();
                }
                if (this._curParty)
                {
                    this._curParty.setRestEndEffectWait(true);
                    this._curParty.updatePartyCharacter();
                }
                ArrayUtil.uniquePushId(this._aRestPlayerUniqueId, param1);
                this.setPhase(this._PHASE_RECOVERY_EFFECT);
                return;
            }
            if (this._curParty.bJumpTradingPost)
            {
                this._nextProcessId = ProcessMain.PROCESS_TRADING_POST;
                this.setPhase(this._PHASE_CLOSE);
            }
            else
            {
                this.setPhase(this._PHASE_MAIN);
            }
            return;
        }// end function

        private function cbInfoBtn(param1:int) : void
        {
            this.setPhase(this._PHASE_ALREADY_MANAGEMENT_NOTICE);
            return;
        }// end function

        private function cbDailyMissionBtn(param1:int) : void
        {
            this._nextProcessId = ProcessMain.PROCESS_DAILY_MISSION;
            this.setPhase(this._PHASE_CLOSE);
            return;
        }// end function

    }
}
