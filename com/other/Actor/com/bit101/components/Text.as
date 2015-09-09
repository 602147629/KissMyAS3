package com.bit101.components
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class Text extends Component
    {
        private var _tf:TextField;
        private var _text:String = "";
        private var _editable:Boolean = true;
        private var _panel:Panel;
        private var _html:Boolean = false;

        public function Text(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:String = "", param5:Function = null)
        {
            this._text = param4;
            super(param1, param2, param3);
            setSize(200, 100);
            if (param5 != null)
            {
                addEventListener(Event.CHANGE, param5);
            }
            return;
        }// end function

        override protected function init() : void
        {
            super.init();
            return;
        }// end function

        override protected function addChildren() : void
        {
            this._panel = new Panel(this);
            this._panel.color = 16777215;
            this._tf = new TextField();
            this._tf.x = 2;
            this._tf.y = 2;
            this._tf.height = _height;
            this._tf.multiline = true;
            this._tf.wordWrap = true;
            this._tf.selectable = true;
            if (Config._switchEnglish)
            {
                this._tf.defaultTextFormat = new TextFormat("Tahoma", 12);
            }
            this._tf.type = TextFieldType.INPUT;
            addChild(this._tf);
            this._tf.addEventListener(Event.CHANGE, this.onChange);
            return;
        }// end function

        private function onChange(event:Event) : void
        {
            this._text = this._tf.text;
            return;
        }// end function

        override public function draw() : void
        {
            super.draw();
            if (this.editable)
            {
                this._panel.setSize(_width, _height);
                this._panel.visible = true;
            }
            else
            {
                this._panel.visible = false;
            }
            this._tf.width = _width - 4;
            this._tf.height = _height - 4;
            if (this._html)
            {
                this._tf.htmlText = this._text;
            }
            else
            {
                this._tf.text = this._text;
            }
            if (this._editable)
            {
                this._tf.mouseEnabled = true;
                this._tf.selectable = true;
                this._tf.type = TextFieldType.INPUT;
            }
            else
            {
                this._tf.mouseEnabled = false;
                this._tf.selectable = false;
                this._tf.type = TextFieldType.DYNAMIC;
            }
            return;
        }// end function

        public function set text(param1:String) : void
        {
            this._text = param1;
            this.draw();
            return;
        }// end function

        public function get text() : String
        {
            if (this._html)
            {
                return this._tf.htmlText;
            }
            return this._tf.text;
        }// end function

        public function set editable(param1:Boolean) : void
        {
            this._editable = param1;
            invalidate();
            return;
        }// end function

        public function get editable() : Boolean
        {
            return this._editable;
        }// end function

        public function set selectable(param1:Boolean) : void
        {
            this._tf.selectable = param1;
            return;
        }// end function

        public function get selectable() : Boolean
        {
            return this._tf.selectable;
        }// end function

        public function set html(param1:Boolean) : void
        {
            this._html = param1;
            this.draw();
            return;
        }// end function

        public function get html() : Boolean
        {
            return this._html;
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

        public function set focus(param1)
        {
            if (param1)
            {
                _stage.focus = this._tf;
            }
            else if (_stage.focus == this._tf)
            {
                _stage.focus = null;
            }
            return;
        }// end function

        public function get focus()
        {
            if (_stage.focus == this._tf)
            {
                return true;
            }
            return false;
        }// end function

        public function get tf() : TextField
        {
            return this._tf;
        }// end function

        public function set tf(param1:TextField) : void
        {
            this._tf = param1;
            return;
        }// end function

    }
}
