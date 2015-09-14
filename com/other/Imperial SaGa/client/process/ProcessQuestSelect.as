package process
{
    import area.*;
    import button.*;
    import develop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import input.*;
    import layer.*;
    import message.*;
    import network.*;
    import player.*;
    import popup.*;
    import quest.*;
    import questSelect.*;
    import resource.*;
    import script.*;
    import sound.*;
    import subdualPoint.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class ProcessQuestSelect extends ProcessBase
    {
        private var _PHASE_NONE:int = 0;
        private var _PHASE_PROVISION_NOTICE:int = 20;
        private var _PHASE_NEW_QUEST_NOTICE_CHECK:int = 30;
        private var _PHASE_NEW_QUEST_NOTICE:int = 40;
        private var _PHASE_WORLD_MAP_OPEN:int = 10;
        private var _PHASE_WORLDMAP:int = 11;
        private var _PHASE_AREAMAP:int = 60;
        private var _PHASE_QUEST_LIST:int = 70;
        private var _PHASE_QUEST_DETAIL:int = 80;
        private var _PHASE_AREAMAP_RETURN:int = 100;
        private var _PHASE_QUEST_DETAIL_RETURN:int = 110;
        private var _PHASE_AREA_QUEST_RESOURCE:int = 120;
        private var _PHASE_BATTLE_QUEST_RESOURCE:int = 400;
        private var _PHASE_BATTLE_QUEST_OPEN:int = 410;
        private var _PHASE_BATTLE_QUEST:int = 420;
        private var _PHASE_CAMPAIGN_QUEST_RESOURCE:int = 500;
        private var _PHASE_CAMPAIGN_QUEST_CHECK:int = 510;
        private var _PHASE_CAMPAIGN_QUEST_OPEN:int = 520;
        private var _PHASE_CAMPAIGN_QUEST:int = 530;
        private var _PHASE_CAMPAIGN_POINT_REWARD:int = 540;
        private var _PHASE_CAMPAIGN_POINT_REWARD_RECEIVE:int = 550;
        private const _PHASE_SCRIPT_CHECK:int = 600;
        private const _PHASE_SCRIPT_LOAD:int = 610;
        private const _PHASE_SCRIPT_EXE:int = 620;
        private const _PHASE_PAGE_CHANGE:int = 700;
        private const _PHASE_NEW_CAMPAIGN_PAGE_NOTICE:int = 800;
        private var _PHASE_GOTO_PROCESS:int = 900;
        private var _PHASE_WORLD_END:int = 1000;
        private var _PHASE_RELOAD:int = 9999;
        private var _layer:LayerQuestSelect;
        private var _phase:int;
        private var _areaId:int;
        private var _selectQuestId:int;
        private var _mcMain:MovieClip;
        private var _mcWorldMap:MovieClip;
        private var _mcAreaMap:MovieClip;
        private var _mcAreaDetail:MovieClip;
        private var _mcAreaQuestList:MovieClip;
        private var _mcAreaQuestDetail:MovieClip;
        private var _worldMap:WorldMap;
        private var _areaDetail:AreaDetail;
        private var _areaMap:AreaMap;
        private var _areaQuestList:AreaQuestList;
        private var _areaQuestDetail:AreaQuestDetail;
        private var _areaName:AreaName;
        private var _noticeWindow:NoticeWindow;
        private var _provisionCheck:ProvisionChecker;
        private var _bConnectionGet:Boolean;
        private var _bSelectIcon:Boolean;
        private var _bNewBattleQuest:Boolean;
        private var _bDetailDisable:Boolean;
        private var _aAreaInformation:Array;
        private var _aAreaQuest:Dictionary;
        private var _bLostSubQuestNotice:Boolean;
        private var _aNewAreaNotice:Array;
        private var _aNewQuestNotice:Array;
        private var _aNewBattleQuestNotice:Array;
        private var _aNewCampaignQuestNotice:Array;
        private var _displayType:int;
        private var _aDisplayQuestNotice:Array;
        private var _aDisplayAreaNotice:Array;
        private var _battleQuestNum:int;
        private var _recommendLv:int;
        private var _aBanner:Array;
        private var _overAreaId:int = -1;
        private var _btnReturn:ButtonBase;
        private var _btnMainQuest:ButtonBase;
        private var _btnBattleQuest:ButtonBase;
        private var _btnCampaignQuest:ButtonBase;
        private var _nowQuestPageIdx:int;
        private var _aQuestPage:Array;
        private var _campaignDetail:CampaignDetail;
        private var _aQuestEvent:Array;
        private var _scriptMain:ScriptMain;
        private var _selectCampaignId:int = -1;
        private var _selectCampaignSubId:int = -1;
        private var _subdualPointBar:SubdualPointBar;
        private var _subdualPointRewardWnd:SubdualPointRewardWindow;
        private var _subdualPointRewardReceive:SubdualPointRewardReceivePopup;

        public function ProcessQuestSelect()
        {
            return;
        }// end function

        private function get _nextQuestPageIdx() : int
        {
            var _loc_1:* = this._nowQuestPageIdx;
            _loc_1++;
            if (_loc_1 >= (this._aQuestPage != null ? (this._aQuestPage.length) : (0)))
            {
                _loc_1 = 0;
            }
            return _loc_1;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._btnReturn)
            {
                ButtonManager.getInstance().removeButton(this._btnReturn);
            }
            this._btnReturn = null;
            if (this._btnMainQuest)
            {
                ButtonManager.getInstance().removeButton(this._btnMainQuest);
            }
            this._btnMainQuest = null;
            if (this._btnBattleQuest)
            {
                ButtonManager.getInstance().removeButton(this._btnBattleQuest);
            }
            this._btnBattleQuest = null;
            if (this._btnCampaignQuest)
            {
                ButtonManager.getInstance().removeButton(this._btnCampaignQuest);
            }
            this._btnCampaignQuest = null;
            if (this._campaignDetail)
            {
                this._campaignDetail.release();
            }
            this._campaignDetail = null;
            if (this._scriptMain)
            {
                this._scriptMain = null;
            }
            if (this._worldMap)
            {
                this._worldMap.release();
            }
            this._worldMap = null;
            if (this._areaDetail)
            {
                this._areaDetail.release();
            }
            this._areaDetail = null;
            if (this._provisionCheck)
            {
                this._provisionCheck.release();
            }
            this._provisionCheck = null;
            if (this._subdualPointRewardReceive)
            {
                this._subdualPointRewardReceive.release();
            }
            this._subdualPointRewardReceive = null;
            if (this._subdualPointRewardWnd)
            {
                this._subdualPointRewardWnd.release();
            }
            this._subdualPointRewardWnd = null;
            if (this._subdualPointBar)
            {
                this._subdualPointBar.release();
            }
            this._subdualPointBar = null;
            if (this._noticeWindow)
            {
                this._noticeWindow.release();
            }
            this._noticeWindow = null;
            if (this._areaMap)
            {
                this._areaMap.release();
            }
            this._areaMap = null;
            if (this._areaQuestList)
            {
                this._areaQuestList.release();
            }
            this._areaQuestList = null;
            if (this._areaQuestDetail)
            {
                this._areaQuestDetail.release();
            }
            this._areaQuestDetail = null;
            if (this._areaName)
            {
                this._areaName.release();
            }
            this._areaName = null;
            if (this._mcAreaDetail)
            {
                if (this._mcAreaDetail.parent)
                {
                    this._mcAreaDetail.parent.removeChild(this._mcAreaDetail);
                }
            }
            this._mcAreaDetail = null;
            if (this._mcWorldMap)
            {
                if (this._mcWorldMap.parent)
                {
                    this._mcWorldMap.parent.removeChild(this._mcWorldMap);
                }
            }
            this._mcWorldMap = null;
            if (this._mcAreaMap)
            {
                if (this._mcAreaMap.parent)
                {
                    this._mcAreaMap.parent.removeChild(this._mcAreaMap);
                }
            }
            this._mcAreaMap = null;
            if (this._mcAreaQuestDetail)
            {
                if (this._mcAreaQuestDetail.parent)
                {
                    this._mcAreaQuestDetail.parent.removeChild(this._mcAreaQuestDetail);
                }
            }
            this._mcAreaQuestDetail = null;
            if (this._mcMain)
            {
                if (this._mcMain.parent)
                {
                    this._mcMain.parent.removeChild(this._mcMain);
                }
            }
            this._mcMain = null;
            TutorialManager.getInstance().release();
            return;
        }// end function

        override public function init() : void
        {
            super.init();
            this._layer = new LayerQuestSelect();
            addChild(this._layer);
            this._bConnectionGet = false;
            this._bSelectIcon = false;
            this._selectQuestId = Constant.UNDECIDED;
            NetManager.getInstance().request(new NetTaskGetAreaQuest(this.cbReceive));
            _bResourceLoadWait = true;
            return;
        }// end function

        private function cbReceive(param1:NetResult) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = false;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            this._aAreaInformation = new Array();
            this._bLostSubQuestNotice = false;
            this._aNewAreaNotice = new Array();
            this._aNewQuestNotice = new Array();
            this._aNewBattleQuestNotice = new Array();
            this._aNewCampaignQuestNotice = new Array();
            this._aBanner = new Array();
            this._aAreaQuest = new Dictionary();
            this._aQuestEvent = new Array();
            this._battleQuestNum = 0;
            this._recommendLv = Constant.UNDECIDED;
            var _loc_2:* = UserDataManager.getInstance().userData.isProgressMax();
            if (_loc_2 && UserDataManager.getInstance().userData.bSubQuestLostPopuped == false)
            {
                this._bLostSubQuestNotice = true;
            }
            var _loc_3:* = AreaManager.getInstance().getAllArea();
            for each (_loc_4 in _loc_3)
            {
                
                this._aAreaQuest[_loc_4.id] = [];
            }
            for each (_loc_7 in param1.data.aArea)
            {
                
                _loc_5 = new AreaInformation();
                _loc_5.setReceive(_loc_7, _loc_2);
                for each (_loc_6 in _loc_5.aQuest)
                {
                    
                    if (_loc_6.bNewQuest)
                    {
                        if (_loc_5.areaId != QuestConstant.BATTLE_QUEST_AREA_ID)
                        {
                            this._aNewQuestNotice.push(_loc_5.areaId);
                        }
                        else
                        {
                            this._aNewBattleQuestNotice.push(_loc_5.areaId);
                        }
                        break;
                    }
                }
                if (_loc_5.bNewArea == true)
                {
                    if (_loc_5.aQuest.length > 0)
                    {
                        this._aNewAreaNotice.push(_loc_5.areaId);
                    }
                }
                if (_loc_5.areaId == QuestConstant.BATTLE_QUEST_AREA_ID)
                {
                    this._battleQuestNum = this._battleQuestNum + _loc_5.aQuest.length;
                }
                for each (_loc_6 in _loc_5.aQuest)
                {
                    
                    if (_loc_6.questType == CommonConstant.QUEST_TYPE_SUB && _loc_6.totalClearCount == 0)
                    {
                        if (this._recommendLv == Constant.UNDECIDED || this._recommendLv > _loc_6.questLv)
                        {
                            this._recommendLv = _loc_6.questLv;
                        }
                    }
                }
                this._aAreaQuest[_loc_5.areaId] = _loc_5.aQuest;
                this._aAreaInformation.push(_loc_5);
            }
            for each (_loc_5 in this._aAreaInformation)
            {
                
                _loc_13 = false;
                for each (_loc_6 in _loc_5.aQuest)
                {
                    
                    if (_loc_6.questType == CommonConstant.QUEST_TYPE_SUB && _loc_6.totalClearCount == 0 && _loc_6.questLv == this._recommendLv)
                    {
                        _loc_6.setEasyQuest(true);
                        _loc_13 = true;
                    }
                }
                _loc_5.setEasyArea(_loc_13);
            }
            _loc_8 = 0;
            for each (_loc_9 in param1.data.aBanner)
            {
                
                _loc_14 = new BannerData();
                _loc_14.setRecieve(_loc_9, _loc_8);
                if (_loc_14.bannerPath.indexOf("http") >= 0)
                {
                    ResourceManager.getInstance().loadResourceUrl(_loc_14.bannerPath);
                    this._aBanner.push(_loc_14);
                }
                _loc_8++;
            }
            for each (_loc_11 in param1.data.aCampaign)
            {
                
                _loc_10 = new QuestCampaignData();
                _loc_10.setReceiveData(_loc_11);
                this._aQuestEvent.push(_loc_10);
                if (!TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_CAMPAIGN_QUEST))
                {
                    for each (_loc_6 in _loc_10.areaInfo.aQuest)
                    {
                        
                        if (_loc_6.bNewQuest)
                        {
                            this._aNewCampaignQuestNotice.push(_loc_5.areaId);
                            break;
                        }
                    }
                }
            }
            this.createQuestPageList();
            ResourceManager.getInstance().loadResource(ResourcePath.QUEST_PATH + "UI_QuestSelect.swf");
            WorldMap.loadResource();
            ResourceManager.getInstance().loadResource(ResourcePath.NAVI_CHARACTER_PATH);
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Balloon.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            for each (_loc_12 in UserDataManager.getInstance().userData.aFormationPlayerUniqueId)
            {
                
                if (_loc_12 == 0)
                {
                    continue;
                }
                _loc_15 = UserDataManager.getInstance().userData.getPlayerPersonal(_loc_12);
                if (_loc_15 == null)
                {
                    continue;
                }
                _loc_16 = PlayerManager.getInstance().getPlayerInformation(_loc_15.playerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_16.swf);
            }
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf");
            SoundManager.getInstance().loadSound(SoundId.BGM_MYP_WORLDMAP);
            SoundManager.getInstance().loadSoundArray([SoundId.SE_CARPET_ROLL, SoundId.SE_WINDOW_OPEN, SoundId.SE_WINDOW_CLOSE, SoundId.SE_ARART_WINDOW, SoundId.SE_ARART_CLOSE]);
            CommonPopup.getInstance().loadResource();
            UseItemSelect.loadResource();
            ProvisionChecker.loadResource();
            ScriptManager.getInstance().defaultResourceLoad();
            ScriptManager.getInstance().loadResource();
            if (TutorialManager.getInstance().isTutorial())
            {
                TutorialManager.getInstance().loadResource();
            }
            this._bConnectionGet = true;
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            if (this._bConnectionGet == false || ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false || ScriptManager.getInstance().isLoaded() == false)
            {
                return;
            }
            if (SoundManager.getInstance().bgmId != SoundId.BGM_MYP_WORLDMAP)
            {
                SoundManager.getInstance().playBgm(SoundId.BGM_MYP_WORLDMAP);
            }
            this._mcMain = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + "UI_QuestSelect.swf", "QuestSelectMc");
            this._mcWorldMap = this._mcMain.worldmapAllMc;
            this._mcAreaMap = this._mcMain.areamapAllMc;
            this._mcAreaDetail = this._mcMain.areaDetailAllMc;
            this._mcAreaQuestList = this._mcMain.questWindowMc;
            this._mcAreaQuestDetail = this._mcMain.questDetailAllMc;
            this._btnReturn = ButtonManager.getInstance().addButton(this._mcMain.returnBtn, this.cbReturnButton);
            this._btnReturn.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._btnReturn.setDisable(true);
            TextControl.setIdText(this._mcMain.returnBtn.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._btnMainQuest = ButtonManager.getInstance().addButton(this._mcMain.mainBtn, this.cbBattleQuest);
            this._btnMainQuest.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcMain.mainBtn.textMc.textDt, MessageId.QUEST_MAIN_QUEST_BUTTON);
            this._btnBattleQuest = ButtonManager.getInstance().addButton(this._mcMain.dailyBtn, this.cbBattleQuest);
            this._btnBattleQuest.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcMain.dailyBtn.textMc.textDt, MessageId.QUEST_BATTLE_QUEST_BUTTON);
            this._btnCampaignQuest = ButtonManager.getInstance().addButton(this._mcMain.campaignBtn, this.cbBattleQuest);
            this._btnCampaignQuest.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcMain.campaignBtn.textMc.textDt, MessageId.QUEST_EVENT_QUEST_BUTTON);
            this.setVisibleBattleQuestButton(false);
            this.setDisableBattleQuestButton(true);
            this._layer.getLayer(LayerQuestSelect.MAIN).addChild(this._mcMain);
            this._worldMap = new WorldMap(this._mcWorldMap, this._aAreaInformation);
            this._areaDetail = new AreaDetail(this._mcAreaDetail, this._aAreaInformation);
            this._areaMap = new AreaMap(this._mcAreaMap, this.cbIconMouseOver, this.cbIconMouseOut, this.cbQuestSelect, this.cbAreaMapMouseClick);
            this._areaQuestList = new AreaQuestList(this._mcAreaQuestList, this.cbLineMouseOver, this.cbLineMouseOut, this.cbQuestSelect);
            this._areaQuestList.setPageCallback(this.cbQuestListIn, this.cbQuestListOut);
            this._areaQuestDetail = new AreaQuestDetail(this._mcAreaQuestDetail, this._layer, this.cbQuestDetailBack, this.cbReload);
            this._areaName = new AreaName(this._mcMain.cityTitleTopMc);
            this._subdualPointBar = new SubdualPointBar(this._layer.getLayer(LayerQuestSelect.MAIN), this.cbRewardBtn);
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_SELECT_END))
            {
                this._areaId = this._aAreaInformation[0].areaId;
                if (this._noticeWindow)
                {
                    this._noticeWindow.release();
                }
                this._noticeWindow = null;
                if (Main.GetProcess().fade.isFade())
                {
                    Main.GetProcess().fade.setFadeIn(0.2);
                }
                this._btnReturn.seal(true);
                this._btnBattleQuest.seal(true);
                QuestSelectManager.getInstance().savePageData(QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN, this._areaId, Constant.UNDECIDED);
                this.setPhase(this._PHASE_AREA_QUEST_RESOURCE);
            }
            else
            {
                this.setQuestPage(this._nowQuestPageIdx);
            }
            _bResourceLoadWait = false;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            switch(this._phase)
            {
                case this._PHASE_WORLD_MAP_OPEN:
                {
                    this.controlWorldMapOpen();
                    break;
                }
                case this._PHASE_PROVISION_NOTICE:
                {
                    this.controlProvisionNotice(param1);
                    break;
                }
                case this._PHASE_NEW_QUEST_NOTICE_CHECK:
                {
                    this.controlNewQuestNoticeCheck();
                    break;
                }
                case this._PHASE_NEW_QUEST_NOTICE:
                {
                    this.controlNewQuestNotice(param1);
                    break;
                }
                case this._PHASE_WORLDMAP:
                {
                    this.controlWorldMap(param1);
                    break;
                }
                case this._PHASE_AREAMAP:
                {
                    this.controlAreaMap(param1);
                    break;
                }
                case this._PHASE_QUEST_LIST:
                {
                    this.controlQuestList(param1);
                    break;
                }
                case this._PHASE_QUEST_DETAIL:
                {
                    this.controlQuestDetail(param1);
                    break;
                }
                case this._PHASE_AREAMAP_RETURN:
                {
                    this.controlAreaMapReturn();
                    break;
                }
                case this._PHASE_QUEST_DETAIL_RETURN:
                {
                    this.controlQuestDetailReturn();
                    break;
                }
                case this._PHASE_AREA_QUEST_RESOURCE:
                {
                    this.controlAreaQuestResource();
                    break;
                }
                case this._PHASE_BATTLE_QUEST_RESOURCE:
                {
                    this.controlBattleQuestResource();
                    break;
                }
                case this._PHASE_BATTLE_QUEST_OPEN:
                {
                    this.controlBattleQuestOpen(param1);
                    break;
                }
                case this._PHASE_BATTLE_QUEST:
                {
                    this.controlBattleQuest(param1);
                    break;
                }
                case this._PHASE_CAMPAIGN_QUEST_RESOURCE:
                {
                    this.controlCampaignQuestResource();
                    break;
                }
                case this._PHASE_CAMPAIGN_QUEST_CHECK:
                {
                    this.controlCampaignQuestCheck();
                    break;
                }
                case this._PHASE_CAMPAIGN_QUEST_OPEN:
                {
                    this.controlCampaignQuestOpen(param1);
                    break;
                }
                case this._PHASE_CAMPAIGN_QUEST:
                {
                    this.controlCampaignQuest(param1);
                    break;
                }
                case this._PHASE_CAMPAIGN_POINT_REWARD:
                {
                    this.controlCampaignPointReward(param1);
                    break;
                }
                case this._PHASE_CAMPAIGN_POINT_REWARD_RECEIVE:
                {
                    this.controlCampaignPointRewardReceive(param1);
                    break;
                }
                case this._PHASE_SCRIPT_CHECK:
                {
                    this.controlScriptCheck(param1);
                    break;
                }
                case this._PHASE_SCRIPT_LOAD:
                {
                    this.controlScriptLoad(param1);
                    break;
                }
                case this._PHASE_SCRIPT_EXE:
                {
                    this.controlScriptExe(param1);
                    break;
                }
                case this._PHASE_PAGE_CHANGE:
                {
                    this.controlPageChange(param1);
                    break;
                }
                case this._PHASE_NEW_CAMPAIGN_PAGE_NOTICE:
                {
                    this.controlNewCampaignPageNotice(param1);
                    break;
                }
                case this._PHASE_GOTO_PROCESS:
                {
                    this.controlGotoProcess();
                    break;
                }
                case this._PHASE_WORLD_END:
                {
                    this.controlWorldEnd();
                    break;
                }
                case this._PHASE_RELOAD:
                {
                    this.controlReload();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._areaMap != null && this._areaMap.bOpen)
            {
                this._bSelectIcon = false;
                _loc_2 = InputManager.getInstance().corsor;
                for each (_loc_3 in this._areaMap.aBtnIcon)
                {
                    
                    if (_loc_3.isHit(_loc_2.x, _loc_2.y))
                    {
                        this._bSelectIcon = true;
                        break;
                    }
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case this._PHASE_WORLD_MAP_OPEN:
                {
                    this.phaseWorldMapOpen();
                    break;
                }
                case this._PHASE_PROVISION_NOTICE:
                {
                    this.phaseProvisionNotice();
                    break;
                }
                case this._PHASE_NEW_QUEST_NOTICE_CHECK:
                {
                    this.phaseNewQuestNoticeCheck();
                    break;
                }
                case this._PHASE_NEW_QUEST_NOTICE:
                {
                    this.phaseNewQuestNotice();
                    break;
                }
                case this._PHASE_WORLDMAP:
                {
                    this.phaseWorldMap();
                    break;
                }
                case this._PHASE_AREAMAP:
                {
                    this.phaseAreaMap();
                    break;
                }
                case this._PHASE_QUEST_LIST:
                {
                    this.phaseQuestList();
                    break;
                }
                case this._PHASE_QUEST_DETAIL:
                {
                    this.phaseQuestDetail();
                    break;
                }
                case this._PHASE_AREAMAP_RETURN:
                {
                    this.phaseAreaMapReturn();
                    break;
                }
                case this._PHASE_QUEST_DETAIL_RETURN:
                {
                    this.phaseQuestDetailReturn();
                    break;
                }
                case this._PHASE_AREA_QUEST_RESOURCE:
                {
                    this.phaseAreaQuestResource();
                    break;
                }
                case this._PHASE_BATTLE_QUEST_RESOURCE:
                {
                    this.phaseBattleQuestResource();
                    break;
                }
                case this._PHASE_BATTLE_QUEST_OPEN:
                {
                    this.phaseBattleQuestOpen();
                    break;
                }
                case this._PHASE_BATTLE_QUEST:
                {
                    this.phaseBattleQuest();
                    break;
                }
                case this._PHASE_CAMPAIGN_QUEST_RESOURCE:
                {
                    this.phaseCampaignQuestResource();
                    break;
                }
                case this._PHASE_CAMPAIGN_QUEST_CHECK:
                {
                    this.phaseCampaignQuestCheck();
                    break;
                }
                case this._PHASE_CAMPAIGN_QUEST_OPEN:
                {
                    this.phaseCampaignQuestOpen();
                    break;
                }
                case this._PHASE_CAMPAIGN_QUEST:
                {
                    this.phaseCampaignQuest();
                    break;
                }
                case this._PHASE_CAMPAIGN_POINT_REWARD:
                {
                    this.phaseCampaignPointReward();
                    break;
                }
                case this._PHASE_CAMPAIGN_POINT_REWARD_RECEIVE:
                {
                    this.phaseCampaignPointRewardReceive();
                    break;
                }
                case this._PHASE_SCRIPT_CHECK:
                {
                    this.phaseScriptCheck();
                    break;
                }
                case this._PHASE_SCRIPT_LOAD:
                {
                    this.phaseScriptLoad();
                    break;
                }
                case this._PHASE_SCRIPT_EXE:
                {
                    this.phaseScriptExe();
                    break;
                }
                case this._PHASE_PAGE_CHANGE:
                {
                    this.phasePageChange();
                    break;
                }
                case this._PHASE_NEW_CAMPAIGN_PAGE_NOTICE:
                {
                    this.phaseNewCampaignPageNotice();
                    break;
                }
                case this._PHASE_GOTO_PROCESS:
                {
                    this.phaseGotoProcess();
                    break;
                }
                case this._PHASE_WORLD_END:
                {
                    this.phaseWorldEnd();
                    break;
                }
                case this._PHASE_RELOAD:
                {
                    this.phaseReload();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function phaseProvisionNotice() : void
        {
            if (this._provisionCheck == null)
            {
                this._provisionCheck = new ProvisionChecker(ProvisionChecker.CHECK_TARGET_FREE_WHOLE_ARMY_ASSAULT);
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
                setPhase(_PHASE_NEW_QUEST_NOTICE_CHECK);
                return;
            }// end function
            );
            }
            else
            {
                this._provisionCheck.release();
                this._provisionCheck = null;
                this.setPhase(this._PHASE_NEW_QUEST_NOTICE_CHECK);
            }
            return;
        }// end function

        private function controlProvisionNotice(param1:Number) : void
        {
            return;
        }// end function

        private function phaseNewQuestNoticeCheck() : void
        {
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_WORLD_MAP))
            {
                TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_WORLD_MAP, function () : void
            {
                setPhase(_PHASE_WORLD_END);
                return;
            }// end function
            );
                return;
            }
            this._displayType = Constant.UNDECIDED;
            this._aDisplayQuestNotice = [];
            this._aDisplayAreaNotice = [];
            if (this._bLostSubQuestNotice)
            {
                this._displayType = NoticeWindow.TYPE_SUB_QUEST_LOST;
                this._bLostSubQuestNotice = false;
                UserDataManager.getInstance().userData.setSubQuestLostPopuped();
            }
            else if (this._aNewQuestNotice.length > 0 || this._aNewAreaNotice.length > 0)
            {
                this._displayType = NoticeWindow.TYPE_AREA_QUEST;
                this._aDisplayQuestNotice = this._aNewQuestNotice;
                this._aDisplayAreaNotice = this._aNewAreaNotice;
                this._aNewQuestNotice = [];
                this._aNewAreaNotice = [];
            }
            else if (this._aNewBattleQuestNotice.length > 0)
            {
                this._displayType = NoticeWindow.TYPE_BATTLE_QUEST;
                this._aDisplayQuestNotice = this._aNewBattleQuestNotice;
                this._aNewBattleQuestNotice = [];
            }
            else if (this._aNewCampaignQuestNotice.length > 0)
            {
                this._displayType = NoticeWindow.TYPE_CAMPAIGN_QUEST;
                this._aDisplayQuestNotice = this._aNewCampaignQuestNotice;
                this._aNewCampaignQuestNotice = [];
            }
            if (this._displayType == Constant.UNDECIDED)
            {
                this.setPhase(this._PHASE_NEW_CAMPAIGN_PAGE_NOTICE);
            }
            else
            {
                this.setPhase(this._PHASE_NEW_QUEST_NOTICE);
            }
            return;
        }// end function

        private function controlNewQuestNoticeCheck() : void
        {
            return;
        }// end function

        private function phaseNewQuestNotice() : void
        {
            if (this._noticeWindow == null)
            {
                this._noticeWindow = new NoticeWindow(this._layer.getLayer(LayerQuestSelect.NOTICE));
            }
            this._noticeWindow.setIn(this._displayType, this._aDisplayAreaNotice, this._aDisplayQuestNotice);
            return;
        }// end function

        private function controlNewQuestNotice(param1:Number) : void
        {
            this._noticeWindow.control(param1);
            if (this._noticeWindow.bClose)
            {
                this.setPhase(this._PHASE_NEW_QUEST_NOTICE_CHECK);
            }
            return;
        }// end function

        private function phaseNewCampaignPageNotice() : void
        {
            var isWindowOpen:Boolean;
            if (!TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_WORLD_MAP))
            {
                if (this._aQuestEvent && this._aQuestEvent.length > 0)
                {
                    if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_CAMPAIGN_QUEST))
                    {
                        isWindowOpen;
                    }
                }
            }
            if (isWindowOpen)
            {
                with ({})
                {
                    {}.cbClose = function () : void
            {
                setActivePage();
                return;
            }// end function
            ;
                }
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_CAMPAIGN_QUEST, function () : void
            {
                setActivePage();
                return;
            }// end function
            );
            }
            else
            {
                this.setActivePage();
            }
            return;
        }// end function

        private function controlNewCampaignPageNotice(param1:Number) : void
        {
            return;
        }// end function

        private function setActivePage() : void
        {
            var _loc_1:* = this._PHASE_WORLDMAP;
            var _loc_2:* = this._aQuestPage[this._nowQuestPageIdx];
            switch(_loc_2.category)
            {
                case QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN:
                {
                    _loc_1 = this._PHASE_CAMPAIGN_QUEST;
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE:
                {
                    _loc_1 = this._PHASE_BATTLE_QUEST;
                    break;
                }
                default:
                {
                    _loc_1 = this._PHASE_WORLDMAP;
                    break;
                    break;
                }
            }
            this.setPhase(_loc_1);
            return;
        }// end function

        private function phaseWorldMapOpen() : void
        {
            this._worldMap.setIn();
            this._areaDetail.setIn();
            this._worldMap.setDisable(true);
            this._areaDetail.setDisplayNotSelect();
            return;
        }// end function

        private function controlWorldMapOpen() : void
        {
            if (this._worldMap.isOpen() && this._areaDetail.isOpen())
            {
                this.setPhase(this._PHASE_PROVISION_NOTICE);
            }
            return;
        }// end function

        private function phaseWorldMap() : void
        {
            this.setVisibleBattleQuestButton(true);
            this.setDisableBattleQuestButton(true);
            return;
        }// end function

        private function controlWorldMap(param1:Number) : void
        {
            if (this._worldMap == null || this._areaDetail == null)
            {
                DebugLog.print("ワールドマップかエリアマップが作成されませんでした。");
                return;
            }
            if (CommonPopup.isUse())
            {
                return;
            }
            if (this._worldMap.isOpen() && this._areaDetail.isOpen() && this._worldMap.isAnimetion() == false)
            {
                if (this._worldMap.selectAreaId == Constant.UNDECIDED)
                {
                    if (this._btnReturn.isEnable() == false)
                    {
                        this._btnReturn.setDisable(false);
                        this.setDisableBattleQuestButton(false);
                    }
                    if (this._worldMap.bEnable)
                    {
                        this._worldMap.setDisable(false);
                    }
                }
                if (this._worldMap.overAreaId != this._overAreaId)
                {
                    this._overAreaId = this._worldMap.overAreaId;
                    if (this._overAreaId != Constant.UNDECIDED)
                    {
                        this._areaDetail.setDisplayArea(this._overAreaId);
                    }
                    else
                    {
                        this._areaDetail.setDisplayNotSelect();
                    }
                }
                if (this._worldMap.selectAreaId != Constant.UNDECIDED)
                {
                    this._worldMap.setOut();
                    this._areaDetail.setOut();
                    this._overAreaId = Constant.UNDECIDED;
                    this._areaDetail.setDisplayNotSelect();
                    this._btnReturn.setDisable(true);
                    this.setDisableBattleQuestButton(true);
                    this._areaId = this._worldMap.selectAreaId;
                }
            }
            if (this._worldMap.isClose() && this._areaDetail.isClose())
            {
                this.setVisibleBattleQuestButton(false);
                this._areaDetail.setDisplayNotSelect();
                this.setPhase(this._PHASE_AREA_QUEST_RESOURCE);
            }
            return;
        }// end function

        private function phaseAreaMap() : void
        {
            this._areaMap.setIn(this._areaId, this._aBanner);
            var _loc_1:* = AreaManager.getInstance().getArea(this._areaId);
            this._areaName.setIn(_loc_1.name);
            return;
        }// end function

        private function controlAreaMap(param1:Number) : void
        {
            this.setPhase(this._PHASE_QUEST_LIST);
            return;
        }// end function

        private function phaseQuestList() : void
        {
            this._areaQuestList.setIn(this._areaId, this._aAreaQuest[this._areaId] as Array);
            return;
        }// end function

        private function controlQuestList(param1:Number) : void
        {
            if (this._areaQuestList != null)
            {
                this._areaQuestList.control(param1);
                if (this._areaQuestList.bOpen)
                {
                    this.commonBtnCtrlQuestList();
                    if (this.getEnableBattleQuestButton() == true)
                    {
                        this.setDisableBattleQuestButton(true);
                        this.setVisibleBattleQuestButton(false);
                    }
                }
            }
            return;
        }// end function

        private function phaseQuestDetail() : void
        {
            if (this._selectQuestId == Constant.UNDECIDED)
            {
                this._phase = this._PHASE_QUEST_LIST;
                return;
            }
            this._areaMap.setButtonEnable(false);
            this._areaQuestList.setLineEnabe(false);
            this._bDetailDisable = true;
            this._btnReturn.setDisable(true);
            this.setDisableBattleQuestButton(true);
            if (this._campaignDetail)
            {
                this._campaignDetail.setBtnEnableAll(false);
            }
            if (this._subdualPointBar)
            {
                this._subdualPointBar.setBtnEnable(false);
            }
            this._areaQuestDetail.reset();
            this._areaQuestDetail.setIn(this.getSelectQuest());
            TutorialManager.getInstance().hideTutorialArrow();
            return;
        }// end function

        private function controlQuestDetail(param1:Number) : void
        {
            if (this._areaQuestDetail != null)
            {
                this._areaQuestDetail.control(param1);
                if (this._bDetailDisable == true && this._areaQuestDetail.bOpen)
                {
                    this._bDetailDisable = false;
                    if (this._areaMap && this._areaMap.bOpen)
                    {
                        this._areaMap.setButtonEnable(true);
                    }
                }
                if (this._areaQuestDetail.bGotoQuest)
                {
                    this._selectQuestId = Constant.UNDECIDED;
                    QuestManager.getInstance().setQuestNo(this._areaQuestDetail.quest.no, this._areaQuestDetail.quest.eventId);
                    QuestManager.getInstance().setUseItem(this._areaQuestDetail.getUseItemId(), this._areaQuestDetail.getUseFreeItemId());
                    this.setPhase(this._PHASE_GOTO_PROCESS);
                }
                if (this._areaQuestDetail.bGotoFormation || this._areaQuestDetail.bGotoTrading)
                {
                    this._selectQuestId = Constant.UNDECIDED;
                    this.setPhase(this._PHASE_GOTO_PROCESS);
                }
            }
            return;
        }// end function

        private function cbQuestListIn() : void
        {
            var _loc_1:* = this._areaQuestList.getQuestLIst();
            this._areaMap.inIcon(_loc_1);
            return;
        }// end function

        private function cbQuestListOut() : void
        {
            this._areaMap.outIcon();
            return;
        }// end function

        private function cbLineMouseOver(param1:int) : void
        {
            this._areaMap.setSelectIcon(param1);
            SoundManager.getInstance().playSe(ButtonBase.SE_SELECT_ID);
            return;
        }// end function

        private function cbLineMouseOut(param1:int) : void
        {
            this._areaMap.setNotSelectIcon(param1);
            return;
        }// end function

        private function cbIconMouseOver(param1:int) : void
        {
            this._areaQuestList.setSelectLine(param1);
            return;
        }// end function

        private function cbIconMouseOut(param1:int) : void
        {
            this._areaQuestList.setNotSelectLine(param1);
            return;
        }// end function

        private function cbQuestSelect(param1:int) : void
        {
            var _loc_2:* = 0;
            if (this._areaQuestList.bOpen && this._selectQuestId != param1)
            {
                _loc_2 = this._PHASE_QUEST_DETAIL;
                if (this._selectQuestId != Constant.UNDECIDED)
                {
                    _loc_2 = this._PHASE_QUEST_DETAIL_RETURN;
                }
                this._areaMap.setFlagOn(param1);
                this._areaMap.setButtonEnable(false);
                this._areaQuestList.setLineEnabe(false);
                this._btnReturn.setDisable(true);
                this._selectQuestId = param1;
                SoundManager.getInstance().playSe(ButtonBase.SE_DECIDE_ID);
                this.setPhase(_loc_2);
            }
            return;
        }// end function

        private function cbAreaMapMouseClick(event:MouseEvent) : void
        {
            return;
        }// end function

        private function phaseAreaMapReturn() : void
        {
            this._areaMap.setOut();
            this._areaQuestList.setOut();
            if (this._areaName.isOpen())
            {
                this._areaName.setOut();
            }
            this._btnReturn.setDisable(true);
            this.setDisableBattleQuestButton(true);
            return;
        }// end function

        private function controlAreaMapReturn() : void
        {
            if (this._areaMap != null && this._areaQuestList != null)
            {
                if (this._areaMap.bClose && this._areaQuestList.bClose)
                {
                    this.setPhase(this._PHASE_WORLD_MAP_OPEN);
                }
            }
            return;
        }// end function

        private function phaseQuestDetailReturn() : void
        {
            if (this._areaQuestDetail.bOpen)
            {
                this._areaQuestDetail.cbReturnQuestList(0);
            }
            this._btnReturn.setDisable(true);
            this.setDisableBattleQuestButton(true);
            return;
        }// end function

        private function controlQuestDetailReturn() : void
        {
            var _loc_1:* = null;
            if (this._areaQuestDetail.bGotoList)
            {
                this._btnReturn.setDisable(true);
                this.setDisableBattleQuestButton(true);
                this._areaQuestDetail.setOut();
            }
            if (this._areaQuestDetail.bClose)
            {
                if (this._selectQuestId == Constant.UNDECIDED)
                {
                    this._areaMap.allFlagOff();
                    this._areaQuestDetail.reset();
                    this._areaQuestList.bTutorial = false;
                    this._areaQuestList.setLineEnabe(true);
                    _loc_1 = QuestSelectManager.getInstance().getPageData();
                    if (_loc_1)
                    {
                        if (_loc_1.category == QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN)
                        {
                            this._phase = this._PHASE_CAMPAIGN_QUEST;
                        }
                        else if (_loc_1.category == QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE)
                        {
                            this._phase = this._PHASE_BATTLE_QUEST;
                        }
                        else
                        {
                            this._phase = this._PHASE_QUEST_LIST;
                        }
                    }
                }
                else
                {
                    this.setPhase(this._PHASE_QUEST_DETAIL);
                }
            }
            return;
        }// end function

        private function phaseAreaQuestResource() : void
        {
            var _loc_1:* = AreaManager.getInstance().getArea(this._areaId);
            ResourceManager.getInstance().loadResource(ResourcePath.QUEST_AREA_MAP_PATH + _loc_1.areaMapFile);
            return;
        }// end function

        private function controlAreaQuestResource() : void
        {
            if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_AREAMAP);
            }
            return;
        }// end function

        private function phaseBattleQuestResource() : void
        {
            var _loc_1:* = AreaManager.getInstance().getArea(this._areaId);
            ResourceManager.getInstance().loadResource(ResourcePath.QUEST_AREA_MAP_PATH + _loc_1.areaMapFile);
            return;
        }// end function

        private function controlBattleQuestResource() : void
        {
            if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_BATTLE_QUEST_OPEN);
            }
            return;
        }// end function

        private function phaseBattleQuestOpen() : void
        {
            this._areaQuestList.setIn(this._areaId, this._aAreaQuest[this._areaId] as Array);
            this._areaMap.setIn(this._areaId, this._aBanner);
            var _loc_1:* = AreaManager.getInstance().getArea(this._areaId);
            this._areaName.setIn(_loc_1.name);
            this.setDisableAllButton(true);
            return;
        }// end function

        private function controlBattleQuestOpen(param1:Number) : void
        {
            if (this._areaQuestList != null && this._areaMap != null)
            {
                this._areaQuestList.control(param1);
                if (this._areaQuestList.bOpen && this._areaQuestList.bLineOpen && this._areaMap.bOpen)
                {
                    this.setPhase(this._PHASE_PROVISION_NOTICE);
                }
            }
            return;
        }// end function

        private function phaseBattleQuest() : void
        {
            this.setDisableAllButton(true);
            return;
        }// end function

        private function controlBattleQuest(param1:Number) : void
        {
            if (this._areaQuestList != null && this._areaMap != null)
            {
                this._areaQuestList.control(param1);
                if (this._areaQuestList.bOpen && this._areaMap.bOpen)
                {
                    this.commonBtnCtrlQuestList();
                    if (this._areaMap.bBtnEnable == false)
                    {
                        this._areaMap.setButtonEnable(true);
                    }
                }
            }
            return;
        }// end function

        private function phaseCampaignQuestResource() : void
        {
            var _loc_1:* = this.getQuestCampaignData(this._selectCampaignId);
            ResourceManager.getInstance().loadResource(ResourcePath.QUEST_EVENT_PATH + _loc_1.swfFileName);
            return;
        }// end function

        private function controlCampaignQuestResource() : void
        {
            if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_CAMPAIGN_QUEST_CHECK);
            }
            return;
        }// end function

        private function phaseCampaignQuestCheck() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_1:* = this.getQuestCampaignData(this._selectCampaignId);
            if (this._campaignDetail != null)
            {
                this._campaignDetail.release();
            }
            this._campaignDetail = null;
            if (this._campaignDetail == null)
            {
                this._campaignDetail = new CampaignDetail(this._mcMain.eventPageNull, ResourcePath.QUEST_EVENT_PATH + _loc_1.swfFileName, this.cbQuestScript);
            }
            var _loc_2:* = Constant.UNDECIDED;
            if (_loc_1)
            {
                _loc_3 = _loc_1.aDetail[0];
                _loc_4 = _loc_1.aDetail[(_loc_1.aDetail.length - 1)];
                if (_loc_3 && !_loc_3.bRead)
                {
                    _loc_2 = _loc_3.campaignSubId;
                }
                if (_loc_2 == Constant.UNDECIDED)
                {
                    if (_loc_4 && !_loc_4.bRead)
                    {
                        _loc_2 = _loc_4.campaignSubId;
                        _loc_6 = 0;
                        while (_loc_6 < (_loc_1.aDetail.length - 1))
                        {
                            
                            _loc_5 = _loc_1.aDetail[_loc_6];
                            if (_loc_5 && !_loc_5.bRead)
                            {
                                _loc_2 = Constant.UNDECIDED;
                                break;
                            }
                            _loc_6++;
                        }
                    }
                }
            }
            if (_loc_2 != Constant.UNDECIDED)
            {
                this.playScript(_loc_2);
            }
            else
            {
                this.setPhase(this._PHASE_CAMPAIGN_QUEST_OPEN);
            }
            return;
        }// end function

        private function controlCampaignQuestCheck() : void
        {
            return;
        }// end function

        private function phaseCampaignQuestOpen() : void
        {
            var _loc_1:* = this.getQuestCampaignData(this._selectCampaignId);
            this._subdualPointBar.setData(_loc_1.subdualPoint);
            if (!this._campaignDetail.bOpen)
            {
                this._campaignDetail.Init(_loc_1.aDetail);
                this._campaignDetail.setIn();
                this._areaQuestList.setIn(_loc_1.areaInfo.areaId, _loc_1.areaInfo.aQuest);
                this._subdualPointBar.setIn();
            }
            this.setDisableAllButton(true);
            return;
        }// end function

        private function controlCampaignQuestOpen(param1:Number) : void
        {
            if (this._areaQuestList != null)
            {
                this._areaQuestList.control(param1);
                if (this._areaQuestList.bOpen && this._areaQuestList.bLineOpen && this._campaignDetail.bOpen)
                {
                    this.setPhase(this._PHASE_CAMPAIGN_POINT_REWARD_RECEIVE);
                }
            }
            return;
        }// end function

        private function phaseCampaignQuest() : void
        {
            this.setDisableAllButton(true);
            return;
        }// end function

        private function controlCampaignQuest(param1:Number) : void
        {
            if (this._areaQuestList != null)
            {
                this._areaQuestList.control(param1);
                if (this._areaQuestList.bOpen && this._campaignDetail.bOpen)
                {
                    this.commonBtnCtrlQuestList();
                    if (this._campaignDetail && this._campaignDetail.bBtnEnable == false)
                    {
                        this._campaignDetail.setBtnEnableAll(true);
                        this._subdualPointBar.setBtnEnable(true);
                    }
                }
            }
            return;
        }// end function

        private function phaseCampaignPointReward() : void
        {
            this.setDisableAllButton(true);
            if (this._subdualPointRewardWnd)
            {
                this._subdualPointRewardWnd.release();
            }
            var _loc_1:* = this.getQuestCampaignData(this._selectCampaignId);
            this._subdualPointRewardWnd = new SubdualPointRewardWindow(this._layer.getLayer(LayerQuestSelect.MAIN), _loc_1.subdualPoint);
            return;
        }// end function

        private function controlCampaignPointReward(param1:Number) : void
        {
            this._subdualPointRewardWnd.control(param1);
            if (this._subdualPointRewardWnd.bEnd)
            {
                this._subdualPointRewardWnd.release();
                this._subdualPointRewardWnd = null;
                this.setPhase(this._PHASE_CAMPAIGN_QUEST);
            }
            return;
        }// end function

        private function phaseCampaignPointRewardReceive() : void
        {
            var _loc_1:* = this.getQuestCampaignData(this._selectCampaignId);
            if (_loc_1.subdualPoint.bEnable && SubdualPointManager.getInstance().bAnyReward)
            {
                this._subdualPointRewardReceive = new SubdualPointRewardReceivePopup(SubdualPointManager.getInstance().bIndividualReward, SubdualPointManager.getInstance().bWholeReward);
            }
            else
            {
                this.setPhase(this._PHASE_PROVISION_NOTICE);
            }
            return;
        }// end function

        private function controlCampaignPointRewardReceive(param1:Number) : void
        {
            if (this._subdualPointRewardReceive != null)
            {
                this._subdualPointRewardReceive.control(param1);
                if (this._subdualPointRewardReceive.bEnd)
                {
                    this._subdualPointRewardReceive.release();
                    this._subdualPointRewardReceive = null;
                    this.setPhase(this._PHASE_PROVISION_NOTICE);
                }
            }
            return;
        }// end function

        private function phaseScriptCheck() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this.getQuestCampaignData(this._selectCampaignId);
            var _loc_2:* = _loc_1.getQuestCampaignDetailData(this._selectCampaignSubId);
            if (_loc_2.endTime != 0 && _loc_2.endTime < TimeClock.getNowTime())
            {
                _loc_3 = MessageManager.getInstance().getMessage(MessageId.QUEST_EVENT_SCRIPT_FINISHED_MESSAGE);
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NAVI, _loc_3, this.cbReload);
            }
            else
            {
                this.setPhase(this._PHASE_SCRIPT_LOAD);
            }
            return;
        }// end function

        private function controlScriptCheck(param1:Number) : void
        {
            return;
        }// end function

        private function phaseScriptLoad() : void
        {
            this.setDisableAllButton(true);
            if (this._selectCampaignSubId == Constant.UNDECIDED)
            {
                this.setPhase(this._PHASE_CAMPAIGN_QUEST_OPEN);
                return;
            }
            var _loc_1:* = this.getQuestCampaignData(this._selectCampaignId);
            var _loc_2:* = _loc_1.getQuestCampaignDetailData(this._selectCampaignSubId);
            ScriptManager.getInstance().loadScript(ScriptManager.SCRIPT_PATH + "Event/" + _loc_2.scriptFileName, ScriptScreen.SCREEN_QUEST_EVENT, false);
            ResourceManager.getInstance().loadResource(ScriptManager.getResourcePath());
            return;
        }// end function

        private function controlScriptLoad(param1:Number) : void
        {
            if (ScriptManager.getInstance().isLoaded() && ResourceManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_SCRIPT_EXE);
            }
            return;
        }// end function

        private function phaseScriptExe() : void
        {
            if (this._scriptMain != null)
            {
            }
            this._scriptMain = null;
            var _loc_1:* = this.getQuestCampaignData(this._selectCampaignId);
            var _loc_2:* = _loc_1.getQuestCampaignDetailData(this._selectCampaignSubId);
            var _loc_3:* = _loc_2.scriptId;
            this._scriptMain = ScriptManager.getInstance().getQuestEventScript(ScriptManager.SCRIPT_PATH + "Event/" + _loc_2.scriptFileName, _loc_3);
            SoundManager.getInstance().stopBgm();
            ScriptManager.getInstance().initScript(this._scriptMain, this._layer.getLayer(LayerQuestSelect.SCRIPT));
            ScriptManager.getInstance().commandInit(_loc_2.bRead);
            return;
        }// end function

        private function controlScriptExe(param1:Number) : void
        {
            var campaignData:QuestCampaignData;
            var detail:QuestCampaignDetailData;
            var t:* = param1;
            ScriptManager.getInstance().commandControl(t);
            if (ScriptManager.getInstance().isScriptEnd())
            {
                ScriptManager.getInstance().releaseScript();
                ScriptManager.getInstance().releaseProcess();
                campaignData = this.getQuestCampaignData(this._selectCampaignId);
                detail = campaignData.getQuestCampaignDetailData(this._selectCampaignSubId);
                if (detail && !detail.bRead)
                {
                    detail.bRead = true;
                    if (this._campaignDetail)
                    {
                        this._campaignDetail.updateNewIcon();
                    }
                    with ({})
                    {
                        {}.cbResult = function (param1:NetResult) : void
            {
                return;
            }// end function
            ;
                    }
                    NetManager.getInstance().request(new NetTaskCampaignScriptCheck(function (param1:NetResult) : void
            {
                return;
            }// end function
            , this._selectCampaignSubId));
                }
                SoundManager.getInstance().playBgm(SoundId.BGM_MYP_WORLDMAP);
                this.setPhase(this._PHASE_CAMPAIGN_QUEST_OPEN);
            }
            return;
        }// end function

        private function phasePageChange() : void
        {
            this.setDisableAllButton(true);
            var _loc_1:* = this._aQuestPage[this._nowQuestPageIdx];
            var _loc_2:* = this._aQuestPage[this._nextQuestPageIdx];
            QuestSelectManager.getInstance().savePageData(_loc_1.category, _loc_1.areaId, _loc_1.campaignId);
            this._areaId = _loc_1.areaId;
            this._selectCampaignId = _loc_1.campaignId;
            if (this._worldMap && this._worldMap.isOpen())
            {
                this._worldMap.setOut();
            }
            if (this._areaDetail)
            {
                if (this._areaDetail.isOpen())
                {
                    this._areaDetail.setOut();
                }
                this._areaDetail.setDisplayNotSelect();
            }
            if (this._campaignDetail && this._campaignDetail.bOpen)
            {
                this._campaignDetail.setOut();
            }
            if (this._subdualPointBar)
            {
                this._subdualPointBar.setOut();
            }
            if (this._areaQuestList && this._areaQuestList.bOpen)
            {
                this._areaQuestList.setOut();
            }
            if (this._areaMap && this._areaMap.bOpen)
            {
                this._areaMap.setOut();
            }
            if (this._areaName && this._areaName.isOpen())
            {
                this._areaName.setOut();
            }
            return;
        }// end function

        private function controlPageChange(param1:Number) : void
        {
            var _loc_4:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            if (this._worldMap && !this._worldMap.isClose())
            {
                return;
            }
            if (this._areaDetail && !this._areaDetail.isClose())
            {
                return;
            }
            if (this._campaignDetail && !this._campaignDetail.bClose)
            {
                return;
            }
            if (this._areaQuestList && !this._areaQuestList.bClose)
            {
                return;
            }
            if (this._areaMap && !this._areaMap.bClose)
            {
                return;
            }
            var _loc_2:* = this._PHASE_WORLD_MAP_OPEN;
            var _loc_3:* = this._aQuestPage[this._nowQuestPageIdx];
            var _loc_5:* = this._nowQuestPageIdx;
            if (++this._nowQuestPageIdx >= this._aQuestPage.length)
            {
                ++this._nowQuestPageIdx = 0;
            }
            _loc_4 = this._aQuestPage[++this._nowQuestPageIdx];
            switch(_loc_3.category)
            {
                case QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN:
                {
                    _loc_2 = this._PHASE_CAMPAIGN_QUEST_RESOURCE;
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE:
                {
                    _loc_2 = this._PHASE_BATTLE_QUEST_RESOURCE;
                    break;
                }
                default:
                {
                    _loc_2 = this._PHASE_WORLD_MAP_OPEN;
                    break;
                    break;
                }
            }
            var _loc_6:* = false;
            var _loc_7:* = "";
            switch(_loc_4.category)
            {
                case QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN:
                {
                    _loc_8 = this.getQuestCampaignData(_loc_4.campaignId);
                    _loc_9 = _loc_8.getQuestCampaignDetailNoReadNum() + _loc_8.getQuestCampaignQuestNoReadNum();
                    _loc_6 = _loc_9 > 0;
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE:
                case QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN:
                {
                    _loc_10 = 0;
                    for each (_loc_11 in this._aAreaQuest[_loc_4.areaId] as Array)
                    {
                        
                        if (_loc_11 && AreaQuest(_loc_11).bNewQuest)
                        {
                            _loc_10++;
                        }
                    }
                    _loc_6 = _loc_10 > 0;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._mcMain.newMc.visible = _loc_6;
            this._bNewBattleQuest = _loc_6;
            this.setVisibleBattleQuestButton(true);
            this.setDisableBattleQuestButton(true);
            this.setPhase(_loc_2);
            return;
        }// end function

        private function phaseGotoProcess() : void
        {
            this.setAllOut();
            this._areaQuestDetail.gotoQuest();
            this._btnReturn.setDisable(true);
            this.setDisableBattleQuestButton(true);
            TutorialManager.getInstance().hideTutorial();
            return;
        }// end function

        private function controlGotoProcess() : void
        {
            var _loc_1:* = 0;
            if (this.isAllClose())
            {
                _loc_1 = ProcessMain.PROCESS_HOME;
                if (this._areaQuestDetail.bGotoFormation)
                {
                    _loc_1 = ProcessMain.PROCESS_COMMAND_POST;
                }
                if (this._areaQuestDetail.bGotoTrading)
                {
                    _loc_1 = ProcessMain.PROCESS_TRADING_POST;
                }
                if (this._areaQuestDetail.bGotoQuest)
                {
                    Main.GetProcess().createLoadingScreen();
                    _loc_1 = ProcessMain.PROCESS_QUEST;
                }
                Main.GetProcess().SetProcessId(_loc_1);
                this.setPhase(this._PHASE_NONE);
            }
            return;
        }// end function

        private function phaseWorldEnd() : void
        {
            this._btnReturn.setDisable(true);
            this.setDisableBattleQuestButton(true);
            this.setAllOut();
            return;
        }// end function

        private function controlWorldEnd() : void
        {
            if (this.isAllClose())
            {
                Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
            }
            return;
        }// end function

        private function phaseReload() : void
        {
            this.setAllOut();
            this._areaQuestDetail.gotoQuest();
            this._btnReturn.setDisable(true);
            this.setDisableBattleQuestButton(true);
            return;
        }// end function

        private function controlReload() : void
        {
            if (this.isAllClose())
            {
                this.setPhase(this._PHASE_NONE);
                this.release();
                this.init();
            }
            return;
        }// end function

        private function cbQuestDetailBack() : void
        {
            this._bDetailDisable = true;
            this._areaMap.setButtonEnable(false);
            this._areaMap.resetSelectIcon();
            this._selectQuestId = Constant.UNDECIDED;
            this.setPhase(this._PHASE_QUEST_DETAIL_RETURN);
            return;
        }// end function

        private function cbReload() : void
        {
            this.setPhase(this._PHASE_RELOAD);
            return;
        }// end function

        private function cbRewardBtn() : void
        {
            this.setPhase(this._PHASE_CAMPAIGN_POINT_REWARD);
            return;
        }// end function

        private function setVisibleBattleQuestButton(param1:Boolean) : void
        {
            var _loc_2:* = param1;
            if (this._aQuestPage.length > 1)
            {
                _loc_2 = param1;
            }
            else
            {
                _loc_2 = false;
            }
            var _loc_3:* = this._aQuestPage[this._nextQuestPageIdx];
            switch(_loc_3.category)
            {
                case QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN:
                {
                    this.setVisibleQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN, false);
                    this.setVisibleQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE, false);
                    this.setVisibleQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN, _loc_2);
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE:
                {
                    this.setVisibleQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN, false);
                    this.setVisibleQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE, _loc_2);
                    this.setVisibleQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN, false);
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN:
                {
                    this.setVisibleQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN, _loc_2);
                    this.setVisibleQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE, false);
                    this.setVisibleQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN, false);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2)
            {
                this._mcMain.newMc.visible = this._bNewBattleQuest;
            }
            else
            {
                this._mcMain.newMc.visible = false;
            }
            return;
        }// end function

        private function setDisableBattleQuestButton(param1:Boolean) : void
        {
            var _loc_2:* = param1;
            if (TutorialManager.getInstance().isTutorial())
            {
                _loc_2 = true;
            }
            else
            {
                _loc_2 = param1;
            }
            var _loc_3:* = this._aQuestPage[this._nextQuestPageIdx];
            switch(_loc_3.category)
            {
                case QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN:
                {
                    this.setDisableQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN, true);
                    this.setDisableQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE, true);
                    this.setDisableQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN, _loc_2);
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE:
                {
                    this.setDisableQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN, true);
                    this.setDisableQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE, _loc_2);
                    this.setDisableQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN, true);
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN:
                {
                    this.setDisableQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN, _loc_2);
                    this.setDisableQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE, true);
                    this.setDisableQuestPageButton(QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN, true);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getEnableBattleQuestButton() : Boolean
        {
            var _loc_1:* = false;
            var _loc_2:* = this._aQuestPage[this._nextQuestPageIdx];
            switch(_loc_2.category)
            {
                case QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN:
                {
                    if (this._btnCampaignQuest)
                    {
                        _loc_1 = this._btnCampaignQuest.isEnable();
                    }
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE:
                {
                    if (this._btnBattleQuest)
                    {
                        _loc_1 = this._btnBattleQuest.isEnable();
                    }
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN:
                {
                    if (this._btnMainQuest)
                    {
                        _loc_1 = this._btnMainQuest.isEnable();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        private function setVisibleQuestPageButton(param1:int, param2:Boolean) : void
        {
            switch(param1)
            {
                case QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN:
                {
                    if (this._btnCampaignQuest)
                    {
                        this._btnCampaignQuest.setVisible(param2);
                    }
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE:
                {
                    if (this._btnBattleQuest)
                    {
                        this._btnBattleQuest.setVisible(param2);
                    }
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN:
                {
                    if (this._btnMainQuest)
                    {
                        this._btnMainQuest.setVisible(param2);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setDisableQuestPageButton(param1:int, param2:Boolean) : void
        {
            switch(param1)
            {
                case QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN:
                {
                    if (this._btnCampaignQuest)
                    {
                        if (param2 == false && this._btnCampaignQuest.getMoveClip().visible == false)
                        {
                            param2 = true;
                        }
                        this._btnCampaignQuest.setDisable(param2);
                    }
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE:
                {
                    if (this._btnBattleQuest)
                    {
                        if (param2 == false && this._btnBattleQuest.getMoveClip().visible == false)
                        {
                            param2 = true;
                        }
                        this._btnBattleQuest.setDisable(param2);
                    }
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN:
                {
                    if (this._btnMainQuest)
                    {
                        if (param2 == false && this._btnMainQuest.getMoveClip().visible == false)
                        {
                            param2 = true;
                        }
                        this._btnMainQuest.setDisable(param2);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setDisableAllButton(param1:Boolean) : void
        {
            this._btnReturn.setDisable(param1);
            this.setDisableBattleQuestButton(param1);
            if (this._areaMap)
            {
                this._areaMap.setButtonEnable(!param1);
            }
            if (this._areaQuestList)
            {
                this._areaQuestList.setLineEnabe(!param1);
            }
            if (this._campaignDetail)
            {
                this._campaignDetail.setBtnEnableAll(!param1);
            }
            if (this._subdualPointBar)
            {
                this._subdualPointBar.setBtnEnable(!param1);
            }
            if (this._areaQuestDetail)
            {
                this._areaQuestDetail.setDisableFlag(param1);
            }
            return;
        }// end function

        private function cbReturnButton(param1:int) : void
        {
            var _loc_2:* = Constant.UNDECIDED;
            switch(this._phase)
            {
                case this._PHASE_WORLDMAP:
                {
                    _loc_2 = this._PHASE_WORLD_END;
                    break;
                }
                case this._PHASE_AREAMAP:
                {
                    _loc_2 = this._PHASE_AREAMAP_RETURN;
                    break;
                }
                case this._PHASE_QUEST_LIST:
                {
                    _loc_2 = this._PHASE_AREAMAP_RETURN;
                    break;
                }
                case this._PHASE_QUEST_DETAIL:
                {
                    break;
                }
                case this._PHASE_BATTLE_QUEST:
                {
                    _loc_2 = this._PHASE_WORLD_END;
                    break;
                }
                case this._PHASE_CAMPAIGN_QUEST:
                {
                    _loc_2 = this._PHASE_WORLD_END;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2 != Constant.UNDECIDED)
            {
                this.setPhase(_loc_2);
            }
            return;
        }// end function

        private function cbBattleQuest(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this.setDisableAllButton(true);
            var _loc_2:* = this._aQuestPage[this._nowQuestPageIdx];
            _loc_3 = this._aQuestPage[this._nextQuestPageIdx];
            var _loc_4:* = false;
            switch(_loc_3.category)
            {
                case QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN:
                {
                    _loc_5 = this.getQuestCampaignData(_loc_3.campaignId);
                    if (_loc_5.endTime != 0 && _loc_5.endTime < TimeClock.getNowTime())
                    {
                        _loc_4 = true;
                    }
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE:
                {
                    break;
                }
                case QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_4)
            {
                _loc_6 = MessageManager.getInstance().getMessage(MessageId.QUEST_EVENT_QUEST_FINISHED_MESSAGE);
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NAVI, _loc_6, this.cbReload);
            }
            else
            {
                var _loc_7:* = this;
                var _loc_8:* = this._nowQuestPageIdx + 1;
                _loc_7._nowQuestPageIdx = _loc_8;
                if (this._nowQuestPageIdx >= this._aQuestPage.length)
                {
                    this._nowQuestPageIdx = 0;
                }
                this.setPhase(this._PHASE_PAGE_CHANGE);
            }
            return;
        }// end function

        private function cbQuestScript(param1:int) : void
        {
            this.playScript(param1);
            return;
        }// end function

        private function playScript(param1:int) : void
        {
            this._selectCampaignSubId = param1;
            this.setPhase(this._PHASE_SCRIPT_CHECK);
            return;
        }// end function

        private function setQuestPage(param1:int) : void
        {
            this._nowQuestPageIdx = param1;
            this.setPhase(this._PHASE_PAGE_CHANGE);
            return;
        }// end function

        private function createQuestPageList() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            this._nowQuestPageIdx = 0;
            this._aQuestPage = [];
            _loc_2 = new QuestSelectCategoryPageData();
            _loc_2.setData(QuestSelectCategoryPageData.CATEGORY_QUEST_MAIN, 0, Constant.UNDECIDED);
            this._aQuestPage.push(_loc_2);
            if (this._battleQuestNum > 0)
            {
                _loc_2 = new QuestSelectCategoryPageData();
                _loc_2.setData(QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE, QuestConstant.BATTLE_QUEST_AREA_ID, Constant.UNDECIDED);
                this._aQuestPage.push(_loc_2);
            }
            for each (_loc_1 in this._aQuestEvent)
            {
                
                _loc_2 = new QuestSelectCategoryPageData();
                _loc_2.setData(QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN, Constant.UNDECIDED, _loc_1.campaignId);
                this._aQuestPage.push(_loc_2);
            }
            _loc_3 = QuestSelectManager.getInstance().getPageData();
            if (_loc_3)
            {
                _loc_4 = 0;
                while (_loc_4 < this._aQuestPage.length)
                {
                    
                    _loc_2 = this._aQuestPage[_loc_4];
                    if (QuestSelectCategoryPageData.isMatchData(_loc_3, _loc_2))
                    {
                        this._nowQuestPageIdx = _loc_4;
                    }
                    _loc_4++;
                }
            }
            return;
        }// end function

        private function getQuestCampaignData(param1:int) : QuestCampaignData
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aQuestEvent)
            {
                
                if (_loc_2.campaignId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        private function getSelectQuest() : AreaQuest
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_2 = QuestSelectManager.getInstance().getPageData();
            if (_loc_2)
            {
                switch(_loc_2.category)
                {
                    case QuestSelectCategoryPageData.CATEGORY_QUEST_CAMPATIN:
                    {
                        _loc_3 = this.getQuestCampaignData(_loc_2.campaignId);
                        if (_loc_3 && _loc_3.areaInfo)
                        {
                            for each (_loc_1 in _loc_3.areaInfo.aQuest)
                            {
                                
                                if (_loc_1.no == this._selectQuestId)
                                {
                                    return _loc_1;
                                }
                            }
                        }
                        break;
                    }
                    case QuestSelectCategoryPageData.CATEGORY_QUEST_BATTLE:
                    {
                    }
                    default:
                    {
                        for each (_loc_1 in this._aAreaQuest[this._areaId])
                        {
                            
                            if (_loc_1.no == this._selectQuestId)
                            {
                                return _loc_1;
                            }
                        }
                        break;
                        break;
                    }
                }
            }
            return null;
        }// end function

        private function setAllOut() : void
        {
            if (this._worldMap && this._worldMap.isOpen())
            {
                this._worldMap.setOut();
            }
            if (this._areaDetail)
            {
                if (this._areaDetail.isOpen())
                {
                    this._areaDetail.setOut();
                }
                this._areaDetail.setDisplayNotSelect();
            }
            if (this._campaignDetail && this._campaignDetail.bOpen)
            {
                this._campaignDetail.setOut();
            }
            if (this._subdualPointBar)
            {
                this._subdualPointBar.setOut();
            }
            if (this._areaQuestList && this._areaQuestList.bOpen)
            {
                this._areaQuestList.setOut();
            }
            if (this._areaMap && this._areaMap.bOpen)
            {
                this._areaMap.setOut();
            }
            if (this._areaName && this._areaName.isOpen())
            {
                this._areaName.setOut();
            }
            return;
        }// end function

        private function isAllClose() : Boolean
        {
            if (this._worldMap && !this._worldMap.isClose())
            {
                return false;
            }
            if (this._areaDetail && !this._areaDetail.isClose())
            {
                return false;
            }
            if (this._campaignDetail && !this._campaignDetail.bClose)
            {
                return false;
            }
            if (this._areaQuestList && !this._areaQuestList.bClose)
            {
                return false;
            }
            if (this._areaMap && !this._areaMap.bClose)
            {
                return false;
            }
            return true;
        }// end function

        private function commonBtnCtrlQuestList() : void
        {
            if (this._areaQuestList.bOpen)
            {
                if (this._areaQuestList.bSortWindowOpen)
                {
                    if (this._areaQuestList.bBtnEnable == true)
                    {
                        this._areaQuestList.setLineEnabe(false);
                    }
                }
                else if (this._areaQuestList.bBtnEnable == false)
                {
                    this._areaQuestList.setLineEnabe(true);
                }
                if (this._areaMap && this._areaMap.bOpen)
                {
                    if (this._areaMap.bBtnEnable == false)
                    {
                        this._areaMap.setButtonEnable(true);
                    }
                }
                if (this._areaQuestDetail && this._areaQuestDetail.bOpen)
                {
                    if (this.getEnableBattleQuestButton() == true)
                    {
                        this.setDisableBattleQuestButton(true);
                    }
                    if (this._btnReturn.isEnable() == true)
                    {
                        this._btnReturn.setDisable(true);
                    }
                    this._areaQuestDetail.setDisableFlag(false);
                }
                else
                {
                    if (this.getEnableBattleQuestButton() == false)
                    {
                        this.setDisableBattleQuestButton(false);
                    }
                    if (this._btnReturn.isEnable() == false)
                    {
                        this._btnReturn.setDisable(false);
                    }
                }
            }
            return;
        }// end function

    }
}
