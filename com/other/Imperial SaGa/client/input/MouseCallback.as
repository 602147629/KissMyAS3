package input
{
    import flash.events.*;

    public class MouseCallback extends InputBase
    {
        private var _cbMove:Function;
        private var _cbClick:Function;
        private var _cbUp:Function;
        private var _cbDown:Function;
        private var _cbWheel:Function;

        public function MouseCallback(param1:Object, param2:int, param3:Function, param4:Function, param5:Function, param6:Function, param7:Function)
        {
            super(param1, param2);
            this._cbMove = param3;
            this._cbClick = param6;
            this._cbUp = param4;
            this._cbDown = param5;
            this._cbWheel = param7;
            return;
        }// end function

        public function mouseMove(event:MouseEvent) : Boolean
        {
            if (_bEnable && this._cbMove != null)
            {
                return this._cbMove(event);
            }
            return false;
        }// end function

        public function leftButtonUp(event:MouseEvent) : Boolean
        {
            if (_bEnable && this._cbUp != null)
            {
                return this._cbUp(event);
            }
            return false;
        }// end function

        public function leftButtonDown(event:Event) : Boolean
        {
            if (_bEnable && this._cbDown != null)
            {
                return this._cbDown(event);
            }
            return false;
        }// end function

        public function leftButtonClick(event:Event) : Boolean
        {
            if (_bEnable && this._cbClick != null)
            {
                return this._cbClick(event);
            }
            return false;
        }// end function

        public function mouseWheel(event:Event) : Boolean
        {
            if (_bEnable && this._cbWheel != null)
            {
                return this._cbWheel(event);
            }
            return false;
        }// end function

    }
}
