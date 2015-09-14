package storage
{
    import button.*;
    import flash.display.*;
    import item.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class StorageItemView extends Object
    {
        private var _baseMc:MovieClip;
        private var _viewMc:MovieClip;
        private var _isoMc:InStayOut;
        private var _buttonBase:ButtonBase;
        private var _uniqueId:int;
        private var _itemIcon:Bitmap;

        public function StorageItemView(param1:MovieClip, param2:Function)
        {
            this._baseMc = param1;
            this._viewMc = this._baseMc.storageItemMc;
            this._buttonBase = ButtonManager.getInstance().addButton(this._viewMc, param2);
            this._buttonBase.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._uniqueId = Constant.UNDECIDED;
            TextControl.setIdText(this._viewMc.title1Mc.textDt, MessageId.STORAGE_ITEM_GET_DATE);
            TextControl.setIdText(this._viewMc.title2Mc.textDt, MessageId.STORAGE_ITEM_RECEIVE_LIMIT);
            this._isoMc = new InStayOut(this._baseMc, true);
            return;
        }// end function

        public function get uniqueId() : int
        {
            return this._uniqueId;
        }// end function

        public function set uniqueId(param1:int) : void
        {
            this._uniqueId = param1;
            this._buttonBase.setId(param1);
            this.updateVisible();
            this.updateDisplay();
            return;
        }// end function

        public function release() : void
        {
            if (this._isoMc)
            {
                this._isoMc.release();
            }
            this._isoMc = null;
            if (this._buttonBase)
            {
                ButtonManager.getInstance().removeButton(this._buttonBase);
                this._buttonBase.release();
            }
            this._buttonBase = null;
            this._viewMc = null;
            this._baseMc = null;
            return;
        }// end function

        private function loadResource() : void
        {
            if (this.uniqueId == Constant.UNDECIDED)
            {
                return;
            }
            return;
        }// end function

        private function updateVisible() : void
        {
            if (this.uniqueId == Constant.UNDECIDED)
            {
                if (this._isoMc.bClosed == false && this._isoMc.bAnimetionClose == false)
                {
                    this._isoMc.setOut();
                }
            }
            else if (this._isoMc.bOpened == false && this._isoMc.bAnimetionOpen == false)
            {
                this._isoMc.setIn();
            }
            this.setButtonEnable(true);
            return;
        }// end function

        private function updateDisplay() : void
        {
            if (this.uniqueId == Constant.UNDECIDED)
            {
                TextControl.setText(this._viewMc.itemNameMc.textDt, "");
                TextControl.setText(this._viewMc.captionMc.textDt, "");
                TextControl.setText(this._viewMc.itemNumMc.textDt, "");
                TextControl.setText(this._viewMc.title1Mc.textDt, "");
                TextControl.setText(this._viewMc.title2Mc.textDt, "");
                TextControl.setText(this._viewMc.date1Mc.textDt, "");
                TextControl.setText(this._viewMc.date2Mc.textDt, "");
                return;
            }
            var _loc_1:* = StorageManager.getInstance().getStorageItem(this.uniqueId);
            TextControl.setText(this._viewMc.itemNameMc.textDt, _loc_1.getItemName());
            TextControl.setText(this._viewMc.itemNumMc.textDt, "x" + _loc_1.num);
            this._viewMc.itemNumMc.visible = _loc_1.category != CommonConstant.ITEM_KIND_CROWN && _loc_1.category != CommonConstant.ITEM_KIND_WARRIOR;
            if (_loc_1.reasonText != "")
            {
                TextControl.setText(this._viewMc.captionMc.textDt, _loc_1.reasonText);
            }
            else if (_loc_1.howtoGetId == Constant.UNDECIDED)
            {
                TextControl.setText(this._viewMc.captionMc.textDt, ItemManager.getInstance().getItemInformation(_loc_1.itemId).explanation);
            }
            else
            {
                TextControl.setText(this._viewMc.captionMc.textDt, StorageManager.getInstance().getHowtoGetText(_loc_1.howtoGetId));
            }
            if (this._itemIcon)
            {
                if (this._itemIcon.parent)
                {
                    this._itemIcon.parent.removeChild(this._itemIcon);
                }
                this._itemIcon = null;
            }
            this._itemIcon = ResourceManager.getInstance().createBitmap(ItemManager.getInstance().getItemPng(_loc_1.category, _loc_1.itemId));
            this._itemIcon.x = this._viewMc.itemNull.x - 24;
            this._itemIcon.y = this._viewMc.itemNull.y - 24;
            this._itemIcon.scaleX = 48 / this._itemIcon.width;
            this._itemIcon.scaleY = 48 / this._itemIcon.height;
            this._itemIcon.smoothing = true;
            this._viewMc.addChildAt(this._itemIcon, this._viewMc.getChildIndex(this._viewMc.itemNumMc));
            if (_loc_1.getTime != 0)
            {
                TextControl.setText(this._viewMc.date1Mc.textDt, _loc_1.getTimeString);
            }
            if (_loc_1.expiredTime != 0 && _loc_1.expiredTime != CommonConstant.UNLIMITED_DATETIME_EPOCH_TIME)
            {
                TextControl.setText(this._viewMc.date2Mc.textDt, _loc_1.expiredTimeString);
            }
            else
            {
                TextControl.setIdText(this._viewMc.date2Mc.textDt, MessageId.STORAGE_ITEM_RECEIVE_NOLIMIT);
            }
            if (_loc_1.acceptTime != 0)
            {
                this._viewMc.date2Mc.visible = false;
                TextControl.setText(this._viewMc.date1Mc.textDt, _loc_1.acceptTimeString);
                TextControl.setIdText(this._viewMc.title1Mc.textDt, MessageId.STORAGE_ITEM_RECEIVE_DATE);
                TextControl.setText(this._viewMc.title2Mc.textDt, "");
            }
            else
            {
                this._viewMc.date2Mc.visible = true;
                TextControl.setIdText(this._viewMc.title1Mc.textDt, MessageId.STORAGE_ITEM_GET_DATE);
                TextControl.setIdText(this._viewMc.title2Mc.textDt, MessageId.STORAGE_ITEM_RECEIVE_LIMIT);
            }
            return;
        }// end function

        public function setButtonEnable(param1:Boolean) : void
        {
            this._buttonBase.setDisable(!param1 || this.uniqueId == Constant.UNDECIDED);
            return;
        }// end function

    }
}
