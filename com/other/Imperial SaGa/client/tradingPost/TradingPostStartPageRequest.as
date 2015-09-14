package tradingPost
{
    import item.*;
    import user.*;

    public class TradingPostStartPageRequest extends Object
    {
        private var _category:int;
        private var _itemId:int;
        private static var _instance:TradingPostStartPageRequest = null;

        public function TradingPostStartPageRequest()
        {
            this.clear();
            return;
        }// end function

        public function get category() : int
        {
            return this._category;
        }// end function

        public function get itemId() : int
        {
            return this._itemId;
        }// end function

        public function get bPageRequest() : Boolean
        {
            return this._category != Constant.EMPTY_ID && this._itemId != Constant.EMPTY_ID;
        }// end function

        public function clear() : void
        {
            this._category = Constant.EMPTY_ID;
            this._itemId = Constant.EMPTY_ID;
            return;
        }// end function

        private function setRequest(param1:int, param2:int) : void
        {
            this._category = param1;
            this._itemId = param2;
            return;
        }// end function

        public function setRequestBedIncrease() : void
        {
            this.setRequest(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM__BED_INCREASE);
            return;
        }// end function

        public function setRequestWarriorIncrease() : void
        {
            this.setRequest(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_WARRIOR_INCREASE);
            return;
        }// end function

        public function setRequestGrowthReset() : void
        {
            this.setRequest(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_GROWTH_RESET);
            return;
        }// end function

        public function setRequestInstantHealing() : void
        {
            this.setRequest(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_INSTANT_HEALING);
            return;
        }// end function

        public function setRequestInstantLearning() : void
        {
            this.setRequest(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_INSTANT_LEARNING);
            return;
        }// end function

        public function setRequestRevisionProbability() : void
        {
            this.setRequest(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_REVISION_PROBABILITY);
            return;
        }// end function

        public function setRequestQuestItem() : void
        {
            var _loc_1:* = UserDataManager.getInstance().userData;
            var _loc_2:* = _loc_1.getOwnPaymentItemNum(PaymentItemId.ITEM_GROWTH_RATE_UP);
            var _loc_3:* = _loc_1.getOwnPaymentItemNum(PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT);
            var _loc_4:* = _loc_1.getOwnPaymentItemNum(PaymentItemId.ITEM_DEFENCE_LP_DAMEAGE);
            if (_loc_1.getOwnPaymentItemNum(PaymentItemId.ITEM_DEFENCE_LP_DAMEAGE) <= 0 && _loc_3 > 0 && _loc_2 > 0)
            {
                this.setRequest(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_DEFENCE_LP_DAMEAGE);
            }
            else if (_loc_3 <= 0 && _loc_2 > 0)
            {
                this.setRequest(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT);
            }
            else
            {
                this.setRequest(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_GROWTH_RATE_UP);
            }
            return;
        }// end function

        public static function getInstance() : TradingPostStartPageRequest
        {
            if (_instance == null)
            {
                _instance = new TradingPostStartPageRequest;
            }
            return _instance;
        }// end function

    }
}
