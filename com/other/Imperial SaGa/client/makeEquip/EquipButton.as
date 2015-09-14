package makeEquip
{
    import button.*;
    import flash.display.*;
    import sound.*;

    public class EquipButton extends ButtonBase
    {
        protected var _bSpecialDisable:Boolean = false;

        public function EquipButton(param1:MovieClip, param2:Function, param3:Function = null, param4:Function = null)
        {
            super(param1, param2, param3, param4);
            return;
        }// end function

        public function set specialDisable(param1:Boolean) : void
        {
            this._bSpecialDisable = param1;
            return;
        }// end function

        public function get speciallyDisaled() : Boolean
        {
            return this._bSpecialDisable;
        }// end function

        public function setSpecialDisable(param1:Boolean) : void
        {
            if (param1)
            {
                if (_mc)
                {
                    _mc.gotoAndStop(_LABEL_DISABLE);
                }
                this._bSpecialDisable = true;
            }
            else
            {
                _mc.gotoAndStop(_LABEL_MOUSE_OUT);
                this._bSpecialDisable = false;
            }
            return;
        }// end function

        override public function setMouseOver() : void
        {
            if (this._bSpecialDisable)
            {
                if (_bMouseOver == false)
                {
                    if (_overSeId != Constant.UNDECIDED)
                    {
                        SoundManager.getInstance().playSe(_overSeId);
                    }
                    if (_cbOverFunc != null)
                    {
                        _cbOverFunc(_id);
                    }
                }
                _bMouseOver = true;
            }
            else
            {
                if (_bMouseOver == false && _bDisable == false)
                {
                    if (_overSeId != Constant.UNDECIDED)
                    {
                        SoundManager.getInstance().playSe(_overSeId);
                    }
                    if (_mc)
                    {
                        _mc.gotoAndStop(_LABEL_MOUSE_OVER);
                    }
                    if (_cbOverFunc != null)
                    {
                        _cbOverFunc(_id);
                    }
                }
                _bMouseOver = true;
            }
            return;
        }// end function

        override public function setMouseOut() : void
        {
            if (this._bSpecialDisable)
            {
                if (_bMouseOver == true)
                {
                    if (_cbOutFunc != null)
                    {
                        _cbOutFunc(_id);
                    }
                }
                _bMouseOver = false;
            }
            else
            {
                if (_bMouseOver == true && _bDisable == false)
                {
                    if (_mc)
                    {
                        _mc.gotoAndStop(_LABEL_MOUSE_OUT);
                    }
                    if (_cbOutFunc != null)
                    {
                        _cbOutFunc(_id);
                    }
                }
                _bMouseOver = false;
            }
            return;
        }// end function

        override public function setClick() : void
        {
            if (this._bSpecialDisable)
            {
                return;
            }
            if (_mc)
            {
                _mc.gotoAndStop(_LABEL_CLICK);
            }
            if (_enterSeId != Constant.UNDECIDED)
            {
                SoundManager.getInstance().playSe(_enterSeId);
            }
            if (_cbClickFunc != null)
            {
                _cbClickFunc(_id);
            }
            return;
        }// end function

        override public function unseal(param1:Boolean = false) : void
        {
            if (_sealCount > 0)
            {
                var _loc_3:* = _sealCount - 1;
                _sealCount = _loc_3;
                if (param1)
                {
                    var _loc_3:* = _sealLabelChangeCount - 1;
                    _sealLabelChangeCount = _loc_3;
                }
            }
            return;
        }// end function

        override public function setDisable(param1:Boolean) : void
        {
            if (param1)
            {
                if (_mc)
                {
                    _bDisable = true;
                }
                seal(true);
            }
            else
            {
                if (_mc)
                {
                    _bDisable = false;
                }
                seal(true);
            }
            _bMouseOver = false;
            return;
        }// end function

    }
}
