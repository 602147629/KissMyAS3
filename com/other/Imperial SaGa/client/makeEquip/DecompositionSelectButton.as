package makeEquip
{
    import button.*;
    import flash.display.*;
    import sound.*;

    public class DecompositionSelectButton extends ButtonBase
    {
        public var selected:Boolean = false;
        public var _selectedItemsButton:Array;
        public var _bLimitRiched:Boolean = false;

        public function DecompositionSelectButton(param1:MovieClip, param2:Array, param3:Function, param4:Function = null, param5:Function = null)
        {
            super(param1, param3, param4, param5);
            this._selectedItemsButton = param2;
            _mc.ItemOn.visible = false;
            this.selected = _mc.ItemOn.visible;
            return;
        }// end function

        public function set limitbutton(param1:Boolean) : void
        {
            this._bLimitRiched = param1;
            return;
        }// end function

        public function get limitedButton() : Boolean
        {
            return this._bLimitRiched;
        }// end function

        public function setHighlighted(param1:Boolean) : void
        {
            if (param1)
            {
                _mc.ItemOn.visible = true;
            }
            else
            {
                _mc.ItemOn.visible = false;
            }
            return;
        }// end function

        override public function setClick() : void
        {
            if (_mc.ItemOn.visible == true)
            {
                if (_mc)
                {
                    _mc.ItemOn.visible = false;
                }
                if (_enterSeId != Constant.UNDECIDED)
                {
                    SoundManager.getInstance().playSe(_enterSeId);
                }
                if (_cbClickFunc != null)
                {
                    _cbClickFunc(_id);
                }
            }
            else if (this._selectedItemsButton.length < 10)
            {
                if (_mc)
                {
                    _mc.ItemOn.visible = true;
                }
                if (_enterSeId != Constant.UNDECIDED)
                {
                    SoundManager.getInstance().playSe(_enterSeId);
                }
                if (_cbClickFunc != null)
                {
                    _cbClickFunc(_id);
                }
            }
            else
            {
                return;
            }
            if (this._bLimitRiched)
            {
                if (_enterSeId != Constant.UNDECIDED)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_CANCEL);
                }
            }
            return;
        }// end function

    }
}
