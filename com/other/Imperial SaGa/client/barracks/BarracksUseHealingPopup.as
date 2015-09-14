package barracks
{
    import asset.*;
    import item.*;
    import message.*;
    import popup.*;

    public class BarracksUseHealingPopup extends Object
    {
        private var _cbEnd:Function;
        public static const POPUP_RESULT_CLOSE:int = 0;
        public static const POPUP_RESULT_GOTO_TRADING_POST:int = 1;
        public static const POPUP_RESULT_USE_FREE_HEALING:int = 2;
        public static const POPUP_RESULT_USE_INSTANT_HEALING:int = 3;

        public function BarracksUseHealingPopup(param1:int, param2:int, param3:Boolean, param4:Function)
        {
            var instantRestoreItemNum:* = param1;
            var freeHealingNum:* = param2;
            var bFreeEnable:* = param3;
            var cbEnd:* = param4;
            this._cbEnd = cbEnd;
            if (freeHealingNum >= 1 && bFreeEnable)
            {
                CommonPopup.getInstance().openPaymentPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.BARRACKS_POPUP_MESSAGE_RECOVER_USE, ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_FREE_HEALING), freeHealingNum), function (param1:Boolean) : void
            {
                if (param1)
                {
                    endUseFreeHealing();
                }
                else
                {
                    endClose();
                }
                return;
            }// end function
            );
            }
            else if (instantRestoreItemNum >= 1)
            {
                CommonPopup.getInstance().openPaymentPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.BARRACKS_POPUP_MESSAGE_RECOVER_USE, ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_INSTANT_HEALING), instantRestoreItemNum), function (param1:Boolean) : void
            {
                if (param1)
                {
                    endUseInstantHealing();
                }
                else
                {
                    endClose();
                }
                return;
            }// end function
            );
            }
            else
            {
                CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.BARRACKS_POPUP_MESSAGE_RECOVER_NOT_ENOUGH), function (param1:Boolean) : void
            {
                if (param1)
                {
                    endGotoTradingPost();
                }
                else
                {
                    endClose();
                }
                return;
            }// end function
            , MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_PURCHASE), MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_QUIT));
            }
            return;
        }// end function

        public function release() : void
        {
            this._cbEnd = null;
            return;
        }// end function

        private function flowEnd(param1:int) : void
        {
            this._cbEnd(param1);
            this.release();
            return;
        }// end function

        private function endClose() : void
        {
            this.flowEnd(POPUP_RESULT_CLOSE);
            return;
        }// end function

        private function endGotoTradingPost() : void
        {
            this.flowEnd(POPUP_RESULT_GOTO_TRADING_POST);
            return;
        }// end function

        private function endUseFreeHealing() : void
        {
            this.flowEnd(POPUP_RESULT_USE_FREE_HEALING);
            return;
        }// end function

        private function endUseInstantHealing() : void
        {
            this.flowEnd(POPUP_RESULT_USE_INSTANT_HEALING);
            return;
        }// end function

    }
}
