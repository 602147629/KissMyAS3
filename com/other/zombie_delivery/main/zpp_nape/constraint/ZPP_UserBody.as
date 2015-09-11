package zpp_nape.constraint
{
    import flash.*;
    import zpp_nape.phys.*;

    public class ZPP_UserBody extends Object
    {
        public var cnt:int;
        public var body:ZPP_Body;

        public function ZPP_UserBody(param1:int = 0, param2:ZPP_Body = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            body = null;
            cnt = 0;
            cnt = param1;
            body = param2;
            return;
        }// end function

    }
}
