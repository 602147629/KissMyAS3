package com.dango_itimi.as3_and_createjs.display
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import flash.display.*;

    public interface IDisplayObjectContainer extends IDisplayObject
    {

        public function IDisplayObjectContainer() : void;

        function removeChild(param1:DisplayObject) : DisplayObject;

        function contains(param1:DisplayObject) : Boolean;

        function addChild(param1:DisplayObject) : DisplayObject;

    }
}
