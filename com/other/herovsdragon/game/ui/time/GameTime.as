package herovsdragon.game.ui.time
{
    import com.dango_itimi.utils.*;
    import flash.utils.*;

    public class GameTime extends Object
    {
        private var startTime:int;

        public function GameTime()
        {
            return;
        }// end function

        public function setStartTime() : void
        {
            this.startTime = getTimer();
            return;
        }// end function

        public function getPlayTime() : int
        {
            return getTimer() - this.startTime;
        }// end function

        public static function changeMilliSecondsToStr(param1:int) : String
        {
            var _loc_2:* = Math.floor(param1 / 1000);
            var _loc_3:* = _loc_2 % 60;
            _loc_2 = Math.floor(_loc_2 / 60);
            var _loc_4:* = _loc_2 % 60;
            var _loc_5:* = Math.floor(_loc_2 / 60);
            var _loc_6:* = [StringUtil.getAddedZeroPlace(String(_loc_5), 2), StringUtil.getAddedZeroPlace(String(_loc_4), 2), StringUtil.getAddedZeroPlace(String(_loc_3), 2)].join(":");
            return _loc_6;
        }// end function

    }
}
