package com.soar.display.bar {
	
    import flash.events.*;
    import flash.display.*;
    //import lovefox.gameUI.*;
    import flash.text.*;

    public class Bar extends Sprite {

        public var _color:uint = 0;
        public var _percent:Number = 1;
        public var _width:uint = 100;
        public var _border:Shape;
        public var _fBar:Shape;
        public var _height:uint = 20;
        private var _txt;

        public function Bar(){
            this._fBar = new Shape();
            addChild(this._fBar);
            this._border = new Shape();
            addChild(this._border);
            this._txt = new TextField();
            this._txt.selectable = false;
            this._txt.autoSize = TextFieldAutoSize.LEFT;
            this._txt.textColor = 0xFFFFFF;
            this._txt.y = -5;
            addChild(this._txt);
            this.redraw();
        }
		
        public static function create(_arg1, _arg2, _arg3, _arg4, _arg5, _arg6=null){
            var _local7:* = new (Bar)();
            _local7._width = _arg1;
            _local7._height = _arg2;
            _local7._color = _arg5;
            _local7.x = _arg3;
            _local7.y = _arg4;
            _local7.redraw();
            if (_arg6 != null){
                _arg6.addChild(_local7);
            };
            return (_local7);
        }

        public function set per(_arg1){
            if (!isNaN(_arg1)){
                this._percent = _arg1;
                this._txt.text = "";
                this.redraw(false);
            };
        }
        public function get color(){
            return (this._color);
        }
        public function setProgress(_arg1, _arg2){
            if (((((!((_arg1 == null))) && (!((_arg2 == null))))) && ((_arg2 > 0)))){
                this._percent = Math.max(0, Math.min(1, (_arg1 / _arg2)));
                this._txt.text = ((_arg1 + "/") + _arg2);
                this.redraw(false);
            };
        }
        override public function set height(_arg1:Number):void{
            this._height = _arg1;
            this.redraw();
        }
        public function set color(_arg1){
            this._color = _arg1;
            this.redraw();
        }
        public function redraw(_arg1=true){
            if (_arg1){
                this._border.graphics.clear();
                this._border.graphics.lineStyle(0, 0xFFFFFF, 0.5, true);
                this._border.graphics.drawRoundRect(0, 0, this._width, this._height, 3, 3);
            };
            this._fBar.graphics.clear();
            this._fBar.graphics.lineStyle(0, 0, 0, true);
            this._fBar.graphics.beginFill(this._color);
            this._fBar.graphics.drawRoundRect(0, 0, Math.max(1, (this._width * this._percent)), this._height, 2, 2);
            this._fBar.graphics.endFill();
        }
        override public function set width(_arg1:Number):void{
            this._width = _arg1;
            this.redraw();
        }
        public function get per(){
            return (this._percent);
        }

    }
}//package lovefox.gui 
