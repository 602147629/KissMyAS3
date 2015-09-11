package haxe.ds._ObjectMap
{
    import flash.*;

    public class NativePropertyIterator extends Object
    {
        public var index:int;
        public var collection:Object;

        public function NativePropertyIterator() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            index = 0;
            return;
        }// end function

        public function next()
        {
            var _loc_1:* = index;
            var _loc_2:* = collection[_loc_1];
            index = _loc_1;
            return _loc_2;
        }// end function

        public function hasNext() : Boolean
        {
            var _loc_1:* = collection;
            var _loc_2:* = index;
            var _loc_3:* = _loc_1 in _loc_2;
            collection = _loc_1;
            index = _loc_2;
            return _loc_3;
        }// end function

    }
}
