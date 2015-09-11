package zpp_nape.constraint
{
    import flash.*;
    import nape.phys.*;

    public class ZPP_CopyHelper extends Object
    {
        public var id:int;
        public var cb:Function;
        public var bc:Body;

        public function ZPP_CopyHelper() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            cb = null;
            bc = null;
            id = 0;
            return;
        }// end function

        public static function dict(param1:int, param2:Body) : ZPP_CopyHelper
        {
            var _loc_3:* = new ZPP_CopyHelper();
            _loc_3.id = param1;
            _loc_3.bc = param2;
            return _loc_3;
        }// end function

        public static function todo(param1:int, param2:Function) : ZPP_CopyHelper
        {
            var _loc_3:* = new ZPP_CopyHelper();
            _loc_3.id = param1;
            _loc_3.cb = param2;
            return _loc_3;
        }// end function

    }
}
