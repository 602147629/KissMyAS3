package com.bit101.components
{
    import flash.display.*;

    public class Panel extends Component
    {
        private var _mask:Sprite;
        private var _background:Shape;
        public var content:Sprite;

        public function Panel(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override protected function init() : void
        {
            super.init();
            setSize(100, 100);
            return;
        }// end function

        override protected function addChildren() : void
        {
            this._background = new Shape();
            addChild(this._background);
            this._mask = new Sprite();
            this._mask.mouseEnabled = false;
            addChild(this._mask);
            this.content = new Sprite();
            addChild(this.content);
            this.content.mask = this._mask;
            this.shadow = _shadow;
            return;
        }// end function

        override public function draw() : void
        {
            super.draw();
            this._background.graphics.clear();
            if (_color == -1)
            {
                if (_subColor == -1)
                {
                    this._background.graphics.beginFill(Style.PANEL, _alpha);
                }
                else
                {
                    if (_gradientFillMatrix == null)
                    {
                        _gradientFillMatrix = new Matrix();
                    }
                    _gradientFillMatrix.createGradientBox(_width, _height, _gradientFillDirection, 0, 0);
                    this._background.graphics.beginGradientFill(_gradientFillType, [Style.PANEL, _subColor], [100, 100], [0, 255], _gradientFillMatrix);
                }
            }
            else if (_subColor == -1)
            {
                this._background.graphics.beginFill(_color, _alpha);
            }
            else
            {
                if (_gradientFillMatrix == null)
                {
                    _gradientFillMatrix = new Matrix();
                }
                _gradientFillMatrix.createGradientBox(_width, _height, _gradientFillDirection, 0, 0);
                this._background.graphics.beginGradientFill(_gradientFillType, [_color, _subColor], [100, 100], [0, 255], _gradientFillMatrix);
            }
            this._background.graphics.drawRoundRect(0, 0, _width, _height, _roundCorner, _roundCorner);
            this._background.graphics.endFill();
            if (_border > 0)
            {
                if (_border > 1)
                {
                    this._background.graphics.lineStyle(3, 0, 0.5, true);
                    this._background.graphics.drawRoundRect(2, 2, _width - 4, _height - 4, _roundCorner, _roundCorner);
                    if (_borderColor == -1)
                    {
                        this._background.graphics.lineStyle(3, Style.BORDER_1, 1, true);
                    }
                    else
                    {
                        this._background.graphics.lineStyle(3, _borderColor, 1, true);
                    }
                }
                else
                {
                    this._background.graphics.lineStyle(0, _borderColor, 1, true);
                }
                if (_border > 1)
                {
                    this._background.graphics.drawRoundRect(1, 1, _width - 2, _height - 2, _roundCorner, _roundCorner);
                    this._background.graphics.lineStyle(1, Style.BORDER_2, 1, true);
                    this._background.graphics.drawRoundRect(0, 0, _width, _height, _roundCorner, _roundCorner);
                    this._background.graphics.lineStyle(1, Style.BORDER_3, 1, true);
                    this._background.graphics.drawRoundRect(2, 2, _width - 4, _height - 4, _roundCorner, _roundCorner);
                }
                else
                {
                    this._background.graphics.drawRoundRect(0, 0, _width, _height, _roundCorner, _roundCorner);
                }
            }
            this._mask.graphics.clear();
            this._mask.graphics.beginFill(16711680, _alpha);
            this._mask.graphics.drawRect(0, 0, _width, _height);
            this._mask.graphics.endFill();
            return;
        }// end function

        override public function set shadow(param1:uint) : void
        {
            super.shadow = param1;
            if (_shadow != 0)
            {
                if (_shadowColor == -1)
                {
                    filters = [new GlowFilter(Style.SHADOW, 1, Math.abs(_shadow), Math.abs(_shadow), 1, 3, _shadow < 0)];
                }
                else
                {
                    filters = [new GlowFilter(_shadowColor, 1, Math.abs(_shadow), Math.abs(_shadow), 1, 3, _shadow < 0)];
                }
            }
            else
            {
                filters = [];
            }
            return;
        }// end function

    }
}
