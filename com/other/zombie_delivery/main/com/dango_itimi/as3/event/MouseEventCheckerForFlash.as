package com.dango_itimi.as3.event
{
    import com.dango_itimi.as3_and_createjs.event.*;
    import flash.*;
    import flash.display.*;
    import flash.events.*;

    public class MouseEventCheckerForFlash extends MouseEventChecker
    {
        public var displayObject:DisplayObject;

        public function MouseEventCheckerForFlash(param1:DisplayObject = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            displayObject = param1;
            return;
        }// end function

        override public function removeEventListener() : void
        {
            displayObject.removeEventListener(MouseEvent.CLICK, onClick);
            displayObject.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            displayObject.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            displayObject.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
            displayObject.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
            return;
        }// end function

        override public function addEventListener() : void
        {
            displayObject.addEventListener(MouseEvent.CLICK, onClick);
            displayObject.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            displayObject.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            displayObject.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
            displayObject.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
            return;
        }// end function

    }
}
