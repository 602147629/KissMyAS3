package com.dango_itimi.as3_and_createjs.utils
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import flash.display.*;

    public interface IContainerUtil
    {

        public function IContainerUtil() : void;

        function removeChild(param1:IDisplayObjectContainer) : DisplayObject;

        function addChild(param1:IDisplayObjectContainer) : DisplayObject;

    }
}
