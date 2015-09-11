package zpp_nape.geom
{
    import flash.*;

    public class ZPP_MarchSpan extends Object
    {
        public var rank:int;
        public var parent:ZPP_MarchSpan;
        public var out:Boolean;
        public var next:ZPP_MarchSpan;
        public static var zpp_pool:ZPP_MarchSpan;

        public function ZPP_MarchSpan() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            next = null;
            out = false;
            rank = 0;
            parent = null;
            parent = this;
            return;
        }// end function

        public function free() : void
        {
            parent = this;
            return;
        }// end function

        public function alloc() : void
        {
            out = false;
            rank = 0;
            return;
        }// end function

    }
}
