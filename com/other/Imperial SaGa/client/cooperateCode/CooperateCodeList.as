package cooperateCode
{
    import button.*;
    import flash.display.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class CooperateCodeList extends Object
    {
        private var _baseMc:MovieClip;
        private var _isoTitle:InStayOut;
        private var _isoMain:InStayOut;
        private var _isoNoItem:InStayOut;
        private var _btnReturn:ButtonBase;
        private var _page:PageButton;
        private var _aCodeView:Array;
        private var _bEnd:Boolean;
        private static const _LIST_ITEM_NUM:int = 10;

        public function CooperateCodeList(param1:DisplayObjectContainer)
        {
            var mc:MovieClip;
            var parent:* = param1;
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_CampaignList.swf", "CampaignListMc");
            parent.addChild(this._baseMc);
            this._isoTitle = new InStayOut(this._baseMc.titleMc);
            this._isoMain = new InStayOut(this._baseMc.mainMc);
            this._isoNoItem = new InStayOut(this._baseMc.mainMc.listWindowMc.notReceiptItemMc);
            TextControl.setIdText(this._baseMc.mainMc.listWindowMc.notReceiptItemMc.textMc.textDt, MessageId.BENEFIT_NOT_GET_CODE);
            this._btnReturn = ButtonManager.getInstance().addButton(this._baseMc.mainMc.returnBtnMc, this.cbReturnButton);
            this._btnReturn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._baseMc.mainMc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            var codeNum:* = CooperateCodeManager.getInstance().cooperateCodeNum;
            var pageMax:* = (codeNum + _LIST_ITEM_NUM - 1) / _LIST_ITEM_NUM;
            this._page = new PageButton(this._baseMc.mainMc.listWindowMc.pageBtnSetGuidMc, this.cbChangePage, 0, pageMax);
            this._aCodeView = [];
            var i:int;
            while (i < _LIST_ITEM_NUM)
            {
                
                mc = this._baseMc.mainMc.listWindowMc["listBox" + (1 + i) + "Mc"];
                this._aCodeView.push(new CooperateCodeView(mc));
                i = (i + 1);
            }
            this.updateList();
            this.setButtonEnable(false);
            this._bEnd = false;
            this._isoTitle.setIn();
            this._isoMain.setIn(function () : void
            {
                setButtonEnable(true);
                return;
            }// end function
            );
            if (codeNum == 0)
            {
                this._isoNoItem.setIn();
            }
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aCodeView)
            {
                
                _loc_1.release();
            }
            this._aCodeView = [];
            if (this._page)
            {
                this._page.release();
            }
            this._page = null;
            if (this._btnReturn)
            {
                ButtonManager.getInstance().removeButton(this._btnReturn);
            }
            this._btnReturn = null;
            if (this._isoNoItem)
            {
                this._isoNoItem.release();
            }
            this._isoNoItem = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._isoTitle)
            {
                this._isoTitle.release();
            }
            this._isoTitle = null;
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            return;
        }// end function

        private function updateList() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_1:* = CooperateCodeManager.getInstance().aCooperateCode;
            var _loc_2:* = 0;
            while (_loc_2 < _LIST_ITEM_NUM)
            {
                
                _loc_3 = this._aCodeView[_loc_2];
                _loc_4 = this._page.pageIndex * _LIST_ITEM_NUM + _loc_2;
                if (_loc_4 < _loc_1.length)
                {
                    _loc_3.setCodeInfo(_loc_1[_loc_4]);
                }
                else
                {
                    _loc_3.setCodeInfo(null);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function setButtonEnable(param1:Boolean) : void
        {
            this._btnReturn.setDisable(!param1);
            this._page.btnDisable(!param1);
            return;
        }// end function

        private function cbReturnButton(param1:int) : void
        {
            var id:* = param1;
            this.setButtonEnable(false);
            this._isoTitle.setOut();
            this._isoMain.setOut(function () : void
            {
                _bEnd = true;
                return;
            }// end function
            );
            return;
        }// end function

        private function cbChangePage(param1:int, param2:int) : Boolean
        {
            this.updateList();
            return true;
        }// end function

    }
}
