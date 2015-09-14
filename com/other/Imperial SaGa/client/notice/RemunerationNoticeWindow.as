package notice
{
    import message.*;
    import popup.*;

    public class RemunerationNoticeWindow extends Object
    {
        private var _noticeType:int;
        private var _aRemuneration:Array;
        private var _cbClose:Function;
        private var _index:int;
        private var _bWarehouse:Boolean;
        private var _bEnd:Boolean;

        public function RemunerationNoticeWindow(param1:int, param2:Array, param3:Function)
        {
            this._noticeType = param1;
            this._aRemuneration = param2;
            this._cbClose = param3;
            this._index = 0;
            this._bWarehouse = false;
            this._bEnd = false;
            this.openCheck();
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            this._cbClose = null;
            this._aRemuneration = null;
            return;
        }// end function

        private function openCheck() : void
        {
            if (this._index < this._aRemuneration.length)
            {
                this.openPopup(this._aRemuneration[this._index]);
            }
            else if (this._bWarehouse)
            {
                this._bWarehouse = false;
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CONFIRM_SEND_STRAGE), this.openCheck);
            }
            else
            {
                this._bEnd = true;
                if (this._cbClose != null)
                {
                    this._cbClose();
                }
            }
            return;
        }// end function

        private function openPopup(param1:RemunerationNoticeData) : void
        {
            if (param1.bWarehouse)
            {
                this._bWarehouse = true;
            }
            var _loc_2:* = MessageId.NOTICE_ITEM_GET;
            if (param1.noticeType == CommonConstant.NOTICE_PAYMENT_EVENT)
            {
                _loc_2 = MessageId.NOTICE_PAYMENT_EVENT_GET_REWARD;
            }
            CommonPopup.getInstance().openItemPopup(MessageManager.getInstance().getMessage(_loc_2), param1.category, param1.itemId, null, param1.num, MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_NEXT), null, this.cbPopup);
            return;
        }// end function

        private function cbPopup() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._index + 1;
            _loc_1._index = _loc_2;
            this.openCheck();
            return;
        }// end function

    }
}
