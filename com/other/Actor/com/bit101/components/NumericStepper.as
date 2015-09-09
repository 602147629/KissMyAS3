package com.bit101.components
{
    import flash.display.*;
    import flash.events.*;

    public class NumericStepper extends Component
    {
        private var _numberIT:InputText;
        public var _addPB:PushButton;
        private var _addCount:uint;
        private var _minusCount:uint;
        private var _minusPB:PushButton;
        private var _maxPB:PushButton;
        protected var _max:Number = 1000;
        protected var _min:Number = 0;
        public var _value:Object = 0;
        private var _hasButton:Boolean = true;
        private var _percent:Boolean = false;

        public function NumericStepper(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:Function = null)
        {
            super(param1, param2, param3);
            if (param4 != null)
            {
                addEventListener(Event.CHANGE, param4);
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
            this._numberIT = new InputText(this, 20, 0, "0", this.handleNumberITChange);
            this._numberIT.width = 20;
            this._numberIT.height = 20;
            this._numberIT.restrict = "0-9";
            this._numberIT._tf.addEventListener(FocusEvent.FOCUS_OUT, this.textFout);
            this._addPB = new PushButton(this, 0, 0, "+");
            this._addPB.setTable("table18", "table31");
            this._addPB.textColor = Style.GOLD_FONT;
            this._addPB.addEventListener(MouseEvent.MOUSE_DOWN, this.handleAddMouseDown);
            this._addPB.setSize(20, 20);
            this._minusPB = new PushButton(this, 0, 0, "-");
            this._minusPB.setTable("table18", "table31");
            this._minusPB.textColor = Style.GOLD_FONT;
            this._minusPB.addEventListener(MouseEvent.MOUSE_DOWN, this.handleMinusMouseDown);
            this._minusPB.setSize(20, 20);
            this._maxPB = new PushButton(this, 56, 0, Config.language("NumericStepper", 1), this.handleMaxClick);
            this._maxPB.setTable("table18", "table31");
            this._maxPB.textColor = Style.GOLD_FONT;
            this._maxPB.setSize(32, 20);
            return;
        }// end function

        private function handleMaxClick(param1)
        {
            this.value = this._max;
            dispatchEvent(new Event("add"));
            return;
        }// end function

        private function handleNumberITChange(param1) : void
        {
            this.value = Number(this._numberIT.text);
            return;
        }// end function

        private function handleAddMouseDown(param1) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this.value + 1;
            _loc_2.value = _loc_3;
            this._addCount = 0;
            _stage.addEventListener(MouseEvent.MOUSE_UP, this.handleAddMouseUp);
            addEventListener(Event.ENTER_FRAME, this.handleAddLoop);
            return;
        }// end function

        private function handleAddMouseUp(param1) : void
        {
            _stage.removeEventListener(MouseEvent.MOUSE_UP, this.handleAddMouseUp);
            removeEventListener(Event.ENTER_FRAME, this.handleAddLoop);
            return;
        }// end function

        private function handleAddLoop(param1) : void
        {
            if (this._addCount > 10)
            {
                if (this._addCount < 30)
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.value + 1;
                    _loc_2.value = _loc_3;
                }
                else
                {
                    this.value = this.value + 10;
                }
            }
            var _loc_2:* = this;
            var _loc_3:* = this._addCount + 1;
            _loc_2._addCount = _loc_3;
            dispatchEvent(new Event("add"));
            return;
        }// end function

        private function handleMinusMouseDown(param1) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this.value - 1;
            _loc_2.value = _loc_3;
            this._minusCount = 0;
            _stage.addEventListener(MouseEvent.MOUSE_UP, this.handleMinusMouseUp);
            addEventListener(Event.ENTER_FRAME, this.handleMinusLoop);
            return;
        }// end function

        private function handleMinusMouseUp(param1) : void
        {
            _stage.removeEventListener(MouseEvent.MOUSE_UP, this.handleMinusMouseUp);
            removeEventListener(Event.ENTER_FRAME, this.handleMinusLoop);
            return;
        }// end function

        private function handleMinusLoop(param1) : void
        {
            if (this._minusCount > 10)
            {
                if (this._minusCount < 30)
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.value - 1;
                    _loc_2.value = _loc_3;
                }
                else
                {
                    this.value = this.value - 10;
                }
            }
            var _loc_2:* = this;
            var _loc_3:* = this._minusCount + 1;
            _loc_2._minusCount = _loc_3;
            dispatchEvent(new Event("dec"));
            return;
        }// end function

        override public function draw() : void
        {
            super.draw();
            if (this._hasButton)
            {
                this._addPB.visible = true;
                this._minusPB.visible = true;
                this._maxPB.visible = true;
                this._numberIT.width = _width - 72;
            }
            else
            {
                this._addPB.visible = false;
                this._minusPB.visible = false;
                this._maxPB.visible = false;
                this._numberIT.width = _width;
            }
            this._addPB.x = _width - 52;
            this._maxPB.x = _width - 32;
            return;
        }// end function

        public function set value(param1:Number) : void
        {
            var _loc_2:* = this._value;
            if (param1 < this._min)
            {
                this._value = this._min;
            }
            else if (param1 > this._max)
            {
                this._value = this._max;
            }
            else
            {
                this._value = param1;
            }
            if (this._percent)
            {
                this._numberIT.text = String(this._value) + "%";
            }
            else
            {
                this._numberIT.text = String(this._value);
            }
            if (_loc_2 != this._value)
            {
                dispatchEvent(new Event(Event.CHANGE));
            }
            return;
        }// end function

        public function get value() : Number
        {
            return this._value;
        }// end function

        public function set maximum(param1:Number) : void
        {
            this._max = param1;
            if (this.value > this._max)
            {
                this._value = this._max;
                this.value = this._max;
            }
            return;
        }// end function

        public function get maximum() : Number
        {
            return this._max;
        }// end function

        public function set minimum(param1:Number) : void
        {
            this._min = param1;
            if (this.value < this._min)
            {
                this._value = this._min;
                this.value = this._min;
            }
            return;
        }// end function

        public function get minimum() : Number
        {
            return this._min;
        }// end function

        public function set hasButton(param1)
        {
            this._hasButton = param1;
            this.draw();
            return;
        }// end function

        public function get hasButton()
        {
            return this._hasButton;
        }// end function

        public function set percent(param1)
        {
            this._percent = param1;
            param1 = param1;
            return;
        }// end function

        public function get percent()
        {
            return this._percent;
        }// end function

        public function set maxVisible(param1:Boolean) : void
        {
            if (param1)
            {
                this.addChild(this._maxPB);
            }
            else if (this._maxPB.parent != null)
            {
                this._maxPB.parent.removeChild(this._maxPB);
            }
            return;
        }// end function

        private function textFout(event:FocusEvent) : void
        {
            dispatchEvent(new Event("FocusOut"));
            return;
        }// end function

        public function get focus() : Boolean
        {
            return this._numberIT.focus;
        }// end function

    }
}
