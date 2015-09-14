package tradingPost
{
    import flash.display.*;
    import item.*;
    import message.*;
    import user.*;
    import utility.*;

    public class TradingPostPaymentPlanBuyPopup extends TradingPostPlanBuyPopup
    {

        public function TradingPostPaymentPlanBuyPopup(param1:DisplayObjectContainer, param2:PaymentPlanData, param3:Function)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override public function flowStart() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (checkPrice() == false)
            {
                popupPriceNotEnough();
                return;
            }
            if (_plan.stock == 0)
            {
                popupStockEmpty();
                return;
            }
            if (_plan.endTime > 0 && _plan.endTime < TimeClock.getNowTime())
            {
                popupTimeOver();
                return;
            }
            if (_plan.hasItem(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_WARRIOR_INCREASE))
            {
                _loc_1 = _plan.getItem(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_WARRIOR_INCREASE);
                _loc_2 = CommonConstant.TRADING_POST_ADD_WARRIOR_COUNT * _loc_1.num;
                if (UserDataManager.getInstance().userData.warriorIncrease + _loc_2 <= CommonConstant.TRADING_POST_ADD_WARRIOR_MAX)
                {
                    this.popupBuyWarriorIncrease();
                }
                else
                {
                    popupWarriorIncreaseOver();
                }
            }
            else if (_plan.hasItem(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM__BED_INCREASE))
            {
                _loc_1 = _plan.getItem(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM__BED_INCREASE);
                _loc_2 = CommonConstant.BARRACKS_ADD_BED_COUNT * _loc_1.num;
                if (CommonConstant.BARRACKS_BED_INIT_NUM + UserDataManager.getInstance().userData.bedIncrease + _loc_2 <= CommonConstant.BARRACKS_BED_MAX_NUM)
                {
                    this.popupBuyBedIncrease();
                }
                else
                {
                    popupBedIncreaseOver();
                }
            }
            else
            {
                _loc_3 = getMaxTradeNum_OwnItemCap(_plan);
                if (_loc_3 > 0)
                {
                    this.popupBuyOther();
                }
                else
                {
                    popupItemMaxOver();
                }
            }
            return;
        }// end function

        private function popupBuyWarriorIncrease() : void
        {
            var planItem:* = _plan.getItem(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_WARRIOR_INCREASE);
            var addNum:* = CommonConstant.TRADING_POST_ADD_WARRIOR_COUNT * planItem.num;
            TradingPostPopupUtility.openPaymentPopup(_parent, TextControl.formatIdText(MessageId.TRADINGPOST_ITEM_PURCHASE_CONFIRM_WI, _plan.getName(), addNum, _plan.price), function (param1:Boolean) : void
            {
                if (param1)
                {
                    if (checkPrice() == false)
                    {
                        popupPriceNotEnough();
                    }
                    else
                    {
                        endBuyWarriorIncrease();
                    }
                }
                else
                {
                    endClose();
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function popupBuyBedIncrease() : void
        {
            var planItem:* = _plan.getItem(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM__BED_INCREASE);
            var addNum:* = CommonConstant.BARRACKS_ADD_BED_COUNT * planItem.num;
            TradingPostPopupUtility.openPaymentPopup(_parent, TextControl.formatIdText(MessageId.BARRACKS_ITEM_PURCHASE_CONFIRM_BED, _plan.getName(), addNum, _plan.price), function (param1:Boolean) : void
            {
                if (param1)
                {
                    if (checkPrice() == false)
                    {
                        popupPriceNotEnough();
                    }
                    else
                    {
                        endBuyBedIncrease();
                    }
                }
                else
                {
                    endClose();
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function popupBuyOther() : void
        {
            var _loc_1:* = "";
            if (_plan.priceType == CommonConstant.TRADE_PRICE_TYPE_CROWN)
            {
                _loc_1 = TextControl.formatIdText(MessageId.TRADINGPOST_ITEM_PURCHASE_CONFIRM, _plan.getName(), 1, _plan.price);
                TradingPostPopupUtility.openPaymentPopup(_parent, _loc_1, this.cbPopupBuyOther);
            }
            else
            {
                _loc_1 = TextControl.formatIdText(MessageId.TRADINGPOST_ITEM_TRADEINSIGNIA_CONFIRM, _plan.getName(), 1, _plan.getPriceTypeName(), _plan.price);
                TradingPostPopupUtility.openYesNoPopup(_parent, _loc_1, this.cbPopupBuyOther);
            }
            return;
        }// end function

        private function cbPopupBuyOther(param1:Boolean) : void
        {
            if (param1)
            {
                if (checkPrice() == false)
                {
                    popupPriceNotEnough();
                }
                else
                {
                    endBuyPurchase();
                }
            }
            else
            {
                endClose();
            }
            return;
        }// end function

    }
}
