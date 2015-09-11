package zpp_nape.space
{
    import flash.*;
    import zpp_nape.dynamics.*;

    public class ZPP_AABBPair extends Object
    {
        public var sleeping:Boolean;
        public var next:ZPP_AABBPair;
        public var n2:ZPP_AABBNode;
        public var n1:ZPP_AABBNode;
        public var id:int;
        public var first:Boolean;
        public var di:int;
        public var arb:ZPP_Arbiter;
        public static var zpp_pool:ZPP_AABBPair;

        public function ZPP_AABBPair() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            next = null;
            arb = null;
            di = 0;
            id = 0;
            sleeping = false;
            first = false;
            n2 = null;
            n1 = null;
            return;
        }// end function

        public function free() : void
        {
            var _loc_1:* = null;
            n2 = null;
            n1 = _loc_1;
            sleeping = false;
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
