package com.dango_itimi.font
{
    import flash.*;
    import haxe.ds.*;

    public class JISFont extends Object
    {
        public var text:String;
        public var map:IMap;

        public function JISFont(param1:Object = undefined) : void
        {
            if (param1 == null)
            {
                param1 = true;
            }
            if (Boot.skip_constructor)
            {
                return;
            }
            if (param1)
            {
                createMap();
            }
            return;
        }// end function

        public function getIndexSet(param1:String) : Array
        {
            var _loc_5:* = 0;
            var _loc_2:* = [];
            var _loc_3:* = 0;
            var _loc_4:* = param1.length;
            while (_loc_3 < _loc_4)
            {
                
                _loc_3++;
                _loc_5 = _loc_3;
                _loc_2.push(getIndex(param1.charAt(_loc_5)));
            }
            return _loc_2;
        }// end function

        public function getIndex(param1:String) : int
        {
            if ("$" + param1 in map.h)
            {
                return map.get(param1);
            }
            else
            {
                return -1;
            }
        }// end function

        public function createMap() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null as String;
            map = new StringMap();
            var _loc_1:* = 0;
            var _loc_2:* = text.length;
            while (_loc_1 < _loc_2)
            {
                
                _loc_1++;
                _loc_3 = _loc_1;
                _loc_4 = text.charAt(_loc_3);
                map.set(_loc_4, _loc_3);
            }
            return;
        }// end function

    }
}
