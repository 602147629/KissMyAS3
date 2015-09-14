package 
{
    import utility.*;

    public class MaintenanceData extends Object
    {
        public var NOTICE_FLAG_A:int = 1;
        public var NOTICE_FLAG_B:int = 2;
        public var NOTICE_FLAG_C:int = 3;
        public const MAINTENANCE_TIME_A:uint = 3600;
        public const MAINTENANCE_TIME_B:uint = 1800;
        public const MAINTENANCE_TIME_C:uint = 600;
        private var _checkType:int;
        private var _newCheckType:int;
        private var _maintenanceTime:uint;
        private var _maintenanceTitle:String;
        private var _maintenanceMessage:String;
        public static const MAINTENANCE_TYPE_MAINTENANCE:int = 1;
        public static const MAINTENANCE_TYPE_COUNTDOWN:int = 2;
        public static const MAINTENANCE_TYPE_WORNING:int = 3;

        public function MaintenanceData()
        {
            this._maintenanceTime = 0;
            this._maintenanceTitle = "";
            this._maintenanceMessage = "";
            return;
        }// end function

        public function setRecive(param1:Object) : void
        {
            this._maintenanceTime = param1.maintenanceData.maintenanceTime;
            this._maintenanceTitle = param1.maintenanceData.title;
            this._maintenanceMessage = param1.maintenanceData.message;
            return;
        }// end function

        public function isMaintenanceTime(param1:Boolean = false) : Boolean
        {
            if (this._maintenanceTime <= 0)
            {
                return false;
            }
            var _loc_2:* = false;
            var _loc_3:* = TimeClock.getNowTime();
            if (param1 == false)
            {
                if (this._checkType < this.NOTICE_FLAG_C && this._maintenanceTime - this.MAINTENANCE_TIME_C < _loc_3 || this._checkType < this.NOTICE_FLAG_B && this._maintenanceTime - this.MAINTENANCE_TIME_B < _loc_3 || this._checkType < this.NOTICE_FLAG_A && this._maintenanceTime - this.MAINTENANCE_TIME_A < _loc_3)
                {
                    _loc_2 = true;
                }
            }
            else if (this._maintenanceTime - this.MAINTENANCE_TIME_C < _loc_3 || this._maintenanceTime - this.MAINTENANCE_TIME_B < _loc_3)
            {
                _loc_2 = true;
            }
            return _loc_2;
        }// end function

        public function getMaintenanceType(param1:Boolean) : int
        {
            var _loc_2:* = TimeClock.getNowTime();
            if (this._maintenanceTime <= _loc_2)
            {
                return MAINTENANCE_TYPE_MAINTENANCE;
            }
            if (param1 == false)
            {
                if (this._checkType < this.NOTICE_FLAG_C && this._maintenanceTime - this.MAINTENANCE_TIME_C < _loc_2 || this._checkType < this.NOTICE_FLAG_B && this._maintenanceTime - this.MAINTENANCE_TIME_B < _loc_2 || this._checkType < this.NOTICE_FLAG_A && this._maintenanceTime - this.MAINTENANCE_TIME_A < _loc_2)
                {
                    return MAINTENANCE_TYPE_COUNTDOWN;
                }
            }
            else if (this._maintenanceTime - this.MAINTENANCE_TIME_C < _loc_2 || this._maintenanceTime - this.MAINTENANCE_TIME_B < _loc_2)
            {
                return MAINTENANCE_TYPE_WORNING;
            }
            return 0;
        }// end function

        public function maintenanceCheckType() : void
        {
            var _loc_1:* = TimeClock.getNowTime();
            this._newCheckType = this._checkType;
            if (this._checkType < this.NOTICE_FLAG_C && this._maintenanceTime - this.MAINTENANCE_TIME_C < _loc_1)
            {
                this._newCheckType = this.NOTICE_FLAG_C;
                return;
            }
            if (this._checkType < this.NOTICE_FLAG_B && this._maintenanceTime - this.MAINTENANCE_TIME_B < _loc_1)
            {
                this._newCheckType = this.NOTICE_FLAG_B;
                return;
            }
            if (this._checkType < this.NOTICE_FLAG_A && this._maintenanceTime - this.MAINTENANCE_TIME_A < _loc_1)
            {
                this._newCheckType = this.NOTICE_FLAG_A;
                return;
            }
            return;
        }// end function

        public function getMaintenanceTime() : String
        {
            var _loc_1:* = TimeClock.getNowTime();
            return "";
        }// end function

        public function getMaintenanceTimeByDate() : Date
        {
            var _loc_1:* = new Date();
            if (this._maintenanceTime > 0)
            {
                _loc_1.setTime(this._maintenanceTime * 1000);
            }
            else
            {
                Assert("メンテナンス時間が設定されていませんでした。");
            }
            return _loc_1;
        }// end function

        public function updateCheckType() : void
        {
            if (this._checkType != this._newCheckType)
            {
                this._checkType = this._newCheckType;
            }
            return;
        }// end function

        public function maintenanceTime() : uint
        {
            return this._maintenanceTime;
        }// end function

        public function get maintenanceTitle() : String
        {
            return this._maintenanceTitle;
        }// end function

        public function get maintenanceMessage() : String
        {
            return this._maintenanceMessage;
        }// end function

    }
}
