package nape.dynamics
{
    import flash.*;
    import zpp_nape.util.*;

    final public class ArbiterIterator extends Object
    {
        public var zpp_next:ArbiterIterator;
        public var zpp_inner:ArbiterList;
        public var zpp_i:int;
        public var zpp_critical:Boolean;
        public static var zpp_pool:ArbiterIterator;

        public function ArbiterIterator() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_next = null;
            zpp_critical = false;
            zpp_i = 0;
            zpp_inner = null;
            if (!ZPP_ArbiterList.internal)
            {
                throw "Error: Cannot instantiate " + "Arbiter" + "Iterator derp!";
            }
            return;
        }// end function

        public function next() : Arbiter
        {
            zpp_critical = false;
            var _loc_1:* = zpp_i;
            (zpp_i + 1);
            return zpp_inner.at(_loc_1);
        }// end function

        public function hasNext() : Boolean
        {
            zpp_inner.zpp_inner.valmod();
            var _loc_1:* = zpp_inner.zpp_gl();
            zpp_critical = true;
            if (zpp_i < _loc_1)
            {
                return true;
            }
            else
            {
                zpp_next = ArbiterIterator.zpp_pool;
                ArbiterIterator.zpp_pool = this;
                zpp_inner = null;
                return false;
            }
        }// end function

        public static function get(param1:ArbiterList) : ArbiterIterator
        {
            var _loc_2:* = null as ArbiterIterator;
            var _loc_3:* = null as ArbiterIterator;
            if (ArbiterIterator.zpp_pool == null)
            {
                ZPP_ArbiterList.internal = true;
                _loc_3 = new ArbiterIterator();
                ZPP_ArbiterList.internal = false;
                _loc_2 = _loc_3;
            }
            else
            {
                _loc_3 = ArbiterIterator.zpp_pool;
                ArbiterIterator.zpp_pool = _loc_3.zpp_next;
                _loc_2 = _loc_3;
            }
            _loc_2.zpp_i = 0;
            _loc_2.zpp_inner = param1;
            _loc_2.zpp_critical = false;
            return _loc_2;
        }// end function

    }
}
