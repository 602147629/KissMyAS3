package battle
{
    import flash.display.*;
    import utility.*;

    public class BattleComboCounter extends Object
    {
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _aNumMc:Array;
        private var _counter:NumericNumberMc;
        private var _counter2:NumericNumberMc;
        private var _count:int;

        public function BattleComboCounter(param1:MovieClip)
        {
            this._mc = param1;
            this._isoMain = new InStayOut(this._mc);
            this._counter = new NumericNumberMc(this._mc.renkeiNum, 0, 0, false);
            this._counter2 = new NumericNumberMc(this._mc.renkeiNum2, 0, 0, false);
            return;
        }// end function

        public function release() : void
        {
            if (this._counter)
            {
                this._counter.release();
            }
            this._counter = null;
            if (this._counter2)
            {
                this._counter2.release();
            }
            this._counter2 = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            this._mc = null;
            this._aNumMc = [];
            return;
        }// end function

        public function open(param1:int) : void
        {
            this._count = param1;
            this._counter.setNum(this._count);
            this._counter2.setNum(this._count);
            var _loc_2:* = "1";
            if (this._count >= 10)
            {
                _loc_2 = "2";
            }
            this._mc.renkeiNum.gotoAndStop(_loc_2);
            this._mc.renkeiNum2.gotoAndStop(_loc_2);
            this._isoMain.setIn();
            return;
        }// end function

        public function close() : void
        {
            if (this._isoMain.bOpened || this._isoMain.bAnimetionOpen)
            {
                this._isoMain.setOut();
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._counter)
            {
                this._counter.control(param1);
            }
            if (this._counter2)
            {
                this._counter2.control(param1);
            }
            return;
        }// end function

        private function setCounter() : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_1:* = [];
            var _loc_2:* = this._count;
            var _loc_3:* = 0;
            while (_loc_3 < 2)
            {
                
                _loc_4 = _loc_2 % 10;
                _loc_5 = this._aNumMc[_loc_3];
                _loc_6 = "in" + _loc_4;
                if (_loc_3 == 1 && _loc_4 == 0)
                {
                    _loc_6 = "end";
                }
                if (_loc_5.currentLabel != _loc_6)
                {
                    _loc_5.gotoAndPlay(_loc_6);
                }
                _loc_2 = _loc_2 / 10;
                _loc_3++;
            }
            return;
        }// end function

    }
}
