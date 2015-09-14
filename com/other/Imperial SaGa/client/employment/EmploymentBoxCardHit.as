package employment
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import player.*;

    public class EmploymentBoxCardHit extends Object
    {
        private var _mcHit:MovieClip;
        private var _cbMouseOver:Function;
        private var _cbMouseOut:Function;
        private var _pInfo:PlayerInformation;

        public function EmploymentBoxCardHit(param1:MovieClip, param2:Function, param3:Function, param4:PlayerInformation)
        {
            this._mcHit = param1;
            this._cbMouseOver = param2;
            this._cbMouseOut = param3;
            this._pInfo = param4;
            if (!this._mcHit.hasEventListener(MouseEvent.MOUSE_OVER))
            {
                this._mcHit.addEventListener(MouseEvent.MOUSE_OVER, this.lisnrMouseOver);
            }
            if (!this._mcHit.hasEventListener(MouseEvent.MOUSE_OUT))
            {
                this._mcHit.addEventListener(MouseEvent.MOUSE_OUT, this.lisnrMouseOut);
            }
            return;
        }// end function

        public function release() : void
        {
            this._mcHit.removeEventListener(MouseEvent.MOUSE_OVER, this.lisnrMouseOver);
            this._mcHit.removeEventListener(MouseEvent.MOUSE_OUT, this.lisnrMouseOut);
            this._pInfo = null;
            this._cbMouseOut = null;
            this._cbMouseOver = null;
            this._mcHit = null;
            return;
        }// end function

        private function cbMouseClick(event:MouseEvent) : void
        {
            return;
        }// end function

        private function lisnrMouseOver(event:MouseEvent) : void
        {
            if (this._cbMouseOver != null)
            {
                this._cbMouseOver(this._mcHit, this._pInfo);
            }
            return;
        }// end function

        private function lisnrMouseOut(event:MouseEvent) : void
        {
            if (this._cbMouseOut != null)
            {
                this._cbMouseOut(this._mcHit, this._pInfo);
            }
            return;
        }// end function

        private function getBallonPos(param1:MovieClip, param2:MovieClip, param3:MovieClip) : void
        {
            var _loc_4:* = param2;
            var _loc_5:* = new Point(_loc_4.x, _loc_4.y);
            _loc_5 = _loc_4.parent.localToGlobal(_loc_5);
            _loc_4 = param3;
            var _loc_6:* = new Point(_loc_4.x, _loc_4.y);
            _loc_6 = _loc_4.parent.localToGlobal(_loc_6);
            return;
        }// end function

    }
}
