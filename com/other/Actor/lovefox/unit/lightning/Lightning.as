package lovefox.unit.lightning
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Lightning extends Object
    {
        public var bTest1:Bitmap;
        public var bTest2:Bitmap;
        public var bd1:BitmapData;
        public var bd2:BitmapData;
        public var seed1:int = 0;
        public var seed2:int = 0;
        public var aOffsetsBd1:Array;
        public var aOffsetsBd2:Array;
        public var vSteps:Vector.<Point>;
        public var vChildren:Vector.<Lightning>;
        public var _startX:Number = 250;
        public var _startY:Number = 250;
        public var _endX:Number = 10;
        public var _endY:Number = 100;
        public var _speed1:Number = 0.1;
        public var _speed2:Number = 0.1;
        private var _steps:int = 0;
        public var _wavelength1:Number = 0.05;
        public var _wavelength2:Number = 0.4;
        public var _amplitude1:Number = 0.08;
        public var _amplitude2:Number = 0.6;
        public var _thickness:Number = 2;
        public var _color:Number = 16777215;
        public var _alpha:Number = 1;
        public var angle:Number = 0;
        public var len:Number = 0;
        public var dx:Number = 0;
        public var dy:Number = 0;
        public var bIsChild:Boolean = false;
        public var parentLightning:Lightning;
        public var _stepStart:int;
        public var _stepEnd:int;
        public var _graphics:Graphics;
        private var _layer:Shape;
        public var timer:Timer;
        public var bAllowUpdate:Boolean = true;
        public static var vStepsAll:Vector.<Point> = new Vector.<Point>;

        public function Lightning()
        {
            this.vChildren = new Vector.<>;
            this.timer = new Timer(3000);
            return;
        }// end function

        private function timer_timerHandler(event:Event) : void
        {
            this.getNewStepsFromParent();
            var _loc_2:* = 0;
            var _loc_3:* = this.vChildren.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this.vChildren[_loc_2].getNewStepsFromParent();
                _loc_2++;
            }
            this.timer.stop();
            this.timer.reset();
            this.timer.delay = 1000 + Math.random() * 4000;
            this.timer.start();
            return;
        }// end function

        public function getNewStepsFromParent() : void
        {
            this._stepStart = Math.floor(Math.random() * (this.parentLightning.steps - 2));
            this._stepEnd = this._stepStart + Math.floor(Math.random() * (this.parentLightning.steps - this._stepStart - 2)) + 2;
            if (this._stepStart > this._stepEnd || this._stepStart < 0 || this._stepEnd >= this.parentLightning.steps)
            {
                this.bAllowUpdate = false;
            }
            else
            {
                this.bAllowUpdate = true;
                this.steps = (this._stepEnd - this._stepStart) * 1;
            }
            return;
        }// end function

        public function init(param1:Shape) : void
        {
            if (this._steps <= 0)
            {
                this.steps = 50;
            }
            this.seed1 = Math.round(Math.random() * 100);
            this.seed2 = Math.round(Math.random() * 100);
            this.aOffsetsBd1 = [new Point(0, 0), new Point(0, 0)];
            this.aOffsetsBd2 = [new Point(0, 0), new Point(0, 0)];
            this._layer = param1;
            this._graphics = param1.graphics;
            return;
        }// end function

        public function kill() : void
        {
            return;
        }// end function

        public function update() : void
        {
            if (!this.bAllowUpdate)
            {
                return;
            }
            if (this.bIsChild)
            {
                this._startX = this.parentLightning.vSteps[this._stepStart].x;
                this._startY = this.parentLightning.vSteps[this._stepStart].y;
                this._endX = this.parentLightning.vSteps[this._stepEnd].x;
                this._endY = this.parentLightning.vSteps[this._stepEnd].y;
                this.angle = this.parentLightning.angle;
            }
            else
            {
                this.angle = Math.atan2(this._endY - this._startY, this._endX - this._startX);
            }
            this.dx = this._endX - this._startX;
            this.dy = this._endY - this._startY;
            this.len = Math.sqrt(this.dx * this.dx + this.dy * this.dy);
            this.aOffsetsBd1[0].x = this.aOffsetsBd1[0].x - this._steps * this._speed1;
            this.aOffsetsBd1[0].y = this.aOffsetsBd1[0].y + this._steps * this._speed1;
            this.aOffsetsBd2[0].x = this.aOffsetsBd2[0].x - this._steps * this._speed2;
            this.aOffsetsBd2[0].y = this.aOffsetsBd2[0].y + this._steps * this._speed2;
            this.bd1.perlinNoise(this._steps * this._wavelength1, 0, 2, this.seed1, false, true, 0, true, this.aOffsetsBd1);
            this.bd2.perlinNoise(this._steps * this._wavelength2, 0, 2, this.seed2, false, true, 0, true, this.aOffsetsBd2);
            this.render();
            var _loc_1:* = 0;
            var _loc_2:* = this.vChildren.length;
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this.vChildren[_loc_1].update();
                _loc_1++;
            }
            return;
        }// end function

        public function render() : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_9:* = null;
            if (!this.bIsChild)
            {
                this._graphics.lineStyle(this._thickness, this._color, this._alpha);
            }
            else
            {
                this._graphics.lineStyle(this._thickness, this._color, this._alpha);
            }
            this._graphics.moveTo(this._startX, this._startY);
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_5:* = 0;
            var _loc_8:* = 1;
            _loc_1 = 0;
            while (_loc_1 < this._steps)
            {
                
                _loc_2 = (this.bd1.getPixel(_loc_1, 0) - 8421504) / 16777215 * this.len * this._amplitude1;
                _loc_3 = Math.sin(this.angle) * _loc_2;
                _loc_4 = Math.cos(this.angle) * _loc_2;
                _loc_5 = (this.bd2.getPixel(_loc_1, 0) - 8421504) / 16777215 * this.len * this._amplitude2;
                _loc_6 = Math.sin(this.angle) * _loc_5;
                _loc_7 = Math.cos(this.angle) * _loc_5;
                _loc_8 = Math.sin(Math.PI * (_loc_1 / (this._steps - 1)));
                _loc_3 = _loc_3 * _loc_8;
                _loc_4 = _loc_4 * _loc_8;
                _loc_6 = _loc_6 * _loc_8;
                _loc_7 = _loc_7 * _loc_8;
                _loc_3 = this._startX + this.dx / (this._steps - 1) * _loc_1 + _loc_3 + _loc_6;
                _loc_4 = this._startY + this.dy / (this._steps - 1) * _loc_1 - _loc_4 - _loc_7;
                _loc_9 = this.vSteps[_loc_1];
                _loc_9.x = _loc_3;
                _loc_9.y = _loc_4;
                this._graphics.lineTo(_loc_3, _loc_4);
                _loc_1++;
            }
            if (!this.bIsChild)
            {
                this._graphics.endFill();
            }
            return;
        }// end function

        public function child_create() : Lightning
        {
            var _loc_1:* = new Lightning();
            _loc_1.setAsChild(this);
            this.vChildren.push(_loc_1);
            return _loc_1;
        }// end function

        public function setAsChild(param1:Lightning) : void
        {
            this.bIsChild = true;
            this.parentLightning = param1;
            this._graphics = this.parentLightning._graphics;
            if (this.parentLightning.parentLightning)
            {
                this._thickness = this.parentLightning._thickness * 0.5;
            }
            this._color = this.parentLightning._color;
            if (this.parentLightning.parentLightning)
            {
                this._alpha = this.parentLightning._alpha * 0.5;
            }
            this.getNewStepsFromParent();
            this.init(this._layer);
            this.timer.start();
            return;
        }// end function

        public function get steps() : int
        {
            return this._steps;
        }// end function

        public function set steps(param1:int) : void
        {
            var _loc_4:* = null;
            if (this._steps == param1)
            {
                return;
            }
            this.vSteps = new Vector.<Point>(param1, true);
            var _loc_2:* = 0;
            var _loc_3:* = param1;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                _loc_4 = new Point();
                this.vSteps[_loc_2] = _loc_4;
                _loc_2++;
            }
            this.bd1 = new BitmapData(param1, 1, false);
            this.bd2 = new BitmapData(param1, 1, false);
            this._steps = param1;
            return;
        }// end function

    }
}
