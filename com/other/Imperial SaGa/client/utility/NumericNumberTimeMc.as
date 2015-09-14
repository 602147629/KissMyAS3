package utility
{
    import flash.display.*;
    import flash.geom.*;

    public class NumericNumberTimeMc extends Object
    {
        private var _DEF_MAX_DECIMAL:int = 8;
        private var _baseMc:MovieClip;
        private var _aNumMc:Array;
        private var _nowCount:int;
        private var _startCount:int;
        private var _endCount:int;
        private var _timeCount:Number;
        private var _updataTime:Number;
        private var _updataCount:int;
        private var _bZeroDisplay:Boolean;
        private var _bCountup:Boolean;
        private var _bLeftSide:Boolean;

        public function NumericNumberTimeMc(param1:MovieClip, param2:int, param3:Number, param4:Boolean = true, param5:Boolean = false)
        {
            this._baseMc = param1;
            this._startCount = param2;
            this._updataTime = param3;
            this._bZeroDisplay = param4;
            this._nowCount = -1;
            this._timeCount = 0;
            this._bCountup = false;
            this._bLeftSide = param5;
            this._aNumMc = [];
            this._init();
            this._setNumeric(param2);
            return;
        }// end function

        public function release() : void
        {
            this._baseMc = null;
            this._aNumMc = [];
            return;
        }// end function

        public function startCount(param1:int, param2:int) : void
        {
            this._startCount = this._nowCount;
            this._endCount = param1;
            this._bCountup = true;
            this._updataCount = param2;
            if (this._startCount > this._endCount)
            {
                this._updataCount = this._updataCount * -1;
            }
            return;
        }// end function

        public function setNum(param1:int) : void
        {
            this._setNumeric(param1);
            return;
        }// end function

        public function setTime(param1:uint) : void
        {
            var _loc_2:* = param1 % 60;
            var _loc_3:* = param1 / 60 % 60;
            var _loc_4:* = param1 / 60 / 60;
            var _loc_5:* = param1 / 60 / 60 * 10000 + _loc_3 * 100 + _loc_2;
            this._setNumeric(_loc_5);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = 0;
            if (!this._bCountup)
            {
                return;
            }
            this._timeCount = this._timeCount + param1;
            if (this._updataTime < this._timeCount)
            {
                _loc_2 = this._controlCount();
                this._setNumeric(_loc_2);
                this._timeCount = 0;
            }
            return;
        }// end function

        public function count(param1:Number) : void
        {
            this._timeCount = this._timeCount + param1;
            return;
        }// end function

        public function countTime() : void
        {
            var _loc_1:* = Math.floor(this._timeCount);
            this._endCount = this._endCount > _loc_1 ? (this._endCount - _loc_1) : (0);
            var _loc_2:* = Math.min(this._startCount, this._endCount);
            var _loc_3:* = _loc_2 % 60;
            var _loc_4:* = _loc_2 / 60 % 60;
            var _loc_5:* = _loc_2 / 60 / 60;
            var _loc_6:* = _loc_2 / 60 / 60 * 10000 + _loc_4 * 100 + _loc_3;
            this.setNum(_loc_6);
            this._timeCount = this._timeCount - _loc_1;
            return;
        }// end function

        public function get countEnd() : Boolean
        {
            return this._endCount == 0;
        }// end function

        public function get countEndBefore() : Boolean
        {
            return this._endCount == 1;
        }// end function

        public function get isCountEnd() : Boolean
        {
            return this._nowCount == this._endCount;
        }// end function

        public function get mc() : MovieClip
        {
            return this._baseMc;
        }// end function

        public function set visible(param1:Boolean) : void
        {
            if (this._baseMc != null)
            {
                this._baseMc.visible = param1;
            }
            return;
        }// end function

        public function get nowCount() : int
        {
            return this._nowCount;
        }// end function

        private function _init() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._DEF_MAX_DECIMAL)
            {
                
                _loc_2 = this._baseMc.getChildByName("n" + _loc_1.toString()) as MovieClip;
                if (_loc_2 == null)
                {
                    break;
                }
                this._aNumMc.push(_loc_2);
                _loc_1++;
            }
            return;
        }// end function

        private function _controlCount() : int
        {
            var _loc_1:* = this._nowCount;
            _loc_1 = _loc_1 + this._updataCount;
            if (this._updataCount > 0)
            {
                if (_loc_1 > this._endCount)
                {
                    _loc_1 = this._endCount;
                }
            }
            if (this._updataCount < 0)
            {
                if (_loc_1 < this._endCount)
                {
                    _loc_1 = this._endCount;
                }
            }
            return _loc_1;
        }// end function

        private function _setNumeric(param1:Number) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            param1 = Math.floor(param1);
            var _loc_2:* = 0;
            if (this._nowCount != param1)
            {
                this._nowCount = param1;
                _loc_3 = param1.toString().length;
                if (this._bLeftSide)
                {
                    _loc_3 = this._aNumMc.length - _loc_3;
                }
                _loc_2 = 0;
                while (_loc_2 < this._aNumMc.length)
                {
                    
                    if (_loc_2 < _loc_3 == this._bLeftSide)
                    {
                        MovieClip(this._aNumMc[_loc_2]).gotoAndStop(1);
                    }
                    else
                    {
                        _loc_4 = param1 % 10;
                        MovieClip(this._aNumMc[_loc_2]).gotoAndStop((_loc_4 + 1));
                        param1 = param1 / 10;
                    }
                    _loc_2++;
                }
                if (this._bZeroDisplay)
                {
                    _loc_2 = 0;
                    while (_loc_2 < this._aNumMc.length)
                    {
                        
                        if (_loc_3 >= 6)
                        {
                            MovieClip(this._aNumMc[_loc_2]).visible = _loc_2 < _loc_3 != this._bLeftSide;
                        }
                        else if (_loc_2 < 6)
                        {
                            MovieClip(this._aNumMc[_loc_2]).visible = true;
                        }
                        else
                        {
                            MovieClip(this._aNumMc[_loc_2]).visible = false;
                        }
                        _loc_2++;
                    }
                }
                else
                {
                    _loc_2 = 0;
                    while (_loc_2 < this._aNumMc.length)
                    {
                        
                        MovieClip(this._aNumMc[_loc_2]).visible = _loc_2 < _loc_3 != this._bLeftSide;
                        _loc_2++;
                    }
                }
            }
            return;
        }// end function

        public function setColor(param1:uint = 0) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = param1 != 0;
            var _loc_3:* = param1 >> 0 & 255;
            var _loc_4:* = param1 >> 8 & 255;
            var _loc_5:* = param1 >> 16 & 255;
            if (_loc_2)
            {
                _loc_6 = new ColorTransform(0, 0, 0, 1, _loc_5, _loc_4, _loc_3);
            }
            else
            {
                _loc_6 = new ColorTransform();
            }
            for each (_loc_7 in this._aNumMc)
            {
                
                _loc_7.transform.colorTransform = _loc_6;
            }
            return;
        }// end function

    }
}
