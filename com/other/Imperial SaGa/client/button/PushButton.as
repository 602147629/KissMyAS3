package button
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;

    public class PushButton extends ButtonBase
    {
        private var _bPush:Boolean;

        public function PushButton(param1:MovieClip)
        {
            super(param1, this.cbClickFunc);
            this._bPush = false;
            _mc.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            return;
        }// end function

        override public function release() : void
        {
            if (_mc != null)
            {
                _mc.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            super.release();
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_2:* = InputManager.getInstance().corsor;
            var _loc_3:* = InputManager.getInstance().bScreenOut;
            if (_loc_3 || _mc.hitTestPoint(_loc_2.x, _loc_2.y) == false)
            {
                this._bPush = false;
            }
            return;
        }// end function

        override public function setMouseDown() : void
        {
            this._bPush = true;
            return;
        }// end function

        override public function setMouseUp() : void
        {
            this._bPush = false;
            return;
        }// end function

        public function cbClickFunc(param1:int) : void
        {
            return;
        }// end function

        public function resetPushFlag() : void
        {
            this._bPush = false;
            return;
        }// end function

        public function get bPush() : Boolean
        {
            return this._bPush;
        }// end function

    }
}
