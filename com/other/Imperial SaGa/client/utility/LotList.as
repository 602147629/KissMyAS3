package utility
{

    public class LotList extends Object
    {
        private var _aLotObject:Array;

        public function LotList()
        {
            this._aLotObject = new Array();
            return;
        }// end function

        public function get aLotObject() : Array
        {
            return this._aLotObject;
        }// end function

        public function addTarget(param1:Object, param2:int) : void
        {
            this._aLotObject.push({target:param1, probability:param2});
            return;
        }// end function

        public function clearTarget() : void
        {
            this._aLotObject = [];
            return;
        }// end function

        public function getTotalProbability() : int
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            for each (_loc_2 in this._aLotObject)
            {
                
                _loc_1 = _loc_1 + _loc_2["probability"];
            }
            return _loc_1;
        }// end function

    }
}
