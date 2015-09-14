package enemy
{
    import battle.*;
    import character.*;

    public class EnemyInformation extends Object
    {
        protected var _id:int;
        protected var _swf:String;
        protected var _imageFileName:String;
        protected var _name:String;
        protected var _series:int;
        protected var _magicReasonable:int;
        protected var _sex:int;
        protected var _armyType:int;
        protected var _bossFlag:Boolean;
        protected var _attack:int;
        protected var _defense:int;
        protected var _speed:int;
        protected var _hp:int;
        protected var _aSetEasySkill:Array;
        protected var _aDefenseTolerance:Array;
        protected var _aBadStatusTolerance:Array;
        protected var _rank:int;

        public function EnemyInformation()
        {
            this._aDefenseTolerance = [];
            this._aBadStatusTolerance = [];
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get swf() : String
        {
            return this._swf;
        }// end function

        public function get bustUpFileName() : String
        {
            return CharacterConstant.ID_BUSTUP + this._imageFileName;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get series() : int
        {
            return this._series;
        }// end function

        public function get magicReasonable() : int
        {
            return this._magicReasonable;
        }// end function

        public function get sex() : int
        {
            return this._sex;
        }// end function

        public function get armyType() : int
        {
            return this._armyType;
        }// end function

        public function get symbolType() : int
        {
            return this._armyType;
        }// end function

        public function get bossFlag() : Boolean
        {
            return this._bossFlag;
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

        public function get aSetEasySkill() : Array
        {
            return this._aSetEasySkill;
        }// end function

        public function get aDefenseTolerance() : Array
        {
            return this._aDefenseTolerance;
        }// end function

        public function get aBadStatusTolerance() : Array
        {
            return this._aBadStatusTolerance;
        }// end function

        public function get rank() : int
        {
            return this._rank;
        }// end function

        public function get bNotDamageMove() : Boolean
        {
            return this.id == EnemyId.id_mons_Giant_XL_CL02_E02 || this.id == EnemyId.id_mons_Giant_XL_CL02_E04 || this.id == EnemyId.id_mons_Giant_XL_CL02_E06 || this.id == EnemyId.id_mons_Giant_XL_CL02_E09;
        }// end function

        public function setXml(param1:Object) : void
        {
            this._id = param1.id;
            this._swf = param1.fileName;
            this._imageFileName = param1.imageFileName;
            this._name = param1.name;
            switch(int(param1.series))
            {
                case 1:
                {
                    this._series = CommonConstant.SERIES_RS1;
                    break;
                }
                case 2:
                {
                    this._series = CommonConstant.SERIES_RS2;
                    break;
                }
                case 3:
                {
                    this._series = CommonConstant.SERIES_RS3;
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(int(param1.sex))
            {
                case 0:
                {
                    this._sex = CharacterConstant.SEX_NON;
                    break;
                }
                case 1:
                {
                    this._sex = CharacterConstant.SEX_MAN;
                    break;
                }
                case 2:
                {
                    this._sex = CharacterConstant.SEX_WOMAN;
                    break;
                }
                case 3:
                {
                    this._sex = CharacterConstant.SEX_MACHINE;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._armyType = int(param1.armytype);
            this._bossFlag = int(param1.bossFlag) == 1;
            this._attack = param1.attack;
            this._defense = param1.defense;
            this._speed = param1.speed;
            this._hp = param1.hp;
            this._magicReasonable = param1.magicReasonable;
            this._aSetEasySkill = [new EnemySetSkill(int(param1.skill01), int(param1.skill01Rate)), new EnemySetSkill(int(param1.skill02), int(param1.skill02Rate)), new EnemySetSkill(int(param1.skill03), int(param1.skill03Rate)), new EnemySetSkill(int(param1.skill04), int(param1.skill04Rate))];
            this._aDefenseTolerance = [new BattleToleranceData(CharacterConstant.ATTRIBUTE_SLASH, int(param1.toleranceSlash)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_PUNCH, int(param1.toleranceBeat)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_THRUST, int(param1.toleranceThrust)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_HEAT, int(param1.toleranceHeat)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_ICY, int(param1.toleranceCold)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_THUNDER, int(param1.toleranceThuneder))];
            this._aBadStatusTolerance = [new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_INSTANT_DEATH, int(param1.toleranceBadStatusDeath)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_PARALYSIS, int(param1.toleranceBadStatusParalyzed)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_HYPNOTIC, int(param1.toleranceBadStatusHypnotic)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_DARKNESS, int(param1.toleranceBadStatusDark)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_POISON, int(param1.toleranceBadStatusPoison)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_STAN, int(param1.toleranceBadStatusStan)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_CHARM, int(param1.toleranceBadStatusCharm)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_CONFUSION, int(param1.toleranceBadStatusConfusion)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_STONE, int(param1.toleranceBadStatusStone))];
            this._rank = param1.rank;
            return;
        }// end function

    }
}
