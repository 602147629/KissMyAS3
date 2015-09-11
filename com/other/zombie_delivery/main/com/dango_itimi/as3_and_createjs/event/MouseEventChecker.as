package com.dango_itimi.as3_and_createjs.event
{
    import flash.*;
    import flash.events.*;

    public class MouseEventChecker extends Object
    {
        public var uppedEvent:MouseEvent;
        public var upped:Boolean;
        public var rollOutedEvent:MouseEvent;
        public var rollOuted:Boolean;
        public var movedEvent:MouseEvent;
        public var moved:Boolean;
        public var downedEvent:MouseEvent;
        public var downed:Boolean;
        public var clickedEvent:MouseEvent;
        public var clicked:Boolean;

        public function MouseEventChecker() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            addEventListener();
            return;
        }// end function

        public function reset() : void
        {
            clicked = false;
            downed = false;
            upped = false;
            moved = false;
            rollOuted = false;
            return;
        }// end function

        public function removeEventListener() : void
        {
            return;
        }// end function

        public function onRollOut(event:MouseEvent) : void
        {
            rollOutedEvent = event;
            rollOuted = true;
            return;
        }// end function

        public function onMouseUp(event:MouseEvent) : void
        {
            uppedEvent = event;
            upped = true;
            return;
        }// end function

        public function onMouseMove(event:MouseEvent) : void
        {
            movedEvent = event;
            moved = true;
            return;
        }// end function

        public function onMouseDown(event:MouseEvent) : void
        {
            downedEvent = event;
            downed = true;
            return;
        }// end function

        public function onClick(event:MouseEvent) : void
        {
            clickedEvent = event;
            clicked = true;
            return;
        }// end function

        public function isUpped() : Boolean
        {
            return upped;
        }// end function

        public function isRollOuted() : Boolean
        {
            return rollOuted;
        }// end function

        public function isMoved() : Boolean
        {
            return moved;
        }// end function

        public function isDowned() : Boolean
        {
            return downed;
        }// end function

        public function isClicked() : Boolean
        {
            return clicked;
        }// end function

        public function getUppedStagePoint() : Object
        {
            return {x:uppedEvent.stageX, y:uppedEvent.stageY};
        }// end function

        public function getUppedLocalPoint() : Object
        {
            return {x:uppedEvent.localX, y:uppedEvent.localY};
        }// end function

        public function getUppedEvent() : MouseEvent
        {
            return uppedEvent;
        }// end function

        public function getRollOutedStagePoint() : Object
        {
            return {x:rollOutedEvent.stageX, y:rollOutedEvent.stageY};
        }// end function

        public function getRollOutedLocalPoint() : Object
        {
            return {x:rollOutedEvent.localX, y:rollOutedEvent.localY};
        }// end function

        public function getRollOutedEvent() : MouseEvent
        {
            return rollOutedEvent;
        }// end function

        public function getMovedStagePoint() : Object
        {
            return {x:movedEvent.stageX, y:movedEvent.stageY};
        }// end function

        public function getMovedLocalPoint() : Object
        {
            return {x:movedEvent.localX, y:movedEvent.localY};
        }// end function

        public function getMovedEvent() : MouseEvent
        {
            return movedEvent;
        }// end function

        public function getDownedStagePoint() : Object
        {
            return {x:downedEvent.stageX, y:downedEvent.stageY};
        }// end function

        public function getDownedLocalPoint() : Object
        {
            return {x:downedEvent.localX, y:downedEvent.localY};
        }// end function

        public function getDownedEvent() : MouseEvent
        {
            return downedEvent;
        }// end function

        public function getClickedStagePoint() : Object
        {
            return {x:clickedEvent.stageX, y:clickedEvent.stageY};
        }// end function

        public function getClickedLocalPoint() : Object
        {
            return {x:clickedEvent.localX, y:clickedEvent.localY};
        }// end function

        public function getClickedEvent() : MouseEvent
        {
            return clickedEvent;
        }// end function

        public function destroy() : void
        {
            return;
        }// end function

        public function addEventListener() : void
        {
            return;
        }// end function

    }
}
