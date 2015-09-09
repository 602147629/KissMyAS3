package com.bit101.components
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import lovefox.util.*;

    public class Component extends MouseSprite
    {
        private var Ronda:Class;
        protected var _width:Number = 0;
        protected var _height:Number = 0;
        protected var _data:Object;
        protected var _highlight:Boolean = false;
        protected var _enabled:Boolean = true;
        protected var _alpha:Number = 1;
        protected var _color:int = -1;
        protected var _subColor:int = -1;
        protected var _bgColor:int = -1;
        protected var _borderColor:int = -1;
        protected var _roundCorner:uint = 0;
        protected var _tipLayer:Sprite;
        protected var _tipTF:TextField;
        protected var _shadow:int = 2;
        protected var _border:int = 0;
        protected var _shadowColor:int = -1;
        protected var _gradientFillMatrix:Matrix;
        protected var _gradientFillDirection:Number;
        protected var _gradientFillType:String = "linear";
        static var _stage:Stage;
        public static const DRAW:String = "draw";

        public function Component(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0) : void
        {
            this._gradientFillDirection = Math.PI / 2;
            this.move(param2, param3);
            if (param1 != null)
            {
                param1.addChild(this);
            }
            this.init();
            return;
        }// end function

        protected function init() : void
        {
            this.addChildren();
            this.invalidate();
            return;
        }// end function

        protected function addChildren() : void
        {
            return;
        }// end function

        protected function getShadow(param1:Number, param2:Boolean = false) : DropShadowFilter
        {
            return new DropShadowFilter(param1, 45, Style.DROPSHADOW, 1, param1, param1, 0.3, 1, param2);
        }// end function

        protected function invalidate() : void
        {
            addEventListener(Event.ENTER_FRAME, this.onInvalidate);
            return;
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            this.x = Math.round(param1);
            this.y = Math.round(param2);
            return;
        }// end function

        public function setSize(param1:Number, param2:Number) : void
        {
            this._width = param1;
            this._height = param2;
            this.invalidate();
            return;
        }// end function

        public function draw() : void
        {
            removeEventListener(Event.ENTER_FRAME, this.onInvalidate);
            dispatchEvent(new Event(Component.DRAW));
            return;
        }// end function

        private function onInvalidate(event:Event) : void
        {
            removeEventListener(Event.ENTER_FRAME, this.onInvalidate);
            this.draw();
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._width = param1;
            this.invalidate();
            dispatchEvent(new Event(Event.RESIZE));
            return;
        }// end function

        override public function get width() : Number
        {
            return this._width;
        }// end function

        override public function set height(param1:Number) : void
        {
            this._height = param1;
            this.invalidate();
            dispatchEvent(new Event(Event.RESIZE));
            return;
        }// end function

        override public function get height() : Number
        {
            return this._height;
        }// end function

        override public function set x(param1:Number) : void
        {
            super.x = Math.round(param1);
            return;
        }// end function

        override public function set y(param1:Number) : void
        {
            super.y = Math.round(param1);
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

        public function set highlight(param1:Boolean) : void
        {
            this._highlight = param1;
            this.draw();
            return;
        }// end function

        public function get highlight() : Boolean
        {
            return this._highlight;
        }// end function

        public function set enabled(param1:Boolean) : void
        {
            this._enabled = param1;
            this.draw();
            return;
        }// end function

        public function get enabled() : Boolean
        {
            return this._enabled;
        }// end function

        override public function set alpha(param1:Number) : void
        {
            this._alpha = param1;
            this.draw();
            return;
        }// end function

        override public function get alpha() : Number
        {
            return this._alpha;
        }// end function

        public function set color(param1:int) : void
        {
            this._color = param1;
            this.invalidate();
            return;
        }// end function

        public function get color() : int
        {
            return this._color;
        }// end function

        public function set subColor(param1:int) : void
        {
            this._subColor = param1;
            this.invalidate();
            return;
        }// end function

        public function get subColor() : int
        {
            return this._subColor;
        }// end function

        public function set gradientFillDirection(param1:Number) : void
        {
            this._gradientFillDirection = param1;
            this.invalidate();
            return;
        }// end function

        public function get gradientFillDirection() : Number
        {
            return this._gradientFillDirection;
        }// end function

        public function set gradientFillType(param1:String) : void
        {
            this._gradientFillType = param1;
            this.invalidate();
            return;
        }// end function

        public function get gradientFillType() : String
        {
            return this._gradientFillType;
        }// end function

        public function set bgColor(param1:int) : void
        {
            this._bgColor = param1;
            this.invalidate();
            return;
        }// end function

        public function get bgColor() : int
        {
            return this._bgColor;
        }// end function

        public function set borderColor(param1:int) : void
        {
            this._borderColor = param1;
            this.invalidate();
            return;
        }// end function

        public function get borderColor() : int
        {
            return this._borderColor;
        }// end function

        public function set roundCorner(param1:uint) : void
        {
            this._roundCorner = param1;
            this.invalidate();
            return;
        }// end function

        public function get roundCorner() : uint
        {
            return this._roundCorner;
        }// end function

        public function set tip(param1:String) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (param1.length > 0)
            {
                if (this._tipLayer == null)
                {
                    this._tipLayer = new Sprite();
                    this._tipLayer.mouseEnabled = false;
                    this._tipLayer.mouseChildren = false;
                    this._tipTF = new TextField();
                    this._tipTF.y = -25;
                    this._tipTF.x = 12;
                    this._tipTF.autoSize = TextFieldAutoSize.LEFT;
                    this._tipTF.selectable = false;
                    this._tipTF.mouseEnabled = false;
                    if (Config._switchEnglish)
                    {
                        this._tipTF.defaultTextFormat = new TextFormat("Tahoma", 12);
                    }
                    this._tipLayer.addChild(this._tipTF);
                }
                _loc_2 = new Label();
                _loc_2.text = param1;
                _loc_2.html = true;
                _loc_3 = _loc_2.width;
                if (_loc_3 > 200)
                {
                    _loc_3 = 200;
                }
                this._tipTF.htmlText = param1;
                this._tipLayer.graphics.clear();
                this._tipLayer.graphics.lineStyle(0, 6710886);
                this._tipLayer.graphics.lineTo(10, -10);
                this._tipLayer.graphics.beginFill(16777215, 0.8);
                this._tipLayer.graphics.drawRect(10, -25, this._tipTF.width + 4, this._tipTF.height);
                this._tipLayer.graphics.endFill();
                removeEventListener(MouseEvent.ROLL_OVER, this.handleTipOver);
                removeEventListener(MouseEvent.ROLL_OUT, this.handleTipOut);
                addEventListener(MouseEvent.ROLL_OVER, this.handleTipOver);
                addEventListener(MouseEvent.ROLL_OUT, this.handleTipOut);
            }
            else
            {
                _stage.removeEventListener(Event.ENTER_FRAME, this.handleTipEnterFrame);
                removeEventListener(MouseEvent.ROLL_OVER, this.handleTipOver);
                removeEventListener(MouseEvent.ROLL_OUT, this.handleTipOut);
                if (this._tipLayer != null)
                {
                    if (this._tipLayer.parent == _stage)
                    {
                        _stage.removeChild(this._tipLayer);
                    }
                }
            }
            return;
        }// end function

        private function handleTipOver(param1)
        {
            _stage.addEventListener(Event.ENTER_FRAME, this.handleTipEnterFrame);
            return;
        }// end function

        private function handleTipOut(param1)
        {
            if (this._tipLayer.parent == _stage)
            {
                _stage.removeChild(this._tipLayer);
            }
            _stage.removeEventListener(Event.ENTER_FRAME, this.handleTipEnterFrame);
            return;
        }// end function

        private function handleTipEnterFrame(param1)
        {
            if (this._tipLayer.parent != _stage)
            {
                _stage.addChild(this._tipLayer);
            }
            this._tipLayer.x = _stage.mouseX;
            this._tipLayer.y = _stage.mouseY;
            return;
        }// end function

        public function get tip() : String
        {
            if (this._tipTF != null && this._tipLayer.parent == _stage)
            {
                return this._tipTF.text;
            }
            return "";
        }// end function

        public function set shadow(param1:uint) : void
        {
            this._shadow = param1;
            return;
        }// end function

        public function get shadow() : uint
        {
            return this._shadow;
        }// end function

        public function set border(param1:uint) : void
        {
            this._border = param1;
            this.invalidate();
            return;
        }// end function

        public function get border() : uint
        {
            return this._border;
        }// end function

        public function set shadowColor(param1:uint) : void
        {
            this._shadowColor = param1;
            this.shadow = this.shadow;
            return;
        }// end function

        public function get shadowColor() : uint
        {
            return this._shadowColor;
        }// end function

        public static function initStage(param1:Stage) : void
        {
            _stage = param1;
            _stage.align = StageAlign.TOP_LEFT;
            _stage.scaleMode = StageScaleMode.NO_SCALE;
            return;
        }// end function

    }
}
