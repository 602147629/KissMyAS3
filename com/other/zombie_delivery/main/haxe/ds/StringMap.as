package haxe.ds
{
    import flash.*;
    import flash.utils.*;

    public class StringMap extends Object implements IMap
    {
        public var h:Dictionary;

        public function StringMap() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            h = new Dictionary();
            return;
        }// end function

        public function set(param1:String, param2:Object) : void
        {
            h["$" + param1] = param2;
            return;
        }// end function

        public function remove(param1:String) : Boolean
        {
            param1 = "$" + param1;
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
                
                _loc_1.push(_loc_3[_loc_2].substr(1));
            }
            return _loc_1.iterator();
        }// end function

        public function iterator() : Object
        {
            var _loc_2:* = 0;
            var _loc_1:* = [];
            var _loc_3:* = h;
            while (_loc_3 in _loc_2)
            {
                
                _loc_1.push(_loc_3[_loc_2]);
            }
            return {ref:h, it:_loc_1.iterator(), hasNext:function () : Boolean
            {
                return this.it.hasNext();
            }// end function
            , next:function () : Object
            {
                var _loc_1:* = this.it.next();
                return this.ref[_loc_1];
            }// end function
            };
        }// end function

        public function get(param1:Object) : Object
        {
            var _loc_2:* = param1;
            return h["$" + _loc_2];
        }// end function

    }
}
