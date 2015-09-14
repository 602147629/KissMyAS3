package utility
{
    import flash.display.*;

    public class WinLoseAnimBox extends Object
    {
        private var _bInit:Boolean = false;
        private var _aWinAnimationNo:Array;
        private var _aLoseAnimationNo:Array;

        public function WinLoseAnimBox(param1:MovieClip)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._bInit = false;
            this._aWinAnimationNo = [];
            this._aLoseAnimationNo = [];
            if (param1)
            {
                _loc_2 = param1.currentLabels;
                for each (_loc_3 in _loc_2)
                {
                    
                    if (_loc_3.name.lastIndexOf("_win") != -1)
                    {
                        this._aWinAnimationNo.push(_loc_3.frame);
                        continue;
                    }
                    this._aLoseAnimationNo.push(_loc_3.frame);
                }
                this._bInit = true;
            }
            return;
        }// end function

        public function get numWinAnimation() : int
        {
            return this._aWinAnimationNo.length;
        }// end function

        public function get numLoseAnimation() : int
        {
            return this._aLoseAnimationNo.length;
        }// end function

        public function release() : void
        {
            this._aLoseAnimationNo = null;
            this._aWinAnimationNo = null;
            return;
        }// end function

        public function getWinAnimationNo(param1:int) : int
        {
            if (param1 < 0 && param1 >= this._aWinAnimationNo.length)
            {
                param1 = 0;
            }
            return this._aWinAnimationNo[param1];
        }// end function

        public function getLoseAnimationNo(param1:int) : int
        {
            if (param1 < 0 && param1 >= this._aLoseAnimationNo.length)
            {
                param1 = 0;
            }
            return this._aLoseAnimationNo[param1];
        }// end function

        private function reset() : void
        {
            this._bInit = false;
            return;
        }// end function

        public function lot(param1:int, param2:int) : Array
        {
            var _loc_3:* = 0;
            var _loc_7:* = 0;
            var _loc_9:* = 0;
            var _loc_4:* = new Array(param1);
            var _loc_5:* = [];
            var _loc_6:* = [];
            _loc_3 = 0;
            while (_loc_3 < this.numLoseAnimation)
            {
                
                _loc_6.push(this.getLoseAnimationNo(_loc_3));
                _loc_3++;
            }
            var _loc_8:* = _loc_6.length;
            _loc_3 = 0;
            while (_loc_3 < _loc_4.length)
            {
                
                if (_loc_8 > 1)
                {
                    _loc_9 = Random.range(0, (_loc_8 - 1));
                    _loc_4[_loc_3] = _loc_6[_loc_9];
                    _loc_6.splice(_loc_9, 1);
                    _loc_6.push(_loc_4[_loc_3]);
                    _loc_8 = _loc_8 - 1;
                }
                else
                {
                    _loc_4[_loc_3] = _loc_6[0];
                    _loc_6.splice(0, 1);
                    _loc_6.push(_loc_4[_loc_3]);
                    _loc_8 = _loc_6.length;
                }
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < this.numWinAnimation)
            {
                
                _loc_5.push(this.getWinAnimationNo(_loc_3));
                _loc_3++;
            }
            _loc_7 = _loc_5[Random.range(0, (_loc_5.length - 1))];
            _loc_4[param2] = _loc_7;
            return _loc_4;
        }// end function

    }
}
