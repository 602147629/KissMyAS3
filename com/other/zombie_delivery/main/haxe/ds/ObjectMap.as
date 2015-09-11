package haxe.ds
{
    import flash.*;
    import flash.utils.*;
    import haxe.ds._ObjectMap.*;

    dynamic public class ObjectMap extends Dictionary implements IMap
    {

        public function ObjectMap() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            super(false);
            return;
        }// end function

        public function keys() : Object
        {
            var _loc_1:* = new NativePropertyIterator();
            _loc_1.collection = this;
            return _loc_1;
        }// end function

        public function get(param1:Object) : Object
        {
            var _loc_2:* = param1;
            return this[_loc_2];
        }// end function

    }
}
