package com.bit101.components
{
    import flash.display.*;
    import flash.events.*;

    public class CheckBox extends Component
    {
        private var _back:Sprite;
        private var _button:Sprite;
        private var _label:Label;
        private var _labelText:String = "";
        private var _selected:Boolean = false;
        private var _iconStyle:int = 0;

        public function CheckBox(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:String = "", param5:Function = null)
        {
            this._labelText = param4;
            super(param1, param2, param3);
            if (param5 != null)
            {
                addEventListener(MouseEvent.CLICK, param5);
            }
            return;
        }// end function

        override protected function init() : void
        {
            super.init();
            buttonMode = true;
            useHandCursor = true;
            setSize(10, 10);
            return;
        }// end function

        override protected function addChildren() : void
        {
            this._back = new Sprite();
            this._back.filters = [getShadow(2, true)];
            addChild(this._back);
            this._button = new Sprite();
            this._button.filters = [getShadow(1)];
            addChild(this._button);
            this._label = new Label(this);
            this._label.enableMouse = false;
            this._label.text = this._labelText;
            addEventListener(MouseEvent.CLICK, this.onClick);
            this.selected = false;
            return;
        }// end function

        override public function draw() : void
        {
            super.draw();
            this._back.graphics.clear();
            if (_enabled)
            {
                if (_color == -1)
                {
                    this._back.graphics.beginFill(Style.FONT_BACKGROUND);
                }
                else
                {
                    this._back.graphics.beginFill(_color);
                }
            }
            else
            {
                this._back.graphics.beginFill(10066329);
            }
            this._button.graphics.clear();
            if (_subColor == -1)
            {
                this._button.graphics.beginFill(this.textColor);
            }
            else
            {
                this._button.graphics.beginFill(_subColor);
            }
            switch(this._iconStyle)
            {
                case 0:
                {
                    this._back.graphics.drawRect(0, 0, _width, _height);
                    this._button.graphics.lineStyle(0, 0, 0);
                    this._button.graphics.moveTo(-2, 4);
                    this._button.graphics.lineTo(3, 11);
                    this._button.graphics.lineTo(13, -1);
                    this._button.graphics.lineTo(3, 6);
                    this._button.graphics.lineTo(-2, 4);
                    break;
                }
                case 1:
                {
                    this._back.graphics.lineStyle(1, this.textColor);
                    this._back.graphics.beginFill(16777215);
                    this._back.graphics.drawRect(0, 0, 10, 10);
                    this._back.graphics.moveTo(0, 5);
                    this._back.graphics.lineTo(10, 5);
                    this._back.graphics.moveTo(5, 0);
                    this._back.graphics.lineTo(5, 10);
                    this._button.graphics.lineStyle(1, this.textColor);
                    this._button.graphics.beginFill(16777215);
                    this._button.graphics.drawRect(0, 0, 10, 10);
                    this._button.graphics.moveTo(0, 5);
                    this._button.graphics.lineTo(10, 5);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._back.graphics.endFill();
            this._button.graphics.endFill();
            this._label.text = this._labelText;
            this._label.x = _width + 2;
            this._label.y = _height / 2 - this._label.height / 2;
            return;
        }// end function

        private function onClick(event:MouseEvent) : void
        {
            if (_enabled)
            {
                this.selected = !this._selected;
            }
            return;
        }// end function

        public function set label(param1:String) : void
        {
            this._labelText = param1;
            invalidate();
            return;
        }// end function

        public function get label() : String
        {
            return this._labelText;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
            switch(this._iconStyle)
            {
                case 0:
                {
                    this._button.visible = param1;
                    break;
                }
                case 1:
                {
                    if (param1)
                    {
                        this._button.visible = param1;
                        this._back.visible = !param1;
                    }
                    else
                    {
                        this._button.visible = param1;
                        this._back.visible = !param1;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
        }// end function

        public function set textColor(param1:Number) : void
        {
            this._label.textColor = param1;
            return;
        }// end function

        public function get textColor() : Number
        {
            return this._label.textColor;
        }// end function

        public function set iconStyle(param1:int) : void
        {
            this._iconStyle = param1;
            this.draw();
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            _enabled = param1;
            this._label.enabled = _enabled;
            this.draw();
            return;
        }// end function

    }
}
