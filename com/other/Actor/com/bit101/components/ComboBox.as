package com.bit101.components
{
    import flash.display.*;
    import flash.text.*;

    public class ComboBox extends Component
    {
        private var _valueIT:InputText;
        private var _openPB:PushButton;
        private var _comboList:List;
        private var _labelArray:Array;
        private var _orientation:String;
        private var _showValueIT:Boolean = true;
        private var _btnfuc:Function = null;
        private var _setValueLock:Boolean = false;
        public static const UP:String = "up";
        public static const DOWN:String = "down";

        public function ComboBox(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:Function = null)
        {
            this._labelArray = [];
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
            useHandCursor = true;
            setSize(100, 200);
            return;
        }// end function

        override protected function addChildren() : void
        {
            this._valueIT = new InputText(this, 0, 0, "");
            this._valueIT.width = 80;
            this._openPB = new PushButton(this, 80, 0, "▼", this.handleOpenClick);
            this._openPB.setTable("table18", "table31");
            this._openPB.textColor = Style.GOLD_FONT;
            this._openPB.width = 20;
            this._openPB.height = 20;
            this._comboList = new List(null, 0, 0);
            this._comboList.orientation = this._orientation;
            return;
        }// end function

        private function handleClickOutside(param1)
        {
            if (!hitTestPoint(_stage.mouseX, _stage.mouseY, true))
            {
                this.close();
                dispatchEvent(new Event(Event.CLOSE));
            }
            return;
        }// end function

        public function innerClose()
        {
            this.close();
            dispatchEvent(new Event(Event.CLOSE));
            return;
        }// end function

        private function handleOpenClick(param1)
        {
            if (_enabled)
            {
                _stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
                if (this._comboList.parent == this)
                {
                    removeChild(this._comboList);
                    dispatchEvent(new Event(Event.CLOSE));
                }
                else
                {
                    addChild(this._comboList);
                    _stage.addEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
                    if (this._btnfuc != null)
                    {
                    }
                    dispatchEvent(new Event(Event.OPEN));
                }
            }
            return;
        }// end function

        public function addItem(param1:Object) : Panel
        {
            return this._comboList.addItem(param1);
        }// end function

        public function removeAll()
        {
            this._comboList.removeAll();
            return;
        }// end function

        public function setItems(param1:Array) : Array
        {
            this._comboList.removeAll();
            return this._comboList.setItems(param1);
        }// end function

        public function close()
        {
            _stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
            if (this._comboList.parent == this)
            {
                removeChild(this._comboList);
            }
            return;
        }// end function

        override public function draw() : void
        {
            super.draw();
            if (this._showValueIT)
            {
                if (this._valueIT.parent != this)
                {
                    addChild(this._valueIT);
                }
                this._valueIT.width = _width - this._openPB.width;
                this._valueIT.height = this._openPB.height;
                this._openPB.x = _width - this._openPB.width;
            }
            else if (this._valueIT.parent == this)
            {
                removeChild(this._valueIT);
            }
            if (this._orientation == UP)
            {
                this._comboList.y = 0;
            }
            else
            {
                this._comboList.y = this._openPB.height;
            }
            this._comboList.width = _width;
            this._comboList.height = _height - this._openPB.height;
            this._comboList.addEventListener(Event.CHANGE, this.handleListChange);
            return;
        }// end function

        private function handleListChange(param1)
        {
            this.value = param1.currentTarget.selectedItem.label;
            if (!this._setValueLock)
            {
                dispatchEvent(new Event(Event.CHANGE));
            }
            this.close();
            dispatchEvent(new Event(Event.CLOSE));
            return;
        }// end function

        public function set rows(param1:uint) : void
        {
            this._comboList.rows = param1;
            this.draw();
            return;
        }// end function

        public function get rows() : uint
        {
            return this._comboList.rows;
        }// end function

        public function set rowHeight(param1:uint) : void
        {
            this._comboList.rowHeight = param1;
            this.draw();
            return;
        }// end function

        public function get rowHeight() : uint
        {
            return this._comboList.rowHeight;
        }// end function

        public function set selectedItem(param1:Object) : void
        {
            this._setValueLock = true;
            this._comboList.selectedItem = param1;
            this._comboList.scrollY = 0;
            if (param1 != null)
            {
                this.value = param1.label;
            }
            else
            {
                this.value = "";
            }
            this._setValueLock = false;
            return;
        }// end function

        public function get selectedItem() : Object
        {
            return this._comboList.selectedItem;
        }// end function

        public function set value(param1:String) : void
        {
            this._valueIT.text = param1;
            return;
        }// end function

        public function get value() : String
        {
            return this._valueIT.text;
        }// end function

        public function set label(param1:String) : void
        {
            this._openPB.label = param1;
            return;
        }// end function

        public function get label() : String
        {
            return this._openPB.label;
        }// end function

        public function get button() : PushButton
        {
            return this._openPB;
        }// end function

        public function get list() : List
        {
            return this._comboList;
        }// end function

        public function set labelWidth(param1:Number) : void
        {
            this._openPB.width = param1;
            this.draw();
            return;
        }// end function

        public function get labelWidth() : Number
        {
            return this._openPB.width;
        }// end function

        public function set labelHeight(param1:Number) : void
        {
            this._openPB.height = param1;
            this.draw();
            return;
        }// end function

        public function get labelHeight() : Number
        {
            return this._openPB.height;
        }// end function

        public function get editable() : Boolean
        {
            return this._valueIT.selectable;
        }// end function

        public function set editable(param1:Boolean) : void
        {
            this._valueIT.selectable = param1;
            return;
        }// end function

        public function set textColor(param1:Number) : void
        {
            this._comboList.textColor = param1;
            return;
        }// end function

        public function get textColor() : Number
        {
            return this._comboList.textColor;
        }// end function

        public function set orientation(param1:String) : void
        {
            this._orientation = param1;
            this._comboList.orientation = this._orientation;
            this.draw();
            return;
        }// end function

        public function get orientation() : String
        {
            return this._orientation;
        }// end function

        public function set showValue(param1:Boolean) : void
        {
            this._showValueIT = param1;
            this._openPB.x = 0;
            this.draw();
            return;
        }// end function

        public function get showValue() : Boolean
        {
            return this._showValueIT;
        }// end function

        public function set itemArray(param1:Array) : void
        {
            this.setItems(param1);
            return;
        }// end function

        public function get itemArray() : Array
        {
            return this._comboList.itemArray;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            _enabled = param1;
            this._openPB.enabled = _enabled;
            if (_enabled)
            {
                this.tf.type = TextFieldType.DYNAMIC;
                this._openPB.textColor = Style.GOLD_FONT;
            }
            return;
        }// end function

        public function set btnfuc(param1:Function) : void
        {
            this._btnfuc = param1;
            return;
        }// end function

        public function get tf() : TextField
        {
            return this._valueIT.tf;
        }// end function

        public function getItemBackground(param1)
        {
            return param1._bindingPushButton;
        }// end function

    }
}
