package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class Window extends Sprite
    {
        var _container:DisplayObjectContainer;
        public var _opening:Object = false;
        public var _dragBar:Table;
        public var _closeBtn:PushButton;
        private var _preMouseX:Object;
        private var _preMouseY:Object;
        private var _preWindowX:Object;
        private var _preWindowY:Object;
        private var _titleTxt:TextField;
        protected var _width:Number = 0;
        protected var _height:Number = 0;
        protected var _data:Object;
        protected var _bgTable:Table;
        private var _active:Boolean = false;
        public var _obStack:Array;
        public var _obCount:int = 0;
        public var _frameCount:int = 0;
        private var _clickStack:Array;
        private var _clickColor:int = 0;
        public static var _activeWindow:Window;
        private static var _openingWindowArray:Array = [];

        public function Window(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            this._obStack = [];
            this._clickStack = [];
            this._bgTable = new Table("table8");
            addChild(this._bgTable);
            x = param2;
            y = param3;
            if (param1 != null)
            {
                param1.addChild(this);
            }
            this._container = param1;
            this._dragBar = new Table("table12");
            this._dragBar.x = -10;
            addChild(this._dragBar);
            this._dragBar.addEventListener(MouseEvent.MOUSE_DOWN, this.handleDragBarDrag);
            this._titleTxt = Config.getSimpleTextField();
            this._titleTxt.y = 2;
            this._titleTxt.textColor = Style.WHITE_FONT;
            addChild(this._titleTxt);
            this._closeBtn = new PushButton(this, 0, 4, "", this.handleCloseBtn);
            this._closeBtn.overshow = true;
            this._closeBtn.setStyle(Config.findUI("window")["closebutton"]);
            addEventListener(MouseEvent.MOUSE_DOWN, this.handleBgMouseDown);
            this.closable = true;
            this._container.removeChild(this);
            this.active = false;
            filters = [new DropShadowFilter(3, 45, 0, 0.5)];
            this.cacheAsBitmap = true;
            return;
        }// end function

        public function resize(param1, param2)
        {
            this._width = param1;
            this._height = param2;
            this._bgTable.resize(param1, param2);
            this._closeBtn.x = this._width - 17;
            this._dragBar.resize(param1 + 20);
            this._titleTxt.x = (this._width - this._titleTxt.width) / 2;
            return;
        }// end function

        function handleBgMouseDown(param1)
        {
            this.active = true;
            return;
        }// end function

        protected function handleCloseBtn(param1)
        {
            this.close();
            return;
        }// end function

        private function openArrayAdd()
        {
            this.openArrayRemove();
            _openingWindowArray.push(this);
            return;
        }// end function

        private function openArrayRemove()
        {
            var _loc_1:* = undefined;
            _loc_1 = 0;
            while (_loc_1 < _openingWindowArray.length)
            {
                
                if (_openingWindowArray[_loc_1] == this)
                {
                    _openingWindowArray.splice(_loc_1, 1);
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function open(event:MouseEvent = null)
        {
            if (!this._opening)
            {
                this.active = true;
                this._opening = true;
            }
            this._container.addChild(this);
            this.testGuide();
            this.openArrayAdd();
            this.dispatchEvent(new Event("open"));
            return;
        }// end function

        public function close()
        {
            if (this._opening)
            {
                this.active = false;
                if (this.parent != null)
                {
                    this.parent.removeChild(this);
                }
                this._opening = false;
                this.dispatchEvent(new Event("close"));
            }
            this.openArrayRemove();
            return;
        }// end function

        public function switchOpen() : void
        {
            if (parent == this._container)
            {
                this.close();
            }
            else
            {
                this.open();
            }
            return;
        }// end function

        public function handleDragBarMove(param1)
        {
            x = Math.max(0, Math.min(this._preWindowX + this._container.mouseX - this._preMouseX, Config.map._mapWidth - this.width));
            y = Math.max(0, Math.min(this._preWindowY + this._container.mouseY - this._preMouseY, Config.map._mapHeight - this.height));
            return;
        }// end function

        public function handleDragBarDrag(param1)
        {
            this._preMouseX = this._container.mouseX;
            this._preMouseY = this._container.mouseY;
            this._preWindowX = x;
            this._preWindowY = y;
            Config.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.handleDragBarMove);
            Config.stage.addEventListener(MouseEvent.MOUSE_UP, this.handleDragUp);
            return;
        }// end function

        public function handleDragUp(param1)
        {
            Config.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleDragBarMove);
            Config.stage.removeEventListener(MouseEvent.MOUSE_UP, this.handleDragUp);
            this.dispatchEvent(new Event("windowmove"));
            return;
        }// end function

        public function handleMouseMove()
        {
            return;
        }// end function

        public function handleMouseDown()
        {
            return;
        }// end function

        public function handleMouseUp()
        {
            return;
        }// end function

        override public function get width() : Number
        {
            return this._width;
        }// end function

        override public function get height() : Number
        {
            return this._height;
        }// end function

        public function set title(param1)
        {
            this._titleTxt.text = param1;
            this._titleTxt.x = (this._width - this._titleTxt.width) / 2;
            return;
        }// end function

        public function get title()
        {
            return this._titleTxt.text;
        }// end function

        public function set draggable(param1)
        {
            this._dragBar.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleDragBarDrag);
            if (param1)
            {
                this._dragBar.addEventListener(MouseEvent.MOUSE_DOWN, this.handleDragBarDrag);
            }
            return;
        }// end function

        public function set closable(param1)
        {
            if (param1)
            {
                this._dragBar.setTable("table12");
                if (this._closeBtn.parent != this)
                {
                    addChild(this._closeBtn);
                }
            }
            else
            {
                this._dragBar.setTable("table3");
                if (this._closeBtn.parent == this)
                {
                    removeChild(this._closeBtn);
                }
            }
            return;
        }// end function

        public function get closable()
        {
            if (this._closeBtn.parent == this)
            {
                return true;
            }
            return false;
        }// end function

        public function set active(param1)
        {
            if (param1)
            {
                if (_activeWindow != this && _activeWindow != null)
                {
                    _activeWindow.active = false;
                }
                _activeWindow = this;
                this._container.addChild(this);
                this.openArrayAdd();
            }
            else if (_activeWindow == this)
            {
                _activeWindow = null;
            }
            if (this._active != param1)
            {
                this._active = param1;
                this.dispatchEvent(new Event("active"));
            }
            return;
        }// end function

        public function get active() : Boolean
        {
            return this._active;
        }// end function

        public function get container() : DisplayObjectContainer
        {
            return this._container;
        }// end function

        public function set dragBar(param1:Boolean) : void
        {
            if (param1)
            {
                this._dragBar.visible = true;
            }
            else
            {
                this._dragBar.visible = false;
            }
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            this._data = param1;
            return;
        }// end function

        public function get data() : Object
        {
            return this._data;
        }// end function

        public function testGuide()
        {
            return;
        }// end function

        public function playOb(param1:String) : void
        {
            var _loc_2:* = param1.split("|");
            _loc_2.shift();
            this._obStack = _loc_2;
            this._obCount = -1;
            this._frameCount = 0;
            Config.startLoop(this.loopOb);
            return;
        }// end function

        public function stopPlayOb() : void
        {
            Config.stopLoop(this.loopOb);
            return;
        }// end function

        public function getObTotalFrame() : int
        {
            var _loc_1:* = this._obStack[(this._obStack.length - 1)].split("@");
            return int(_loc_1[0]);
        }// end function

        protected function loopOb(param1 = null) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._frameCount >= this._obStack.length)
            {
                Config.stopLoop(this.loopOb);
                return;
            }
            var _loc_5:* = this;
            var _loc_6:* = this._obCount + 1;
            _loc_5._obCount = _loc_6;
            var _loc_2:* = 0;
            while (_loc_2 <= this._obCount)
            {
                
                if (this._frameCount >= this._obStack.length)
                {
                    Config.stopLoop(this.loopOb);
                    return;
                }
                _loc_3 = this._obStack[this._frameCount].split("@");
                _loc_2 = int(_loc_3[0]);
                if (_loc_2 > this._obCount)
                {
                    return;
                }
                var _loc_5:* = this;
                var _loc_6:* = this._frameCount + 1;
                _loc_5._frameCount = _loc_6;
                _loc_4 = _loc_3[1].split(":");
                this.doOb(_loc_4);
            }
            return;
        }// end function

        protected function doOb(param1:Array) : Boolean
        {
            var _loc_2:* = null;
            switch(param1[0])
            {
                case "d":
                {
                    _loc_2 = param1[1].split(",");
                    this.addMouseClick(int(_loc_2[0]), int(_loc_2[1]));
                    return true;
                }
                case "u":
                {
                    _loc_2 = param1[1].split(",");
                    this.addMouseClick(int(_loc_2[0]), int(_loc_2[1]), 26316);
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private function addMouseClick(param1:int, param2:int, param3:int = 13369344) : void
        {
            var _loc_4:* = new Shape();
            new Shape().x = param1;
            _loc_4.y = param2;
            addChild(_loc_4);
            this._clickColor = param3;
            _loc_4.graphics.beginFill(this._clickColor, 1);
            _loc_4.graphics.drawCircle(0, 0, 1);
            _loc_4.graphics.endFill();
            this._clickStack.push({count:0, shape:_loc_4});
            if (this._clickStack.length == 1)
            {
                Config.startLoop(this.mouseClickLoop);
            }
            return;
        }// end function

        private function mouseClickLoop(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this._clickStack.length)
            {
                
                _loc_3 = this._clickStack[_loc_2].shape;
                _loc_4 = this._clickStack[_loc_2].count;
                var _loc_5:* = this._clickStack[_loc_2];
                var _loc_6:* = this._clickStack[_loc_2].count + 1;
                _loc_5.count = _loc_6;
                _loc_3.graphics.clear();
                _loc_3.graphics.beginFill(this._clickColor, 1);
                _loc_3.graphics.drawCircle(0, 0, _loc_4);
                if (_loc_4 > 3)
                {
                    _loc_3.graphics.drawCircle(0, 0, _loc_4 - 3);
                }
                _loc_3.graphics.endFill();
                if (_loc_4 > 10)
                {
                    _loc_3.alpha = (20 - _loc_4) / 10;
                }
                if (_loc_4 > 20)
                {
                    _loc_3.parent.removeChild(_loc_3);
                    this._clickStack.splice(_loc_2, 1);
                    _loc_2 = _loc_2 - 1;
                }
                _loc_2++;
            }
            if (this._clickStack.length == 0)
            {
                Config.stopLoop(this.mouseClickLoop);
            }
            return;
        }// end function

        public static function closeOne()
        {
            var _loc_1:* = undefined;
            if (_openingWindowArray.length > 0)
            {
                _loc_1 = _openingWindowArray.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    if (_openingWindowArray[_loc_1].closable)
                    {
                        _openingWindowArray[_loc_1].close();
                        return;
                    }
                    _loc_1 = _loc_1 - 1;
                }
            }
            return;
        }// end function

    }
}
