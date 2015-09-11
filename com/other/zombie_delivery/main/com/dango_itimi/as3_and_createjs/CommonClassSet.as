package com.dango_itimi.as3_and_createjs
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.event.*;
    import com.dango_itimi.as3_and_createjs.font.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import com.dango_itimi.event.*;
    import flash.display.*;

    public class CommonClassSet extends Object
    {
        public static var keyCheckerClass:Class;
        public static var mouseEventCheckerClass:Class;
        public static var movieClipUtilClass:Class;
        public static var containerUtilClass:Class;
        public static var defaultLayerClass:Class;
        public static var textToBitmapFontConverterClass:Class;

        public function CommonClassSet() : void
        {
            return;
        }// end function

        public static function createLayer() : IDisplayObjectContainer
        {
            return Type.createInstance(CommonClassSet.defaultLayerClass, []);
        }// end function

        public static function createContainerUtil(param1:DisplayObjectContainer) : IContainerUtil
        {
            return Type.createInstance(CommonClassSet.containerUtilClass, [param1]);
        }// end function

        public static function createMovieClipUtil(param1:MovieClip) : IMovieClipUtil
        {
            return Type.createInstance(CommonClassSet.movieClipUtilClass, [param1]);
        }// end function

        public static function createMouseEventChecker(param1:DisplayObject) : MouseEventChecker
        {
            return Type.createInstance(CommonClassSet.mouseEventCheckerClass, [param1]);
        }// end function

        public static function createKeyChecker(param1:DisplayObject) : KeyChecker
        {
            return Type.createInstance(CommonClassSet.keyCheckerClass, [param1]);
        }// end function

        public static function createTextToBitmapFontConverter(param1:int, param2:Class, param3:Class, param4:Class = undefined, param5:Class = undefined) : TextToBitmapFontConverter
        {
            return Type.createInstance(CommonClassSet.textToBitmapFontConverterClass, [param1, param2, param3, param4, param5]);
        }// end function

    }
}
