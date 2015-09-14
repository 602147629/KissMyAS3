package status
{
    import flash.display.*;
    import item.*;
    import message.*;
    import network.*;
    import player.*;
    import popup.*;
    import user.*;

    public class GrowsResetConfirmPopup extends Object
    {
        private var _parent:DisplayObjectContainer;
        private var _personal:PlayerPersonal;
        private var _cbResetReceive:Function;
        private var _cbEnd:Function;
        private var _result:int;
        private var _phase:int;
        public static const RESULT_NONE:int = 0;
        public static const RESULT_GOTO_TRADING_POST:int = 1;
        public static const RESULT_RESET:int = 2;
        private static const _PHASE_RESET_CHECK:int = 1;
        private static const _PHASE_ITEM_CHECK:int = 2;
        private static const _PHASE_CONFIRM_RESET:int = 3;
        private static const _PHASE_RESET_EFFECT:int = 4;
        private static const _PHASE_CLOSE:int = 99;

        public function GrowsResetConfirmPopup(param1:DisplayObjectContainer, param2:PlayerPersonal, param3:Function, param4:Function)
        {
            this._parent = param1;
            this._personal = param2;
            this._cbResetReceive = param3;
            this._cbEnd = param4;
            this._result = RESULT_NONE;
            this.setPhase(_PHASE_RESET_CHECK);
            return;
        }// end function

        public function get result() : int
        {
            return this._result;
        }// end function

        public function release() : void
        {
            this._cbEnd = null;
            this._cbResetReceive = null;
            this._personal = null;
            this._parent = null;
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(param1)
                {
                    case _PHASE_RESET_CHECK:
                    {
                        this.phaseResetCheck();
                        break;
                    }
                    case _PHASE_ITEM_CHECK:
                    {
                        this.phaseItemCheck();
                        break;
                    }
                    case _PHASE_CONFIRM_RESET:
                    {
                        this.phaseConfirmReset();
                        break;
                    }
                    case _PHASE_RESET_EFFECT:
                    {
                        this.phaseResetEffect();
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

        private function phaseResetCheck() : void
        {
            this.setPhase(_PHASE_ITEM_CHECK);
            return;
        }// end function

        private function phaseItemCheck() : void
        {
            var itemNum:* = UserDataManager.getInstance().userData.getOwnPaymentItemNum(PaymentItemId.ITEM_GROWTH_RESET);
            if (itemNum <= 0)
            {
                CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.PLAYER_DETAIL_GROWTH_RESET_NOT_ENOUGH, ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_GROWTH_RESET)), function (param1:Boolean) : void
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
                this.setPhase(_PHASE_CONFIRM_RESET);
            }
            return;
        }// end function

        private function phaseConfirmReset() : void
        {
            var info:* = PlayerManager.getInstance().getPlayerInformation(this._personal.playerId);
            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.PLAYER_DETAIL_GROWTH_RESET_NOTICE, ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_GROWTH_RESET), info.name), function (param1:Boolean) : void
            {
                if (param1)
                {
                    NetManager.getInstance().request(new NetTaskGrowthReset(_personal.uniqueId, cbReceive));
                }
                else
                {
                    setPhase(_PHASE_CLOSE);
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function phaseResetEffect() : void
        {
            var info:* = PlayerManager.getInstance().getPlayerInformation(this._personal.playerId);
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.PLAYER_DETAIL_GROWTH_RESET_RESULT, info.name), function () : void
            {
                setPhase(_PHASE_CLOSE);
                return;
            }// end function
            );
            return;
        }// end function

        private function phaseClose() : void
        {
            this._cbEnd(this._result);
            return;
        }// end function

        private function cbReceive(param1:NetResult) : void
        {
            this._result = RESULT_RESET;
            if (this._cbResetReceive != null)
            {
                this._cbResetReceive(param1);
            }
            this.setPhase(_PHASE_RESET_EFFECT);
            return;
        }// end function

    }
}
