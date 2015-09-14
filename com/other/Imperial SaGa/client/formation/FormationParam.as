package formation
{
    import player.*;

    public class FormationParam extends Object
    {
        private var _charaIndex:int;
        private var _probability:int;
        private var _attack:int;
        private var _defense:int;
        private var _speed:int;
        private var _magic:int;
        private var _condition:int;
        private var _columnPosition:int;
        private var _rowPosition:int;

        public function FormationParam(param1:XML)
        {
            this._charaIndex = param1.index;
            this._probability = param1.probability;
            this._speed = param1.speed;
            this._attack = param1.attack;
            this._defense = param1.defense;
            this._magic = param1.magicType;
            this._columnPosition = param1.columnPosition;
            this._rowPosition = param1.rowPosition;
            this._condition = PlayerInformation.convertXmlWeaponTypeToCharacterWeaponType(int(param1.condition));
            return;
        }// end function

        public function charaIndex() : int
        {
            return this._charaIndex;
        }// end function

        public function get probability() : int
        {
            return this._probability;
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

        public function get magic() : int
        {
            return this._magic;
        }// end function

        public function get condition() : int
        {
            return this._condition;
        }// end function

        public function get columnPosition() : int
        {
            return this._columnPosition;
        }// end function

        public function get rowPosition() : int
        {
            return this._rowPosition;
        }// end function

    }
}
