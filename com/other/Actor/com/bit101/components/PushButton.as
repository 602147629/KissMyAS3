package com.bit101.components
{
    import flash.display.*;
    import flash.events.*;

    public class PushButton extends Component
    {
        protected var _mode:uint = 0;
        protected var _back:Object;
        protected var _face:Object;
        protected var _label:Label;
        protected var _labelText:String = "";
        protected var _over:Boolean = false;
        protected var _down:Boolean = false;
        protected var _icon:DisplayObject;
        protected var _selected:Boolean = false;
        private var _overshow:Boolean = false;
        private var _privateNameStack:Array;
        public var _style:String = "";
        public var _table:String = "table5";
        private var _cdMax:Object;
        private var _cd:Number = 0;
        private var _cdPreTime:Object;
        private var _cdInterval:Object;
        var _cdShape:Object;
        public static var BUTTOM_MODE:Object = 0;
        public static var CHECK_MODE:Object = 1;
        private static var _styleBuff:Object = {};

        public function PushButton(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0, param4:String = "", param5:Function = null, param6 = null, param7 = null, param8 = null)
        {
            this._privateNameStack = [];
            if (param6 == null)
            {
                if (param7 == null)
                {
                    this._face = new Table("table5");
                    this._back = new Table("table4");
                    this._table = "table5";
                }
                else
                {
                    this._face = new Table(param7);
                    if (param8 == null)
                    {
                        this._back = new Table(param7);
                    }
                    else
                    {
                        this._back = new Table(param8);
                    }
                    this._table = param7;
                }
                this._style = "";
            }
            else
            {
                if (_styleBuff[String(param6.normal.dir)] == null)
                {
                    _styleBuff[String(param6.normal.dir)] = BitmapLoader.pick(String(param6.normal.dir));
                }
                this._face = new Bitmap(_styleBuff[String(param6.normal.dir)]);
                if (_styleBuff[String(param6.hover.dir)] == null)
                {
                    _styleBuff[String(param6.hover.dir)] = BitmapLoader.pick(String(param6.hover.dir));
                }
                this._back = new Bitmap(_styleBuff[String(param6.hover.dir)]);
                this._table = "";
                this._style = String(param6.normal.dir);
            }
            super(param1, param2, param3);
            if (param5 != null)
            {
                addEventListener(MouseEvent.CLICK, param5);
            }
            this.label = param4;
            return;
        }// end function

        public function set mode(param1)
        {
            this._mode = param1;
            this.draw();
            return;
        }// end function

        public function setStyle(param1)
        {
            this._style = String(param1.normal.dir);
            this._table = "";
            removeChild(this._face);
            removeChild(this._back);
            if (_styleBuff[String(param1.normal.dir)] == null)
            {
                _styleBuff[String(param1.normal.dir)] = BitmapLoader.pick(String(param1.normal.dir));
            }
            this._face = new Bitmap(_styleBuff[String(param1.normal.dir)]);
            if (_styleBuff[String(param1.hover.dir)] == null)
            {
                _styleBuff[String(param1.hover.dir)] = BitmapLoader.pick(String(param1.hover.dir));
            }
            this._back = new Bitmap(_styleBuff[String(param1.hover.dir)]);
            addChild(this._back);
            addChild(this._face);
            return;
        }// end function

        public function setTable(param1, param2 = null)
        {
            this._style = "";
            this._table = param1;
            this._face.setTable(param1);
            if (param2 == null)
            {
                this._back.setTable(param1);
            }
            else
            {
                this._back.setTable(param2);
            }
            this.draw();
            return;
        }// end function

        override protected function init() : void
        {
            super.init();
            buttonMode = true;
            useHandCursor = true;
            setSize(100, 20);
            return;
        }// end function

        override protected function addChildren() : void
        {
            this._back.alpha = 0;
            this._face.alpha = 1;
            addChild(this._back);
            addChild(this._face);
            this._cdShape = new Shape();
            addChild(this._cdShape);
            this._label = new Label();
            addChild(this._label);
            this._label.textColor = 5977896;
            addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            addEventListener(MouseEvent.ROLL_OVER, this.onMouseOver);
            return;
        }// end function

        override public function draw() : void
        {
            super.draw();
            if (this._back is Table)
            {
                this._back.resize(_width, _height);
            }
            if (this._face is Table)
            {
                this._face.resize(_width, _height);
            }
            if (this._mode == 1)
            {
                if (this._selected)
                {
                    this._face.alpha = 0;
                    this._back.alpha = 1;
                }
                else
                {
                    this._face.alpha = 1;
                    this._back.alpha = 0;
                }
            }
            this._label.autoSize = true;
            this._label.text = this._labelText;
            this._label.move(this._back.width / 2 - this._label.width / 2, this._back.height / 2 - this._label.height / 2 - 1);
            if (this._icon != null)
            {
                this._icon.x = (this._back.width - this._icon.width) / 2;
                this._icon.y = (this._back.height - this._icon.height) / 2;
            }
            return;
        }// end function

        private function onMouseOver(event:MouseEvent) : void
        {
            if (this._overshow && this._mode == 0)
            {
                this._back.alpha = 1;
                this._face.alpha = 0;
                this._over = true;
                addEventListener(MouseEvent.ROLL_OUT, this.onMouseOut);
            }
            return;
        }// end function

        private function onMouseOut(event:MouseEvent) : void
        {
            removeEventListener(MouseEvent.ROLL_OUT, this.onMouseOut);
            this._over = false;
            if (this._mode == 0)
            {
                if (this._overshow)
                {
                    this._face.alpha = 1;
                    this._back.alpha = 0;
                }
                else if (!this._down && !this._selected)
                {
                    this._face.alpha = 1;
                }
            }
            return;
        }// end function

        private function onMouseDown(event:MouseEvent) : void
        {
            this._down = true;
            if (_enabled)
            {
                if (this._mode == 0)
                {
                    if (!this._overshow)
                    {
                        this._back.alpha = 1;
                        this._face.alpha = 0;
                    }
                }
                if (_stage != null)
                {
                    _stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
                }
            }
            return;
        }// end function

        private function onMouseUp(event:MouseEvent) : void
        {
            this._down = false;
            if (this._mode == 0)
            {
                if (!this._overshow)
                {
                    this._face.alpha = 1;
                    this._back.alpha = 0;
                }
            }
            if (_stage != null)
            {
                _stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            }
            return;
        }// end function

        public function set label(param1:String) : void
        {
            this._labelText = param1;
            this.draw();
            invalidate();
            return;
        }// end function

        public function get label() : String
        {
            return this._labelText;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            this._label.enabled = param1;
            this.mouseEnabled = param1;
            if (param1)
            {
                this.highlight = highlight;
                this.mouseEnabled = true;
                this.mouseChildren = true;
            }
            else
            {
                this.highlight = false;
                this.mouseEnabled = false;
                this.mouseChildren = false;
            }
            return;
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

        public function set textColor(param1:Number) : void
        {
            this._label.textColor = param1;
            return;
        }// end function

        public function get textColor() : Number
        {
            return this._label.textColor;
        }// end function

        public function set icon(param1:DisplayObject) : void
        {
            if (this._icon != null)
            {
                removeChild(this._icon);
            }
            this._icon = param1;
            if (this._icon != null)
            {
                addChild(this._icon);
            }
            this.draw();
            return;
        }// end function

        public function get icon() : DisplayObject
        {
            return this._icon;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
            this.draw();
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
        }// end function

        public function set overshow(param1:Boolean) : void
        {
            this._overshow = param1;
            return;
        }// end function

        override public function get width() : Number
        {
            return this._back.width;
        }// end function

        override public function get height() : Number
        {
            return this._back.height;
        }// end function

        public function set back(param1)
        {
            if (this._back != null)
            {
                removeChild(this._back);
            }
            this._back = param1;
            addChild(this._back);
            this.draw();
            return;
        }// end function

        public function set face(param1)
        {
            if (this._face != null)
            {
                removeChild(this._face);
            }
            this._face = param1;
            addChild(this._face);
            this.draw();
            return;
        }// end function

        public function setCd(param1, param2 = null)
        {
            if (param1 > 0)
            {
                this._cdMax = param2;
                this._cdPreTime = getTimer() + param1;
                this._cd = param1;
                if (this._cd > this._cdMax)
                {
                    this._cd = this._cdMax;
                }
                this.handleCdCircle();
            }
            else
            {
                this._cd = 0;
                clearTimeout(this._cdInterval);
                this._cdShape.graphics.clear();
            }
            return;
        }// end function

        private function handleCdCircle()
        {
            clearTimeout(this._cdInterval);
            this._cd = this._cdPreTime - getTimer();
            var _loc_1:* = (this._cdMax - this._cd) / this._cdMax;
            var _loc_2:* = Math.PI * 2 * _loc_1;
            this._cdShape.graphics.clear();
            if (this._cd > 0)
            {
                this._cdShape.graphics.beginFill(0, 0.5);
                this._cdShape.graphics.moveTo(this.width / 2, this.height / 2);
                if (_loc_1 < 1 / 8)
                {
                    this._cdShape.graphics.lineTo(this.width / 2, 0);
                    this._cdShape.graphics.lineTo(0, 0);
                    this._cdShape.graphics.lineTo(0, this.height);
                    this._cdShape.graphics.lineTo(this.width, this.height);
                    this._cdShape.graphics.lineTo(this.width, 0);
                    this._cdShape.graphics.lineTo(this.width / 2 + Math.tan(_loc_2) * this.width / 2, 0);
                }
                else if (_loc_1 < 3 / 8)
                {
                    this._cdShape.graphics.lineTo(this.width / 2, 0);
                    this._cdShape.graphics.lineTo(0, 0);
                    this._cdShape.graphics.lineTo(0, this.height);
                    this._cdShape.graphics.lineTo(this.width, this.height);
                    this._cdShape.graphics.lineTo(this.width, this.height / 2 - Math.tan(Math.PI / 2 - _loc_2) * this.height / 2);
                }
                else if (_loc_1 < 5 / 8)
                {
                    this._cdShape.graphics.lineTo(this.width / 2, 0);
                    this._cdShape.graphics.lineTo(0, 0);
                    this._cdShape.graphics.lineTo(0, this.height);
                    this._cdShape.graphics.lineTo(this.width / 2 + Math.tan(Math.PI - _loc_2) * this.width / 2, this.height);
                }
                else if (_loc_1 < 7 / 8)
                {
                    this._cdShape.graphics.lineTo(this.width / 2, 0);
                    this._cdShape.graphics.lineTo(0, 0);
                    this._cdShape.graphics.lineTo(0, this.height / 2 + Math.tan(Math.PI / 2 * 3 - _loc_2) * this.height / 2);
                }
                else
                {
                    this._cdShape.graphics.lineTo(this.width / 2, 0);
                    this._cdShape.graphics.lineTo(Math.tan(_loc_2) * this.width / 2 + this.width / 2, 0);
                }
                this._cdShape.graphics.lineTo(this.width / 2, this.height / 2);
                this._cdShape.graphics.endFill();
                this._cdInterval = setTimeout(this.handleCdCircle, 100);
            }
            else
            {
                this._cd = 0;
                this.dispatchEvent(new Event("cd_stop"));
            }
            return;
        }// end function

        public function get cd() : Number
        {
            return this._cd;
        }// end function

    }
}
