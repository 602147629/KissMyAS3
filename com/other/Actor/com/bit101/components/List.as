package com.bit101.components
{
    import flash.display.*;

    public class List extends Component
    {
        private var _bgPanel:Panel;
        private var _content:Sprite;
        private var _contentMask:Shape;
        private var _vSlider:VSlider;
        private var _itemArray:Array;
        private var _labelArray:Array;
        private var _rows:uint = 1;
        private var _rowHeight:uint = 20;
        private var _selectedItem:Object;
        private var _autoHeight:Boolean = true;
        private var _selectable:Boolean = true;
        private var _textColor:int = -1;
        private var _orientation:String;
        private var _overshow:Boolean = false;
        public static const UP:String = "up";
        public static const DOWN:String = "down";

        public function List(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:Function = null)
        {
            this._itemArray = [];
            this._labelArray = [];
            super(param1, param2, param3);
            if (param4 != null)
            {
                addEventListener(Event.CHANGE, param4);
            }
            _roundCorner = 7;
            _borderColor = 8410936;
            var _loc_5:* = 16709562;
            _bgColor = 16709562;
            _color = _loc_5;
            _border = 1;
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
            this._bgPanel = new Panel(this, 0, 0);
            this._bgPanel.color = 13421772;
            this._content = new Sprite();
            addChild(this._content);
            this._contentMask = new Shape();
            addChild(this._contentMask);
            this._content.mask = this._contentMask;
            this._vSlider = new VSlider(this, 90, 0, this.handleSlide);
            this._vSlider.width = 10;
            addEventListener(MouseEvent.MOUSE_WHEEL, this.handleMouseWheel);
            return;
        }// end function

        private function handleMouseWheel(param1)
        {
            if (this._vSlider.parent != null)
            {
                if (param1.delta > 0)
                {
                    this._vSlider.value = this._vSlider.value + this._rowHeight;
                }
                else
                {
                    this._vSlider.value = this._vSlider.value - this._rowHeight;
                }
                if (this._orientation == UP)
                {
                    this._content.y = this._vSlider.value;
                }
                else
                {
                    this._content.y = -(this._vSlider.maximum - this._vSlider.value);
                }
            }
            return;
        }// end function

        private function handleSlide(param1)
        {
            if (this._orientation == UP)
            {
                this._content.y = this._vSlider.value;
            }
            else
            {
                this._content.y = -(this._vSlider.maximum - this._vSlider.value);
            }
            return;
        }// end function

        private function handleLabelClick(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (this._selectedItem != null)
            {
                if (this._selectable)
                {
                    if (this._selectedItem._bindingPushButton.data.forceColor == null)
                    {
                        if (this._selectedItem.color != null)
                        {
                            this._selectedItem._bindingPushButton.color = this._selectedItem.color;
                        }
                        else
                        {
                            this._selectedItem._bindingPushButton.color = _color;
                        }
                    }
                    else
                    {
                        this._selectedItem._bindingPushButton.color = this._selectedItem._bindingPushButton.data.forceColor;
                    }
                }
            }
            this._selectedItem = _loc_2.data;
            if (this._selectable)
            {
                this._selectedItem._bindingPushButton.color = Style.SELECTED_ITEM;
            }
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        private function handleLabelRollOver(param1)
        {
            var _loc_2:* = undefined;
            if (this._overshow)
            {
                _loc_2 = param1.currentTarget;
                _loc_2.data._bindingPushButton.color = Style.SELECTED_ITEM;
            }
            return;
        }// end function

        private function handleLabelRollOut(param1)
        {
            var _loc_2:* = undefined;
            if (this._overshow)
            {
                _loc_2 = param1.currentTarget;
                if (this._overshow)
                {
                    if (_loc_2.data.color != null)
                    {
                        _loc_2.data._bindingPushButton.color = _loc_2.data.color;
                    }
                    else
                    {
                        _loc_2.data._bindingPushButton.color = _color;
                    }
                }
            }
            return;
        }// end function

        private function subAddItem(param1)
        {
            this._itemArray.push(param1);
            if (param1 == null)
            {
                param1 = {};
            }
            if (param1.label == null)
            {
                param1.label = "";
            }
            var _loc_2:* = new Panel(this._content, 0, 0);
            _loc_2.buttonMode = true;
            _loc_2.shadow = _shadow;
            _loc_2.height = this._rowHeight;
            _loc_2.color = _color;
            if (param1.tip != null)
            {
                _loc_2.tip = param1.tip;
            }
            var _loc_3:* = new Label(_loc_2, 0, 0, param1.label);
            if (this._textColor != -1)
            {
                _loc_3.textColor = this._textColor;
            }
            _loc_2.addEventListener(MouseEvent.CLICK, this.handleLabelClick);
            _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.handleLabelRollOver);
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.handleLabelRollOut);
            if (param1.color != null)
            {
                _loc_2.color = param1.color;
            }
            if (param1.icon != null)
            {
                _loc_2.content.addChild(param1.icon);
                param1.icon.mouseEnabled = false;
                param1.icon.mouseChildren = false;
            }
            param1._bindingPushButton = _loc_2;
            param1._bindingLabel = _loc_3;
            _loc_2.data = param1;
            this._labelArray.push(_loc_2);
            return _loc_2;
        }// end function

        public function sortOn(param1:Object, param2:Object = null) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = this._itemArray.concat();
            _loc_3 = 0;
            while (_loc_3 < this._labelArray.length)
            {
                
                this._labelArray[_loc_3].removeEventListener(MouseEvent.CLICK, this.handleLabelClick);
                this._labelArray[_loc_3].removeEventListener(MouseEvent.ROLL_OVER, this.handleLabelRollOver);
                this._labelArray[_loc_3].removeEventListener(MouseEvent.ROLL_OUT, this.handleLabelRollOut);
                this._content.removeChild(this._labelArray[_loc_3]);
                delete this._labelArray[_loc_3];
                delete this._itemArray[_loc_3];
                _loc_3 = _loc_3 + 1;
            }
            this._labelArray = [];
            this._itemArray = [];
            _loc_4.sortOn(param1, param2);
            this.setItems(_loc_4);
            this.draw();
            return;
        }// end function

        public function addItem(param1) : Panel
        {
            return this.subAddItem(param1);
        }// end function

        public function removeAll()
        {
            var _loc_1:* = undefined;
            _loc_1 = 0;
            while (_loc_1 < this._labelArray.length)
            {
                
                this._labelArray[_loc_1].removeEventListener(MouseEvent.CLICK, this.handleLabelClick);
                this._labelArray[_loc_1].removeEventListener(MouseEvent.ROLL_OVER, this.handleLabelRollOver);
                this._labelArray[_loc_1].removeEventListener(MouseEvent.ROLL_OUT, this.handleLabelRollOut);
                this._content.removeChild(this._labelArray[_loc_1]);
                delete this._labelArray[_loc_1];
                delete this._itemArray[_loc_1];
                _loc_1 = _loc_1 + 1;
            }
            this._labelArray = [];
            this._itemArray = [];
            this._content.y = 0;
            this.draw();
            return;
        }// end function

        public function setItems(param1:Array)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            this.removeAll();
            if (param1 != null)
            {
                _loc_3 = [];
                _loc_2 = 0;
                while (_loc_2 < param1.length)
                {
                    
                    _loc_3.push(this.subAddItem(param1[_loc_2]));
                    _loc_2 = _loc_2 + 1;
                }
                this.draw();
                return _loc_3;
            }
            return;
        }// end function

        public function close()
        {
            return;
        }// end function

        override public function draw() : void
        {
            var _loc_1:* = undefined;
            super.draw();
            this._bgPanel.alpha = _alpha;
            this._bgPanel.roundCorner = _roundCorner;
            this._bgPanel.borderColor = _borderColor;
            this._bgPanel.color = _bgColor;
            this._bgPanel.border = _border;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (Math.ceil(this._itemArray.length / this._rows) * this._rowHeight <= _height)
            {
                if (this._vSlider.parent == this)
                {
                    removeChild(this._vSlider);
                }
                if (this._orientation == UP)
                {
                    this._bgPanel.width = _width;
                    if (this._autoHeight)
                    {
                        this._bgPanel.height = Math.ceil(this._itemArray.length / this._rows) * this._rowHeight;
                    }
                    else
                    {
                        this._bgPanel.height = _height;
                    }
                    this._bgPanel.y = -this._bgPanel.height;
                    this._contentMask.graphics.clear();
                    this._contentMask.graphics.beginFill(16711680);
                    this._contentMask.graphics.drawRoundRect(0, -this._bgPanel.height, _width, this._bgPanel.height, _roundCorner, _roundCorner);
                    _loc_1 = 0;
                    while (_loc_1 < this._itemArray.length)
                    {
                        
                        this._labelArray[_loc_1].x = _loc_2 * _width / this._rows;
                        this._labelArray[_loc_1].y = (-(_loc_3 + 1)) * this._rowHeight;
                        this._labelArray[_loc_1].width = _width / this._rows;
                        this._labelArray[_loc_1].height = this._rowHeight;
                        if (this._labelArray[_loc_1].data.color != null)
                        {
                            this._labelArray[_loc_1].color = this._labelArray[_loc_1].data.color;
                        }
                        else
                        {
                            this._labelArray[_loc_1].color = _color;
                        }
                        _loc_2 = _loc_2 + 1;
                        if (_loc_2 >= this._rows)
                        {
                            _loc_2 = 0;
                            _loc_3 = _loc_3 + 1;
                        }
                        _loc_1 = _loc_1 + 1;
                    }
                }
                else
                {
                    this._bgPanel.width = _width;
                    if (this._autoHeight)
                    {
                        this._bgPanel.height = Math.ceil(this._itemArray.length / this._rows) * this._rowHeight;
                    }
                    else
                    {
                        this._bgPanel.height = _height;
                    }
                    this._bgPanel.y = 0;
                    this._contentMask.graphics.clear();
                    this._contentMask.graphics.beginFill(16711680);
                    this._contentMask.graphics.drawRoundRect(0, 0, _width, this._bgPanel.height, _roundCorner, _roundCorner);
                    _loc_1 = 0;
                    while (_loc_1 < this._itemArray.length)
                    {
                        
                        this._labelArray[_loc_1].x = _loc_2 * _width / this._rows;
                        this._labelArray[_loc_1].y = _loc_3 * this._rowHeight;
                        this._labelArray[_loc_1].width = _width / this._rows;
                        this._labelArray[_loc_1].height = this._rowHeight;
                        if (this._labelArray[_loc_1].data.color != null)
                        {
                            this._labelArray[_loc_1].color = this._labelArray[_loc_1].data.color;
                        }
                        else
                        {
                            this._labelArray[_loc_1].color = _color;
                        }
                        _loc_2 = _loc_2 + 1;
                        if (_loc_2 >= this._rows)
                        {
                            _loc_2 = 0;
                            _loc_3 = _loc_3 + 1;
                        }
                        _loc_1 = _loc_1 + 1;
                    }
                }
            }
            else
            {
                this._vSlider.height = _height;
                this._vSlider.x = _width - this._vSlider.width;
                if (this._vSlider.parent != this)
                {
                    addChild(this._vSlider);
                }
                if (this._orientation == UP)
                {
                    this._vSlider.y = -_height;
                    this._vSlider.value = this._content.y;
                    this._bgPanel.width = _width;
                    this._bgPanel.height = _height;
                    this._bgPanel.y = -this._bgPanel.height;
                    this._contentMask.graphics.clear();
                    this._contentMask.graphics.beginFill(16711680);
                    this._contentMask.graphics.drawRoundRect(0, -this._bgPanel.height, _width, this._bgPanel.height, _roundCorner, _roundCorner);
                    _loc_1 = 0;
                    while (_loc_1 < this._itemArray.length)
                    {
                        
                        this._labelArray[_loc_1].x = _loc_2 * (_width - this._vSlider.width) / this._rows;
                        this._labelArray[_loc_1].y = (-(_loc_3 + 1)) * this._rowHeight;
                        this._labelArray[_loc_1].width = (_width - this._vSlider.width) / this._rows;
                        this._labelArray[_loc_1].height = this._rowHeight;
                        if (this._labelArray[_loc_1].data.color != null)
                        {
                            this._labelArray[_loc_1].color = this._labelArray[_loc_1].data.color;
                        }
                        else
                        {
                            this._labelArray[_loc_1].color = _color;
                        }
                        _loc_2 = _loc_2 + 1;
                        if (_loc_2 >= this._rows)
                        {
                            _loc_2 = 0;
                            _loc_3 = _loc_3 + 1;
                        }
                        _loc_1 = _loc_1 + 1;
                    }
                }
                else
                {
                    this._vSlider.value = this._vSlider.maximum - this._content.y;
                    this._vSlider.y = 0;
                    this._bgPanel.width = _width;
                    this._bgPanel.height = _height;
                    this._bgPanel.y = 0;
                    this._contentMask.graphics.clear();
                    this._contentMask.graphics.beginFill(16711680);
                    this._contentMask.graphics.drawRoundRect(0, 0, _width, this._bgPanel.height, _roundCorner, _roundCorner);
                    _loc_1 = 0;
                    while (_loc_1 < this._itemArray.length)
                    {
                        
                        this._labelArray[_loc_1].x = _loc_2 * (_width - this._vSlider.width) / this._rows;
                        this._labelArray[_loc_1].y = _loc_3 * this._rowHeight;
                        this._labelArray[_loc_1].width = (_width - this._vSlider.width) / this._rows;
                        this._labelArray[_loc_1].height = this._rowHeight;
                        if (this._labelArray[_loc_1].data.color != null)
                        {
                            this._labelArray[_loc_1].color = this._labelArray[_loc_1].data.color;
                        }
                        else
                        {
                            this._labelArray[_loc_1].color = _color;
                        }
                        _loc_2 = _loc_2 + 1;
                        if (_loc_2 >= this._rows)
                        {
                            _loc_2 = 0;
                            _loc_3 = _loc_3 + 1;
                        }
                        _loc_1 = _loc_1 + 1;
                    }
                }
                this._vSlider.maximum = _loc_3 * this._rowHeight - _height;
                this._vSlider.handleSize = Math.max(10, _height * _height / (_loc_3 * this._rowHeight));
                this._vSlider.value = this._vSlider.maximum;
            }
            return;
        }// end function

        public function getRow(param1)
        {
            return param1._bindingPushButton;
        }// end function

        public function setSelectedItem(param1:Object, param2 = false) : void
        {
            var _loc_3:* = undefined;
            if (param1 == null)
            {
                if (this._selectedItem != null)
                {
                    if (this._selectable)
                    {
                        if (this._selectedItem._bindingPushButton.data.forceColor == null)
                        {
                            if (this._selectedItem.color != null)
                            {
                                this._selectedItem._bindingPushButton.color = this._selectedItem.color;
                            }
                            else
                            {
                                this._selectedItem._bindingPushButton.color = _color;
                            }
                        }
                        else
                        {
                            this._selectedItem._bindingPushButton.color = this._selectedItem._bindingPushButton.data.forceColor;
                        }
                    }
                }
                this._selectedItem = param1;
                return;
            }
            _loc_3 = 0;
            while (_loc_3 < this._labelArray.length)
            {
                
                if (this._labelArray[_loc_3].data == param1)
                {
                    if (this._selectedItem != null)
                    {
                        if (this._selectable)
                        {
                            if (this._selectedItem._bindingPushButton.data.forceColor == null)
                            {
                                if (this._selectedItem.color != null)
                                {
                                    this._selectedItem._bindingPushButton.color = this._selectedItem.color;
                                }
                                else
                                {
                                    this._selectedItem._bindingPushButton.color = _color;
                                }
                            }
                            else
                            {
                                this._selectedItem._bindingPushButton.color = this._selectedItem._bindingPushButton.data.forceColor;
                            }
                        }
                    }
                    this._selectedItem = param1;
                    if (this._selectedItem != null)
                    {
                        if (this._selectable)
                        {
                            this._selectedItem._bindingPushButton.color = Style.SELECTED_ITEM;
                        }
                        else if (this._selectedItem._bindingPushButton.data.forceColor != null)
                        {
                            this._selectedItem._bindingPushButton.color = this._selectedItem._bindingPushButton.data.forceColor;
                        }
                    }
                    this._vSlider.value = this._vSlider.maximum - Math.floor(_loc_3 / this._rows) * this._rowHeight;
                    this._content.y = -(this._vSlider.maximum - this._vSlider.value);
                    if (param2)
                    {
                        dispatchEvent(new Event(Event.CHANGE));
                    }
                    return;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function set selectedItem(param1:Object) : void
        {
            this.setSelectedItem(param1, true);
            return;
        }// end function

        public function scrollToItem(param1)
        {
            var _loc_2:* = undefined;
            _loc_2 = 0;
            while (_loc_2 < this._labelArray.length)
            {
                
                if (this._labelArray[_loc_2].data == param1)
                {
                    this.scrollY = Math.min(this._labelArray.length * this._rowHeight, Math.max(0, _loc_2 * this._rowHeight - _height / 2));
                    return;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function set scrollY(param1)
        {
            this._content.y = -param1;
            this._vSlider.value = this._content.y + this._vSlider.maximum;
            return;
        }// end function

        public function get scrollY()
        {
            return this._content.y;
        }// end function

        public function get selectedItem() : Object
        {
            return this._selectedItem;
        }// end function

        public function set rows(param1:uint) : void
        {
            this._rows = param1;
            this.draw();
            return;
        }// end function

        public function get rows() : uint
        {
            return this._rows;
        }// end function

        public function set rowHeight(param1:uint) : void
        {
            this._rowHeight = param1;
            this.draw();
            return;
        }// end function

        public function get rowHeight() : uint
        {
            return this._rowHeight;
        }// end function

        public function set textColor(param1:Number) : void
        {
            var _loc_2:* = undefined;
            this._textColor = param1;
            _loc_2 = 0;
            while (_loc_2 < this._labelArray.length)
            {
                
                this._labelArray[_loc_2].textColor = param1;
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function get textColor() : Number
        {
            return this._textColor;
        }// end function

        public function set orientation(param1:String) : void
        {
            this._orientation = param1;
            this.draw();
            return;
        }// end function

        public function get orientation() : String
        {
            return this._orientation;
        }// end function

        public function set itemArray(param1:Array) : void
        {
            this.setItems(param1);
            return;
        }// end function

        public function get itemArray() : Array
        {
            return this._itemArray;
        }// end function

        public function set autoHeight(param1:Boolean) : void
        {
            this._autoHeight = param1;
            this.draw();
            return;
        }// end function

        public function get autoHeight() : Boolean
        {
            return this._autoHeight;
        }// end function

        public function set selectable(param1:Boolean) : void
        {
            this._selectable = param1;
            if (!this._selectable)
            {
                if (this._selectedItem != null)
                {
                    if (this._selectedItem._bindingPushButton.data.forceColor == null)
                    {
                        if (this._selectedItem.color != null)
                        {
                            this._selectedItem._bindingPushButton.color = this._selectedItem.color;
                        }
                        else
                        {
                            this._selectedItem._bindingPushButton.color = _color;
                        }
                    }
                    else
                    {
                        this._selectedItem._bindingPushButton.color = this._selectedItem._bindingPushButton.data.forceColor;
                    }
                }
            }
            else if (this._selectedItem != null)
            {
                this._selectedItem._bindingPushButton.color = Style.SELECTED_ITEM;
            }
            return;
        }// end function

        public function get selectable() : Boolean
        {
            return this._selectable;
        }// end function

        public function get length() : uint
        {
            return this._itemArray.length;
        }// end function

        override public function set shadow(param1:uint) : void
        {
            var _loc_2:* = undefined;
            super.shadow = param1;
            for (_loc_2 in this._labelArray)
            {
                
                this._labelArray[_loc_2].shadow = _shadow;
            }
            return;
        }// end function

        public function set bgShadow(param1:uint) : void
        {
            this._bgPanel.shadow = param1;
            return;
        }// end function

        public function set overshow(param1:Boolean) : void
        {
            this._overshow = param1;
            return;
        }// end function

    }
}
