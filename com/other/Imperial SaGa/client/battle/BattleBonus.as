package battle
{
    import player.*;

    public class BattleBonus extends Object
    {
        private var _questUniqueId:uint;
        private var _bApplied:Boolean;
        private var _bonus:PlayerBattleBonus;

        public function BattleBonus()
        {
            return;
        }// end function

        public function get questUniqueId() : uint
        {
            return this._questUniqueId;
        }// end function

        public function set questUniqueId(param1:uint) : void
        {
            this._questUniqueId = param1;
            return;
        }// end function

        public function get bApplied() : Boolean
        {
            return this._bApplied;
        }// end function

        public function set bApplied(param1:Boolean) : void
        {
            this._bApplied = param1;
            return;
        }// end function

        public function get bonus() : PlayerBattleBonus
        {
            return this._bonus;
        }// end function

        public function set bonus(param1:PlayerBattleBonus) : void
        {
            this._bonus = param1;
            return;
        }// end function

        public static function searchBonus(param1:Array, param2:int) : BattleBonus
        {
            var _loc_4:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1[_loc_3];
                if (param2 == _loc_4.questUniqueId)
                {
                    return _loc_4;
                }
                _loc_3++;
            }
            return null;
        }// end function

    }
}
