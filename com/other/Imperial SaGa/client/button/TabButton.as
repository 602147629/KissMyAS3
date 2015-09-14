package button
{

    public class TabButton extends ButtonBase
    {
        private var _bVisible:Boolean;
        private var _aBtn:Array;
        private var _lastHitIdx:int;

        public function TabButton()
        {
            super(null, null);
            _bHitPixel = true;
            this._bVisible = true;
            this._aBtn = [];
            this._lastHitIdx = Constant.UNDECIDED;
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aBtn)
            {
                
                _loc_1.release();
            }
            this._aBtn = null;
            super.release();
            return;
        }// end function

        public function addBtn(param1:ButtonBase) : void
        {
            param1.bHitPixel = _bHitPixel;
            param1.setVisible(this._bVisible);
            this._aBtn.push(param1);
            return;
        }// end function

        public function sortBtn(param1:Array) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._aBtn.length)
            {
                
                this._aBtn[_loc_2] = param1[_loc_2];
                _loc_2++;
            }
            return;
        }// end function

        override public function set bHitPixel(param1:Boolean) : void
        {
            var _loc_2:* = null;
            _bHitPixel = param1;
            for each (_loc_2 in this._aBtn)
            {
                
                _loc_2.bHitPixel = param1;
            }
            return;
        }// end function

        override public function isHit(param1:Number, param2:Number) : Boolean
        {
            var _loc_4:* = null;
            this._lastHitIdx = Constant.UNDECIDED;
            var _loc_3:* = this._aBtn.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4 = this._aBtn[_loc_3];
                if (_loc_4.isHit(param1, param2))
                {
                    if (_loc_4.isEnable())
                    {
                        this._lastHitIdx = _loc_3;
                        return true;
                    }
                    break;
                }
                _loc_3 = _loc_3 - 1;
            }
            return false;
        }// end function

        override public function setClick() : void
        {
            var _loc_1:* = this._aBtn[this._lastHitIdx];
            if (_loc_1)
            {
                _loc_1.setClick();
            }
            return;
        }// end function

        override public function setMouseOver() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (_bDisable == false)
            {
                _loc_1 = this._aBtn.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_2 = this._aBtn[_loc_1];
                    if (_loc_1 == this._lastHitIdx)
                    {
                        _loc_2.setMouseOver();
                    }
                    else
                    {
                        _loc_2.setMouseOut();
                    }
                    _loc_1 = _loc_1 - 1;
                }
            }
            _bMouseOver = true;
            return;
        }// end function

        override public function setMouseOut() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (_bDisable == false)
            {
                _loc_1 = this._aBtn.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_2 = this._aBtn[_loc_1];
                    _loc_2.setMouseOut();
                    _loc_1 = _loc_1 - 1;
                }
            }
            _bMouseOver = false;
            return;
        }// end function

        override public function setMouseDown() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (_bDisable == false)
            {
                _loc_1 = this._aBtn.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_2 = this._aBtn[_loc_1];
                    _loc_2.setMouseDown();
                    _loc_1 = _loc_1 - 1;
                }
            }
            return;
        }// end function

        override public function setMouseUp() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (_bDisable == false)
            {
                _loc_1 = this._aBtn.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_2 = this._aBtn[_loc_1];
                    _loc_2.setMouseUp();
                    _loc_1 = _loc_1 - 1;
                }
            }
            return;
        }// end function

        override public function setDisable(param1:Boolean) : void
        {
            var _loc_3:* = null;
            super.setDisable(param1);
            var _loc_2:* = this._aBtn.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aBtn[_loc_2];
                _loc_3.setDisable(param1);
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        override public function setVisible(param1:Boolean) : void
        {
            super.setVisible(param1);
            this._bVisible = param1;
            return;
        }// end function

    }
}
