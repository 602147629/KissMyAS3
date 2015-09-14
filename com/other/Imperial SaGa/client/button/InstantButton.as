package button
{
    import flash.display.*;
    import item.*;
    import message.*;
    import utility.*;

    public class InstantButton extends Object
    {
        private var _btnMc:MovieClip;
        private var _btnInstant:ButtonBase;
        private var _bDisable:Boolean;
        private var _endTime:uint;
        private var _bEnableTime:Boolean;

        public function InstantButton(param1:MovieClip, param2:int, param3:Function)
        {
            this._btnMc = param1;
            this._btnInstant = ButtonManager.getInstance().addButton(this._btnMc, param3);
            this._btnInstant.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._btnMc.textMc.textDt, param2);
            TextControl.setText(this._btnMc.textMc.numDt, "");
            this._bDisable = false;
            this._endTime = 0;
            this.updateBtn();
            return;
        }// end function

        public function getBtn() : ButtonBase
        {
            return this._btnInstant;
        }// end function

        public function get bEnableTime() : Boolean
        {
            return this._bEnableTime;
        }// end function

        public function release() : void
        {
            ButtonManager.getInstance().removeButton(this._btnInstant);
            this._btnInstant = null;
            this._btnMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            this.updateEnableTime();
            return;
        }// end function

        public function setCrown(param1:int) : void
        {
            TextControl.setText(this._btnMc.textMc.numDt, param1 + MessageManager.getInstance().getMessage(MessageId.COMMON_MONEY));
            return;
        }// end function

        public function setLearning(param1:int) : void
        {
            var _loc_2:* = ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_INSTANT_LEARNING);
            TextControl.setText(this._btnMc.textMc.numDt, _loc_2 + " " + param1 + MessageManager.getInstance().getMessage(MessageId.COMMON_UNIT_PIECES));
            return;
        }// end function

        public function setEndTime(param1:uint) : void
        {
            this._endTime = param1;
            this.updateEnableTime();
            return;
        }// end function

        public function setDisable(param1:Boolean) : void
        {
            if (this._bDisable != param1)
            {
                this._bDisable = param1;
                this.updateBtn();
            }
            return;
        }// end function

        private function updateEnableTime() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = false;
            if (this._endTime)
            {
                _loc_2 = TimeClock.getNowTime();
                _loc_1 = _loc_2 + Constant.INSTANT_MARGIN_SEC < this._endTime;
            }
            if (this._bEnableTime != _loc_1)
            {
                this._bEnableTime = _loc_1;
                this.updateBtn();
            }
            return;
        }// end function

        private function updateBtn() : void
        {
            this._btnInstant.setDisable(this._bDisable || !this._bEnableTime);
            return;
        }// end function

    }
}
