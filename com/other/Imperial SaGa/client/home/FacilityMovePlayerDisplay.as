package home
{
    import flash.display.*;
    import player.*;

    public class FacilityMovePlayerDisplay extends PlayerDisplay
    {
        private static const WALK_MAX_RATE:Number = 0.97;
        private static const WALK_MIN_RATE:Number = 0.03;
        private static const DASH_MAX_RATE:Number = 0.93;
        private static const DASH_MIN_RATE:Number = 0.07;
        private static const ADD_ALPHA:Number = 0.1;

        public function FacilityMovePlayerDisplay(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            mc.alpha = 0;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            this.alphaCheck();
            return;
        }// end function

        private function alphaCheck() : void
        {
            var _loc_1:* = _time / _waitTime;
            var _loc_2:* = false;
            if (_mc.currentLabel == PlayerDisplay.LABEL_SIDE_WALK || _mc.currentLabel == PlayerDisplay.LABEL_FRONT_WALK || _mc.currentLabel == PlayerDisplay.LABEL_BACK_WALK)
            {
                if (_loc_1 > WALK_MAX_RATE)
                {
                    _loc_2 = true;
                    mc.alpha = mc.alpha - ADD_ALPHA;
                }
                else if (_loc_1 < WALK_MIN_RATE)
                {
                    _loc_2 = true;
                    mc.alpha = mc.alpha + ADD_ALPHA;
                }
            }
            if (_mc.currentLabel == PlayerDisplay.LABEL_SIDE_DASH || _mc.currentLabel == PlayerDisplay.LABEL_FRONT_WALK || _mc.currentLabel == PlayerDisplay.LABEL_BACK_WALK)
            {
                if (_loc_1 > DASH_MAX_RATE)
                {
                    _loc_2 = true;
                    mc.alpha = mc.alpha - ADD_ALPHA;
                }
                else if (_loc_1 < DASH_MIN_RATE)
                {
                    _loc_2 = true;
                    mc.alpha = mc.alpha + ADD_ALPHA;
                }
            }
            if (_loc_2 == false)
            {
                mc.alpha = 1;
            }
            return;
        }// end function

    }
}
