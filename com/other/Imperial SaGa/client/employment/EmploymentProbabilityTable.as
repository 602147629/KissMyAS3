package employment
{

    public class EmploymentProbabilityTable extends Object
    {
        private var _type:int;
        private var _aProbabilityContent:Array;
        private var _msg:String;

        public function EmploymentProbabilityTable(param1:int, param2:Array, param3:String)
        {
            this._type = param1;
            this._aProbabilityContent = param2.concat();
            this._msg = param3;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function get aProbabilityContent() : Array
        {
            return this._aProbabilityContent;
        }// end function

        public function get msg() : String
        {
            return this._msg;
        }// end function

    }
}
