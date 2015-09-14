package player
{
    import battle.*;
    import character.*;

    public class PlayerInformation extends Object
    {
        protected var _id:int;
        protected var _swf:String;
        protected var _cardFileName:String;
        protected var _characterId:int;
        protected var _name:String;
        protected var _yomigana:String;
        protected var _rarity:int;
        protected var _series:int;
        protected var _sex:int;
        protected var _armyType:int;
        protected var _attack:int;
        protected var _defense:int;
        protected var _speed:int;
        protected var _recoverRate:int;
        protected var _hp:int;
        protected var _lp:int;
        protected var _sp:int;
        private var _maxAttack:int;
        private var _maxDefense:int;
        private var _maxSpeed:int;
        private var _maxHp:int;
        protected var _weaponType:int;
        protected var _magicReasonable:int;
        protected var _life:int;
        private var _comeUpType:int;
        private var _magicType:int;
        protected var _aDefenseTolerance:Array;
        protected var _aBadStatusTolerance:Array;
        private var _feverType:int;
        private var _commanderSkillId:int;
        private var _tag:int;
        protected var _diagramName:String;
        protected var _diagramFileName:String;
        protected var _diagramType:int;
        protected var _aDiagramCharaId:Array;
        private var _normalSkillId:int;
        protected var _aSetSkillId:Array;

        public function PlayerInformation()
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
            return CharacterConstant.ID_BUSTUP + this._cardFileName;
        }// end function

        public function get cardFileName() : String
        {
            return this.getCardFileName();
        }// end function

        public function get correlationFileName() : String
        {
            return CharacterConstant.ID_CORRELATION + this.getCardFileName();
        }// end function

        private function getCardFileName() : String
        {
            return this._cardFileName;
        }// end function

        public function get characterId() : int
        {
            return this._characterId;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get yomigana() : String
        {
            return this._yomigana;
        }// end function

        public function get rarity() : int
        {
            return this._rarity;
        }// end function

        public function get series() : int
        {
            return this._series;
        }// end function

        public function get sex() : int
        {
            return this._sex;
        }// end function

        public function get armyType() : int
        {
            return this._armyType;
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

        public function get recoverRate() : int
        {
            return this._recoverRate;
        }// end function

        public function get hp() : int
        {
            return this._hp;
        }// end function

        public function get lp() : int
        {
            return this._lp;
        }// end function

        public function get sp() : int
        {
            return this._sp;
        }// end function

        public function get maxAttack() : int
        {
            return this._maxAttack;
        }// end function

        public function get maxDefense() : int
        {
            return this._maxDefense;
        }// end function

        public function get maxSpeed() : int
        {
            return this._maxSpeed;
        }// end function

        public function get maxHp() : int
        {
            return this._maxHp;
        }// end function

        public function get weaponType() : int
        {
            return this._weaponType;
        }// end function

        public function get magicReasonable() : int
        {
            return this._magicReasonable;
        }// end function

        public function get life() : int
        {
            return this._life;
        }// end function

        public function get comeUpType() : int
        {
            return this._comeUpType;
        }// end function

        public function get magicType() : int
        {
            return this._magicType;
        }// end function

        public function getDefenseTolerance() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aDefenseTolerance)
            {
                
                _loc_1.push(_loc_2.clone());
            }
            return _loc_1;
        }// end function

        public function getBadStatusTolerance() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aBadStatusTolerance)
            {
                
                _loc_1.push(_loc_2.clone());
            }
            return _loc_1;
        }// end function

        public function get feverType() : int
        {
            return this._feverType;
        }// end function

        public function get commanderSkillId() : int
        {
            return this._commanderSkillId;
        }// end function

        public function hasCommanderSkill() : Boolean
        {
            return this._commanderSkillId != Constant.EMPTY_ID;
        }// end function

        public function get tag() : int
        {
            return this._tag;
        }// end function

        public function get diagramName() : String
        {
            return this._diagramName;
        }// end function

        public function get diagramFileName() : String
        {
            return this._diagramFileName;
        }// end function

        public function get diagramType() : int
        {
            return this._diagramType;
        }// end function

        public function get aDiagramCharaId() : Array
        {
            return this._aDiagramCharaId;
        }// end function

        public function get normalSkillId() : int
        {
            return this._normalSkillId;
        }// end function

        public function get aSetSkillId() : Array
        {
            return this._aSetSkillId.concat();
        }// end function

        public function setXml(param1:XML) : void
        {
            var _loc_4:* = 0;
            this._id = param1.id;
            this._swf = param1.fileName;
            this._cardFileName = param1.cardFileName;
            this._name = param1.name;
            this._yomigana = param1.yomigana;
            this._characterId = param1.charaId;
            this._rarity = int(param1.rarity);
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
            switch(int(param1.armytype))
            {
                case 0:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_EMPIREHEAVYINFANTRY;
                    break;
                }
                case 1:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_EMPIRELIGHTINFANTRY;
                    break;
                }
                case 2:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_EMPIREJAGER;
                    break;
                }
                case 3:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_MAGICIAN;
                    break;
                }
                case 4:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_FREEFIGHTER;
                    break;
                }
                case 5:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_FREEMAGE;
                    break;
                }
                case 6:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_CITYTHIEF;
                    break;
                }
                case 7:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_STRATEGIST;
                    break;
                }
                case 8:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_IMPEROALGUARD;
                    break;
                }
                case 9:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_FIGHTER;
                    break;
                }
                case 10:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_ZYGOGROUP;
                    break;
                }
                case 11:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_ARMEDMERCHANTFLEET;
                    break;
                }
                case 12:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_HOLYORDER;
                    break;
                }
                case 13:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_NOMAD;
                    break;
                }
                case 14:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_DESSERTGUARD;
                    break;
                }
                case 15:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_EASTGUARD;
                    break;
                }
                case 16:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_AMAZONS;
                    break;
                }
                case 17:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_HUNTER;
                    break;
                }
                case 18:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_WOMANDEIVER;
                    break;
                }
                case 19:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_SALAMANDER;
                    break;
                }
                case 20:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_MALL;
                    break;
                }
                case 21:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_NEREID;
                    break;
                }
                case 22:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_IRIS;
                    break;
                }
                case 23:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_ONMYOJI;
                    break;
                }
                case 24:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_LASTEMPEROR;
                    break;
                }
                case 25:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_SEVENHEROES;
                    break;
                }
                case 26:
                {
                    this._armyType = CharacterConstant.ARMYTYPE_NON;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._attack = param1.attack;
            this._defense = param1.defense;
            this._speed = param1.speed;
            this._recoverRate = param1.recoverRate;
            this._hp = param1.hp;
            this._lp = param1.lp;
            this._sp = param1.sp;
            this._maxAttack = param1.maxAttack;
            this._maxDefense = param1.maxDefense;
            this._maxSpeed = param1.maxSpeed;
            this._maxHp = param1.maxHp;
            this._series = int(param1.series);
            this._weaponType = convertXmlWeaponTypeToCharacterWeaponType(int(param1.weapon));
            this._magicReasonable = param1.magicReasonable;
            this._life = param1.life;
            this._comeUpType = int(param1.weapon);
            this._magicType = 0;
            if (int(param1.magicTypeWater) == 1)
            {
                this._magicType = this._magicType | CharacterConstant.MAGIC_TYPE_WATER;
            }
            if (int(param1.magicTypeFlame) == 1)
            {
                this._magicType = this._magicType | CharacterConstant.MAGIC_TYPE_FLAME;
            }
            if (int(param1.magicTypeEarth) == 1)
            {
                this._magicType = this._magicType | CharacterConstant.MAGIC_TYPE_EARTH;
            }
            if (int(param1.magicTypeWind) == 1)
            {
                this._magicType = this._magicType | CharacterConstant.MAGIC_TYPE_WIND;
            }
            if (int(param1.magicTypeLight) == 1)
            {
                this._magicType = this._magicType | CharacterConstant.MAGIC_TYPE_LIGHT;
            }
            if (int(param1.magicTypeHades) == 1)
            {
                this._magicType = this._magicType | CharacterConstant.MAGIC_TYPE_HADES;
            }
            this._aDefenseTolerance = [new BattleToleranceData(CharacterConstant.ATTRIBUTE_SLASH, int(param1.toleranceSlash)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_PUNCH, int(param1.toleranceBeat)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_THRUST, int(param1.toleranceThrust)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_HEAT, int(param1.toleranceHeat)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_ICY, int(param1.toleranceCold)), new BattleToleranceData(CharacterConstant.ATTRIBUTE_THUNDER, int(param1.toleranceThuneder))];
            this._aBadStatusTolerance = [new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_INSTANT_DEATH, int(param1.toleranceBadStatusDeath)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_PARALYSIS, int(param1.toleranceBadStatusParalyzed)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_HYPNOTIC, int(param1.toleranceBadStatusHypnotic)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_DARKNESS, int(param1.toleranceBadStatusDark)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_POISON, int(param1.toleranceBadStatusPoison)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_STAN, int(param1.toleranceBadStatusStan)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_CHARM, int(param1.toleranceBadStatusCharm)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_CONFUSION, int(param1.toleranceBadStatusConfusion)), new BattleToleranceData(BattleConstant.BAD_STATE_TYPE_STONE, int(param1.toleranceBadStatusStone))];
            this._feverType = param1.assaultType;
            this._commanderSkillId = param1.commanderSkill;
            this._tag = param1.tag;
            this._diagramName = param1.diagramName;
            this._diagramFileName = param1.diagramFileName;
            this._diagramType = param1.diagramType;
            this._aDiagramCharaId = [];
            var _loc_2:* = param1.diagramPosition.pos;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length())
            {
                
                _loc_4 = _loc_2[_loc_3];
                this._aDiagramCharaId.push(_loc_4);
                _loc_3++;
            }
            this._normalSkillId = param1.defaultSkill;
            this._aSetSkillId = [];
            this._aSetSkillId.push(int(param1.initialSA1));
            this._aSetSkillId.push(int(param1.initialSA2));
            this._aSetSkillId.push(int(param1.initialSA3));
            return;
        }// end function

        public function getDefenseToleranceRate(param1:int) : int
        {
            return BattleToleranceData.getToleranceRate(this._aDefenseTolerance, param1);
        }// end function

        public function getBadStatusToleranceRate(param1:int) : int
        {
            return BattleToleranceData.getToleranceRate(this._aBadStatusTolerance, param1);
        }// end function

        public static function convertXmlWeaponTypeToCharacterWeaponType(param1:int) : int
        {
            switch(param1)
            {
                case 1:
                {
                    return CommonConstant.CHARACTER_WEAPONTYPE_SWORD;
                }
                case 2:
                {
                    return CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD;
                }
                case 3:
                {
                    return CommonConstant.CHARACTER_WEAPONTYPE_SPEAR;
                }
                case 4:
                {
                    return CommonConstant.CHARACTER_WEAPONTYPE_AX;
                }
                case 5:
                {
                    return CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD;
                }
                case 6:
                {
                    return CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS;
                }
                case 7:
                {
                    return CommonConstant.CHARACTER_WEAPONTYPE_BOW;
                }
                case 8:
                {
                    return CommonConstant.CHARACTER_WEAPONTYPE_CLUB;
                }
                case 9:
                {
                    return CommonConstant.CHARACTER_WEAPONTYPE_NAIL;
                }
                case 10:
                {
                    return CommonConstant.CHARACTER_WEAPONTYPE_HALBERD;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

    }
}
