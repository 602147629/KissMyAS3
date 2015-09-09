package com.bit101.components
{
    import flash.display.*;

    public class PushButtonList extends Component
    {
        private var _buttonList:Array;
        private var _currentButton:PushButton;
        private var _opening:Boolean = false;
        private var _selectedIndex:uint;
        private var _orientation:uint = 0;

        public function PushButtonList(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:Function = null)
        {
            this._buttonList = [];
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
            setSize(50, 20);
            return;
        }// end function

        override protected function addChildren() : void
        {
            return;
        }// end function

        override public function draw() : void
        {
            var _loc_1:* = undefined;
            super.draw();
            if (this._buttonList.length == 0)
            {
                return;
            }
            if (this._currentButton.parent != this)
            {
                addChild(this._currentButton);
            }
            this._currentButton.x = 0;
            this._currentButton.y = 0;
            var _loc_2:* = 0;
            if (this._opening)
            {
                _loc_1 = this._buttonList.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    this._buttonList[_loc_1].width = _width;
                    this._buttonList[_loc_1].height = _height;
                    if (this._buttonList[_loc_1] != this._currentButton)
                    {
                        if (this._buttonList[_loc_1].parent != this)
                        {
                            addChild(this._buttonList[_loc_1]);
                        }
                        if (this._orientation == 1)
                        {
                            this._buttonList[_loc_1].x = _loc_2 + _width;
                            this._buttonList[_loc_1].y = 0;
                            _loc_2 = _loc_2 + _width;
                        }
                        else if (this._orientation == 2)
                        {
                            this._buttonList[_loc_1].x = 0;
                            this._buttonList[_loc_1].y = _loc_2 + _height;
                            _loc_2 = _loc_2 + _height;
                        }
                        else if (this._orientation == 3)
                        {
                            this._buttonList[_loc_1].x = _loc_2 - _width;
                            this._buttonList[_loc_1].y = 0;
                            _loc_2 = _loc_2 - _width;
                        }
                        else
                        {
                            this._buttonList[_loc_1].x = 0;
                            this._buttonList[_loc_1].y = _loc_2 - _height;
                            _loc_2 = _loc_2 - _height;
                        }
                    }
                    else
                    {
                        this._selectedIndex = _loc_1;
                    }
                    _loc_1 = _loc_1 - 1;
                }
            }
            else
            {
                _loc_1 = this._buttonList.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    this._buttonList[_loc_1].width = _width;
                    this._buttonList[_loc_1].height = _height;
                    if (this._buttonList[_loc_1] != this._currentButton)
                    {
                        if (this._buttonList[_loc_1].parent == this)
                        {
                            removeChild(this._buttonList[_loc_1]);
                        }
                    }
                    else
                    {
                        this._selectedIndex = _loc_1;
                    }
                    _loc_1 = _loc_1 - 1;
                }
            }
            return;
        }// end function

        public function addButtons(param1:Array) : Array
        {
            var _loc_2:* = undefined;
            var _loc_3:* = [];
            _loc_2 = 0;
            while (_loc_2 < param1.length)
            {
                
                _loc_3.push(this.addPushButton(param1[_loc_2]));
                _loc_2 = _loc_2 + 1;
            }
            this.draw();
            return _loc_3;
        }// end function

        public function addButton(param1:String) : PushButton
        {
            var _loc_2:* = this.addPushButton(param1);
            this.draw();
            return _loc_2;
        }// end function

        private function addPushButton(param1:String) : PushButton
        {
            var _loc_2:* = new PushButton(this, 0, 0, param1, this.handleButtonClick);
            _loc_2.setTable("table18", "table31");
            _loc_2.textColor = Style.GOLD_FONT;
            if (this._buttonList.length == 0)
            {
                this._currentButton = _loc_2;
            }
            this._buttonList.push(_loc_2);
            return _loc_2;
        }// end function

        private function handleButtonClick(param1)
        {
            var _loc_2:* = undefined;
            if (_enabled)
            {
                _loc_2 = false;
                if (this._currentButton != param1.currentTarget)
                {
                    this._currentButton = param1.currentTarget;
                    _loc_2 = true;
                }
                this.opening = !this.opening;
                if (_loc_2)
                {
                    dispatchEvent(new Event(Event.CHANGE));
                }
            }
            return;
        }// end function

        private function handleClickOutside(param1)
        {
            if (!hitTestPoint(_stage.mouseX, _stage.mouseY))
            {
                this.opening = false;
            }
            return;
        }// end function

        public function set orientation(param1:uint) : void
        {
            this._orientation = param1;
            this.draw();
            return;
        }// end function

        public function get orientation() : uint
        {
            return this._orientation;
        }// end function

        public function set opening(param1:Boolean) : void
        {
            this._opening = param1;
            this.draw();
            if (_stage != null)
            {
                _stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
            }
            if (this._opening)
            {
                _stage.addEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
            }
            return;
        }// end function

        public function get opening() : Boolean
        {
            return this._opening;
        }// end function

        public function set selectedIndex(param1:uint) : void
        {
            this._selectedIndex = param1;
            this._currentButton = this._buttonList[this._selectedIndex];
            this.draw();
            return;
        }// end function

        public function get selectedIndex() : uint
        {
            return this._selectedIndex;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            this.opening = false;
            return;
        }// end function

        override public function set color(param1:int) : void
        {
            var _loc_2:* = undefined;
            _color = param1;
            for (_loc_2 in this._buttonList)
            {
                
                this._buttonList[_loc_2].color = _color;
            }
            return;
        }// end function

        override public function set subColor(param1:int) : void
        {
            var _loc_2:* = undefined;
            _subColor = param1;
            for (_loc_2 in this._buttonList)
            {
                
                this._buttonList[_loc_2].subColor = _subColor;
            }
            return;
        }// end function

        override public function set borderColor(param1:int) : void
        {
            var _loc_2:* = undefined;
            _borderColor = param1;
            for (_loc_2 in this._buttonList)
            {
                
                this._buttonList[_loc_2].borderColor = _borderColor;
            }
            return;
        }// end function

        override public function set border(param1:uint) : void
        {
            var _loc_2:* = undefined;
            _border = param1;
            for (_loc_2 in this._buttonList)
            {
                
                this._buttonList[_loc_2].border = _border;
            }
            return;
        }// end function

    }
}
