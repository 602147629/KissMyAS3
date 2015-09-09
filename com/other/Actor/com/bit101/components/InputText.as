package com.bit101.components
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class InputText extends Component
    {
        private var _back:Object;
        private var _password:Boolean = false;
        private var _text:String = "";
        public var _tf:TextField;

        public function InputText(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:String = "", param5:Function = null)
        {
            this._text = param4;
            super(param1, param2, param3);
            if (param5 != null)
            {
                addEventListener(Event.CHANGE, param5);
            }
            return;
        }// end function

        override protected function init() : void
        {
            super.init();
            setSize(100, 20);
            return;
        }// end function

        override protected function addChildren() : void
        {
            this._back = new Sprite();
            this._back.filters = [getShadow(2, true)];
            addChild(this._back);
            this._tf = new TextField();
            this._tf.selectable = true;
            this._tf.type = TextFieldType.INPUT;
            if (Config._switchEnglish)
            {
                this._tf.restrict = "^一-龥";
                this._tf.defaultTextFormat = new TextFormat("Tahoma", 12);
            }
            addChild(this._tf);
            this._tf.addEventListener(Event.CHANGE, this.onChange);
            return;
        }// end function

        public function setTable(param1)
        {
            removeChild(this._back);
            this._back = new Table(param1);
            addChild(this._back);
            addChild(this._tf);
            this.draw();
            return;
        }// end function

        override public function draw() : void
        {
            super.draw();
            if (this._back is Table)
            {
                this._back.resize(_width, _height);
            }
            else
            {
                this._back.graphics.clear();
                if (_color == -1)
                {
                    this._back.graphics.beginFill(Style.FONT_BACKGROUND);
                }
                else
                {
                    this._back.graphics.beginFill(_color);
                }
                this._back.graphics.drawRect(0, 0, _width, _height);
                this._back.graphics.endFill();
            }
            this._tf.displayAsPassword = this._password;
            this._tf.text = this._text;
            this._tf.width = _width - 4;
            if (this._tf.text == "")
            {
                this._tf.text = "X";
                this._tf.height = Math.min(this._tf.textHeight + 4, _height);
                this._tf.text = "";
            }
            else
            {
                this._tf.height = Math.min(this._tf.textHeight + 4, _height);
            }
            this._tf.x = 2;
            this._tf.y = Math.round(_height / 2 - this._tf.height / 2);
            this._tf.textColor = Style.WINDOW_FONT;
            return;
        }// end function

        private function onChange(event:Event) : void
        {
            this._text = this._tf.text;
            return;
        }// end function

        public function set text(param1:String) : void
        {
            this._text = param1;
            invalidate();
            return;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

        public function set restrict(param1:String) : void
        {
            this._tf.restrict = param1;
            return;
        }// end function

        public function get restrict() : String
        {
            return this._tf.restrict;
        }// end function

        public function set maxChars(param1:int) : void
        {
            this._tf.maxChars = param1;
            return;
        }// end function

        public function get maxChars() : int
        {
            return this._tf.maxChars;
        }// end function

        public function set password(param1:Boolean) : void
        {
            this._password = param1;
            invalidate();
            return;
        }// end function

        public function get password() : Boolean
        {
            return this._password;
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

        public function set editable(param1:Boolean) : void
        {
            if (param1)
            {
                this._tf.type = TextFieldType.INPUT;
            }
            else
            {
                this._tf.type = TextFieldType.DYNAMIC;
            }
            return;
        }// end function

        public function get tf() : TextField
        {
            return this._tf;
        }// end function

        public function set type(param1) : void
        {
            this._tf.type = param1;
            return;
        }// end function

        public function get type()
        {
            return this._tf.type;
        }// end function

    }
}
