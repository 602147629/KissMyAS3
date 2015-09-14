package subdualPoint
{
    import asset.*;
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import status.*;

    public class SubdualPointRewardList extends Object
    {
        private var _mc:MovieClip;
        private var _data:SubdualPointData;
        private var _bButtonEnable:Boolean;
        private var _displayMode:int;
        private var _pointBox:SubdualPointBox;
        private var _tabList:TabList;
        private var _page:PageButton;
        private var _aRecord:Array;
        private var _mouseOverId:int;
        private var _simpleStatus:CommonSimpleStatus;
        private static const _DISPLAY_MODE_INDIVIDUAL:int = 0;
        private static const _DISPLAY_MODE_WHOLE:int = 1;

        public function SubdualPointRewardList(param1:MovieClip, param2:SubdualPointData)
        {
            var _loc_5:* = null;
            this._mc = param1;
            this._data = param2;
            this._bButtonEnable = false;
            this._displayMode = _DISPLAY_MODE_INDIVIDUAL;
            this._pointBox = new SubdualPointBox(this._mc.pointBox);
            this._tabList = new TabList(this.cbChangeTab);
            this._tabList.addTab(this._mc.TabBtn01, MessageManager.getInstance().getMessage(MessageId.EVENT_QUEST_DESTRUCTION_REWARD_SINGLE), _DISPLAY_MODE_INDIVIDUAL);
            this._tabList.addTab(this._mc.TabBtn02, MessageManager.getInstance().getMessage(MessageId.EVENT_QUEST_DESTRUCTION_REWARD_ALL), _DISPLAY_MODE_WHOLE);
            this._tabList.changeTabId(this._displayMode);
            this._tabList.btnEnable(this._bButtonEnable);
            this._page = new PageButton(this._mc.pageBtnSetGuidMc, this.cbChangePage);
            this._page.btnEnable(this._bButtonEnable);
            var _loc_3:* = [this._mc.reward1, this._mc.reward2, this._mc.reward3, this._mc.reward4, this._mc.reward5, this._mc.reward6, this._mc.reward7, this._mc.reward8, this._mc.reward9, this._mc.reward10, this._mc.reward11, this._mc.reward12];
            this._aRecord = [];
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = new SubdualPointRewardRecord(_loc_4, _loc_3[_loc_4], this.cbOverReward, this.cbOutReward);
                this._aRecord.push(_loc_5);
                _loc_4++;
            }
            this._mouseOverId = Constant.UNDECIDED;
            this._simpleStatus = new CommonSimpleStatus(this._mc.parent);
            this._simpleStatus.hide();
            TextControl.setText(this._mc.infoTextMc.textDt, TextControl.formatIdText(MessageId.EVENT_QUEST_DESTRUCTION_REWARD_EXPLANATION, AssetListManager.getInstance().getAssetName(AssetId.ASSET_EVENT_POINT_0001)));
            this.updatePoint();
            this.updateList();
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            if (this._simpleStatus)
            {
                this._simpleStatus.release();
            }
            this._simpleStatus = null;
            for each (_loc_1 in this._aRecord)
            {
                
                _loc_1.release();
            }
            this._aRecord = null;
            if (this._page)
            {
                this._page.release();
            }
            this._page = null;
            if (this._tabList)
            {
                this._tabList.release();
            }
            this._tabList = null;
            if (this._pointBox)
            {
                this._pointBox.release();
            }
            this._pointBox = null;
            this._data = null;
            this._mc = null;
            return;
        }// end function

        public function setButtonEnable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            this._bButtonEnable = param1;
            this._tabList.btnEnable(param1);
            this._page.btnEnable(param1);
            for each (_loc_2 in this._aRecord)
            {
                
                _loc_2.setButtonEnable(param1);
            }
            return;
        }// end function

        private function updatePoint() : void
        {
            this._pointBox.setPoint(this._data.individualPoint, this._data.wholePoint);
            return;
        }// end function

        private function updateList() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = this.getRewardDataArray();
            var _loc_2:* = this._page.pageIndex * this._aRecord.length;
            var _loc_3:* = 0;
            while (_loc_3 < this._aRecord.length)
            {
                
                _loc_4 = this._aRecord[_loc_3];
                _loc_5 = null;
                if (_loc_2 + _loc_3 < _loc_1.length)
                {
                    _loc_5 = _loc_1[_loc_2 + _loc_3];
                    if (_loc_5.bGet == false && SubdualPointManager.getInstance().checkReceivedReward(this._displayMode, _loc_5))
                    {
                        _loc_5.changeStatusReceipt();
                    }
                }
                _loc_4.setRewardData(_loc_5);
                _loc_4.setButtonEnable(this._bButtonEnable);
                _loc_3++;
            }
            return;
        }// end function

        private function getRewardDataArray() : Array
        {
            return this._displayMode == _DISPLAY_MODE_INDIVIDUAL ? (this._data.aIndividualReward) : (this._data.aWholeReward);
        }// end function

        private function cbChangeTab(param1:int, param2:int) : Boolean
        {
            this._displayMode = param2;
            var _loc_3:* = this.getRewardDataArray();
            this._page.setPage(0, Math.ceil(_loc_3.length / this._aRecord.length));
            this.updateList();
            return true;
        }// end function

        private function cbChangePage(param1:int, param2:int) : Boolean
        {
            this.updateList();
            return true;
        }// end function

        private function cbOverReward(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._mouseOverId != param1)
            {
                this._mouseOverId = param1;
                _loc_2 = this._aRecord[param1];
                if (_loc_2 && _loc_2.data && _loc_2.data.category != CommonConstant.ITEM_KIND_CROWN)
                {
                    _loc_3 = _loc_2.balloonAmbitNull;
                    _loc_4 = new Point(_loc_3.x, _loc_3.y);
                    _loc_4 = _loc_3.parent.localToGlobal(_loc_4);
                    _loc_4 = this._mc.globalToLocal(_loc_4);
                    _loc_3 = _loc_2.balloonNull;
                    _loc_5 = new Point(_loc_3.x, _loc_3.y);
                    _loc_5 = _loc_3.parent.localToGlobal(_loc_5);
                    if (this._simpleStatus)
                    {
                        this._simpleStatus.setData(_loc_2.data.category, _loc_2.data.itemId);
                        this._simpleStatus.setPosition(_loc_4);
                        this._simpleStatus.setArrowTargetPosition(_loc_5);
                        this._simpleStatus.show();
                    }
                }
                else if (this._simpleStatus && this._simpleStatus.isShow())
                {
                    this._simpleStatus.hide();
                }
            }
            return;
        }// end function

        private function cbOutReward(param1:int) : void
        {
            if (this._mouseOverId == param1)
            {
                this._mouseOverId = -1;
                if (this._simpleStatus.isShow())
                {
                    this._simpleStatus.hide();
                }
            }
            return;
        }// end function

    }
}
