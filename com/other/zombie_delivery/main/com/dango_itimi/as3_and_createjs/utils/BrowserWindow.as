package com.dango_itimi.as3_and_createjs.utils
{
    import flash.*;
    import flash.net.*;

    public class BrowserWindow extends Object
    {

        public function BrowserWindow() : void
        {
            return;
        }// end function

        public static function open(param1:String) : void
        {
            Lib.getURL(new URLRequest(param1), "_blank");
            return;
        }// end function

    }
}
