package button
{
    import flash.display.*;
    import message.*;

    public class SortAscendButton extends ButtonBase
    {
        private var _bAscend:Boolean;

        public function SortAscendButton(param1:MovieClip, param2:Function, param3:Function = null, param4:Function = null)
        {
            super(param1, param2, param3, param4);
            this.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._bAscend = false;
            this.setBtnText();
            return;
        }// end function

        public function get bAscend() : Boolean
        {
            return this._bAscend;
        }// end function

        override public function setClick() : void
        {
            this._bAscend = this._bAscend == false;
            this.setBtnText();
            super.setClick();
            return;
        }// end function

        private function setBtnText() : void
        {
            if (this._bAscend)
            {
                TextControl.setIdText(_mc.textMc.textDt, MessageId.PLAYER_LIST_SORT_UPPER_BUTTON);
            }
            else
            {
                TextControl.setIdText(_mc.textMc.textDt, MessageId.PLAYER_LIST_SORT_LOWER_BUTTON);
            }
            return;
        }// end function

    }
}
