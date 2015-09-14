package facility
{

    public class FacilityUpgradeTimeData extends Object
    {
        private var _nextGrade:int;
        private var _time:int;
        private var _type:int;

        public function FacilityUpgradeTimeData(param1:Object)
        {
            this._nextGrade = param1.grade;
            this._time = param1.time;
            this._type = param1.type;
            return;
        }// end function

        public function get nextGrade() : int
        {
            return this._nextGrade;
        }// end function

        public function get time() : int
        {
            return this._time;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function clone() : FacilityUpgradeTimeData
        {
            return new FacilityUpgradeTimeData({grade:this._nextGrade, time:this._time, type:this._type});
        }// end function

    }
}
