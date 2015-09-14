package tradingPost
{
    import asset.*;
    import flash.display.*;
    import message.*;
    import user.*;

    public class TradingPostPlanBuyPopup extends Object
    {
        protected var _parent:DisplayObjectContainer;
        protected var _plan:PaymentPlanData;
        private var _cbEnd:Function;
        public static const BUY_POPUP_RESULT_CLOSE:int = 0;
        public static const BUY_POPUP_RESULT_GOTO_PHASE_CROWN_UPDATE:int = 1;
        public static const BUY_POPUP_RESULT_GOTO_PHASE_PHASE_RE_OPEN:int = 2;
        public static const BUY_POPUP_RESULT_BUY_PURCHASE:int = 10;
        public static const BUY_POPUP_RESULT_BUY_WARRIOR_INCREASE:int = 11;
        public static const BUY_POPUP_RESULT_BUY_BED_INCREASE:int = 12;

        public function TradingPostPlanBuyPopup(param1:DisplayObjectContainer, param2:PaymentPlanData, param3:Function)
        {
            this._parent = param1;
            this._plan = param2;
            this._cbEnd = param3;
            return;
        }// end function

        public function release() : void
        {
            this._cbEnd = null;
            this._plan = null;
            this._parent = null;
            return;
        }// end function

        public function flowStart() : void
        {
            this.endClose();
            return;
        }// end function

        private function flowEnd(param1:int) : void
        {
            this._cbEnd(param1);
            this.release();
            return;
        }// end function

        protected function endClose() : void
        {
            this.flowEnd(BUY_POPUP_RESULT_CLOSE);
            return;
        }// end function

        protected function endCrownUpdate() : void
        {
            this.flowEnd(BUY_POPUP_RESULT_GOTO_PHASE_CROWN_UPDATE);
            return;
        }// end function

        protected function endReOpen() : void
        {
            this.flowEnd(BUY_POPUP_RESULT_GOTO_PHASE_PHASE_RE_OPEN);
            return;
        }// end function

        protected function endBuyPurchase() : void
        {
            this.flowEnd(BUY_POPUP_RESULT_BUY_PURCHASE);
            return;
        }// end function

        protected function endBuyWarriorIncrease() : void
        {
            this.flowEnd(BUY_POPUP_RESULT_BUY_WARRIOR_INCREASE);
            return;
        }// end function

        protected function endBuyBedIncrease() : void
        {
            this.flowEnd(BUY_POPUP_RESULT_BUY_BED_INCREASE);
            return;
        }// end function

        protected function checkPrice() : Boolean
        {
            return TradingPostPlanBuyPopup.checkPrice(this._plan, 1);
        }// end function

        protected function popupPriceNotEnough() : void
        {
            switch(this._plan.priceType)
            {
                case CommonConstant.TRADE_PRICE_TYPE_CROWN:
                {
                    this.popupCrownNotEnough();
                    break;
                }
                case CommonConstant.TRADE_PRICE_TYPE_SILVER_INSIGNIA:
                case CommonConstant.TRADE_PRICE_TYPE_GOLD_INSIGNIA:
                {
                    this.popupInsigniaNotEnough();
                    break;
                }
                default:
                {
                    this.endClose();
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function popupCrownNotEnough() : void
        {
            TradingPostPopupUtility.openYesNoPopup(this._parent, MessageManager.getInstance().getMessage(MessageId.CROWN_NOT_ENOUGH_TO_BUY), function (param1:Boolean) : void
            {
                if (param1)
                {
                    endCrownUpdate();
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

        private function popupInsigniaNotEnough() : void
        {
            TradingPostPopupUtility.openAlertPopup(this._parent, MessageManager.getInstance().getMessage(MessageId.TRADINGPOST_INSIGNIA_NOT_ENOUGH), this.endClose);
            return;
        }// end function

        protected function popupTimeOver() : void
        {
            TradingPostPopupUtility.openAlertPopup(this._parent, MessageManager.getInstance().getMessage(MessageId.TRADINGPOST_CONNECT_ERROR_BACK_HOME), this.endReOpen);
            return;
        }// end function

        protected function popupStockEmpty() : void
        {
            var _loc_1:* = MessageManager.getInstance().getMessage(MessageId.TRADINGPOST_STOCK_EMPTY);
            _loc_1 = _loc_1.replace("%d", this._plan.getName());
            TradingPostPopupUtility.openAlertPopup(this._parent, _loc_1, this.endClose);
            return;
        }// end function

        protected function popupWarriorIncreaseOver() : void
        {
            TradingPostPopupUtility.openAlertPopup(this._parent, MessageManager.getInstance().getMessage(MessageId.TRADINGPOST_ITEM_PURCHASE_WI_OVER), this.endClose);
            return;
        }// end function

        protected function popupBedIncreaseOver() : void
        {
            TradingPostPopupUtility.openAlertPopup(this._parent, MessageManager.getInstance().getMessage(MessageId.BARRACKS_ITEM_PURCHASE_BED_OVER), this.endClose);
            return;
        }// end function

        protected function popupItemMaxOver() : void
        {
            TradingPostPopupUtility.openAlertPopup(this._parent, TextControl.formatIdText(MessageId.TRADINGPOST_ITEM_MAX, this._plan.getName()), this.endClose);
            return;
        }// end function

        private static function getOwnItemMax(param1:int, param2:int) : int
        {
            var _loc_3:* = 0;
            switch(param1)
            {
                case CommonConstant.ITEM_KIND_CROWN:
                {
                    _loc_3 = CommonConstant.OWN_ITEM_MAX_CROWN;
                    break;
                }
                case CommonConstant.ITEM_KIND_ACCESSORIES:
                {
                    _loc_3 = CommonConstant.OWN_ITEM_MAX_ACCESSORIES;
                    break;
                }
                case CommonConstant.ITEM_KIND_PAYMENT_ITEM:
                {
                    _loc_3 = CommonConstant.OWN_ITEM_MAX_PAYMENT_ITEM;
                    break;
                }
                case CommonConstant.ITEM_KIND_DESTINY_STONE:
                {
                    _loc_3 = CommonConstant.OWN_ITEM_MAX_DESTINY_STONE;
                    break;
                }
                case CommonConstant.ITEM_KIND_WARRIOR:
                {
                    _loc_3 = UserDataManager.getInstance().getReserveMax() + UserDataManager.getInstance().userData.warriorIncrease;
                    break;
                }
                case CommonConstant.ITEM_KIND_ASSET:
                {
                    switch(param2)
                    {
                        case AssetId.ASSET_MAGIC_DEVELOP:
                        {
                            _loc_3 = CommonConstant.OWN_ITEM_MAX_MAGIC_LABO;
                            break;
                        }
                        case AssetId.ASSET_TRAINING:
                        {
                            _loc_3 = CommonConstant.OWN_ITEM_MAX_TRAINING;
                            break;
                        }
                        case AssetId.ASSET_GACHA_POINT:
                        {
                            _loc_3 = CommonConstant.OWN_ITEM_MAX_EMPLOYMENT;
                            break;
                        }
                        case AssetId.ASSET_FREE_HEALING:
                        {
                            _loc_3 = CommonConstant.FREE_HEALING_MAX_NUM;
                            break;
                        }
                        case AssetId.ASSET_GOLD_INSIGNIA:
                        {
                            _loc_3 = CommonConstant.OWN_ITEM_MAX_INSIGNIA;
                            break;
                        }
                        case AssetId.ASSET_SILVER_INSIGNIA:
                        {
                            _loc_3 = CommonConstant.OWN_ITEM_MAX_INSIGNIA;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        public static function getOwnItemCap(param1:int, param2:int) : int
        {
            var _loc_5:* = 0;
            var _loc_3:* = UserDataManager.getInstance().userData;
            var _loc_4:* = getOwnItemMax(param1, param2);
            switch(param1)
            {
                case CommonConstant.ITEM_KIND_CROWN:
                {
                    _loc_5 = _loc_3.getCrownTotal().total;
                    break;
                }
                case CommonConstant.ITEM_KIND_ACCESSORIES:
                {
                    _loc_5 = _loc_3.getEquipItemTotalNum();
                    break;
                }
                case CommonConstant.ITEM_KIND_PAYMENT_ITEM:
                {
                    _loc_5 = _loc_3.getOwnPaymentItemNum(param2);
                    break;
                }
                case CommonConstant.ITEM_KIND_DESTINY_STONE:
                {
                    _loc_5 = _loc_3.getOwnDestinyStoneNum(param2);
                    break;
                }
                case CommonConstant.ITEM_KIND_WARRIOR:
                {
                    _loc_5 = _loc_3.aPlayerPersonal.length;
                    break;
                }
                case CommonConstant.ITEM_KIND_ASSET:
                {
                    _loc_5 = _loc_3.getOwnAssetNum(param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_4 - _loc_5;
        }// end function

        public static function getMaxTradeNum(param1:PaymentPlanData) : int
        {
            var _loc_2:* = getOwnPriceNum(param1.priceType);
            var _loc_3:* = param1.price >= 0 ? (_loc_2 / param1.price) : (0);
            if (_loc_3 < 0)
            {
                _loc_3 = 0;
            }
            var _loc_4:* = getMaxTradeNum_OwnItemCap(param1);
            return getMaxTradeNum_OwnItemCap(param1) > _loc_3 ? (_loc_3) : (_loc_4);
        }// end function

        public static function getMaxTradeNum_OwnItemCap(param1:PaymentPlanData) : int
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_2:* = int.MAX_VALUE;
            for each (_loc_3 in param1.itemList)
            {
                
                _loc_4 = getCapMaxTradeNum(_loc_3.category, _loc_3.itemId, _loc_3.num);
                if (_loc_2 > _loc_4)
                {
                    _loc_2 = _loc_4;
                }
            }
            return _loc_2 == int.MAX_VALUE ? (0) : (_loc_2);
        }// end function

        private static function getCapMaxTradeNum(param1:int, param2:int, param3:int) : int
        {
            var _loc_4:* = getOwnItemCap(param1, param2);
            var _loc_5:* = param3 >= 0 ? (_loc_4 / param3) : (0);
            if ((param3 >= 0 ? (_loc_4 / param3) : (0)) < 0)
            {
                _loc_5 = 0;
            }
            return _loc_5;
        }// end function

        private static function getOwnPriceNum(param1:int) : int
        {
            var _loc_2:* = null;
            switch(param1)
            {
                case CommonConstant.TRADE_PRICE_TYPE_CROWN:
                {
                    _loc_2 = UserDataManager.getInstance().userData.getCrownTotal();
                    return _loc_2.total;
                }
                case CommonConstant.TRADE_PRICE_TYPE_SILVER_INSIGNIA:
                {
                    return UserDataManager.getInstance().userData.silverInsignia;
                }
                case CommonConstant.TRADE_PRICE_TYPE_GOLD_INSIGNIA:
                {
                    return UserDataManager.getInstance().userData.goldInsignia;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        public static function checkPrice(param1:PaymentPlanData, param2:int) : Boolean
        {
            var _loc_3:* = param1.price * param2;
            var _loc_4:* = getOwnPriceNum(param1.priceType);
            return getOwnPriceNum(param1.priceType) >= _loc_3;
        }// end function

    }
}
