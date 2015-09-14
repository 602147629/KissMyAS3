package player
{
    import battle.*;
    import character.*;
    import utility.*;

    public class PlayerCommanderSkill extends Object
    {
        private var _id:int;
        private var _sex:int;
        private var _series:int;
        private var _armyType:int;
        private var _rarity:int;
        private var _weapon1:int;
        private var _weapon2:int;
        private var _weapon3:int;
        private var _tag:int;
        private var _bCondFree:Boolean;
        private var _attack:int;
        private var _defense:int;
        private var _speed:int;
        private var _magic:int;
        private var _aDefenseTolerance:Array;
        private var _aBadStatusTolerance:Array;
        private var _description:String;

        public function PlayerCommanderSkill()
        {
            this._aDefenseTolerance = [];
            this._aBadStatusTolerance = [];
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get condSex() : int
        {
            return this._sex;
        }// end function

        public function get condSeries() : int
        {
            return this._series;
        }// end function

        public function get condArmyType() : int
        {
            return this._armyType;
        }// end function

        public function get condRarity() : int
        {
            return this._rarity;
        }// end function

        public function get condWeapon1() : int
        {
            return this._weapon1;
        }// end function

        public function get condWeapon2() : int
        {
            return this._weapon2;
        }// end function

        public function get condWeapon3() : int
        {
            return this._weapon3;
        }// end function

        public function get condTag() : int
        {
            return this._tag;
        }// end function

        public function isCondFree() : Boolean
        {
            return this._bCondFree;
        }// end function

        public function get addAttack() : int
        {
            return this._attack;
        }// end function

        public function get addDefense() : int
        {
            return this._defense;
        }// end function

        public function get addSpeed() : int
        {
            return this._speed;
        }// end function

        public function get addMagic() : int
        {
            return this._magic;
        }// end function

        public function get aAddDefenseTolerance() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aDefenseTolerance)
            {
                
                _loc_1.push(_loc_2.clone());
            }
            return _loc_1;
        }// end function

        public function get aAddBadStatusTolerance() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aBadStatusTolerance)
            {
                
                _loc_1.push(_loc_2.clone());
            }
            return _loc_1;
        }// end function

        public function get description() : String
        {
            return this._description;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._id = param1.id;
            this._sex = param1.sex;
            this._series = param1.series;
            this._armyType = param1.armytype;
            this._rarity = param1.rarity;
            this._weapon1 = PlayerInformation.convertXmlWeaponTypeToCharacterWeaponType(int(param1.weapon1));
            this._weapon2 = PlayerInformation.convertXmlWeaponTypeToCharacterWeaponType(int(param1.weapon2));
            this._weapon3 = PlayerInformation.convertXmlWeaponTypeToCharacterWeaponType(int(param1.weapon3));
            this._tag = param1.tag;
            this._bCondFree = this._sex + this._series + this._armyType + this._rarity + this._weapon1 + this._weapon2 + this._weapon3 + this._tag == 0;
            this._attack = param1.AddStatus.attack;
            this._defense = param1.AddStatus.defense;
            this._speed = param1.AddStatus.speed;
            this._magic = param1.AddStatus.magic;
            this._aDefenseTolerance = [new BattleToleranceData(CharacterConstant.ATTRIBUTE_SLASH, int(param1.DefenseEffect.cut)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_PUNCH, int(param1.DefenseEffect.strike)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_THRUST, int(param1.DefenseEffect.stabb)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_HEAT, int(param1.DefenseEffect.heat)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_ICY, int(param1.DefenseEffect.cold)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_THUNDER, int(param1.DefenseEffect.thunder))];
            this._aBadStatusTolerance = [new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_INSTANT_DEATH, int(param1.SpecialStatus.death)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_PARALYSIS, int(param1.SpecialStatus.paralysis)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_HYPNOTIC, int(param1.SpecialStatus.hypnotism)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_DARKNESS, int(param1.SpecialStatus.darkness)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_POISON, int(param1.SpecialStatus.poinson)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_STAN, int(param1.SpecialStatus.stan)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_CHARM, int(param1.SpecialStatus.charm)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_CONFUSION, int(param1.SpecialStatus.confusion)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_STONE, int(param1.SpecialStatus.stone))];
            this._description = StringTools.xmlLineToStringLine(param1.description);
            return;
        }// end function

    }
}
