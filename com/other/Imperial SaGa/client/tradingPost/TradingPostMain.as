package tradingPost
{
    import asset.*;
    import button.*;
    import crownHistory.*;
    import flash.display.*;
    import flash.geom.*;
    import item.*;
    import layer.*;
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

    public class TradingPostMain extends Object
    {
        private var _phase:int;
        private var _parent:DisplayObjectContainer;
        private var _layer:LayerTradingPost;
        private var _mcBase:MovieClip;
        private var _mcHeader:MovieClip;
        private var _mcMain:MovieClip;
        private var _mcBalloon:MovieClip;
        private var _bmNavi:Bitmap;
        private var _isoMain:InStayOut;
        private var _isoHeader:InStayOut;
        private var _isoBalloon:InStayOut;
        private var _insigniaBox:TradingPostInsigniaBox;
        private var _simpleStatus:PlayerSimpleStatus;
        private var _equipStatus:EquipSimpleStatus;
        private var _btnClose:ButtonBase;
        private var _aTabId:Array;
        private var _aTabBtn:Array;
        private var _page:PageButton;
        private var _aBtnItem:Array;
        private var _aPlanDisplay:Array;
        private var _crownHistory:CrownHistoryWindow;
        private var _bTradingInfoLoaded:Boolean;
        private var _tradingPostData:TradingPostData;
        private var _aPlanData:Array;
        private var _purchasedPlan:PaymentPlanData;
        private var _mouseOverPlanIndex:int;
        private var _selectedPlanIndex:int;
        private var _bBtnEnable:Boolean;
        private var _tabType:int;
        private var _bReOpen:Boolean;
        private static const NAVI_PLAYER_ID:int = 30164;
        private static const _ITEM_PAGE_NUM:int = 8;
        private static const _TAB_NUM:int = 3;
        private static const _PHASE_LOADING:int = 0;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_MAIN:int = 2;
        private static const _PHASE_CROWN_HISTORY:int = 3;
        private static const _PHASE_POPUP:int = 4;
        private static const _PHASE_CONNECTING:int = 5;
        private static const _PHASE_CLOSE:int = 6;
        private static const _PHASE_RE_OPEN:int = 7;
        private static const _PHASE_CROWN_UPDATE:int = 10;
        private static const _PHASE_MAINTENANCE:int = 90;
        private static const _PHASE_CONNECT_ERROR:int = 99;
        private static const LABEL_TAB_IDX_0:String = "tab1";
        private static const LABEL_TAB_IDX_1:String = "tab2";
        private static const LABEL_TAB_IDX_2:String = "tab3";

        public function TradingPostMain(param1:DisplayObjectContainer)
        {
            this._parent = param1;
            this._layer = new LayerTradingPost();
            this._parent.addChild(this._layer);
            this._bTradingInfoLoaded = false;
            NetManager.getInstance().request(new NetTaskTrading(this.cbConnectTrading));
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._bReOpen == false && this._phase == _PHASE_CONNECT_ERROR || this._phase == _PHASE_CLOSE && (this._isoMain && this._isoMain.bClosed) && (this._isoHeader && this._isoHeader.bClosed) && (this._insigniaBox && this._insigniaBox.bClosed);
        }// end function

        public function get bStay() : Boolean
        {
            return this._phase != _PHASE_OPEN && this._phase != _PHASE_CLOSE && (this._isoMain && this._isoMain.bAnimetion == false) && (this._isoHeader && this._isoHeader.bAnimetion == false) && (this._insigniaBox && this._insigniaBox.bAnimetion == false);
        }// end function

        private function cbConnectTrading(param1:NetResult) : void
        {
            var res:* = param1;
            if (res.resultCode != NetId.RESULT_OK)
            {
                TradingPostPopupUtility.openAlertPopup(this._layer.getLayer(LayerTradingPost.POPUP), MessageManager.getInstance().getMessage(MessageId.CONNECT_ERROR_BACK_HOME), function () : void
            {
                setPhase(_PHASE_CLOSE);
                return;
            }// end function
            );
                return;
            }
            this._tradingPostData = new TradingPostData();
            this._tradingPostData.setRecieve(res.data);
            this._tradingPostData.loadResource();
            ResourceManager.getInstance().loadResource(ResourcePath.TRADINGPOST_PATH + "UI_Trade.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            CommonPopup.getInstance().loadResource([CommonPopup.POPUP_TYPE_NAVI, CommonPopup.POPUP_TYPE_NAVI_FULBRIGHT]);
            ResourceManager.getInstance().loadResource(ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_GOLD_INSIGNIA));
            ResourceManager.getInstance().loadResource(ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_SILVER_INSIGNIA));
            SoundManager.getInstance().loadSound(SoundId.BGM_INS_TRADE);
            SoundManager.getInstance().loadSoundArray([SoundId.SE_SELECT_WINDOW]);
            this._bTradingInfoLoaded = true;
            this._phase = _PHASE_LOADING;
            return;
        }// end function

        private function resourceLoaded() : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            if (!this._bTradingInfoLoaded)
            {
                return;
            }
            if (ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false)
            {
                return;
            }
            var _loc_1:* = ResourcePath.TRADINGPOST_PATH + "UI_Trade.swf";
            this._mcBase = ResourceManager.getInstance().createMovieClip(_loc_1, "TradeMainMc");
            this._layer.getLayer(LayerTradingPost.MAIN).addChild(this._mcBase);
            this._mcMain = this._mcBase.tradeItemMc;
            this._mcHeader = this._mcBase.tradeTitleMc;
            this._mcBalloon = this._mcMain.charaBalloonMc;
            this._isoMain = new InStayOut(this._mcMain);
            this._isoHeader = new InStayOut(this._mcHeader);
            this._isoBalloon = new InStayOut(this._mcBalloon);
            this._insigniaBox = new TradingPostInsigniaBox(this._layer.getLayer(LayerTradingPost.INSIGNIA));
            this._simpleStatus = new PlayerSimpleStatus(this._layer.getLayer(LayerTradingPost.STATUS), PlayerSimpleStatus.LABEL_MAIN);
            this._simpleStatus.setMouseEventEnable(false);
            this._simpleStatus.hide();
            this._equipStatus = new EquipSimpleStatus(this._layer.getLayer(LayerTradingPost.STATUS));
            this._equipStatus.setMouseEventEnable(false);
            this._equipStatus.hide();
            this._btnClose = ButtonManager.getInstance().addButton(this._mcMain.returnBtnMc, this.cbCloseButton);
            this._btnClose.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcMain.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._aTabId = [];
            if (this._tradingPostData.checkTabItemStock(PaymentPlanData.TAB_SPECIAL))
            {
                this._aTabId = [PaymentPlanData.TAB_SPECIAL, PaymentPlanData.TAB_NORMAL, PaymentPlanData.TAB_INSIGNIA];
            }
            else
            {
                this._aTabId = [PaymentPlanData.TAB_NORMAL, PaymentPlanData.TAB_INSIGNIA, PaymentPlanData.TAB_SPECIAL];
            }
            this._tabType = Main.GetProcess().prevProcessId == ProcessMain.PROCESS_RETIRE ? (PaymentPlanData.TAB_INSIGNIA) : (this._aTabId[0]);
            this._aTabBtn = [];
            var _loc_2:* = 0;
            while (_loc_2 < _TAB_NUM)
            {
                
                _loc_6 = this._mcMain.itemListMc.tabSetMc["tabBtnOff" + (_loc_2 + 1) + "Mc"];
                _loc_6.visible = true;
                if (this._tradingPostData.checkTabItemList(this._aTabId[_loc_2]) == false)
                {
                    _loc_6.visible = false;
                }
                else
                {
                    _loc_7 = ButtonManager.getInstance().addButton(_loc_6, this.cbChangeTab, this._aTabId[_loc_2]);
                    _loc_7.enterSeId = SoundId.SE_SELECT_WINDOW;
                    this._aTabBtn.push(_loc_7);
                }
                _loc_2++;
            }
            this.setTabLabel(this._tabType);
            this._page = new PageButton(this._mcMain.itemListMc, this.cbChangePage, 0, this._tradingPostData.getTabPageMax(this._tabType));
            this._aBtnItem = [];
            this._aPlanDisplay = [];
            var _loc_3:* = 0;
            while (_loc_3 < _ITEM_PAGE_NUM)
            {
                
                _loc_8 = this._mcMain.itemListMc["item" + (_loc_3 + 1)];
                _loc_9 = this._mcMain.itemListMc["remainingSetMc" + String((_loc_3 + 1))];
                _loc_10 = this._mcMain.itemListMc["remainingPeriodMc" + String((_loc_3 + 1))];
                _loc_11 = new TradingPostItemBtn(_loc_8, this.cbClickItemBtn, this.cbMouseOverItemBtn, this.cbMouseOutItemBtn);
                _loc_11.setId(_loc_3);
                ButtonManager.getInstance().addButtonBase(_loc_11);
                this._aBtnItem.push(_loc_11);
                _loc_12 = new TradingPostPlanDisplay(_loc_8, _loc_9, _loc_10);
                this._aPlanDisplay.push(_loc_12);
                _loc_3++;
            }
            (this._mcMain.bigCharacterNull as MovieClip).removeChildren();
            var _loc_4:* = ResourceManager.getInstance().createBitmap(ResourcePath.COMMON_DATA_PATH + "NaviCharaGra/chr_fulbright.png");
            if (ResourceManager.getInstance().createBitmap(ResourcePath.COMMON_DATA_PATH + "NaviCharaGra/chr_fulbright.png"))
            {
                _loc_4.smoothing = true;
                _loc_4.x = -_loc_4.width / 2;
                _loc_4.y = -_loc_4.height;
                (this._mcMain.bigCharacterNull as MovieClip).addChild(_loc_4);
            }
            if (SoundManager.getInstance().bgmId != SoundId.BGM_INS_TRADE)
            {
                SoundManager.getInstance().playBgm(SoundId.BGM_INS_TRADE);
            }
            this.setTabText(this._mcMain.itemListMc.tabSetMc.tabBtnOff1Mc, this._mcMain.itemListMc.tabSetMc.tabBtnOn1Mc, this._aTabId[0]);
            this.setTabText(this._mcMain.itemListMc.tabSetMc.tabBtnOff2Mc, this._mcMain.itemListMc.tabSetMc.tabBtnOn2Mc, this._aTabId[1]);
            this.setTabText(this._mcMain.itemListMc.tabSetMc.tabBtnOff3Mc, this._mcMain.itemListMc.tabSetMc.tabBtnOn3Mc, this._aTabId[2]);
            var _loc_5:* = TradingPostStartPageRequest.getInstance();
            if (TradingPostStartPageRequest.getInstance().bPageRequest)
            {
                _loc_13 = this._tradingPostData.searchTab(_loc_5.category, _loc_5.itemId);
                if (this._tabType == _loc_13)
                {
                    this.updatePaymentPlanDisplay();
                }
                else
                {
                    this.cbChangeTab(_loc_13);
                }
                _loc_14 = this.searchPageIndex(_loc_13, _loc_5.category, _loc_5.itemId);
                if (_loc_14 >= 0)
                {
                    if (this._page.pageIndex != _loc_14)
                    {
                        this._page.setPage(_loc_14, this._page.pageMax);
                        this.cbChangePage(_loc_14, PageButton.PAGE_BUTTON_ID_NONE);
                    }
                }
            }
            _loc_5.clear();
            this._crownHistory = null;
            this._mouseOverPlanIndex = -1;
            this._selectedPlanIndex = -1;
            this._bBtnEnable = false;
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_1 in this._aPlanDisplay)
            {
                
                _loc_1.release();
            }
            this._aPlanDisplay = null;
            if (this._crownHistory)
            {
                this._crownHistory.release();
            }
            this._crownHistory = null;
            for each (_loc_2 in this._aBtnItem)
            {
                
                ButtonManager.getInstance().removeButton(_loc_2);
            }
            this._aBtnItem = null;
            if (this._page)
            {
                this._page.release();
            }
            this._page = null;
            for each (_loc_3 in this._aTabBtn)
            {
                
                ButtonManager.getInstance().removeButton(_loc_3);
            }
            this._aTabBtn = null;
            ButtonManager.getInstance().removeButton(this._btnClose);
            this._btnClose = null;
            if (this._equipStatus)
            {
                this._equipStatus.release();
            }
            this._equipStatus = null;
            if (this._simpleStatus)
            {
                this._simpleStatus.release();
            }
            this._simpleStatus = null;
            if (this._insigniaBox)
            {
                this._insigniaBox.release();
            }
            this._insigniaBox = null;
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
            if (this._isoBalloon)
            {
                this._isoBalloon.release();
            }
            this._isoBalloon = null;
            this._mcHeader = null;
            this._mcMain = null;
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
                case _PHASE_CROWN_HISTORY:
                {
                    this.initPhaseCrownHistory();
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
                case _PHASE_RE_OPEN:
                {
                    this.initPhaseReOpen();
                    break;
                }
                case _PHASE_CROWN_UPDATE:
                {
                    this.initPhaseCrownUpdate();
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
                case _PHASE_MAIN:
                {
                    this.controlPhaseMain(param1);
                    break;
                }
                case _PHASE_CROWN_HISTORY:
                {
                    this.controlPhaseCrownHistory(param1);
                    break;
                }
                case _PHASE_MAINTENANCE:
                {
                    this.controlPhaseMaintenance();
                    break;
                }
                case _PHASE_RE_OPEN:
                {
                    this.controlPhaseReOpen();
                    break;
                }
                case _PHASE_CROWN_UPDATE:
                {
                    this.controlPhaseCrownUpdate(param1);
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
            this.btnEnable(false);
            this._bReOpen = false;
            this.updatePaymentPlanDisplay();
            this.pageChange();
            this.updateItemList();
            this.updateItemListBtn();
            this.updateInsigniaBox();
            this._isoMain.setIn(function () : void
            {
                openBalloon(MessageManager.getInstance().getMessage(MessageId.TRADINGPOST_NAVI_MESSAGE_01));
                setPhase(_PHASE_MAINTENANCE);
                return;
            }// end function
            );
            this._isoHeader.setIn();
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

        private function initPhaseMain() : void
        {
            this.btnEnable(true);
            this._mouseOverPlanIndex = -1;
            this._selectedPlanIndex = -1;
            this.openBalloon(MessageManager.getInstance().getMessage(MessageId.TRADINGPOST_NAVI_MESSAGE_01));
            this.updatePaymentPlanDisplay();
            this.updateItemListBtn();
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRADING_POST))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_TRADING_POST);
            }
            return;
        }// end function

        private function controlPhaseMain(param1:Number) : void
        {
            return;
        }// end function

        private function initPhaseCrownHistory() : void
        {
            this.btnEnable(false);
            this.closeBalloon();
            this._isoMain.setOut();
            this._isoHeader.setOut();
            this._insigniaBox.setOut();
            if (this._crownHistory == null)
            {
                this._crownHistory = new CrownHistoryWindow(this._mcBase);
            }
            else
            {
                this._crownHistory.reset();
            }
            return;
        }// end function

        private function controlPhaseCrownHistory(param1:Number) : void
        {
            if (this._crownHistory)
            {
                this._crownHistory.control(param1);
                if (this._crownHistory.bLoaded)
                {
                    if (this._crownHistory.bOpenWait && this._isoMain.bClosed && this._isoHeader.bClosed && this._insigniaBox.bClosed)
                    {
                        this._crownHistory.open();
                    }
                    if (this._crownHistory.bClose)
                    {
                        this.setPhase(_PHASE_OPEN);
                    }
                }
            }
            return;
        }// end function

        private function initPhasePopup() : void
        {
            this.btnEnable(false);
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this.btnEnable(false);
            this.closeBalloon();
            this._isoMain.setOut();
            this._isoHeader.setOut();
            this._insigniaBox.setOut();
            return;
        }// end function

        private function initPhaseReOpen() : void
        {
            this._bReOpen = true;
            this._bTradingInfoLoaded = false;
            this.btnEnable(false);
            this.closeBalloon();
            this._isoMain.setOut();
            this._isoHeader.setOut();
            this._insigniaBox.setOut();
            return;
        }// end function

        private function controlPhaseReOpen() : void
        {
            if (this._isoMain && this._isoMain.bClosed && (this._isoHeader && this._isoHeader.bClosed) && (this._insigniaBox && this._insigniaBox.bClosed))
            {
                this._phase = _PHASE_LOADING;
                NetManager.getInstance().request(new NetTaskTrading(this.cbConnectTrading));
            }
            return;
        }// end function

        private function initPhaseCrownUpdate() : void
        {
            Main.GetProcess().createCrownUpdateWindow();
            return;
        }// end function

        private function controlPhaseCrownUpdate(param1:Number) : void
        {
            if (Main.GetProcess().isCrownUpdateing() == false)
            {
                this.cbClosePopup();
            }
            return;
        }// end function

        private function btnEnable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            this._bBtnEnable = param1;
            this._insigniaBox.setMouseOverEnable(this._bBtnEnable);
            this._btnClose.setDisableFlag(!this._bBtnEnable);
            this._page.btnEnable(this._bBtnEnable);
            if (this._bBtnEnable)
            {
                this.updatePaymentPlanDisplay();
                this.updateItemListBtn();
            }
            else
            {
                for each (_loc_2 in this._aBtnItem)
                {
                    
                    _loc_2.setDisableFlag(!this._bBtnEnable);
                }
                if (this._simpleStatus.isShow())
                {
                    this._simpleStatus.hide();
                }
                if (this._equipStatus.isShow())
                {
                    this._equipStatus.hide();
                }
            }
            return;
        }// end function

        private function openBalloon(param1:String) : void
        {
            var text:* = param1;
            if (this._isoBalloon.bOpened)
            {
                this._isoBalloon.setOut(function () : void
            {
                TextControl.setText(_mcBalloon.balloonMc.textMc.textDt, text);
                _isoBalloon.setIn();
                return;
            }// end function
            );
            }
            else
            {
                TextControl.setText(this._mcBalloon.balloonMc.textMc.textDt, text);
                this._isoBalloon.setIn();
            }
            return;
        }// end function

        private function closeBalloon() : void
        {
            if (!this._isoBalloon.bClosed)
            {
                this._isoBalloon.setOut();
            }
            return;
        }// end function

        private function updateItemList() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < _ITEM_PAGE_NUM)
            {
                
                _loc_1 = this._aBtnItem[_loc_3];
                _loc_1.setDisable(true);
                _loc_2 = this._aPlanDisplay[_loc_3];
                _loc_2.clear();
                _loc_3++;
            }
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < this._aPlanData.length)
            {
                
                _loc_6 = this._page.pageIndex * _ITEM_PAGE_NUM + _loc_5;
                _loc_7 = this._aPlanData[_loc_5] as PaymentPlanData;
                if (_loc_7 == null)
                {
                }
                else
                {
                    _loc_8 = _loc_7.calcPosIndex();
                    if (_loc_8 < _ITEM_PAGE_NUM)
                    {
                        _loc_1 = this._aBtnItem[_loc_8];
                        _loc_2 = this._aPlanDisplay[_loc_8];
                        if (_loc_7.checkEnable() && _loc_7.page == (this._page.pageIndex + 1))
                        {
                            _loc_2.setPlanData(_loc_7);
                            _loc_1.setDisable(!this._bBtnEnable);
                            _loc_4++;
                        }
                    }
                }
                _loc_5++;
            }
            return;
        }// end function

        private function updateItemListBtn() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < _ITEM_PAGE_NUM)
            {
                
                _loc_3 = this._page.pageIndex * _ITEM_PAGE_NUM + _loc_1;
                _loc_4 = this._aBtnItem[_loc_1];
                _loc_4.setDisable(true);
                _loc_1++;
            }
            for each (_loc_2 in this._aPlanData)
            {
                
                _loc_5 = _loc_2.calcPosIndex();
                _loc_6 = this._aBtnItem[_loc_5];
                if (_loc_2.page == (this._page.pageIndex + 1) && (_loc_2.stock == Constant.UNDECIDED || _loc_2.stock > 0))
                {
                    _loc_6.setDisable(!this._bBtnEnable);
                }
            }
            return;
        }// end function

        private function updatePaymentPlanDisplay() : void
        {
            this._aPlanData = this._tradingPostData.getTabItemList(this._tabType).concat();
            this._aPlanData = this._aPlanData.sortOn(["page", "line", "row"], [Array.NUMERIC | Array.NUMERIC | Array.NUMERIC]);
            return;
        }// end function

        private function updateInsigniaBox() : void
        {
            this._insigniaBox.updateNum();
            if (this._tabType == PaymentPlanData.TAB_INSIGNIA)
            {
                this._insigniaBox.setIn();
            }
            else
            {
                this._insigniaBox.setOut();
            }
            return;
        }// end function

        private function showMouseOverPlayerStatus(param1:PaymentPlanData, param2:int) : Boolean
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this._bBtnEnable)
            {
                _loc_3 = param1.calcPosIndex();
                _loc_4 = this._aPlanDisplay[_loc_3];
                if (_loc_4)
                {
                    _loc_5 = PlayerSimpleStatus.calcPos(this._layer.getLayer(LayerTradingPost.STATUS), _loc_4.balloonAmbitNull);
                    _loc_6 = PlayerSimpleStatus.calcPos(this._layer.getLayer(LayerTradingPost.STATUS), _loc_4.balloonNull);
                    this._simpleStatus.show();
                    this._simpleStatus.setStatusByPlayerId(param2);
                    this._simpleStatus.setPosition(_loc_5);
                    this._simpleStatus.setArrowTargetPosition(_loc_6);
                    return true;
                }
            }
            return false;
        }// end function

        private function showMouseOverEquipStatus(param1:PaymentPlanData, param2:int) : Boolean
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this._bBtnEnable)
            {
                _loc_3 = param1.calcPosIndex();
                _loc_4 = this._aPlanDisplay[_loc_3];
                if (_loc_4)
                {
                    _loc_5 = PlayerSimpleStatus.calcPos(this._layer.getLayer(LayerTradingPost.STATUS), _loc_4.balloonAmbitNull);
                    _loc_6 = PlayerSimpleStatus.calcPos(this._layer.getLayer(LayerTradingPost.STATUS), _loc_4.balloonNull);
                    this._equipStatus.show();
                    this._equipStatus.setItemData(param2);
                    this._equipStatus.setPosition(_loc_5);
                    this._equipStatus.setArrowTargetPosition(_loc_6);
                    return true;
                }
            }
            return false;
        }// end function

        private function cbMouseOverItemBtn(param1:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_2:* = this._page.pageIndex * _ITEM_PAGE_NUM + param1;
            var _loc_3:* = false;
            var _loc_4:* = false;
            for each (_loc_5 in this._aPlanData)
            {
                
                if (_loc_5 == null)
                {
                    continue;
                }
                _loc_6 = _loc_5.calcPlanIndex(_ITEM_PAGE_NUM);
                if (_loc_6 == _loc_2)
                {
                    this._mouseOverPlanIndex = _loc_2;
                    _loc_7 = _loc_5.getName();
                    _loc_8 = TextControl.formatIdText(MessageId.TRADINGPOST_TRADE_NAME, _loc_5.getDescription());
                    _loc_9 = _loc_5.getCategoryItem(CommonConstant.ITEM_KIND_WARRIOR);
                    if (_loc_9)
                    {
                        _loc_3 = this.showMouseOverPlayerStatus(_loc_5, _loc_9.itemId);
                    }
                    if (_loc_3 == false)
                    {
                        _loc_10 = _loc_5.getCategoryItem(CommonConstant.ITEM_KIND_ACCESSORIES);
                        if (_loc_10)
                        {
                            _loc_4 = this.showMouseOverEquipStatus(_loc_5, _loc_10.itemId);
                        }
                    }
                    _loc_11 = "";
                    if (_loc_5.hasItem(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_WARRIOR_INCREASE))
                    {
                        _loc_11 = TextControl.formatIdText(MessageId.TRADINGPOST_NAVI_MESSAGE_02_TRADINGPOST, _loc_7, _loc_8, _loc_7, int((CommonConstant.TRADING_POST_ADD_WARRIOR_MAX - UserDataManager.getInstance().userData.warriorIncrease) / CommonConstant.TRADING_POST_ADD_WARRIOR_COUNT));
                    }
                    else if (_loc_5.hasItem(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM__BED_INCREASE))
                    {
                        _loc_11 = TextControl.formatIdText(MessageId.TRADINGPOST_NAVI_MESSAGE_02_TRADINGPOST, _loc_7, _loc_8, _loc_7, int((CommonConstant.BARRACKS_BED_MAX_NUM - CommonConstant.BARRACKS_BED_INIT_NUM - UserDataManager.getInstance().userData.bedIncrease) / CommonConstant.BARRACKS_ADD_BED_COUNT));
                    }
                    else if (_loc_5.priceType == CommonConstant.TRADE_PRICE_TYPE_CROWN)
                    {
                        _loc_11 = TextControl.formatIdText(MessageId.TRADINGPOST_NAVI_MESSAGE_02, _loc_7, _loc_8, this.naviMessageParts_OwnItemNum(_loc_5));
                    }
                    else
                    {
                        if (_loc_9)
                        {
                            _loc_11 = TextControl.formatIdText(MessageId.TRADINGPOST_NAVI_MESSAGE_02_TRADEINSIGNIA, UserDataManager.getInstance().getCurrentPlayerCap());
                        }
                        else
                        {
                            _loc_10 = _loc_5.itemList[0];
                            _loc_12 = MessageId.TRADINGPOST_NAVI_MESSAGE_01_TRADEINSIGNIA;
                            if (_loc_10.category == CommonConstant.ITEM_KIND_ASSET && _loc_10.itemId == AssetId.ASSET_GACHA_POINT)
                            {
                                _loc_12 = MessageId.TRADINGPOST_NAVI_MESSAGE_03_TRADEINSIGNIA;
                            }
                            _loc_11 = TextControl.formatIdText(_loc_12, _loc_10.getName(), UserDataManager.getInstance().userData.getOwnItemNum(_loc_10.category, _loc_10.itemId));
                        }
                        _loc_11 = TextControl.formatIdText(MessageId.TRADINGPOST_NAVI_MESSAGE_02, _loc_7, _loc_8, _loc_11);
                    }
                    this.openBalloon(_loc_11);
                    break;
                }
            }
            if (_loc_3 == false)
            {
                if (this._simpleStatus.isShow())
                {
                    this._simpleStatus.hide();
                }
            }
            if (_loc_4 == false)
            {
                if (this._equipStatus.isShow())
                {
                    this._equipStatus.hide();
                }
            }
            return;
        }// end function

        private function naviMessageParts_OwnItemNum(param1:PaymentPlanData) : String
        {
            var _loc_7:* = null;
            var _loc_2:* = [];
            var _loc_3:* = [];
            var _loc_4:* = param1.itemList.length;
            if (param1.itemList.length > 3)
            {
                _loc_4 = 3;
            }
            if (_loc_4 > 1)
            {
                return "";
            }
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.itemList[_loc_5];
                _loc_2.push(_loc_7.getName());
                _loc_3.push(UserDataManager.getInstance().userData.getOwnItemNum(_loc_7.category, _loc_7.itemId));
                _loc_5++;
            }
            var _loc_6:* = "";
            if (_loc_4 == 1)
            {
                _loc_6 = TextControl.formatIdText(MessageId.TRADINGPOST_NAVI_MESSAGE_PARTS_01, _loc_2[0], _loc_3[0]);
            }
            else if (_loc_4 == 2)
            {
                _loc_6 = TextControl.formatIdText(MessageId.TRADINGPOST_NAVI_MESSAGE_PARTS_02, _loc_2[0], _loc_3[0], _loc_2[1], _loc_3[1]);
            }
            else if (_loc_4 == 3)
            {
                _loc_6 = TextControl.formatIdText(MessageId.TRADINGPOST_NAVI_MESSAGE_PARTS_03, _loc_2[0], _loc_3[0], _loc_2[1], _loc_3[1], _loc_2[2], _loc_3[2]);
            }
            return _loc_6;
        }// end function

        private function cbMouseOutItemBtn(param1:int) : void
        {
            var _loc_2:* = this._page.pageIndex * _ITEM_PAGE_NUM + param1;
            if (this._mouseOverPlanIndex == _loc_2)
            {
                this._mouseOverPlanIndex = -1;
                if (this._simpleStatus.isShow())
                {
                    this._simpleStatus.hide();
                }
                if (this._equipStatus.isShow())
                {
                    this._equipStatus.hide();
                }
                this.openBalloon(MessageManager.getInstance().getMessage(MessageId.TRADINGPOST_NAVI_MESSAGE_01));
            }
            return;
        }// end function

        private function cbClickItemBtn(param1:int) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = this._page.pageIndex * _ITEM_PAGE_NUM + param1;
            var _loc_3:* = 0;
            while (_loc_3 < this._aPlanData.length)
            {
                
                _loc_4 = this._aPlanData[_loc_3];
                if (_loc_4.calcPlanIndex(_ITEM_PAGE_NUM) == _loc_2)
                {
                    this._selectedPlanIndex = _loc_3;
                    break;
                }
                _loc_3++;
            }
            this.updatePaymentPlanDisplay();
            this.updateItemListBtn();
            this.cbBuyButton(param1);
            return;
        }// end function

        private function cbCloseButton(param1:int) : void
        {
            if (this._phase == _PHASE_MAIN)
            {
                this.setPhase(_PHASE_CLOSE);
            }
            return;
        }// end function

        private function cbCrownHistory(param1:int) : void
        {
            this.setPhase(_PHASE_CROWN_HISTORY);
            return;
        }// end function

        private function cbBuyButton(param1:int) : void
        {
            if (this._selectedPlanIndex < 0 || this._selectedPlanIndex >= this._aPlanData.length)
            {
                return;
            }
            this.setPhase(_PHASE_POPUP);
            this._purchasedPlan = this._aPlanData[this._selectedPlanIndex];
            var _loc_2:* = new TradingPostPaymentPlanBuyPopup(this._layer.getLayer(LayerTradingPost.POPUP), this._purchasedPlan, this.cbBuyPopup);
            _loc_2.flowStart();
            return;
        }// end function

        private function cbBuyPopup(param1:int) : void
        {
            switch(param1)
            {
                case TradingPostPlanBuyPopup.BUY_POPUP_RESULT_CLOSE:
                default:
                {
                    this.cbClosePopup();
                    break;
                }
                case TradingPostPlanBuyPopup.BUY_POPUP_RESULT_GOTO_PHASE_PHASE_RE_OPEN:
                {
                    this.setPhase(_PHASE_CROWN_UPDATE);
                    break;
                }
                case TradingPostPlanBuyPopup.BUY_POPUP_RESULT_BUY_PURCHASE:
                {
                    this.setPhase(_PHASE_RE_OPEN);
                    break;
                }
                case TradingPostPlanBuyPopup.BUY_POPUP_RESULT_BUY_WARRIOR_INCREASE:
                {
                    NetManager.getInstance().request(new NetTaskTradingPurchase(this._purchasedPlan, 1, this.cbConnectTradingPurchase));
                    break;
                }
                case TradingPostPlanBuyPopup.BUY_POPUP_RESULT_BUY_BED_INCREASE:
                {
                    NetManager.getInstance().request(new NetTaskTradingWarriorIncrease(this._purchasedPlan, this.cbConnectTradingWarriorIncrease));
                    break;
                }
                case :
                {
                    NetManager.getInstance().request(new NetTaskTradingWarriorIncrease(this._purchasedPlan, this.cbConnectTradingBedIncrease));
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function setTabText(param1:MovieClip, param2:MovieClip, param3:int) : void
        {
            var _loc_4:* = Constant.EMPTY_ID;
            switch(param3)
            {
                case PaymentPlanData.TAB_NORMAL:
                {
                    _loc_4 = MessageId.TRADINGPOST_TAB_ITEM;
                    break;
                }
                case PaymentPlanData.TAB_INSIGNIA:
                {
                    _loc_4 = MessageId.TRADINGPOST_TAB_EQUIP;
                    break;
                }
                case PaymentPlanData.TAB_SPECIAL:
                {
                    _loc_4 = MessageId.TRADINGPOST_TAB_SPECIAL;
                    break;
                }
                default:
                {
                    break;
                }
            }
            TextControl.setIdText(param1.textMc.textDt, _loc_4);
            TextControl.setIdText(param2.textMc.textDt, _loc_4);
            return;
        }// end function

        private function setTabLabel(param1:int) : void
        {
            var _loc_2:* = this._aTabId.indexOf(param1);
            var _loc_3:* = LABEL_TAB_IDX_0;
            switch(_loc_2)
            {
                case 1:
                {
                    _loc_3 = LABEL_TAB_IDX_1;
                    break;
                }
                case 2:
                {
                    _loc_3 = LABEL_TAB_IDX_2;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._mcMain.itemListMc.tabSetMc.gotoAndStop(_loc_3);
            return;
        }// end function

        private function pageChange() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this._page.pageIndex;
            var _loc_2:* = 0;
            for each (_loc_3 in this._aPlanData)
            {
                
                if (_loc_3 != null && _loc_3.page > _loc_2)
                {
                    _loc_2 = _loc_3.page;
                }
            }
            if (_loc_1 >= _loc_2)
            {
                _loc_1 = _loc_2 - 1;
            }
            if (_loc_1 < 0)
            {
                _loc_1 = 0;
            }
            this._page.setPage(_loc_1, _loc_2);
            return;
        }// end function

        private function cbConnectTradingWarriorIncrease(param1:NetResult) : void
        {
            if (param1.resultCode != NetId.RESULT_OK)
            {
                if (param1.resultCode == NetId.RESULT_ERROR_TRADING_WARRIOR_INCREASE_OVER_SLOT)
                {
                    TradingPostPopupUtility.openAlertPopup(this._layer.getLayer(LayerTradingPost.POPUP), MessageManager.getInstance().getMessage(MessageId.TRADINGPOST_ITEM_PURCHASE_WI_OVER), this.cbClosePopup);
                    return;
                }
                this.popupConnectTradingError();
                return;
            }
            this.updateConnectTrading(param1);
            var _loc_2:* = this._purchasedPlan.getItem(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_WARRIOR_INCREASE);
            var _loc_3:* = CommonConstant.TRADING_POST_ADD_WARRIOR_COUNT * _loc_2.num;
            TradingPostPopupUtility.openAlertPopup(this._layer.getLayer(LayerTradingPost.POPUP), TextControl.formatIdText(MessageId.TRADINGPOST_ITEM_PURCHASED_WI, this._purchasedPlan.getName(), _loc_3), this.cbClosePopup);
            return;
        }// end function

        private function cbConnectTradingBedIncrease(param1:NetResult) : void
        {
            if (param1.resultCode != NetId.RESULT_OK)
            {
                if (param1.resultCode == NetId.RESULT_ERROR_TRADING_WARRIOR_INCREASE_OVER_SLOT)
                {
                    TradingPostPopupUtility.openAlertPopup(this._layer.getLayer(LayerTradingPost.POPUP), MessageManager.getInstance().getMessage(MessageId.BARRACKS_ITEM_PURCHASE_BED_OVER), this.cbClosePopup);
                    return;
                }
                this.popupConnectTradingError();
                return;
            }
            this.updateConnectTrading(param1);
            TradingPostPopupUtility.openAlertPopup(this._layer.getLayer(LayerTradingPost.POPUP), TextControl.formatIdText(MessageId.BARRACKS_ITEM_PURCHASED_BED, UserDataManager.getInstance().getCurrentBedNum()), this.cbClosePopup);
            return;
        }// end function

        private function cbConnectTradingPurchase(param1:NetResult) : void
        {
            if (param1.resultCode != NetId.RESULT_OK)
            {
                this.popupConnectTradingError();
                return;
            }
            this.updateConnectTrading(param1);
            var _loc_2:* = this._purchasedPlan.price * param1.data.num;
            var _loc_3:* = "";
            if (this._purchasedPlan.priceType == CommonConstant.TRADE_PRICE_TYPE_CROWN)
            {
                _loc_3 = TextControl.formatIdText(MessageId.TRADINGPOST_ITEM_PURCHASED, _loc_2, this._purchasedPlan.getName(), param1.data.num);
            }
            else
            {
                _loc_3 = TextControl.formatIdText(MessageId.TRADINGPOST_ITEM_TRADEINSIGNIA, this._purchasedPlan.getPriceTypeName(), _loc_2, this._purchasedPlan.getName(), param1.data.num);
            }
            TradingPostPopupUtility.openAlertPopup(this._layer.getLayer(LayerTradingPost.POPUP), _loc_3, this.cbClosePopup);
            return;
        }// end function

        private function popupConnectTradingError() : void
        {
            TradingPostPopupUtility.openAlertPopup(this._layer.getLayer(LayerTradingPost.POPUP), MessageManager.getInstance().getMessage(MessageId.TRADINGPOST_CONNECT_ERROR_BACK_HOME), function () : void
            {
                setPhase(_PHASE_RE_OPEN);
                return;
            }// end function
            );
            return;
        }// end function

        private function updateConnectTrading(param1:NetResult) : void
        {
            this._insigniaBox.updateNum();
            this._tradingPostData.paymentPlanStockDown(this._purchasedPlan.planId, param1.data.num);
            this.updatePaymentPlanDisplay();
            this.updateItemList();
            this.pageChange();
            return;
        }// end function

        private function cbClosePopup() : void
        {
            this.setPhase(_PHASE_MAIN);
            return;
        }// end function

        private function cbChangePage(param1:int, param2:int) : Boolean
        {
            this.updateItemList();
            this.updateItemListBtn();
            return true;
        }// end function

        private function cbChangeTab(param1:int) : void
        {
            if (this._tabType == param1)
            {
                return;
            }
            this._tabType = param1;
            this.setTabLabel(this._tabType);
            this.updatePaymentPlanDisplay();
            this.pageChange();
            this.updateItemList();
            this.updateItemListBtn();
            this.updateInsigniaBox();
            return;
        }// end function

        private function searchPageIndex(param1:int, param2:int, param3:int) : int
        {
            var _loc_4:* = null;
            for each (_loc_4 in this._aPlanData)
            {
                
                if (_loc_4.checkEnable() && _loc_4.tab == param1)
                {
                    if (_loc_4.searchItem(param2, param3) >= 0)
                    {
                        return (_loc_4.page - 1);
                    }
                }
            }
            return -1;
        }// end function

    }
}
