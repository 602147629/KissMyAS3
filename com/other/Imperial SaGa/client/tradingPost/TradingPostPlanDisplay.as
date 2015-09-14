package tradingPost
{
    import flash.display.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class TradingPostPlanDisplay extends Object
    {
        private var _mcItem:MovieClip;
        private var _mcStock:MovieClip;
        private var _mcTime:MovieClip;
        private var _crownNumericPrice:NumericNumberMc;
        private var _crownNumericPrice2:NumericNumberMc;
        private var _goldNumericPrice:NumericNumberMc;
        private var _goldNumericPrice2:NumericNumberMc;
        private var _silverNumericPrice:NumericNumberMc;
        private var _silverNumericPrice2:NumericNumberMc;
        private var _stockNum:NumericNumberMc;

        public function TradingPostPlanDisplay(param1:MovieClip, param2:MovieClip, param3:MovieClip)
        {
            this._mcItem = param1;
            this._mcStock = param2;
            this._mcTime = param3;
            this._crownNumericPrice = new NumericNumberMc(this._mcItem.itemPriceMc, 0, 1, false);
            this._crownNumericPrice2 = new NumericNumberMc(this._mcItem.itemPrice2Mc, 0, 1, false);
            this._goldNumericPrice = new NumericNumberMc(this._mcItem.itemGoldPriceMc, 0, 1, false);
            this._goldNumericPrice2 = new NumericNumberMc(this._mcItem.itemGoldPrice2Mc, 0, 1, false);
            this._silverNumericPrice = new NumericNumberMc(this._mcItem.itemSilverPriceMc, 0, 1, false);
            this._silverNumericPrice2 = new NumericNumberMc(this._mcItem.itemSilverPrice2Mc, 0, 1, false);
            this._stockNum = new NumericNumberMc(this._mcStock.remainingSetNumMc, 0, 1, false);
            TextControl.setText(this._mcTime.textDt, "");
            return;
        }// end function

        public function get balloonAmbitNull() : MovieClip
        {
            return this._mcItem.BalloonAmbitNull;
        }// end function

        public function get balloonNull() : MovieClip
        {
            return this._mcItem.BalloonNull;
        }// end function

        public function release() : void
        {
            this._stockNum.release();
            this._stockNum = null;
            this._silverNumericPrice2.release();
            this._silverNumericPrice2 = null;
            this._silverNumericPrice.release();
            this._silverNumericPrice = null;
            this._goldNumericPrice2.release();
            this._goldNumericPrice2 = null;
            this._goldNumericPrice.release();
            this._goldNumericPrice = null;
            this._crownNumericPrice2.release();
            this._crownNumericPrice2 = null;
            this._crownNumericPrice.release();
            this._crownNumericPrice = null;
            this._mcTime = null;
            this._mcStock = null;
            this._mcItem = null;
            return;
        }// end function

        public function clear() : void
        {
            this._mcItem.visible = false;
            this._mcTime.visible = false;
            this._mcStock.visible = false;
            return;
        }// end function

        public function setPlanData(param1:PaymentPlanData) : void
        {
            TextControl.setText(this._mcItem.itemNameMc.textDt, param1.getName());
            this.setupSetNum(param1);
            this.clearPrice();
            switch(param1.priceType)
            {
                case CommonConstant.TRADE_PRICE_TYPE_CROWN:
                {
                    this.setupCrownPrice(param1.getPriceTypeName(), param1.price, false);
                    break;
                }
                case CommonConstant.TRADE_PRICE_TYPE_SILVER_INSIGNIA:
                {
                    this.setupSilverPrice(param1.getPriceTypeName(), param1.price, false);
                    break;
                }
                case CommonConstant.TRADE_PRICE_TYPE_GOLD_INSIGNIA:
                {
                    this.setupGoldPrice(param1.getPriceTypeName(), param1.price, false);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.setupEndTime(param1.endTime);
            this.setupStock(param1.stock);
            this.setupBitmap(param1.getFileName());
            this._mcItem.visible = true;
            return;
        }// end function

        private function setupSetNum(param1:PaymentPlanData) : void
        {
            this._mcItem.ItemKazuTextMc.visible = false;
            this._mcItem.numMc.visible = false;
            return;
        }// end function

        private function clearPrice() : void
        {
            this._crownNumericPrice.visible = false;
            this._crownNumericPrice2.visible = false;
            this._goldNumericPrice.visible = false;
            this._goldNumericPrice2.visible = false;
            this._silverNumericPrice.visible = false;
            this._silverNumericPrice2.visible = false;
            this._mcItem.itemPriceMc.visible = false;
            this._mcItem.itemPrice2Mc.visible = false;
            this._mcItem.itemGoldPriceMc.visible = false;
            this._mcItem.itemGoldPrice2Mc.visible = false;
            this._mcItem.itemSilverPriceMc.visible = false;
            this._mcItem.itemSilverPrice2Mc.visible = false;
            return;
        }// end function

        private function setupCrownPrice(param1:String, param2:int, param3:Boolean) : void
        {
            var _loc_4:* = param3 ? (this._crownNumericPrice2) : (this._crownNumericPrice);
            (param3 ? (this._crownNumericPrice2) : (this._crownNumericPrice)).visible = true;
            _loc_4.setNum(param2);
            var _loc_5:* = param3 ? (this._mcItem.itemPrice2Mc) : (this._mcItem.itemPriceMc);
            (param3 ? (this._mcItem.itemPrice2Mc) : (this._mcItem.itemPriceMc)).visible = true;
            TextControl.setText(_loc_5.textDt, param1);
            return;
        }// end function

        private function setupGoldPrice(param1:String, param2:int, param3:Boolean) : void
        {
            var _loc_4:* = param3 ? (this._goldNumericPrice2) : (this._goldNumericPrice);
            (param3 ? (this._goldNumericPrice2) : (this._goldNumericPrice)).visible = true;
            _loc_4.setNum(param2);
            var _loc_5:* = param3 ? (this._mcItem.itemGoldPrice2Mc) : (this._mcItem.itemGoldPriceMc);
            (param3 ? (this._mcItem.itemGoldPrice2Mc) : (this._mcItem.itemGoldPriceMc)).visible = true;
            TextControl.setText(_loc_5.textDt, param1);
            return;
        }// end function

        private function setupSilverPrice(param1:String, param2:int, param3:Boolean) : void
        {
            var _loc_4:* = param3 ? (this._silverNumericPrice2) : (this._silverNumericPrice);
            (param3 ? (this._silverNumericPrice2) : (this._silverNumericPrice)).visible = true;
            _loc_4.setNum(param2);
            var _loc_5:* = param3 ? (this._mcItem.itemSilverPrice2Mc) : (this._mcItem.itemSilverPriceMc);
            (param3 ? (this._mcItem.itemSilverPrice2Mc) : (this._mcItem.itemSilverPriceMc)).visible = true;
            TextControl.setText(_loc_5.textDt, param1);
            return;
        }// end function

        private function setupEndTime(param1:uint) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1 > 0)
            {
                this._mcTime.visible = true;
                _loc_2 = new Date();
                _loc_2.setTime(param1 * 1000);
                _loc_3 = TextControl.formatIdText(MessageId.TRADINGPOST_END_TIME, (_loc_2.getMonth() + 1), _loc_2.getDate());
                TextControl.setText(this._mcTime.textDt, _loc_3);
            }
            return;
        }// end function

        private function setupStock(param1:int) : void
        {
            if (param1 >= 0)
            {
                this._mcStock.visible = true;
                if (param1 > 0)
                {
                    this._stockNum.setNum(param1);
                    this._mcStock.gotoAndStop("set");
                }
                else
                {
                    this._mcStock.gotoAndPlay("soldOut");
                }
            }
            return;
        }// end function

        private function setupBitmap(param1:String) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = ResourceManager.getInstance().createBitmap(param1);
            if (_loc_2)
            {
                _loc_2.smoothing = true;
                _loc_2.scaleX = 0.8;
                _loc_2.scaleY = 0.8;
                _loc_2.x = _loc_2.x - _loc_2.width / 2;
                _loc_2.y = _loc_2.y - _loc_2.height / 2;
                _loc_3 = this._mcItem.itemNull as MovieClip;
                if (_loc_3.numChildren > 0)
                {
                    _loc_3.removeChildren(0, (_loc_3.numChildren - 1));
                }
                _loc_3.addChild(_loc_2);
            }
            return;
        }// end function

    }
}
