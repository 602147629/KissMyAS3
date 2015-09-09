package lovefox.gui
{
    import flash.display.*;

    public class Bar extends Sprite
    {
        public var _width:uint = 100;
        public var _height:uint = 20;
        public var _color:uint = 0;
        public var _fBar:Shape;
        public var _border:Shape;
        public var _percent:Number = 1;
        private var _txt:Object;

        public function Bar()
        {
            this._fBar = new Shape();
            addChild(this._fBar);
            this._border = new Shape();
            addChild(this._border);
            this._txt = Config.getSimpleTextField();
            this._txt.textColor = 16777215;
            this._txt.y = -5;
            addChild(this._txt);
            this.redraw();
            return;
        }// end function

        public function redraw(param1 = true)
        {
            if (param1)
            {
                this._border.graphics.clear();
                this._border.graphics.lineStyle(0, 16777215, 0.5, true);
                this._border.graphics.drawRoundRect(0, 0, this._width, this._height, 3, 3);
            }
            this._fBar.graphics.clear();
            this._fBar.graphics.lineStyle(0, 0, 0, true);
            this._fBar.graphics.beginFill(this._color);
            this._fBar.graphics.drawRoundRect(0, 0, Math.max(1, this._width * this._percent), this._height, 2, 2);
            this._fBar.graphics.endFill();
            return;
        }// end function

        public function setProgress(param1, param2)
        {
            if (param1 != null && param2 != null && param2 > 0)
            {
                this._percent = Math.max(0, Math.min(1, param1 / param2));
                this._txt.text = param1 + "/" + param2;
                this.redraw(false);
            }
            return;
        }// end function

        public function set per(param1)
        {
            if (!isNaN(param1))
            {
                this._percent = param1;
                this._txt.text = "";
                this.redraw(false);
            }
            return;
        }// end function

        public function get per()
        {
            return this._percent;
        }// end function

        public function set color(param1)
        {
            this._color = param1;
            this.redraw();
            return;
        }// end function

        public function get color()
        {
            return this._color;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._width = param1;
            this.redraw();
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            this._height = param1;
            this.redraw();
            return;
        }// end function

        public static function create(param1, param2, param3, param4, param5, param6 = null)
        {
            var _loc_7:* = new Bar;
            new Bar._width = param1;
            _loc_7._height = param2;
            _loc_7._color = param5;
            _loc_7.x = param3;
            _loc_7.y = param4;
            _loc_7.redraw();
            if (param6 != null)
            {
                param6.addChild(_loc_7);
            }
            return _loc_7;
        }// end function

    }
}
