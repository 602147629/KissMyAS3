package network
{
    import item.*;
    import tradingPost.*;
    import user.*;

    public class NetTaskTradingWarriorIncrease extends NetTask
    {
        private var _planData:PaymentPlanData;

        public function NetTaskTradingWarriorIncrease(param1:PaymentPlanData, param2:Function)
        {
            super(NetId.PROTOCOL_TRADING_WARRIOR_INCREASE, param2);
            _param.planId = param1.planId;
            this._planData = param1;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                _loc_2 = UserDataManager.getInstance().userData;
                if (param1.data.crownData)
                {
                    _loc_2.setCrownTotal(param1.data.crownData);
                    Main.GetProcess().topBar.update();
                }
                if (this._planData.priceType == CommonConstant.TRADE_PRICE_TYPE_SILVER_INSIGNIA)
                {
                    _loc_2.setSilverInsignia(_loc_2.silverInsignia - this._planData.price * _param.num);
                }
                if (this._planData.priceType == CommonConstant.TRADE_PRICE_TYPE_GOLD_INSIGNIA)
                {
                    _loc_2.setGoldInsignia(_loc_2.goldInsignia - this._planData.price * _param.num);
                }
                if (this._planData.hasItem(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM__BED_INCREASE))
                {
                    _loc_2.bedIncrease = param1.data.warriorIncrease;
                }
                else
                {
                    _loc_2.warriorIncrease = param1.data.warriorIncrease;
                }
                return true;
            }
            if (param1.resultCode == NetId.RESULT_ERROR_TRADING_WARRIOR_INCREASE_OVER_SLOT)
            {
                return true;
            }
            return false;
        }// end function

    }
}
