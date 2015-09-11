package com.dango_itimi.font
{
    import flash.*;

    public class JIS0201 extends JISFont
    {
        public static var TEXT:String;

        public function JIS0201(param1:Object = undefined) : void
        {
            if (param1 == null)
            {
                param1 = true;
            }
            if (Boot.skip_constructor)
            {
                return;
            }
            text = JIS0201.TEXT;
            super(param1);
            return;
        }// end function

    }
}
