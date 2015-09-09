package com.bit101.components
{
    import flash.display.*;
    import flash.text.*;

    public class Label extends Component
    {
        private var _autoSize:Boolean = true;
        private var _text:String = "";
        private var _tf:TextField;
        private var _html:Boolean = false;

        public function Label(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:String = "", param5:Function = null)
        {
            if (param4.length > 0)
            {
                this._text = param4;
            }
            else
            {
                this._text = "";
            }
            super(param1, param2, param3);
            if (param5 != null)
            {
                addEventListener(TextEvent.LINK, param5);
            }
            return;
        }// end function

        override protected function init() : void
        {
            super.init();
            this.mouseEnabled = false;
            return;
        }// end function

        override protected function addChildren() : void
        {
            _height = 18;
            this._tf = new TextField();
            this._tf.textColor = Style.LABEL_TEXT;
            this._tf.height = _height;
            this._tf.selectable = false;
            this._tf.mouseEnabled = false;
            this._tf.textColor = Style.WINDOW_FONT;
            if (Config._switchEnglish)
            {
                this._tf.defaultTextFormat = new TextFormat("Tahoma", 12);
            }
            addChild(this._tf);
            return;
        }// end function

        override public function draw() : void
        {
            super.draw();
            if (this._html)
            {
                this._tf.htmlText = this._text;
            }
            else
            {
                this._tf.text = this._text;
            }
            if (this._autoSize)
            {
                this._tf.autoSize = TextFieldAutoSize.LEFT;
                if (this._tf.wordWrap)
                {
                    this._tf.width = _width;
                }
                else
                {
                    _width = this._tf.width;
                }
                var _loc_1:* = 18;
                this._tf.height = 18;
                _height = _loc_1;
            }
            else
            {
                this._tf.autoSize = TextFieldAutoSize.NONE;
                this._tf.width = _width;
                this._tf.height = _height;
            }
            return;
        }// end function

        public function set text(param1:String) : void
        {
            if (this._text != param1)
            {
                this._text = param1;
                this.invalidate();
            }
            return;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

        public function set autoSize(param1:Boolean) : void
        {
            this._autoSize = param1;
            return;
        }// end function

        public function get autoSize() : Boolean
        {
            return this._autoSize;
        }// end function

        public function set html(param1:Boolean) : void
        {
            this._html = param1;
            if (param1)
            {
                this._tf.multiline = true;
            }
            else
            {
                this._tf.multiline = false;
            }
            this.invalidate();
            return;
        }// end function

        public function get html() : Boolean
        {
            return this._html;
        }// end function

        override public function set mouseEnabled(param1:Boolean) : void
        {
            this._tf.mouseEnabled = param1;
            return;
        }// end function

        override public function get mouseEnabled() : Boolean
        {
            return this._tf.mouseEnabled;
        }// end function

        public function set wordWrap(param1:Boolean) : void
        {
            this._tf.wordWrap = param1;
            this.invalidate();
            return;
        }// end function

        public function get wordWrap() : Boolean
        {
            return this._tf.wordWrap;
        }// end function

        public function set textColor(param1:Number) : void
        {
            this._tf.textColor = param1;
            return;
        }// end function

        public function get textColor() : Number
        {
            return this._tf.textColor;
        }// end function

        override public function set highlight(param1:Boolean) : void
        {
            _highlight = param1;
            if (_highlight)
            {
                filters = [Style.HIGHLIGHT];
            }
            else
            {
                filters = [];
            }
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            if (_enabled)
            {
                this.textColor = Style.WINDOW_FONT;
            }
            else
            {
                this.textColor = Style.WINDOW_FONT_DISABLE;
            }
            return;
        }// end function

        public function get tf() : TextField
        {
            return this._tf;
        }// end function

        override public function get width() : Number
        {
            return this._tf.width;
        }// end function

        override protected function invalidate() : void
        {
            this.draw();
            return;
        }// end function

    }
}
