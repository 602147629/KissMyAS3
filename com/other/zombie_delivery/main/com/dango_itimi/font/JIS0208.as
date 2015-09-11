package com.dango_itimi.font
{
    import flash.*;

    public class JIS0208 extends JISFont
    {
        public static var TEXT:String;

        public function JIS0208(param1:Object = undefined) : void
        {
            if (param1 == null)
            {
                param1 = true;
            }
            if (Boot.skip_constructor)
            {
                return;
            }
            text = JIS0208.TEXT;
            super(param1);
            return;
        }// end function

    }
}
