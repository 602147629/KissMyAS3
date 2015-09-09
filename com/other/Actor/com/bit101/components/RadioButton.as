package com.bit101.components
{
    import flash.display.*;
    import flash.events.*;

    public class RadioButton extends Component
    {
        private var _back:Sprite;
        private var _button:Sprite;
        private var _group:String;
        private var _selected:Boolean = false;
        private var _label:Label;
        private var _labelText:String = "";
        private static var buttons:Array;

        public function RadioButton(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:String = "", param5:Boolean = false, param6:Function = null)
        {
            addButton(this);
            this._selected = param5;
            this._labelText = param4;
            super(param1, param2, param3);
            if (param6 != null)
            {
                addEventListener(MouseEvent.CLICK, param6);
            }
            return;
        }// end function

        override protected function init() : void
        {
            super.init();
            setSize(10, 10);
            buttonMode = true;
            useHandCursor = true;
            addEventListener(MouseEvent.CLICK, this.onClick, false, 1);
            this.selected = this._selected;
            return;
        }// end function

        override protected function addChildren() : void
        {
            this._back = new Sprite();
            this._back.filters = [getShadow(2, true)];
            addChild(this._back);
            this._button = new Sprite();
            this._button.filters = [getShadow(1)];
            this._button.visible = false;
            addChild(this._button);
            this._label = new Label();
            addChild(this._label);
            return;
        }// end function

        override public function draw() : void
        {
            super.draw();
            this._back.graphics.clear();
            if (_subColor == -1)
            {
                this._back.graphics.beginFill(Style.BACKGROUND);
            }
            else
            {
                this._back.graphics.beginFill(_subColor);
            }
            this._back.graphics.drawCircle(_width / 2, _height / 2, _width / 2);
            this._back.graphics.endFill();
            this._button.graphics.clear();
            if (_color == -1)
            {
                this._button.graphics.beginFill(Style.BUTTON_FACE);
            }
            else
            {
                this._button.graphics.beginFill(_color);
            }
            this._button.graphics.drawCircle(_width / 2, _height / 2, _width / 2 - 2);
            this._label.x = _width + 2;
            this._label.y = _height / 2 - this._label.height / 2;
            this._label.text = this._labelText;
            return;
        }// end function

        private function onClick(event:MouseEvent) : void
        {
            if (_enabled)
            {
                if (this._group != "")
                {
                    this.selected = true;
                }
                else
                {
                    this.selected = !this._selected;
                }
            }
            return;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
            this._button.visible = this._selected;
            if (this._selected)
            {
                clear(this);
            }
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
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

        public function set group(param1:String) : void
        {
            this._group = param1;
            return;
        }// end function

        public function get group() : String
        {
            return this._group;
        }// end function

        private static function addButton(param1:RadioButton) : void
        {
            if (buttons == null)
            {
                buttons = new Array();
            }
            buttons.push(param1);
            return;
        }// end function

        private static function clear(param1:RadioButton) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < buttons.length)
            {
                
                if (buttons[_loc_2] != param1 && buttons[_loc_2]._group == param1.group)
                {
                    buttons[_loc_2].selected = false;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

    }
}
