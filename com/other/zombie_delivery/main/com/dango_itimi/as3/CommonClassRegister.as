package com.dango_itimi.as3
{
    import com.dango_itimi.as3.event.*;
    import com.dango_itimi.as3.font.*;
    import com.dango_itimi.as3.utils.*;
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.as3.*;

    public class CommonClassRegister extends Object
    {

        public function CommonClassRegister() : void
        {
            return;
        }// end function

        public static function initialize() : void
        {
            CommonClassSet.mouseEventCheckerClass = MouseEventCheckerForFlash;
            CommonClassSet.movieClipUtilClass = MovieClipUtil;
            CommonClassSet.containerUtilClass = ContainerUtil;
            CommonClassSet.defaultLayerClass = Sprite;
            CommonClassSet.keyCheckerClass = KeyCheckerForFlash;
            CommonClassSet.textToBitmapFontConverterClass = TextToBitmapFontConverterForFlash;
            return;
        }// end function

    }
}
