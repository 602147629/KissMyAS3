package com.soar.display.bar {
    import flash.events.*;
    import flash.display.*;
    import flash.text.*;

    public class HpBar extends Bar {

        public static function create(_arg1, _arg2, _arg3, _arg4, _arg5, _arg6=null){
            var _local7:* = new (HpBar)();
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

        override public function redraw(_arg1=true){
            var _local2:*;
            if (_arg1){
                _border.graphics.clear();
                _border.graphics.lineStyle(0, 0xFFFFFF, 0.5, true);
                _border.graphics.drawRoundRect(0, 0, _width, _height, 3, 3);
            };
            if (_percent > 0.5){
                _local2 = (((0x0100 * 0x0100) * Math.floor((((1 - _percent) * 2) * 0xFF))) + (0x0100 * 0xFF));
            } else {
                _local2 = (((0x0100 * 0x0100) * 0xFF) + (0x0100 * Math.floor(((_percent * 2) * 0xFF))));
            };
            _fBar.graphics.clear();
            _fBar.graphics.lineStyle(0, 0, 0, true);
            _fBar.graphics.beginFill(_local2);
            _fBar.graphics.drawRoundRect(0, 0, Math.max(1, (_width * _percent)), _height, 2, 2);
            _fBar.graphics.endFill();
        }

    }
}//package lovefox.gui 
