package com.dango_itimi.as3.event
{
    import com.dango_itimi.event.*;
    import flash.*;
    import flash.display.*;
    import flash.events.*;

    public class KeyCheckerForFlash extends KeyChecker
    {

        public function KeyCheckerForFlash(param1:DisplayObject = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            param1.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            param1.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
            return;
        }// end function

        public function onKeyUp(event:KeyboardEvent) : void
        {
            up(event.keyCode);
            return;
        }// end function

        public function onKeyDown(event:KeyboardEvent) : void
        {
            down(event.keyCode);
            return;
        }// end function

    }
}
