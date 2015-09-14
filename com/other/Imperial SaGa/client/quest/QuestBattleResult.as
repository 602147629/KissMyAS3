package quest
{
    import battle.*;

    public class QuestBattleResult extends Object
    {
        private var _uniqueId:uint;
        private var _battleCount:int;
        private var _hp:int;
        private var _attack:int;
        private var _defense:int;
        private var _speed:int;

        public function QuestBattleResult(param1:uint)
        {
            this._uniqueId = param1;
            this._battleCount = 0;
            this._hp = 0;
            this._attack = 0;
            this._defense = 0;
            this._speed = 0;
            return;
        }// end function

        public function get uniqueId() : uint
        {
            return this._uniqueId;
        }// end function

        public function get battleCount() : int
        {
            return this._battleCount;
        }// end function

        public function get hp() : int
        {
            return this._hp;
        }// end function

        public function get attack() : int
        {
            return this._attack;
        }// end function

        public function get defense() : int
        {
            return this._defense;
        }// end function

        public function get speed() : int
        {
            return this._speed;
        }// end function

        public function addBattleCount(param1:BattleBonus) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._battleCount + 1;
            _loc_2._battleCount = _loc_3;
            if (param1)
            {
                if (param1.bonus.hp)
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._hp + 1;
                    _loc_2._hp = _loc_3;
                }
                if (param1.bonus.attack)
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._attack + 1;
                    _loc_2._attack = _loc_3;
                }
                if (param1.bonus.defense)
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._defense + 1;
                    _loc_2._defense = _loc_3;
                }
                if (param1.bonus.speed)
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._speed + 1;
                    _loc_2._speed = _loc_3;
                }
            }
            return;
        }// end function

    }
}
