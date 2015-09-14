package effect
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import utility.*;

    public class EffectBatibati extends Object
    {
        private const _ADVANCE_WAIT_TIME:Number = 0.001;
        private const _COUNT_MAX:int = 10;
        private const _MAX_THICKNESS:int = 99;
        private var _maxThickness:int;
        private var _SPEED_HI:int = 4;
        private var _SPEED_NORMAL:int = 3;
        private var _SPEED_SLOW:int = 2;
        private var _SPEED_VERY_SLOW:int = 1;
        private var _speed:int;
        private var _canvas:Sprite;
        private var _aPos:Array;
        private var _target:Point;
        private var _count:int;
        private var _advanceWait:Number;
        private var _lengthMin:int;
        private var _lengthMax:int;
        private var _color:uint;

        public function EffectBatibati(param1:DisplayObjectContainer, param2:Point, param3:Point)
        {
            this._aPos = [param2];
            this._target = param3.clone();
            this._advanceWait = this._ADVANCE_WAIT_TIME;
            this._count = this._COUNT_MAX;
            this._maxThickness = this._MAX_THICKNESS;
            this._canvas = new Sprite();
            this._canvas.filters = [new GlowFilter(14737632, 0.5, 8, 8)];
            this.setColor(224, 224, 0);
            this._speed = this._SPEED_HI;
            this.setLength(10, 15);
            param1.addChild(this._canvas);
            return;
        }// end function

        public function setSpeedNormal() : void
        {
            this._speed = this._SPEED_NORMAL;
            return;
        }// end function

        public function setSpeedSlow() : void
        {
            this._speed = this._SPEED_SLOW;
            return;
        }// end function

        public function setLength(param1:int, param2:int) : void
        {
            this._lengthMin = param1;
            this._lengthMax = param2;
            return;
        }// end function

        public function setColor(param1:int, param2:int, param3:int) : void
        {
            this._color = param1 << 16 | param2 << 8 | param3;
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._count <= 0 && this._aPos.length <= 1;
        }// end function

        public function release() : void
        {
            if (this._canvas)
            {
                if (this._canvas.parent)
                {
                    this._canvas.parent.removeChild(this._canvas);
                }
            }
            this._canvas = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            this._advanceWait = this._advanceWait - param1;
            if (this._advanceWait <= 0)
            {
                this._advanceWait = this._ADVANCE_WAIT_TIME;
                _loc_2 = 0;
                while (_loc_2 < this._speed)
                {
                    
                    var _loc_7:* = this;
                    var _loc_8:* = this._count - 1;
                    _loc_7._count = _loc_8;
                    if (this._count > 0)
                    {
                        if (this._aPos.length > 6)
                        {
                            this.removePos();
                        }
                        _loc_3 = new Matrix();
                        _loc_4 = this._aPos[(this._aPos.length - 1)];
                        _loc_5 = new Point(this._target.x - _loc_4.x, this._target.y - _loc_4.y);
                        if (_loc_5.length <= 15)
                        {
                            this._count = 0;
                        }
                        _loc_6 = Random.range(10, 40);
                        if (Lot.isHit(50))
                        {
                            _loc_6 = _loc_6 * -1;
                        }
                        _loc_3.rotate(_loc_6 * Math.PI / 180);
                        _loc_5 = _loc_3.transformPoint(_loc_5);
                        _loc_5.normalize(Random.range(this._lengthMin, this._lengthMax));
                        _loc_4 = _loc_4.add(_loc_5);
                        this._aPos.push(_loc_4);
                        if (this._count == 0)
                        {
                            break;
                        }
                    }
                    else
                    {
                        this.removePos();
                    }
                    _loc_2++;
                }
            }
            this.draw();
            return;
        }// end function

        private function draw() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_1:* = this._canvas.graphics;
            _loc_1.clear();
            if (this._aPos.length <= 1)
            {
                return;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this._aPos.length)
            {
                
                _loc_3 = this._aPos[_loc_2];
                _loc_4 = _loc_2;
                if (_loc_4 > this._maxThickness)
                {
                    _loc_4 = this._maxThickness;
                }
                _loc_1.lineStyle(_loc_4, this._color, 0.8);
                if (_loc_2 == 0)
                {
                    _loc_1.moveTo(_loc_3.x, _loc_3.y);
                }
                else
                {
                    _loc_1.lineTo(_loc_3.x, _loc_3.y);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function removePos() : void
        {
            this._aPos.shift();
            return;
        }// end function

    }
}
