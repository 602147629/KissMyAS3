package tradingPost
{
    import resource.*;

    public class TradingPostData extends Object
    {
        private var _aPaymentPlan:Array;

        public function TradingPostData()
        {
            this._aPaymentPlan = [];
            return;
        }// end function

        public function get aPaymentPlan() : Array
        {
            return this._aPaymentPlan;
        }// end function

        public function setRecieve(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._aPaymentPlan = [];
            for each (_loc_2 in param1.aPaymentPlan)
            {
                
                _loc_3 = new PaymentPlanData();
                _loc_3.setRecieve(_loc_2);
                if (_loc_3.tab == PaymentPlanData.TAB_SPECIAL && _loc_3.checkEndTimeOver())
                {
                    continue;
                }
                if (_loc_3.checkEnable())
                {
                    this._aPaymentPlan.push(_loc_3);
                }
            }
            return;
        }// end function

        public function loadResource() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aPaymentPlan)
            {
                
                ResourceManager.getInstance().loadResource(_loc_1.getFileName());
            }
            return;
        }// end function

        public function paymentPlanStockDown(param1:int, param2:int) : void
        {
            var _loc_3:* = null;
            for each (_loc_3 in this._aPaymentPlan)
            {
                
                if (param1 == _loc_3.planId && _loc_3.stock > 0)
                {
                    _loc_3.stockDown(param2);
                }
            }
            return;
        }// end function

        public function checkTabItemList(param1:int) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aPaymentPlan)
            {
                
                if (param1 == _loc_2.tab)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function checkTabItemStock(param1:int) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aPaymentPlan)
            {
                
                if (param1 == _loc_2.tab && (_loc_2.stock == Constant.UNDECIDED || _loc_2.stock > 0))
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function getTabItemList(param1:int) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this._aPaymentPlan)
            {
                
                if (param1 == _loc_3.tab)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public function getTabPageMax(param1:int) : int
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            for each (_loc_3 in this._aPaymentPlan)
            {
                
                if (param1 == _loc_3.tab && _loc_3.page > _loc_2)
                {
                    _loc_2 = _loc_3.page;
                }
            }
            return _loc_2;
        }// end function

        public function searchTab(param1:int, param2:int) : int
        {
            var _loc_4:* = null;
            var _loc_3:* = Constant.UNDECIDED;
            for each (_loc_4 in this._aPaymentPlan)
            {
                
                if (_loc_4.hasItem(param1, param2))
                {
                    if (_loc_4.tab == PaymentPlanData.TAB_NORMAL)
                    {
                        _loc_3 = _loc_4.tab;
                        break;
                        continue;
                    }
                    if (_loc_4.tab == PaymentPlanData.TAB_SPECIAL)
                    {
                        if (_loc_3 == Constant.UNDECIDED)
                        {
                            _loc_3 = _loc_4.tab;
                        }
                        continue;
                    }
                    _loc_3 = _loc_4.tab;
                }
            }
            if (_loc_3 == Constant.UNDECIDED)
            {
                _loc_3 = PaymentPlanData.TAB_NORMAL;
            }
            return _loc_3;
        }// end function

    }
}
