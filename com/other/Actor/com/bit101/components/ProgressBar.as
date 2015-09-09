package com.bit101.components
{
    import flash.display.*;

    public class ProgressBar extends Component
    {
        private var _back:Sprite;
        private var _bar:Sprite;
        private var _value:Number = 0;
        private var _max:Number = 1;

        public function ProgressBar(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override protected function init() : void
        {
            super.init();
            setSize(100, 10);
            return;
        }// end function

        override protected function addChildren() : void
        {
            this._back = new Sprite();
            this._back.filters = [getShadow(2, true)];
            addChild(this._back);
            this._bar = new Sprite();
            this._bar.x = 1;
            this._bar.y = 1;
            this._bar.filters = [getShadow(1)];
            addChild(this._bar);
            return;
        }// end function

        private function update() : void
        {
            this._bar.scaleX = Math.max(0, Math.min(1, this._value / this._max));
            return;
        }// end function

        override public function draw() : void
        {
            super.draw();
            this._back.graphics.clear();
            if (_bgColor == -1)
            {
                this._back.graphics.beginFill(Style.FONT_BACKGROUND);
            }
            else
            {
                this._back.graphics.beginFill(_bgColor);
            }
            this._back.graphics.drawRoundRect(0, 0, _width, _height, _roundCorner, _roundCorner);
            this._back.graphics.endFill();
            this._bar.graphics.clear();
            if (_color == -1)
            {
                if (_subColor == -1)
                {
                    this._bar.graphics.beginFill(Style.WINDOW_FONT, _alpha);
                }
                else
                {
                    if (_gradientFillMatrix == null)
                    {
                        _gradientFillMatrix = new Matrix();
                    }
                    _gradientFillMatrix.createGradientBox(_width, _height, _gradientFillDirection, 0, 0);
                    this._bar.graphics.beginGradientFill(_gradientFillType, [Style.WINDOW_FONT, _subColor], [100, 100], [0, 255], _gradientFillMatrix);
                }
            }
            else if (_subColor == -1)
            {
                this._bar.graphics.beginFill(_color, _alpha);
            }
            else
            {
                if (_gradientFillMatrix == null)
                {
                    _gradientFillMatrix = new Matrix();
                }
                _gradientFillMatrix.createGradientBox(_width, _height, _gradientFillDirection, 0, 0);
                this._bar.graphics.beginGradientFill(_gradientFillType, [_color, _subColor], [100, 100], [0, 255], _gradientFillMatrix);
            }
            this._bar.graphics.drawRoundRect(0, 0, _width - 2, _height - 2, _roundCorner, _roundCorner);
            this._bar.graphics.endFill();
            return;
        }// end function

        public function set maximum(param1:Number) : void
        {
            this._max = param1;
            this._value = Math.min(this._value, this._max);
            this.update();
            return;
        }// end function

        public function get maximum() : Number
        {
            return this._max;
        }// end function

        public function set value(param1:Number) : void
        {
            this._value = Math.min(param1, this._max);
            this.update();
            return;
        }// end function

        public function get value() : Number
        {
            return this._value;
        }// end function

        public function set percentComplete(param1:Number) : void
        {
            this._bar.scaleX = param1;
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            super.width = param1;
            this.update();
            return;
        }// end function

    }
}
