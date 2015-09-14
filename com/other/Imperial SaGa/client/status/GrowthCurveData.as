package status
{

    public class GrowthCurveData extends Object
    {
        private var _uniqueId:int;
        private var _aGrowth:Array;

        public function GrowthCurveData(param1:int, param2:Array)
        {
            this._uniqueId = param1;
            this._aGrowth = param2.concat();
            return;
        }// end function

        public function get uniqueId() : int
        {
            return this._uniqueId;
        }// end function

        public function get aGrowth() : Array
        {
            return this._aGrowth.concat();
        }// end function

        public function addGrowth(param1:int) : void
        {
            this._aGrowth.push(param1);
            return;
        }// end function

    }
}
