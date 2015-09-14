package quest
{
    import button.*;
    import flash.display.*;
    import icon.*;
    import input.*;
    import layer.*;
    import message.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class QuestResultRewardSClearPopup extends PopupBase
    {
        private var _mcBase:MovieClip;
        private var _mcItemBase:MovieClip;
        private var _aReward:Array;
        private var _idx:int;
        private var _btnClose:ButtonBase;
        private var _naviCharaBmp:Bitmap;
        private var _bitmapItem:Bitmap;
        private var _isoWindow:InStayOut;
        private var _bBusy:Boolean;
        private var _itemIcon:RewardDescriptionIcon;

        public function QuestResultRewardSClearPopup(param1:MovieClip, param2:LayerQuest)
        {
            _popupSeId = SoundId.SE_REV_RESULT_SRANK;
            this._mcBase = param1;
            this._mcItemBase = param1.rewardBox;
            this._idx = 0;
            this._isoWindow = new InStayOut(this._mcBase.rewardBox);
            this._bBusy = false;
            this._btnClose = ButtonManager.getInstance().addButton(this._mcBase.okBtnMc, this.cbBtn);
            this._btnClose.setDisable(true);
            this._btnClose.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcBase.okBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CONFIRM);
            this._mcItemBase.itemNumTextMc.visible = false;
            this._itemIcon = new RewardDescriptionIcon(this._mcBase.rewardBox, Constant.EMPTY_ID, Constant.EMPTY_ID, 0, InputManager.INPUT_GROUP_CONFIG);
            this._itemIcon.setMouseOverEnable(true);
            return;
        }// end function

        public function isBusy() : Boolean
        {
            return this._bBusy;
        }// end function

        public function isEmpty() : Boolean
        {
            return this._idx >= this._aReward.length;
        }// end function

        override public function release() : void
        {
            ButtonManager.getInstance().removeButton(this._btnClose);
            if (this._bitmapItem && this._bitmapItem.parent)
            {
                this._bitmapItem.parent.removeChild(this._bitmapItem);
                this._bitmapItem = null;
            }
            if (this._naviCharaBmp && this._naviCharaBmp.parent)
            {
                this._naviCharaBmp.parent.removeChild(this._naviCharaBmp);
                this._naviCharaBmp = null;
            }
            if (this._itemIcon)
            {
                this._itemIcon.release();
            }
            this._itemIcon = null;
            if (this._isoWindow)
            {
                this._isoWindow.release();
            }
            this._isoWindow = null;
            this._mcBase = null;
            super.release();
            return;
        }// end function

        public function nextItem() : void
        {
            if (this._bBusy || this.isEmpty())
            {
                return;
            }
            this._bBusy = true;
            this._isoWindow.setOut(this.cbWindowOut);
            return;
        }// end function

        private function cbWindowOut() : void
        {
            if (this._mcBase == null)
            {
                return;
            }
            this.setupItem();
            return;
        }// end function

        private function setupItem() : void
        {
            var _loc_1:* = null;
            if (this._idx < this._aReward.length)
            {
                _loc_1 = this._aReward[this._idx];
                this._itemIcon.setItem(_loc_1.categoryId, _loc_1.itemId, _loc_1.num);
                var _loc_2:* = this;
                var _loc_3:* = this._idx + 1;
                _loc_2._idx = _loc_3;
            }
            else
            {
                this._itemIcon.setItem(Constant.EMPTY_ID, Constant.EMPTY_ID, 0);
                this.setNaviInfoText("");
            }
            this._isoWindow.setIn(this.cbWindowIn);
            return;
        }// end function

        private function cbWindowIn() : void
        {
            if (this._mcBase == null)
            {
                return;
            }
            this._bBusy = false;
            return;
        }// end function

        public function openPopupReward(param1:Function, param2:String, param3:Array, param4:Boolean = false, param5:DisplayObjectContainer = null) : void
        {
            this._aReward = param3 == null ? ([]) : (param3);
            this._naviCharaBmp = this.createNaviCharaBmp();
            this.setNaviBitmap(this._naviCharaBmp);
            this.setNaviInfoText(param2);
            this.setupItem();
            super.openPopup(param5, this._mcBase, param1, [this._btnClose], param4);
            return;
        }// end function

        public function setNaviBitmap(param1:Bitmap) : void
        {
            var _loc_2:* = null;
            this._naviCharaBmp = param1;
            if (this._mcBase.naviCharaMc.naviCharaNull)
            {
                _loc_2 = this._mcBase.naviCharaMc.naviCharaNull;
                if (_loc_2.numChildren > 0)
                {
                    _loc_2.removeChildren(0, (_loc_2.numChildren - 1));
                }
                _loc_2.addChild(param1);
            }
            return;
        }// end function

        public function setNaviInfoText(param1:String) : void
        {
            if (param1 == null)
            {
                param1 = "";
            }
            if (this._mcItemBase.infoTextMc)
            {
                TextControl.setText(this._mcItemBase.infoTextMc.textDt, param1);
            }
            return;
        }// end function

        private function createNaviCharaBmp() : Bitmap
        {
            var _loc_1:* = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
            if (_loc_1)
            {
                _loc_1.smoothing = true;
                _loc_1.x = -_loc_1.width / 2;
                _loc_1.y = -_loc_1.height;
            }
            return _loc_1;
        }// end function

        override protected function btnEnable(param1:Boolean) : void
        {
            super.btnEnable(param1);
            this._btnClose.setDisable(!param1);
            return;
        }// end function

        override protected function cbBtn(param1:int) : void
        {
            if (this.isEmpty())
            {
                return super.cbBtn(param1);
            }
            this.nextItem();
            return;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.NAVI_CHARACTER_PATH;
        }// end function

        public static function getSoundResource() : Array
        {
            var _loc_1:* = [SoundId.SE_REV_RESULT_SRANK];
            return _loc_1;
        }// end function

    }
}
