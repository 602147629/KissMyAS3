package utility
{
    import button.*;
    import flash.display.*;

    public class ReelCounter extends Object
    {
        private const _MAX_NUMBER:int = 5;
        private var _mcBase:MovieClip;
        private var _aBtn:Array;
        private var _num:int;
        private var _max:int;
        private var _min:int;
        private var _aMcUpButton:Array;
        private var _aMcDownButton:Array;
        private var _aMcNumber:Array;
        private var _column:int;

        public function ReelCounter(param1:MovieClip, param2:int, param3:int, param4:int = 0)
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            this._mcBase = param1;
            this._aMcUpButton = [];
            this._aMcDownButton = [];
            this._aMcNumber = [];
            this._column = 0;
            var _loc_5:* = 1;
            while (_loc_5 <= this._MAX_NUMBER)
            {
                
                _loc_8 = this._mcBase.getChildByName("numUpBtn" + _loc_5 + "Mc") as MovieClip;
                if (_loc_8 == null)
                {
                    break;
                }
                this._aMcUpButton.push(_loc_8);
                _loc_9 = this._mcBase.getChildByName("numDownBtn" + _loc_5 + "Mc") as MovieClip;
                if (_loc_9 == null)
                {
                    break;
                }
                this._aMcDownButton.push(_loc_9);
                _loc_10 = this._mcBase.getChildByName("itemNum" + _loc_5 + "Mc") as MovieClip;
                if (_loc_10 == null)
                {
                    break;
                }
                this._aMcNumber.push(_loc_10);
                this._column = _loc_5;
                _loc_5++;
            }
            if (this._aMcNumber.length != this._aMcUpButton.length || this._aMcNumber.length != this._aMcDownButton.length)
            {
                Assert.print("数値入力リールのMovieClip数が違います");
                return;
            }
            this._aBtn = [];
            var _loc_6:* = 0;
            while (_loc_6 < this._column)
            {
                
                this._aBtn.push(ButtonManager.getInstance().addButton(this._aMcUpButton[_loc_6], this.cbClickBtn, 10 * _loc_6));
                this._aBtn.push(ButtonManager.getInstance().addButton(this._aMcDownButton[_loc_6], this.cbClickBtn, 10 * _loc_6 + 1));
                _loc_6++;
            }
            for each (_loc_7 in this._aBtn)
            {
                
                _loc_7.enterSeId = ButtonBase.SE_CURSOR_ID;
            }
            this._num = param2;
            this._max = Math.max(1, param3);
            this._min = param4;
            this.updateNumber();
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            this._aMcDownButton = [];
            this._aMcUpButton = [];
            this._aMcNumber = [];
            for each (_loc_1 in this._aBtn)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aBtn = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        private function cbClickBtn(param1:int) : void
        {
            var _loc_2:* = param1 / 10;
            var _loc_3:* = param1 % 10 != 0;
            var _loc_4:* = _loc_2 * 10;
            if (_loc_2 * 10 == 0)
            {
                _loc_4 = 1;
            }
            if (_loc_3)
            {
                _loc_4 = _loc_4 * -1;
            }
            this._num = this._num + _loc_4;
            if (this._num < this._min)
            {
                this._num = this._min;
            }
            if (this._num > this._max)
            {
                this._num = this._max;
            }
            this.updateNumber();
            return;
        }// end function

        public function numMax() : void
        {
            this._num = this._max;
            this.updateNumber();
            return;
        }// end function

        public function numMin() : void
        {
            this._num = this._min;
            this.updateNumber();
            return;
        }// end function

        private function updateNumber() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_1:* = this._num;
            var _loc_2:* = 0;
            while (_loc_2 < this._column)
            {
                
                _loc_3 = this._aMcNumber[_loc_2];
                _loc_4 = _loc_1 % 10;
                _loc_3.gotoAndStop((_loc_4 + 1));
                _loc_1 = _loc_1 / 10;
                _loc_2++;
            }
            if (this._num <= this._min)
            {
                this._aBtn[1].setDisable(true);
                this._aBtn[3].setDisable(true);
            }
            else
            {
                this._aBtn[1].setDisable(false);
                this._aBtn[3].setDisable(false);
            }
            if (this._num >= this._max)
            {
                this._aBtn[0].setDisable(true);
                this._aBtn[2].setDisable(true);
            }
            else
            {
                this._aBtn[0].setDisable(false);
                this._aBtn[2].setDisable(false);
            }
            return;
        }// end function

        public function setDisable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            if (param1)
            {
                for each (_loc_2 in this._aBtn)
                {
                    
                    _loc_2.setDisable(true);
                }
            }
            else
            {
                this.updateNumber();
            }
            return;
        }// end function

    }
}
