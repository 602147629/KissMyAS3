package lovefox.gui
{
    import flash.display.*;

    public class CustomButton extends Sprite
    {
        private var _style:Object = 0;
        private var _normalShape:Shape;
        private var _hoverShape:Shape;
        private var _txtBmp:Bitmap;
        private var _width:Object;
        private var _height:Object;
        private var _text:Object;
        private var _title:Object;
        private var _index:Object;
        private var _autoSize:Boolean = false;
        private var _vary:int = 2;
        private var _hover:Boolean;
        public static var STYLE_SOLID:Object = 0;
        public static var STYLE_HALO:Object = 1;
        public static var STYLE_CHAT:Object = 2;

        public function CustomButton()
        {
            this._normalShape = new Shape();
            this._hoverShape = new Shape();
            this._hoverShape.alpha = 0;
            addChild(this._normalShape);
            addChild(this._hoverShape);
            this._txtBmp = new Bitmap();
            addChild(this._txtBmp);
            this._width = 100;
            this._height = 22;
            this.redraw();
            buttonMode = true;
            addEventListener(MouseEvent.ROLL_OVER, this.handleMouseOver);
            addEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
            return;
        }// end function

        public function get hover()
        {
            return this._hover;
        }// end function

        public function set hover(param1)
        {
            if (this._hover != param1)
            {
                this._hover = param1;
                removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
                addEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            }
            return;
        }// end function

        private function handleEnterFrame(param1)
        {
            if (this._hover)
            {
                this._hoverShape.alpha = this._hoverShape.alpha + 1 / this._vary;
                if (this._hoverShape.alpha >= 1)
                {
                    removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
                }
            }
            else
            {
                this._hoverShape.alpha = this._hoverShape.alpha - 1 / this._vary;
                if (this._hoverShape.alpha <= 0)
                {
                    removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
                }
            }
            return;
        }// end function

        private function handleMouseOver(param1)
        {
            if (this._vary > 1)
            {
                this.hover = true;
            }
            Config.buttonLock = true;
            return;
        }// end function

        private function handleMouseOut(param1)
        {
            if (this._vary > 1)
            {
                this.hover = false;
            }
            Config.buttonLock = false;
            return;
        }// end function

        private function redraw()
        {
            if (this._style == STYLE_CHAT)
            {
                this._hoverShape.graphics.clear();
                this._hoverShape.graphics.lineStyle(0, 0, 0);
                this._hoverShape.graphics.beginFill(0, 0.5);
                this._hoverShape.graphics.drawRect(0, 0, this._width, this._height);
                this._hoverShape.graphics.endFill();
                this._normalShape.graphics.clear();
                this._normalShape.graphics.lineStyle(0, 0, 0);
                this._normalShape.graphics.beginFill(0, 0);
                this._normalShape.graphics.drawRect(0, 0, this._width, this._height);
                this._normalShape.graphics.endFill();
                this._txtBmp.x = (this._width - this._txtBmp.width) / 2;
                this._txtBmp.y = (this._height - this._txtBmp.height) / 2;
            }
            else
            {
                this._hoverShape.graphics.clear();
                this._hoverShape.graphics.lineStyle(0, 0, 0);
                this._hoverShape.graphics.beginFill(16777215);
                this._hoverShape.graphics.drawRoundRect(0, 0, this._width, this._height, 6, 6);
                this._hoverShape.graphics.endFill();
                this._hoverShape.graphics.beginFill(0);
                this._hoverShape.graphics.drawRoundRect(1, 1, this._width - 2, this._height - 2, 6, 6);
                this._hoverShape.graphics.beginFill(16777215, 0.5);
                this._hoverShape.graphics.drawRoundRect(2, 2, this._width - 4, 6, 2, 2);
                this._hoverShape.graphics.beginFill(0);
                this._hoverShape.graphics.drawRect(2, 6, this._width - 4, 3);
                this._hoverShape.graphics.endFill();
                this._normalShape.graphics.clear();
                this._normalShape.graphics.lineStyle(1, 16777215, 1, true);
                this._normalShape.graphics.beginFill(0);
                this._normalShape.graphics.drawRoundRect(0, 0, this._width, this._height, 6, 6);
                this._normalShape.graphics.endFill();
                this._txtBmp.x = (this._width - this._txtBmp.width) / 2;
                this._txtBmp.y = (this._height - this._txtBmp.height) / 2;
            }
            return;
        }// end function

        public function set autoSize(param1) : void
        {
            this._autoSize = param1;
            if (this._autoSize)
            {
                this._width = this._txtBmp.width + 10;
                this.redraw();
            }
            return;
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

        public function set index(param1)
        {
            this._index = param1;
            return;
        }// end function

        public function get index()
        {
            return this._index;
        }// end function

        public function set title(param1)
        {
            this._title = param1;
            return;
        }// end function

        public function get title()
        {
            return this._title;
        }// end function

        public function set color(param1)
        {
            this._txtBmp.bitmapData.dispose();
            this._txtBmp.bitmapData = Text2Bitmap.toBmp(this._text, param1);
            return;
        }// end function

        public function get label()
        {
            return this._text;
        }// end function

        public function set label(param1)
        {
            this._text = param1;
            this._txtBmp.bitmapData = Text2Bitmap.toBmp(this._text);
            if (this._autoSize)
            {
                this._width = this._txtBmp.width + 10;
            }
            this.redraw();
            return;
        }// end function

        public function set style(param1)
        {
            this._style = param1;
            this.redraw();
            return;
        }// end function

        public function destroy()
        {
            if (this._txtBmp.bitmapData != null)
            {
                this._txtBmp.bitmapData.dispose();
            }
            return;
        }// end function

        public static function create(param1, param2, param3, param4, param5, param6 = null, param7 = null)
        {
            var _loc_8:* = undefined;
            _loc_8 = new CustomButton;
            _loc_8._width = param1;
            _loc_8._height = param2;
            _loc_8.label = param5;
            _loc_8.x = param3;
            _loc_8.y = param4;
            if (param6 != null)
            {
                _loc_8.addEventListener(MouseEvent.CLICK, param6);
            }
            if (param7 != null)
            {
                param7.addChild(_loc_8);
            }
            return _loc_8;
        }// end function

    }
}
