package crownHistory
{
    import button.*;
    import flash.display.*;
    import message.*;
    import network.*;
    import resource.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class CrownHistoryWindow extends Object
    {
        private var _phase:int;
        private var _parent:DisplayObjectContainer;
        private var _mcBase:MovieClip;
        private var _mcMain:MovieClip;
        private var _isoMain:InStayOut;
        private var _btnReturn:ButtonBase;
        private var _aCrownHistory:Array;
        private var _historyCount:int;
        private var _page:PageButton;
        private var _bCrownHistoryInfoLoaded:Boolean;
        private static const _LIST_ITEM_NUM:int = 10;
        private static const _PHASE_LOADING:int = 0;
        private static const _PHASE_OPEN_WAIT:int = 1;
        private static const _PHASE_OPEN:int = 2;
        private static const _PHASE_MAIN:int = 3;
        private static const _PHASE_CONNECTING:int = 4;
        private static const _PHASE_CLOSE:int = 5;

        public function CrownHistoryWindow(param1:DisplayObjectContainer)
        {
            this._parent = param1;
            ResourceManager.getInstance().loadResource(ResourcePath.HOME_PATH + "UI_CrownFlow.swf");
            this._aCrownHistory = [];
            this._historyCount = 0;
            this._bCrownHistoryInfoLoaded = false;
            this.getNetCrownHistoryData(0);
            this.setPhase(_PHASE_LOADING);
            return;
        }// end function

        public function get bAnimetion() : Boolean
        {
            return this._phase != _PHASE_OPEN && this._phase != _PHASE_CLOSE && (this._isoMain == null || this._isoMain && this._isoMain.bAnimetion);
        }// end function

        public function get bLoaded() : Boolean
        {
            return this._bCrownHistoryInfoLoaded && this._phase != _PHASE_LOADING;
        }// end function

        public function get bOpenWait() : Boolean
        {
            return this._phase == _PHASE_OPEN_WAIT;
        }// end function

        public function get bClose() : Boolean
        {
            return this._phase == _PHASE_CLOSE && (this._isoMain && this._isoMain.bClosed);
        }// end function

        private function resourceLoaded() : void
        {
            if (!ResourceManager.getInstance().isLoaded() || !this._bCrownHistoryInfoLoaded)
            {
                return;
            }
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_CrownFlow.swf", "CrownFlowMainMc");
            this._parent.addChild(this._mcBase);
            this._mcMain = this._mcBase.crownFlowListMc;
            this._isoMain = new InStayOut(this._mcBase);
            this._btnReturn = ButtonManager.getInstance().addButton(this._mcBase.returnBtnMc, this.cbReturnButton);
            this._btnReturn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcBase.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this._page = new PageButton(this._mcMain, this.cbChangePage, 0, Math.ceil(this._historyCount / _LIST_ITEM_NUM));
            this.btnEnable(false);
            this._isoMain.setEnd();
            var _loc_1:* = UserDataManager.getInstance().userData.getCrownTotal();
            TextControl.setIdText(this._mcBase.crownTotalListMc.textFreeCrMc.textDt, MessageId.CROWN_HISTORY_FREE_CROWN);
            TextControl.setIdText(this._mcBase.crownTotalListMc.textBuyCrMc.textDt, MessageId.CROWN_HISTORY_BUY_CROWN);
            TextControl.setIdText(this._mcBase.crownTotalListMc.textTotalCrMc.textDt, MessageId.CROWN_HISTORY_TOTAL_CROWN);
            TextControl.setText(this._mcBase.crownTotalListMc.listFreeCr.textDt, _loc_1.free.toString());
            TextControl.setText(this._mcBase.crownTotalListMc.listBuyCr.textDt, _loc_1.paid.toString());
            TextControl.setText(this._mcBase.crownTotalListMc.listTotalCr.textDt, _loc_1.total.toString());
            this.setPhase(_PHASE_OPEN_WAIT);
            return;
        }// end function

        public function release() : void
        {
            ButtonManager.getInstance().removeButton(this._btnReturn);
            this._btnReturn = null;
            if (this._page)
            {
                this._page.release();
            }
            this._page = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
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
                case _PHASE_CONNECTING:
                {
                    this.initPhaseConnecting();
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
            this.updateList();
            this._isoMain.setIn(function () : void
            {
                setPhase(_PHASE_MAIN);
                return;
            }// end function
            );
            return;
        }// end function

        private function initPhaseMain() : void
        {
            this.btnEnable(true);
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MYPAGE_CROWN_HISTORY))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MYPAGE_CROWN_HISTORY);
            }
            return;
        }// end function

        private function controlPhaseMain(param1:Number) : void
        {
            return;
        }// end function

        private function initPhaseConnecting() : void
        {
            this.btnEnable(false);
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this.btnEnable(false);
            this._isoMain.setOut();
            return;
        }// end function

        public function reset() : void
        {
            var prevPhase:int;
            prevPhase = this._phase;
            this.setPhase(_PHASE_CONNECTING);
            this._aCrownHistory = [];
            this._historyCount = 0;
            this._bCrownHistoryInfoLoaded = false;
            this.getNetCrownHistoryData(0, function () : void
            {
                _page.setPage(0, Math.ceil(_historyCount / _LIST_ITEM_NUM));
                if (prevPhase == _PHASE_MAIN)
                {
                    updateList();
                }
                else if (prevPhase == _PHASE_CLOSE)
                {
                    setPhase(_PHASE_OPEN_WAIT);
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function open() : void
        {
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        private function btnEnable(param1:Boolean) : void
        {
            this._btnReturn.setDisableFlag(!param1);
            this._page.btnEnable(param1);
            return;
        }// end function

        private function updateList() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = [this._mcMain.list1Mc, this._mcMain.list2Mc, this._mcMain.list3Mc, this._mcMain.list4Mc, this._mcMain.list5Mc, this._mcMain.list6Mc, this._mcMain.list7Mc, this._mcMain.list8Mc, this._mcMain.list9Mc, this._mcMain.list10Mc];
            var _loc_2:* = 0;
            while (_loc_2 < _LIST_ITEM_NUM)
            {
                
                _loc_3 = this._page.pageIndex * _LIST_ITEM_NUM + _loc_2;
                if (_loc_3 < this._historyCount)
                {
                    _loc_4 = this._aCrownHistory[_loc_3] as CrownHistoryData;
                    if (_loc_4)
                    {
                        _loc_1[_loc_2].visible = true;
                        _loc_1[_loc_2].gotoAndStop(_loc_4.amount >= 0 ? ("blue") : ("red"));
                        _loc_5 = new Date();
                        _loc_5.setTime(_loc_4.time * 1000);
                        TextControl.setText(_loc_1[_loc_2].listText1Mc.textDt, _loc_5.fullYear.toString() + "/" + ((_loc_5.month + 1)).toString() + "/" + _loc_5.date.toString());
                        TextControl.setText(_loc_1[_loc_2].listText2Mc.textDt, (_loc_5.hours < 10 ? ("0") : ("")) + _loc_5.hours.toString() + ":" + (_loc_5.minutes < 10 ? ("0") : ("")) + _loc_5.minutes.toString());
                        TextControl.setText(_loc_1[_loc_2].listText3Mc.textDt, _loc_4.amount >= 0 ? (_loc_4.amount.toString()) : (""));
                        TextControl.setText(_loc_1[_loc_2].listText4Mc.textDt, _loc_4.amount >= 0 ? ("") : ((-_loc_4.amount).toString()));
                        TextControl.setText(_loc_1[_loc_2].listText5Mc.textDt, _loc_4.text);
                        TextControl.setText(_loc_1[_loc_2].listText6Mc.textDt, _loc_4.count.toString());
                        TextControl.setText(_loc_1[_loc_2].listText7Mc.textDt, _loc_4.total.toString());
                    }
                    else
                    {
                        _loc_1[_loc_2].visible = false;
                    }
                }
                else
                {
                    _loc_1[_loc_2].visible = false;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function getNetCrownHistoryData(param1:int, param2:Function = null) : void
        {
            var start:* = param1;
            var cbCompleted:* = param2;
            NetManager.getInstance().request(new NetTaskCrownHistory(start, _LIST_ITEM_NUM * 5, function (param1:NetResult) : void
            {
                var _loc_3:* = undefined;
                var _loc_4:* = undefined;
                var _loc_2:* = 0;
                for each (_loc_3 in param1.data.aCrownHistory)
                {
                    
                    _loc_4 = new CrownHistoryData(_loc_3);
                    _aCrownHistory[start + _loc_2] = _loc_4;
                    _loc_2 = _loc_2 + 1;
                }
                _historyCount = parseInt(param1.data.historyCount);
                _bCrownHistoryInfoLoaded = true;
                if (cbCompleted != null)
                {
                    cbCompleted();
                }
                return;
            }// end function
            ));
            return;
        }// end function

        private function isGotCrownHistoryData(param1:int, param2:int) : Boolean
        {
            var _loc_3:* = param1;
            while (_loc_3 < param1 + param2 && _loc_3 < this._historyCount)
            {
                
                if (!this._aCrownHistory[_loc_3])
                {
                    return false;
                }
                _loc_3++;
            }
            return true;
        }// end function

        private function cbReturnButton(param1:int) : void
        {
            if (this._phase == _PHASE_MAIN)
            {
                this.setPhase(_PHASE_CLOSE);
            }
            return;
        }// end function

        private function cbChangePage(param1:int, param2:int) : Boolean
        {
            var pageIndex:* = param1;
            var id:* = param2;
            if (!this.isGotCrownHistoryData(pageIndex * _LIST_ITEM_NUM, _LIST_ITEM_NUM))
            {
                this.setPhase(_PHASE_CONNECTING);
                this.getNetCrownHistoryData(pageIndex * _LIST_ITEM_NUM, function () : void
            {
                _page.update();
                updateList();
                setPhase(_PHASE_MAIN);
                return;
            }// end function
            );
                return false;
            }
            this.updateList();
            return true;
        }// end function

    }
}
