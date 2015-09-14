package player
{

    public class PlayerBattleBonus extends Object
    {
        private var _attack:int;
        private var _defense:int;
        private var _speed:int;
        private var _hp:int;
        public static const STATUS_ATTAK:int = 1;
        public static const STATUS_DEFENSE:int = 2;
        public static const STATUS_SPEED:int = 3;
        public static const STATUS_HP:int = 4;

        public function PlayerBattleBonus()
        {
            return;
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

        public function get hp() : int
        {
            return this._hp;
        }// end function

        public function setParam(param1:Object) : void
        {
            this._attack = param1.attack;
            this._defense = param1.defense;
            this._speed = param1.speed;
            this._hp = param1.hp;
            return;
        }// end function

        public function setAddBonus(param1:int, param2:int, param3:int, param4:int) : void
        {
            this._attack = param1;
            this._defense = param2;
            this._speed = param3;
            this._hp = param4;
            return;
        }// end function

        public function getStatusUpId() : Array
        {
            var _loc_1:* = [];
            if (this._attack > 0)
            {
                _loc_1.push(STATUS_ATTAK);
            }
            if (this._defense > 0)
            {
                _loc_1.push(STATUS_DEFENSE);
            }
            if (this._speed > 0)
            {
                _loc_1.push(STATUS_SPEED);
            }
            if (this._hp > 0)
            {
                _loc_1.push(STATUS_HP);
            }
            return _loc_1;
        }// end function

    }
}
