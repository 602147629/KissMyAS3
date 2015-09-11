package 
{
    import flash.*;

    public class List extends Object
    {
        public var q:Array;
        public var length:int;
        public var h:Array;

        public function List() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            length = 0;
            return;
        }// end function

        public function iterator() : Object
        {
            return {h:h, hasNext:function ()
            {
                return this.h != null;
            }// end function
            , next:function ()
            {
                if (this.h == null)
                {
                    return null;
                }
                var _loc_1:* = this.h[0];
                this.h = this.h[1];
                return _loc_1;
            }// end function
            };
        }// end function

        public function add(param1:Object) : void
        {
            var _loc_2:* = [param1];
            if (h == null)
            {
                h = _loc_2;
            }
            else
            {
                q[1] = _loc_2;
            }
            q = _loc_2;
            (length + 1);
            return;
        }// end function

    }
}
