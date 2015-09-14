package facility
{

    public class FacilityList extends Object
    {
        private var _id:uint;
        private var _grade:int;
        private var _point:int;
        private var _time:uint;

        public function FacilityList()
        {
            return;
        }// end function

        public function get id() : uint
        {
            return this._id;
        }// end function

        public function get grade() : int
        {
            return this._grade;
        }// end function

        public function get point() : int
        {
            return this._point;
        }// end function

        public function get time() : uint
        {
            return this._time;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._id = param1.id;
            this._grade = param1.grade;
            this._point = param1.point;
            this._time = param1.time;
            return;
        }// end function

    }
}
