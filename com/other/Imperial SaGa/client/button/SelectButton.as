package button
{
    import flash.display.*;

    public class SelectButton extends ButtonBase
    {
        private var _bSelect:Boolean;

        public function SelectButton(param1:MovieClip, param2:Function, param3:Function = null, param4:Function = null)
        {
            super(param1, param2, param3, param4);
            this._bSelect = false;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override public function setClick() : void
        {
            this.setSelect(this._bSelect == false);
            super.setClick();
            return;
        }// end function

        public function setSelect(param1:Boolean) : void
        {
            this._bSelect = param1;
            if (param1)
            {
                _mc.selectFrame.visible = true;
            }
            else
            {
                _mc.selectFrame.visible = false;
            }
            return;
        }// end function

        public function get bSelect() : Boolean
        {
            return this._bSelect;
        }// end function

    }
}
