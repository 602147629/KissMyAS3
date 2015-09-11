package nape.phys
{
    import flash.*;
    import zpp_nape.util.*;

    final public class CompoundIterator extends Object
    {
        public var zpp_next:CompoundIterator;
        public var zpp_inner:CompoundList;
        public var zpp_i:int;
        public var zpp_critical:Boolean;
        public static var zpp_pool:CompoundIterator;

        public function CompoundIterator() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_next = null;
            zpp_critical = false;
            zpp_i = 0;
            zpp_inner = null;
            if (!ZPP_CompoundList.internal)
            {
                throw "Error: Cannot instantiate " + "Compound" + "Iterator derp!";
            }
            return;
        }// end function

        public function next() : Compound
        {
            zpp_critical = false;
            var _loc_1:* = zpp_i;
            (zpp_i + 1);
            return zpp_inner.at(_loc_1);
        }// end function

        public function hasNext() : Boolean
        {
            zpp_inner.zpp_inner.valmod();
            var _loc_2:* = zpp_inner;
            _loc_2.zpp_inner.valmod();
            if (_loc_2.zpp_inner.zip_length)
            {
                _loc_2.zpp_inner.zip_length = false;
                _loc_2.zpp_inner.user_length = _loc_2.zpp_inner.inner.length;
            }
            var _loc_1:* = _loc_2.zpp_inner.user_length;
            zpp_critical = true;
            if (zpp_i < _loc_1)
            {
                return true;
            }
            else
            {
                zpp_next = CompoundIterator.zpp_pool;
                CompoundIterator.zpp_pool = this;
                zpp_inner = null;
                return false;
            }
        }// end function

        public static function get(param1:CompoundList) : CompoundIterator
        {
            var _loc_2:* = null as CompoundIterator;
            var _loc_3:* = null as CompoundIterator;
            if (CompoundIterator.zpp_pool == null)
            {
                ZPP_CompoundList.internal = true;
                _loc_3 = new CompoundIterator();
                ZPP_CompoundList.internal = false;
                _loc_2 = _loc_3;
            }
            else
            {
                _loc_3 = CompoundIterator.zpp_pool;
                CompoundIterator.zpp_pool = _loc_3.zpp_next;
                _loc_2 = _loc_3;
            }
            _loc_2.zpp_i = 0;
            _loc_2.zpp_inner = param1;
            _loc_2.zpp_critical = false;
            return _loc_2;
        }// end function

    }
}
