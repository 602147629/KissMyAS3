package com.dango_itimi.as3.utils
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.*;
    import flash.display.*;

    public class ContainerUtil extends Object implements IContainerUtil
    {
        public var displayObjectContainer:DisplayObjectContainer;

        public function ContainerUtil(param1:DisplayObjectContainer = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            displayObjectContainer = param1;
            return;
        }// end function

        public function removeChild(param1:IDisplayObjectContainer) : DisplayObject
        {
            return displayObjectContainer.removeChild(param1);
        }// end function

        public function addChild(param1:IDisplayObjectContainer) : DisplayObject
        {
            return displayObjectContainer.addChild(param1);
        }// end function

    }
}
