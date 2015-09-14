package balloon
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class BalloonManager extends Object
    {
        private var _screen:DisplayObjectContainer;
        private var _aBalloon:Array;
        private static var _instance:BalloonManager = null;

        public function BalloonManager()
        {
            return;
        }// end function

        public function getBalloonCount() : int
        {
            return this._aBalloon.length;
        }// end function

        public function release() : void
        {
            this.clearBalloon();
            this._screen.removeEventListener(MouseEvent.MOUSE_MOVE, this.cbMouseMove);
            return;
        }// end function

        public function init(param1:DisplayObjectContainer) : void
        {
            this._screen = param1;
            this._screen.addEventListener(MouseEvent.MOUSE_MOVE, this.cbMouseMove);
            this._aBalloon = [];
            return;
        }// end function

        public function addBalloon(param1:BalloonNormal) : void
        {
            if (this._aBalloon.indexOf(param1) != -1)
            {
                return;
            }
            this._aBalloon.push(param1);
            return;
        }// end function

        public function removeBalloon(param1:BalloonNormal) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aBalloon.indexOf(param1);
            if (_loc_2 != -1)
            {
                _loc_3 = this._aBalloon[_loc_2];
                _loc_3.release();
                this._aBalloon.splice(_loc_2, 1);
            }
            return;
        }// end function

        private function clearBalloon() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aBalloon)
            {
                
                _loc_1.release();
            }
            this._aBalloon = [];
            return;
        }// end function

        private function cbMouseMove(event:MouseEvent) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = new Point(this._screen.mouseX, this._screen.mouseY);
            var _loc_3:* = false;
            for each (_loc_4 in this._aBalloon)
            {
                
                if (_loc_4.bEnable == false)
                {
                    continue;
                }
                if (_loc_3 == false)
                {
                    if (_loc_4.isHitTargetPos(_loc_2))
                    {
                        _loc_3 = true;
                        _loc_4.setMouseOver(true);
                        continue;
                    }
                }
                _loc_4.setMouseOver(false);
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBalloon)
            {
                
                _loc_2.control(param1);
            }
            return;
        }// end function

        public static function getInstance() : BalloonManager
        {
            if (_instance == null)
            {
                _instance = new BalloonManager;
            }
            return _instance;
        }// end function

    }
}
