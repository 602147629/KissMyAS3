package network
{
    import tradingPost.*;
    import user.*;

    public class NetTaskTradingPurchase extends NetTask
    {
        private var _planData:PaymentPlanData;

        public function NetTaskTradingPurchase(param1:PaymentPlanData, param2:int, param3:Function)
        {
            super(NetId.PROTOCOL_TRADING_PURCHASE, param3);
            _param.planId = param1.planId;
            _param.num = param2;
            this._planData = param1;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                param1.data.num = _param.num;
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
                if (param1.data.getItemInfo)
                {
                    UserDataManager.getInstance().userData.setGetItemInfo(param1.data.getItemInfo);
                }
                return true;
            }
            if (param1.resultCode == NetId.RESULT_ERROR_TRADING_PURCHASE_EXPIRED || param1.resultCode == NetId.RESULT_ERROR_TRADING_PURCHASE_STOCK_OUT || param1.resultCode == NetId.RESULT_ERROR_TRADING_PURCHASE_LACK_CROWN)
            {
                return true;
            }
            return false;
        }// end function

    }
}
