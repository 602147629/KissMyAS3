package barracks
{
    import asset.*;
    import flash.display.*;
    import item.*;
    import message.*;
    import status.*;
    import user.*;

    public class BarracksHealingBox extends UserResourceBox
    {
        private var _setuped:int;
        private var _fix_mode:int;
        private var _fix_num:int;
        public static const SETUP_ICON_AUTO:int = 0;
        public static const SETUP_ICON_FREE:int = 1;
        public static const SETUP_ICON_CHARGE:int = 2;

        public function BarracksHealingBox(param1:MovieClip, param2:DisplayObjectContainer = null)
        {
            this._setuped = Constant.UNDECIDED;
            this._fix_mode = SETUP_ICON_AUTO;
            this._fix_num = Constant.UNDECIDED;
            super(param1, Constant.EMPTY_ID, param2);
            return;
        }// end function

        public function get setupedMode() : int
        {
            return this._setuped;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override public function updateNum() : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_1:* = UserDataManager.getInstance().userData;
            var _loc_2:* = _loc_1.freeHealingNum;
            var _loc_3:* = _loc_1.getOwnPaymentItemNum(PaymentItemId.ITEM_INSTANT_HEALING);
            var _loc_4:* = Constant.UNDECIDED;
            if (this._fix_mode == SETUP_ICON_AUTO)
            {
                _loc_4 = _loc_2 > 0 ? (SETUP_ICON_FREE) : (SETUP_ICON_CHARGE);
            }
            else
            {
                _loc_4 = this._fix_mode;
            }
            if (this._setuped != _loc_4)
            {
                deleteStatus();
                deleteIcon();
                this._setuped = _loc_4;
                if (_loc_4 == SETUP_ICON_FREE)
                {
                    _loc_6 = AssetListManager.getInstance().getAssetPng(AssetId.ASSET_FREE_HEALING);
                    _loc_9 = AssetListManager.getInstance().getAssetInfomation(AssetId.ASSET_FREE_HEALING);
                    _loc_7 = _loc_9.name;
                    _loc_8 = _loc_9.description;
                }
                else
                {
                    _loc_6 = ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_INSTANT_HEALING);
                    _loc_10 = ItemManager.getInstance().getPaymentItemInformation(PaymentItemId.ITEM_INSTANT_HEALING);
                    _loc_7 = _loc_10.name;
                    _loc_8 = _loc_10.description;
                }
                createIcon(_loc_6);
                createStatus(_loc_7, _loc_8);
                _mcBase.FreeIcon.visible = _loc_4 == SETUP_ICON_FREE;
            }
            if (this._fix_num == Constant.UNDECIDED)
            {
                _loc_5 = this._setuped == SETUP_ICON_FREE ? (_loc_2) : (_loc_3);
            }
            else
            {
                _loc_5 = this._fix_num;
            }
            TextControl.setText(_mcBase.NumTextMc.textDt, _loc_5.toString());
            return;
        }// end function

        public function setMode(param1:int, param2:int = -1) : void
        {
            this._fix_mode = param1;
            this._fix_num = param2;
            this.updateNum();
            return;
        }// end function

    }
}
