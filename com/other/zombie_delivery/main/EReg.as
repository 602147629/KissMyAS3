package 
{
    import flash.*;

    public class EReg extends Object
    {
        public var result:Array;
        public var r:RegExp;

        public function EReg(param1:String = undefined, param2:String = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            r = new RegExp(param1, param2);
            return;
        }// end function

        public function replace(param1:String, param2:String) : String
        {
            return param1.replace(r, param2);
        }// end function

        public function match(param1:String) : Boolean
        {
            if (r.global)
            {
                r.lastIndex = 0;
            }
            result = r.exec(param1);
            return result != null;
        }// end function

    }
}
