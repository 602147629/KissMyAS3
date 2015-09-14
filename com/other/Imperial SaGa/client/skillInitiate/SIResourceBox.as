package skillInitiate
{
    import flash.display.*;
    import item.*;
    import message.*;
    import status.*;
    import user.*;

    public class SIResourceBox extends UserResourceBox
    {

        public function SIResourceBox(param1:MovieClip)
        {
            super(param1, Constant.EMPTY_ID);
            createIcon(ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_REVISION_PROBABILITY));
            var _loc_2:* = ItemManager.getInstance().getPaymentItemInformation(PaymentItemId.ITEM_REVISION_PROBABILITY);
            createStatus(_loc_2.name, _loc_2.description);
            return;
        }// end function

        override public function updateNum() : void
        {
            var _loc_1:* = UserDataManager.getInstance().userData.getOwnPaymentItemNum(PaymentItemId.ITEM_REVISION_PROBABILITY);
            TextControl.setText(_mcBase.NumTextMc.textDt, _loc_1.toString());
            return;
        }// end function

    }
}
