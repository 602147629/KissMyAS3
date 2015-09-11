package haxe.ds
{
    import flash.*;
    import flash.utils.*;

    public class IntMap extends Object implements IMap
    {
        public var h:Dictionary;

        public function IntMap() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            h = new Dictionary();
            return;
        }// end function

        public function remove(param1:int) : Boolean
        {
            if (!(param1 in h))
            {
                return false;
            }
            delete h[param1];
            return true;
        }// end function

        public function keys() : Object
        {
            var _loc_2:* = 0;
            var _loc_1:* = [];
            var _loc_3:* = h;
            while (_loc_3 in _loc_2)
            {
                
                _loc_1.push(_loc_3[_loc_2]);
            }
            return _loc_1.iterator();
        }// end function

        public function get(param1:Object) : Object
        {
            var _loc_2:* = param1;
            return h[_loc_2];
        }// end function

    }
}
