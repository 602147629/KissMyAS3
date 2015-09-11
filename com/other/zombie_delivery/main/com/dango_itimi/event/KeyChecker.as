package com.dango_itimi.event
{
    import flash.*;
    import haxe.ds.*;

    public class KeyChecker extends Object
    {
        public var uppedKeyMap:IMap;
        public var downedKeyMap:IMap;

        public function KeyChecker() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            initialize();
            return;
        }// end function

        public function up(param1:int) : void
        {
            uppedKeyMap.set(param1, true);
            downedKeyMap.remove(param1);
            return;
        }// end function

        public function isUpped(param1:int) : Boolean
        {
            return "$" + param1 in uppedKeyMap.h;
        }// end function

        public function isDownedAnyKey() : Boolean
        {
            var _loc_2:* = false;
            var _loc_1:* = downedKeyMap.iterator();
            
            if (_loc_1.hasNext())
            {
                _loc_2 = _loc_1.next();
                return true;
                ;
            }
            return false;
        }// end function

        public function isDowned(param1:int) : Boolean
        {
            return "$" + param1 in downedKeyMap.h;
        }// end function

        public function initialize() : void
        {
            downedKeyMap = new StringMap();
            uppedKeyMap = new StringMap();
            return;
        }// end function

        public function down(param1:int) : void
        {
            downedKeyMap.set(param1, true);
            return;
        }// end function

    }
}
