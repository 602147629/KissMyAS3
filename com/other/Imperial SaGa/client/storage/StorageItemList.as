package storage
{
    import button.*;
    import flash.display.*;
    import message.*;
    import network.*;
    import popup.*;
    import utility.*;

    public class StorageItemList extends Object
    {
        private const _DISPLAY_MODE_LIMIT_ITEM:int = 0;
        private const _DISPLAY_MODE_UNLIMITED_ITEM:int = 1;
        private const _DISPLAY_MODE_HISTORY:int = 2;
        private const _BUTTON_ID_RECEIPT_ALL:int = 0;
        private var _mcTop:MovieClip;
        private var _baseMc:MovieClip;
        private var _aStorageItemView:Array;
        private var _notReceiptItemMc:MovieClip;
        private var _isoNoItem:InStayOut;
        private var _aFilterButton:Array;
        private var _aItemIdList:Array;
        private var _aButton:Array;
        private var _currentFilter:int;
        private var _page:PageButton;
        private var _currentPage:int;
        private var _tabList:TabList;
        private var _displayMode:int;
        private var _bButtonDisable:Boolean;
        private var _bInternalButtonEnable:Boolean;
        private var _selectedItemId:int;

        public function StorageItemList(param1:MovieClip, param2:MovieClip)
        {
            this._mcTop = param1;
            this._baseMc = param2;
            this._aFilterButton = [];
            this._aButton = [];
            this._aStorageItemView = [];
            this._displayMode = this._DISPLAY_MODE_LIMIT_ITEM;
            this._currentFilter = StorageConstant.ITEM_FILTER_NONE;
            this.createButtons();
            this.createItemView();
            this._notReceiptItemMc = this._baseMc.notReceiptItemMc;
            TextControl.setIdText(this._notReceiptItemMc.textMc.textDt, MessageId.STORAGE_LIST_MESSAGE_NORMAL_NONE);
            this._isoNoItem = new InStayOut(this._notReceiptItemMc);
            this.cbChangeTab(0, this._displayMode);
            this._bButtonDisable = true;
            this.buttonEnable(true);
            return;
        }// end function

        private function get _bHistoryMode() : Boolean
        {
            return this._displayMode == this._DISPLAY_MODE_HISTORY;
        }// end function

        public function get bHistoryMode() : Boolean
        {
            return this._bHistoryMode;
        }// end function

        public function get bDisplayMode() : int
        {
            return this._displayMode;
        }// end function

        public function get bButtonEnable() : Boolean
        {
            return this._bInternalButtonEnable && !this._bButtonDisable;
        }// end function

        public function get itemNum() : int
        {
            return this._aItemIdList.length;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._tabList)
            {
                this._tabList.release();
            }
            this._tabList = null;
            if (this._page)
            {
                this._page.release();
            }
            this._page = null;
            if (this._aButton)
            {
                for each (_loc_1 in this._aButton)
                {
                    
                    ButtonManager.getInstance().removeButton(_loc_1);
                    _loc_1.release();
                }
            }
            this._aButton = null;
            if (this._aFilterButton)
            {
                for each (_loc_2 in this._aFilterButton)
                {
                    
                    _loc_2.release();
                }
            }
            this._aFilterButton = null;
            if (this._aStorageItemView)
            {
                for each (_loc_3 in this._aStorageItemView)
                {
                    
                    _loc_3.release();
                }
            }
            this._aStorageItemView = null;
            this._baseMc = null;
            this._mcTop = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            return;
        }// end function

        private function createButtons() : void
        {
            var _loc_1:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_2:* = [{mc:this._baseMc.filterBtn1Mc, id:StorageConstant.ITEM_FILTER_ITEM, textId:MessageId.STORAGE_FILTER_ITEM}, {mc:this._baseMc.filterBtn2Mc, id:StorageConstant.ITEM_FILTER_CROWN, textId:MessageId.STORAGE_FILTER_CROWN}, {mc:this._baseMc.filterBtn3Mc, id:StorageConstant.ITEM_FILTER_CHARACTER, textId:MessageId.STORAGE_FILTER_CHARACTER}, {mc:this._baseMc.filterBtn4Mc, id:StorageConstant.ITEM_FILTER_DESTINY_STONE, textId:MessageId.STORAGE_FILTER_DESTINY_STONE}, {mc:this._baseMc.filterBtn5Mc, id:StorageConstant.ITEM_FILTER_NONE, textId:MessageId.STORAGE_FILTER_ALL}];
            for each (_loc_3 in _loc_2)
            {
                
                _loc_1 = _loc_3.mc;
                _loc_6 = _loc_3.id;
                _loc_7 = _loc_3.textId;
                _loc_8 = new StorageFilterButton(_loc_1, _loc_6, _loc_7, this.cbChangeFilter);
                this._aFilterButton.push(_loc_8);
            }
            _loc_4 = [{mc:this._baseMc.receiptAllBtnMc, callback:this.cbReceiptAll, soundId:ButtonBase.SE_DECIDE_ID}];
            this._aButton = [];
            _loc_5 = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                _loc_9 = ButtonManager.getInstance().addButton(_loc_4[_loc_5].mc, _loc_4[_loc_5].callback);
                _loc_9.enterSeId = _loc_4[_loc_5].soundId;
                this._aButton.push(_loc_9);
                _loc_5++;
            }
            TextControl.setIdText(this._baseMc.receiptAllBtnMc.textMc.textDt, MessageId.STORAGE_GET_ALL_BUTTON);
            this._page = new PageButton(this._baseMc.pageBtnSetGuidMc, this.cbChangePage, 0, 10);
            this._page.btnEnable(true);
            this._tabList = new TabList(this.cbChangeTab);
            this._tabList.addTab(this._baseMc.TabBtn01, MessageManager.getInstance().getMessage(MessageId.STORAGE_TAB_TITLE_WITH_LIMIT), this._DISPLAY_MODE_LIMIT_ITEM);
            this._tabList.addTab(this._baseMc.TabBtn02, MessageManager.getInstance().getMessage(MessageId.STORAGE_TAB_TITLE_INDEFINITE), this._DISPLAY_MODE_UNLIMITED_ITEM);
            this._tabList.addTab(this._baseMc.TabBtn03, MessageManager.getInstance().getMessage(MessageId.STORAGE_TITLE_BUTTON_HISTORY), this._DISPLAY_MODE_HISTORY);
            this._tabList.changeTabId(this._displayMode);
            return;
        }// end function

        private function updateListPage() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_1:* = this._page.pageIndex;
            this._page.update();
            var _loc_2:* = 0;
            while (_loc_2 < this._aStorageItemView.length)
            {
                
                _loc_3 = this._aStorageItemView[_loc_2];
                _loc_4 = _loc_1 * this._aStorageItemView.length + _loc_2;
                if (_loc_4 < 0 || _loc_4 >= this._aItemIdList.length)
                {
                    _loc_3.uniqueId = Constant.UNDECIDED;
                }
                else
                {
                    _loc_5 = this._aItemIdList[_loc_1 * this._aStorageItemView.length + _loc_2];
                    if (_loc_5 != 0)
                    {
                        _loc_3.uniqueId = _loc_5;
                    }
                    else
                    {
                        _loc_3.uniqueId = Constant.UNDECIDED;
                    }
                }
                _loc_2++;
            }
            TextControl.setText(this._baseMc.numTextMc.numDt, this._aItemIdList != null ? (this._aItemIdList.length.toString()) : ("0"));
            return;
        }// end function

        private function resetPageNum(param1:int, param2:int = 0) : void
        {
            var _loc_3:* = param1 <= 0 ? (1) : (param1);
            this._page.setPage(param2 > (_loc_3 - 1) ? ((_loc_3 - 1)) : (param2), _loc_3);
            if (param1 == 0)
            {
                this._currentPage = 0;
                TextControl.setIdText(this._mcTop.storageTextMc.textDt, this._bHistoryMode ? (MessageId.STORAGE_LIST_MESSAGE_HISTORY_NONE) : (MessageId.STORAGE_LIST_MESSAGE_NORMAL_NONE));
                if (this._isoNoItem.bOpened == false && this._isoNoItem.bAnimetionOpen == false)
                {
                    this._isoNoItem.setIn();
                }
                TextControl.setIdText(this._notReceiptItemMc.textMc.textDt, this._bHistoryMode ? (MessageId.STORAGE_LIST_MESSAGE_HISTORY_NONE) : (MessageId.STORAGE_LIST_MESSAGE_NORMAL_NONE));
                this.setEnableReceiptAllBtn(false);
            }
            else
            {
                this._currentPage = param2;
                TextControl.setIdText(this._mcTop.storageTextMc.textDt, this._bHistoryMode ? (MessageId.STORAGE_LIST_MESSAGE_HISTORY) : (MessageId.STORAGE_LIST_MESSAGE_NORMAL));
                if (this._isoNoItem.bClosed == false && this._isoNoItem.bAnimetionClose == false)
                {
                    this._isoNoItem.setOut();
                }
                if (!this._bHistoryMode)
                {
                    this.setEnableReceiptAllBtn(true);
                }
            }
            this.updateListPage();
            return;
        }// end function

        private function createItemView() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._aStorageItemView = [];
            var _loc_1:* = [this._baseMc.storageItem1Mc, this._baseMc.storageItem2Mc, this._baseMc.storageItem3Mc, this._baseMc.storageItem4Mc, this._baseMc.storageItem5Mc, this._baseMc.storageItem6Mc, this._baseMc.storageItem7Mc, this._baseMc.storageItem8Mc];
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = new StorageItemView(_loc_2, this.cbReceiptItem);
                this._aStorageItemView.push(_loc_3);
            }
            return;
        }// end function

        public function setButtonDisable(param1:Boolean) : void
        {
            this._bButtonDisable = param1;
            this.buttonEnable(this._bInternalButtonEnable);
            return;
        }// end function

        private function buttonEnable(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            this._bInternalButtonEnable = param1;
            param1 = this.bButtonEnable;
            if (this._aButton)
            {
                _loc_2 = 0;
                while (_loc_2 < this._aButton.length)
                {
                    
                    _loc_3 = this._aButton[_loc_2];
                    if (_loc_2 != this._BUTTON_ID_RECEIPT_ALL)
                    {
                        _loc_3.setDisable(!param1);
                    }
                    else
                    {
                        _loc_3.setDisable(!param1 || this._aItemIdList.length == 0);
                    }
                    _loc_2++;
                }
            }
            this.updateListPage();
            if (this._aFilterButton)
            {
                for each (_loc_4 in this._aFilterButton)
                {
                    
                    _loc_4.setButtonEnable(param1);
                }
            }
            if (this._aStorageItemView)
            {
                for each (_loc_5 in this._aStorageItemView)
                {
                    
                    _loc_5.setButtonEnable(param1);
                }
            }
            if (this._page)
            {
                this._page.btnEnable(param1);
            }
            if (this._tabList)
            {
                this._tabList.btnEnable(param1);
            }
            return;
        }// end function

        private function setEnableReceiptAllBtn(param1:Boolean) : void
        {
            if (this._aButton)
            {
                this._aButton[this._BUTTON_ID_RECEIPT_ALL].setDisable(!param1 || this._aItemIdList.length == 0);
            }
            return;
        }// end function

        private function cbReceiptAll(param1:int) : void
        {
            this.buttonEnable(false);
            var _loc_2:* = MessageManager.getInstance().getMessage(MessageId.STORAGE_TAB_TITLE_INDEFINITE);
            var _loc_3:* = "";
            if (this._displayMode == this._DISPLAY_MODE_LIMIT_ITEM)
            {
                _loc_2 = MessageManager.getInstance().getMessage(MessageId.STORAGE_TAB_TITLE_WITH_LIMIT);
            }
            if (this._currentFilter == StorageConstant.ITEM_FILTER_NONE)
            {
                _loc_3 = TextControl.formatIdText(MessageId.STORAGE_POPUP_CONFIRM_ALL, _loc_2);
            }
            else
            {
                _loc_3 = TextControl.formatIdText(MessageId.STORAGE_POPUP_CONFIRM_ALL_PARTS, _loc_2, MessageManager.getInstance().getMessage(StorageConstant.FILTER_MESSAGE_ID[this._currentFilter]));
            }
            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, _loc_3, this.cbReceiptAllConfirm, MessageManager.getInstance().getMessage(MessageId.STORAGE_POPUP_YES), MessageManager.getInstance().getMessage(MessageId.STORAGE_POPUP_NO));
            return;
        }// end function

        private function cbReceiptAllConfirm(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            if (param1)
            {
                _loc_2 = 0;
                if (this._displayMode == this._DISPLAY_MODE_LIMIT_ITEM)
                {
                    _loc_2 = 1;
                }
                NetManager.getInstance().request(new NetTaskWareHouseReceiveAll(this.cbItemReceiveAll, _loc_2, this._currentFilter));
            }
            else
            {
                this.cbClosePopup();
            }
            return;
        }// end function

        private function cbClosePopup() : void
        {
            this.buttonEnable(true);
            this._selectedItemId = Constant.UNDECIDED;
            return;
        }// end function

        private function cbReceiptItem(param1:int) : void
        {
            var _loc_3:* = null;
            if (this._bHistoryMode)
            {
                return;
            }
            this.buttonEnable(false);
            this._selectedItemId = param1;
            var _loc_2:* = StorageManager.getInstance().getStorageItem(param1);
            var _loc_4:* = MessageManager.getInstance().getMessage(MessageId.STORAGE_FILTER_ITEM);
            _loc_3 = _loc_2.getItemName();
            _loc_4 = MessageManager.getInstance().getMessage(StorageManager.getInstance().getItemCategoryNameId(_loc_2));
            CommonPopup.getInstance().openItemPopup(TextControl.formatIdText(MessageId.STORAGE_POPUP_CONFIRM, _loc_4), _loc_2.category, _loc_2.itemId, _loc_3, _loc_2.num, MessageManager.getInstance().getMessage(MessageId.STORAGE_POPUP_YES), MessageManager.getInstance().getMessage(MessageId.STORAGE_POPUP_NO), this.cbReceiptConfirm);
            return;
        }// end function

        private function cbReceiptConfirm(param1:Boolean) : void
        {
            if (param1)
            {
                NetManager.getInstance().request(new NetTaskWareHouseReceive([this._selectedItemId], this.cbItemReceive));
            }
            else
            {
                this.cbClosePopup();
            }
            return;
        }// end function

        private function cbItemReceive(param1:NetResult) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                _loc_2 = param1.data.aWarehouseAcceptData;
                if (_loc_2.length > 0)
                {
                    _loc_3 = new StorageItemData(_loc_2[0]);
                    _loc_4 = StorageManager.getInstance().getItemCategoryNameId(_loc_3);
                    if (_loc_4 == Constant.EMPTY_ID)
                    {
                        _loc_4 = MessageId.STORAGE_FILTER_ITEM;
                    }
                    _loc_5 = MessageManager.getInstance().getMessage(_loc_4);
                    _loc_6 = _loc_3.getItemName();
                    CommonPopup.getInstance().openItemPopup(TextControl.formatIdText(MessageId.STORAGE_POPUP_COMPLETE, _loc_5), _loc_3.category, _loc_3.itemId, _loc_6, _loc_3.num, MessageManager.getInstance().getMessage(MessageId.STORAGE_POPUP_OK), null, this.cbClosePopup);
                }
                else
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.STORAGE_POPUP_ERROR_FULL), this.cbClosePopup, MessageManager.getInstance().getMessage(MessageId.STORAGE_POPUP_OK));
                }
                this.setList(this._currentFilter, this._displayMode, this._currentPage);
                this.buttonEnable(false);
            }
            if (param1.resultCode == NetId.RESULT_ERROR_WAREHOUSE_RECEIVE_INVALID_ITEM_DARA)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.TRADINGPOST_ITEM_ERROR), this.cbClosePopup);
            }
            return;
        }// end function

        private function cbItemReceiveAll(param1:NetResult) : void
        {
            var _loc_2:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                _loc_2 = param1.data.aWarehouseAcceptData;
                if (_loc_2.length > 0)
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.STORAGE_POPUP_COMPLETE_ALL, _loc_2.length), this.cbClosePopup, MessageManager.getInstance().getMessage(MessageId.STORAGE_POPUP_OK));
                }
                else
                {
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.STORAGE_POPUP_ERROR_FULL_ALL), this.cbClosePopup, MessageManager.getInstance().getMessage(MessageId.STORAGE_POPUP_OK));
                }
                this.setList(this._currentFilter, this._displayMode, this._currentPage);
            }
            if (param1.resultCode == NetId.RESULT_ERROR_WAREHOUSE_RECEIVE_INVALID_ITEM_DARA)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.TRADINGPOST_ITEM_ERROR), this.cbClosePopup);
            }
            return;
        }// end function

        private function setList(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = null;
            this._currentFilter = param1;
            this._displayMode = param2;
            this._currentPage = param3;
            this._aItemIdList = StorageManager.getInstance().getAllStorageItemId(this._currentFilter, this.getStorageKind(this._displayMode));
            this.resetPageNum(Math.ceil(this._aItemIdList.length / this._aStorageItemView.length), this._currentPage);
            if (this._aFilterButton)
            {
                for each (_loc_4 in this._aFilterButton)
                {
                    
                    _loc_4.setButtonState(this._currentFilter);
                }
            }
            this.updateListPage();
            return;
        }// end function

        private function cbChangeFilter(param1:int, param2:Boolean = true) : void
        {
            var _loc_3:* = param1;
            if (this._currentFilter == _loc_3 && param2)
            {
                _loc_3 = StorageConstant.ITEM_FILTER_NONE;
            }
            this.setList(_loc_3, this._displayMode, 0);
            return;
        }// end function

        private function cbChangeTab(param1:int, param2:int) : Boolean
        {
            this._displayMode = param2;
            this.setList(this._currentFilter, this._displayMode, 0);
            var _loc_3:* = "";
            switch(this._displayMode)
            {
                case this._DISPLAY_MODE_UNLIMITED_ITEM:
                case this._DISPLAY_MODE_LIMIT_ITEM:
                {
                    _loc_3 = MessageManager.getInstance().getMessage(MessageId.STORAGE_TITLE_NORMAL);
                    this.setEnableReceiptAllBtn(true);
                    break;
                }
                case this._DISPLAY_MODE_HISTORY:
                {
                    _loc_3 = MessageManager.getInstance().getMessage(MessageId.STORAGE_TITLE_HISTORY);
                    this.setEnableReceiptAllBtn(false);
                    break;
                }
                default:
                {
                    break;
                }
            }
            TextControl.setText(this._baseMc.numTextMc.textDt, _loc_3);
            return true;
        }// end function

        private function cbChangePage(param1:int, param2:int) : Boolean
        {
            switch(param2)
            {
                case PageButton.PAGE_BUTTON_ID_LEFT:
                case PageButton.PAGE_BUTTON_ID_LEFT_LEFT:
                case PageButton.PAGE_BUTTON_ID_LEFT_END:
                {
                    break;
                }
                case PageButton.PAGE_BUTTON_ID_RIGHT:
                case PageButton.PAGE_BUTTON_ID_RIGHT_RIGHT:
                case PageButton.PAGE_BUTTON_ID_RIGHT_END:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._currentPage = param1;
            this.updateListPage();
            return false;
        }// end function

        private function getStorageKind(param1:int) : int
        {
            switch(param1)
            {
                case this._DISPLAY_MODE_UNLIMITED_ITEM:
                {
                    return StorageConstant.STORAGE_KIND_UNLIMITED_ITEM;
                }
                case this._DISPLAY_MODE_LIMIT_ITEM:
                {
                    return StorageConstant.STORAGE_KIND_LIMIT_ITEM;
                }
                case this._DISPLAY_MODE_HISTORY:
                {
                    return StorageConstant.STORAGE_KIND_HISTORY;
                }
                default:
                {
                    break;
                }
            }
            return -1;
        }// end function

    }
}
