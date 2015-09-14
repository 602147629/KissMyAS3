package popup
{
    import button.*;
    import flash.display.*;

    public class CommonPopupReel extends Object
    {
        private var _mcBase:MovieClip;
        private var _aBtn:Array;
        private var _mcNum1:MovieClip;
        private var _mcNum2:MovieClip;
        private var _num:int;
        private var _max:int;

        public function CommonPopupReel(param1:MovieClip, param2:int, param3:int)
        {
            var _loc_4:* = null;
            this._mcBase = param1;
            this._aBtn = [];
            this._aBtn.push(ButtonManager.getInstance().addButton(this._mcBase.numUpBtn1Mc, this.cbClickBtn, 0));
            this._aBtn.push(ButtonManager.getInstance().addButton(this._mcBase.numUpBtn2Mc, this.cbClickBtn, 1));
            this._aBtn.push(ButtonManager.getInstance().addButton(this._mcBase.numDownBtn1Mc, this.cbClickBtn, 2));
            this._aBtn.push(ButtonManager.getInstance().addButton(this._mcBase.numDownBtn2Mc, this.cbClickBtn, 3));
            for each (_loc_4 in this._aBtn)
            {
                
                _loc_4.enterSeId = ButtonBase.SE_CURSOR_ID;
            }
            this._mcNum1 = this._mcBase.itemNum1Mc;
            this._mcNum2 = this._mcBase.itemNum2Mc;
            this._num = param2;
            this._max = Math.max(1, param3);
            this._mcNum1.gotoAndStop((this.num + 1));
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function get max() : int
        {
            return this._max;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
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
            switch(param1)
            {
                case 0:
                {
                    var _loc_4:* = this;
                    var _loc_5:* = this._num + 1;
                    _loc_4._num = _loc_5;
                    if (this._num > this._max)
                    {
                        this._num = this._max;
                    }
                    break;
                }
                case 1:
                {
                    this._num = this._num + 10;
                    if (this._num > this._max)
                    {
                        this._num = this._max;
                    }
                    break;
                }
                case 2:
                {
                    var _loc_4:* = this;
                    var _loc_5:* = this._num - 1;
                    _loc_4._num = _loc_5;
                    if (this._num < 1)
                    {
                        this._num = 1;
                    }
                    break;
                }
                case 3:
                {
                    this._num = this._num - 10;
                    if (this._num < 1)
                    {
                        this._num = 1;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_2:* = this._num / 10;
            var _loc_3:* = this._num % 10;
            this._mcNum2.gotoAndStop((_loc_2 + 1));
            this._mcNum1.gotoAndStop((_loc_3 + 1));
            return;
        }// end function

    }
}
