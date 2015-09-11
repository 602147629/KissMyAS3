package 
{
    import flash.*;

    public class StringBuf extends Object
    {
        public var b:String;

        public function StringBuf() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            b = "";
            return;
        }// end function

    }
}
