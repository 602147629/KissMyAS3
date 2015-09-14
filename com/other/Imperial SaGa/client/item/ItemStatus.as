package item
{
    import battle.*;

    public class ItemStatus extends Object
    {
        private var _addAttack:int;
        private var _addDefense:int;
        private var _addSpeed:int;
        private var _addMagic:int;
        private var _aDefenseTolerance:Array;
        private var _aBadStatusTolerance:Array;

        public function ItemStatus()
        {
            this._aDefenseTolerance = [];
            this._aBadStatusTolerance = [];
            return;
        }// end function

        public function get addAttack() : int
        {
            return this._addAttack;
        }// end function

        public function get addDefense() : int
        {
            return this._addDefense;
        }// end function

        public function get addSpeed() : int
        {
            return this._addSpeed;
        }// end function

        public function get addMagic() : int
        {
            return this._addMagic;
        }// end function

        public function get aDefenseTolerance() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aDefenseTolerance)
            {
                
                _loc_1.push(_loc_2.clone());
            }
            return _loc_1;
        }// end function

        public function get aBadStatusTolerance() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aBadStatusTolerance)
            {
                
                _loc_1.push(_loc_2.clone());
            }
            return _loc_1;
        }// end function

        public function setStatus(param1:int, param2:int, param3:int, param4:int, param5:Array, param6:Array) : void
        {
            this._addAttack = param1;
            this._addDefense = param2;
            this._addSpeed = param3;
            this._addMagic = param4;
            this._aDefenseTolerance = param5.concat();
            this._aBadStatusTolerance = param6.concat();
            return;
        }// end function

    }
}
