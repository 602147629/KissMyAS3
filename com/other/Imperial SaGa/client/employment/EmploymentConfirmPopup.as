package employment
{
    import asset.*;
    import item.*;
    import message.*;
    import popup.*;
    import tutorial.*;
    import user.*;

    public class EmploymentConfirmPopup extends Object
    {
        private var _costType:int;
        private var _checkMsg:String;
        private var _totalPrice:int;
        private var _employmentNum:int;
        private var _bTutorial:Boolean;
        private var _cbEnd:Function;
        private var _result:int;
        private var _phase:int;
        public static const COST_TYPE_GACHA_POINT:int = 1;
        public static const COST_TYPE_CROWN:int = 2;
        public static const COST_TYPE_SPECIAL_TICKET:int = 3;
        public static const RESULT_NONE:int = 0;
        public static const RESULT_GOTO_TRADING_POST:int = 1;
        public static const RESULT_CROWN:int = 2;
        public static const RESULT_EMPLOYMENT:int = 3;
        private static const _PHASE_TUTORIAL_CHECK:int = 1;
        private static const _PHASE_NUM_CHECK:int = 2;
        private static const _PHASE_COST_CHECK:int = 3;
        private static const _PHASE_EMPLOYMENT_CHECK:int = 4;
        private static const _PHASE_CLOSE:int = 99;

        public function EmploymentConfirmPopup(param1:int, param2:String, param3:int, param4:int, param5:Boolean, param6:Function)
        {
            this._costType = param1;
            this._checkMsg = param2;
            this._totalPrice = param3;
            this._employmentNum = param4;
            this._bTutorial = param5;
            this._cbEnd = param6;
            this._result = RESULT_NONE;
            this.setPhase(_PHASE_TUTORIAL_CHECK);
            return;
        }// end function

        public function get result() : int
        {
            return this._result;
        }// end function

        public function release() : void
        {
            this._cbEnd = null;
            this._checkMsg = null;
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(param1)
                {
                    case _PHASE_TUTORIAL_CHECK:
                    {
                        this.phaseTutorialCheck();
                        break;
                    }
                    case _PHASE_NUM_CHECK:
                    {
                        this.phaseNumCheck();
                        break;
                    }
                    case _PHASE_COST_CHECK:
                    {
                        this.phaseCostCheck();
                        break;
                    }
                    case _PHASE_EMPLOYMENT_CHECK:
                    {
                        this.phaseEmploymentCheck();
                        break;
                    }
                    case _PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function phaseTutorialCheck() : void
        {
            if (this._bTutorial && TutorialManager.getInstance().isTutorial())
            {
                this._totalPrice = 0;
                this._result = RESULT_EMPLOYMENT;
                this.setPhase(_PHASE_CLOSE);
                return;
            }
            this.setPhase(_PHASE_NUM_CHECK);
            return;
        }// end function

        private function phaseNumCheck() : void
        {
            if (this._costType != COST_TYPE_CROWN && UserDataManager.getInstance().getCurrentPlayerCap() < this._employmentNum)
            {
                this.capacityNotEnohgh();
            }
            else
            {
                this.setPhase(_PHASE_COST_CHECK);
            }
            return;
        }// end function

        private function phaseCostCheck() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            switch(this._costType)
            {
                case COST_TYPE_GACHA_POINT:
                {
                    _loc_1 = UserDataManager.getInstance().userData.gachaResource;
                    if (_loc_1 < this._totalPrice)
                    {
                        CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, AssetListManager.getInstance().getAssetLackMessage(AssetId.ASSET_GACHA_POINT), this.cbToClose);
                    }
                    else
                    {
                        this.setPhase(_PHASE_EMPLOYMENT_CHECK);
                    }
                    break;
                }
                case COST_TYPE_CROWN:
                {
                    _loc_2 = UserDataManager.getInstance().userData.getCrownTotal();
                    if (_loc_2.total < this._totalPrice)
                    {
                        this.crownNotEnohgh();
                    }
                    else
                    {
                        this.setPhase(_PHASE_EMPLOYMENT_CHECK);
                    }
                    break;
                }
                case COST_TYPE_SPECIAL_TICKET:
                {
                    _loc_3 = UserDataManager.getInstance().userData.getOwnPaymentItemNum(PaymentItemId.ITEM_TICKET_GACHA_001);
                    if (_loc_3 < this._totalPrice)
                    {
                        CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.EMPLOYMENT_SPECIAL_TICKET_NOT_ENOUGH, ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_TICKET_GACHA_001)), this.cbToClose);
                    }
                    else
                    {
                        this.setPhase(_PHASE_EMPLOYMENT_CHECK);
                    }
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function phaseEmploymentCheck() : void
        {
            switch(this._costType)
            {
                case COST_TYPE_GACHA_POINT:
                {
                    CommonPopup.getInstance().openConsumePopup(CommonPopup.POPUP_TYPE_NORMAL, AssetId.ASSET_GACHA_POINT, this._checkMsg, this.cbEmploymentCheck);
                    break;
                }
                case COST_TYPE_CROWN:
                {
                    CommonPopup.getInstance().openPaymentPopup(CommonPopup.POPUP_TYPE_NORMAL, this._checkMsg, this.cbEmploymentCheck);
                    break;
                }
                case COST_TYPE_SPECIAL_TICKET:
                {
                    CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, this._checkMsg, this.cbEmploymentCheck);
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._cbEnd(this._result);
            return;
        }// end function

        private function crownNotEnohgh() : void
        {
            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CROWN_NOT_ENOUGH_TO_BUY), function (param1:Boolean) : void
            {
                if (param1)
                {
                    _result = RESULT_CROWN;
                }
                setPhase(_PHASE_CLOSE);
                return;
            }// end function
            );
            return;
        }// end function

        private function capacityNotEnohgh() : void
        {
            if (UserDataManager.getInstance().checkWarriorExtendable())
            {
                CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_COMFIRM_GOTO_TRADE), function (param1:Boolean) : void
            {
                if (param1)
                {
                    _result = RESULT_GOTO_TRADING_POST;
                }
                setPhase(_PHASE_CLOSE);
                return;
            }// end function
            );
            }
            else
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_COMFIRM_NOT_GOTO_TRADE), function () : void
            {
                setPhase(_PHASE_CLOSE);
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function cbToClose() : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbEmploymentCheck(param1:Boolean) : void
        {
            if (param1)
            {
                this._result = RESULT_EMPLOYMENT;
            }
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

    }
}
