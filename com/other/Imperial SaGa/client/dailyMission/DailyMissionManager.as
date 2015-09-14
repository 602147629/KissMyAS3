package dailyMission
{
    import utility.*;

    public class DailyMissionManager extends Object
    {
        private var _lotteryTime:uint;
        private var _timeLimit:uint;
        private var _aMissionData:Array;
        private var _clearCount:int;
        private var _bAllGet:Boolean;
        private static var _instance:DailyMissionManager = null;

        public function DailyMissionManager()
        {
            this.reset();
            return;
        }// end function

        public function get lotteryTime() : uint
        {
            return this._lotteryTime;
        }// end function

        public function get timeLimit() : uint
        {
            return this._timeLimit;
        }// end function

        public function get aMissionData() : Array
        {
            return this._aMissionData.concat();
        }// end function

        public function get bAnyClear() : Boolean
        {
            return this._clearCount > 0;
        }// end function

        public function get bAllGet() : Boolean
        {
            return this._bAllGet;
        }// end function

        public function reset() : void
        {
            this._lotteryTime = 0;
            this._timeLimit = 0;
            this._aMissionData = [];
            this._clearCount = 0;
            this._bAllGet = false;
            return;
        }// end function

        public function setReceive(param1:Object) : void
        {
            this.readMissionData(param1.aDailyMission);
            this.updateClearCount();
            return;
        }// end function

        public function checkReceiveComplete(param1:Object) : void
        {
            if (param1 && param1.aComplete)
            {
                this.readMissionData(param1.aComplete);
                this.updateClearCount();
            }
            return;
        }// end function

        private function readMissionData(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = 0;
            this._aMissionData = [];
            for each (_loc_3 in param1)
            {
                
                _loc_2 = _loc_3.lotteryTime;
                _loc_4 = new DailyMissionData();
                _loc_4.setReceive(_loc_3);
                this._aMissionData.push(_loc_4);
            }
            this._lotteryTime = _loc_2;
            this._timeLimit = this._lotteryTime > 0 ? (TimeClock.calcNextResetTime(CommonConstant.DATE_RESET_TIME, this._lotteryTime)) : (0);
            return;
        }// end function

        public function updateClearCount() : void
        {
            var _loc_2:* = null;
            this._clearCount = 0;
            var _loc_1:* = 0;
            for each (_loc_2 in this._aMissionData)
            {
                
                if (_loc_2.bAchieved)
                {
                    var _loc_5:* = this;
                    var _loc_6:* = this._clearCount + 1;
                    _loc_5._clearCount = _loc_6;
                }
                if (_loc_2.bGet)
                {
                    _loc_1++;
                }
            }
            this._bAllGet = _loc_1 > 0 && _loc_1 >= this._aMissionData.length;
            return;
        }// end function

        public function getRemainTime() : uint
        {
            var _loc_1:* = TimeClock.getNowTime();
            if (_loc_1 < this._timeLimit)
            {
                _loc_1 = this._timeLimit - _loc_1;
            }
            else
            {
                _loc_1 = 0;
            }
            return _loc_1;
        }// end function

        public function checkResetTime() : Boolean
        {
            if (this._timeLimit > 0)
            {
                return this._timeLimit <= TimeClock.getNowTime();
            }
            return false;
        }// end function

        public static function getInstance() : DailyMissionManager
        {
            if (_instance == null)
            {
                _instance = new DailyMissionManager;
            }
            return _instance;
        }// end function

    }
}
