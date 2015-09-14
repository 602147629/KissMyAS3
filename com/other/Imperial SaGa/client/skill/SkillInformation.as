package skill
{
    import battle.*;
    import character.*;
    import utility.*;

    public class SkillInformation extends Object
    {
        private var _skillId:int;
        private var _type:int;
        private var _skillType:int;
        private var _skillName:String;
        private var _fileName:String;
        private var _skillEffectId:int;
        private var _rank:int;
        private var _gliterDiffculty:int;
        private var _comeUpType:int;
        private var _hit:int;
        private var _speedCorrection:int;
        private var _power:int;
        private var _sp:int;
        private var _invokeType:int;
        private var _sequenceType:int;
        private var _attackAttribute:int;
        private var _targetType:int;
        private var _mainTarget:int;
        private var _effectRange:int;
        private var _specifySex:int;
        private var _specifySpecies:int;
        private var _specialQualityFlags:uint;
        private var _addStatus:int;
        private var _addStatusRate:int;
        private var _addStatusTurnMin:int;
        private var _addStatusTurnMax:int;
        private var _linkSkillNameHead:String;
        private var _linkSkillNameNext:String;
        private var _bComboLater:Boolean;
        private var _bComboFront:Boolean;
        private var _detailDescription:String;
        private var _detailDescriptionBattle:String;

        public function SkillInformation()
        {
            return;
        }// end function

        public function get id() : int
        {
            return this._skillId;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function get skillType() : int
        {
            return this._skillType;
        }// end function

        public function get name() : String
        {
            return this._skillName;
        }// end function

        public function get fileName() : String
        {
            return this._fileName;
        }// end function

        public function get effectId() : int
        {
            return this._skillEffectId;
        }// end function

        public function get rank() : int
        {
            return this._rank;
        }// end function

        public function get gliterDiffculty() : int
        {
            return this._gliterDiffculty;
        }// end function

        public function get comeUpType() : int
        {
            return this._comeUpType;
        }// end function

        public function get hit() : int
        {
            return this._hit;
        }// end function

        public function get hitShowVal() : int
        {
            return this._hit / 10;
        }// end function

        public function get speedCorrection() : int
        {
            return this._speedCorrection;
        }// end function

        public function get power() : int
        {
            return this._power;
        }// end function

        public function get sp() : int
        {
            return this._sp;
        }// end function

        public function get invokeType() : int
        {
            return this._invokeType;
        }// end function

        public function get sequenceType() : int
        {
            return this._sequenceType;
        }// end function

        public function isSupport() : Boolean
        {
            return this._power == 0;
        }// end function

        public function get attackAttribute() : int
        {
            return this._attackAttribute;
        }// end function

        public function get targetType() : int
        {
            return this._targetType;
        }// end function

        public function get mainTarget() : int
        {
            return this._mainTarget;
        }// end function

        public function get effectRange() : int
        {
            return this._effectRange;
        }// end function

        public function get specifySex() : int
        {
            return this._specifySex;
        }// end function

        public function get specifySpecies() : int
        {
            return this._specifySpecies;
        }// end function

        public function get specialQualityFlags() : uint
        {
            return this._specialQualityFlags;
        }// end function

        public function hasSpecialQuality(param1:uint) : Boolean
        {
            return (this._specialQualityFlags & param1) != 0;
        }// end function

        public function get addStatus() : int
        {
            return this._addStatus;
        }// end function

        public function get addStatusRate() : int
        {
            return this._addStatusRate;
        }// end function

        public function get addStatusTurnMin() : int
        {
            return this._addStatusTurnMin;
        }// end function

        public function get addStatusTurnMax() : int
        {
            return this._addStatusTurnMax;
        }// end function

        public function get linkSkillNameHead() : String
        {
            return this._linkSkillNameHead;
        }// end function

        public function get linkSkillNameNext() : String
        {
            return this._linkSkillNameNext;
        }// end function

        public function get bComboLater() : Boolean
        {
            return this._bComboLater;
        }// end function

        public function get bComboFront() : Boolean
        {
            return this._bComboFront;
        }// end function

        public function get detailDescription() : String
        {
            return this._detailDescription;
        }// end function

        public function get detailDescriptionBattle() : String
        {
            return this._detailDescriptionBattle;
        }// end function

        public function get bKumitePossible() : Boolean
        {
            return this._power > 0 && this._type != SkillConstant.TYPE_MAGIC;
        }// end function

        public function get bTrainingPossible() : Boolean
        {
            return this._power > 0;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._skillId = parseInt(param1.id);
            this._skillEffectId = parseInt(param1.effectId);
            this._type = param1.type;
            this._skillType = CommonConstant.SKILL_TYPE_NOTYPE;
            switch(int(param1.weponOrMagic))
            {
                case 1:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_SWORD;
                    break;
                }
                case 2:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_GREATSWORD;
                    break;
                }
                case 3:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_SPEAR;
                    break;
                }
                case 4:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_AX;
                    break;
                }
                case 5:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_SHORTSWORD;
                    break;
                }
                case 6:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_MATERIALARTS;
                    break;
                }
                case 7:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_BOW;
                    break;
                }
                case 8:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_CLUB;
                    break;
                }
                case 9:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_NAIL;
                    break;
                }
                case 10:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_HALBERD;
                    break;
                }
                case 11:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_WATER;
                    break;
                }
                case 12:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_FIRE;
                    break;
                }
                case 13:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_EARTH;
                    break;
                }
                case 14:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_WIND;
                    break;
                }
                case 15:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_LIGHT;
                    break;
                }
                case 16:
                {
                    this._skillType = CommonConstant.SKILL_TYPE_DARK;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._skillName = param1.name;
            this._fileName = param1.fileName;
            this._rank = param1.rank;
            this._gliterDiffculty = param1.gliterDiffculty;
            this._comeUpType = int(param1.weponOrMagic);
            this._hit = param1.hit;
            this._speedCorrection = param1.speedRevisen;
            this._power = param1.power;
            this._sp = param1.consumptionSp;
            this._invokeType = param1.invokeType;
            this._sequenceType = param1.sequenceType;
            this._attackAttribute = 0;
            var _loc_2:* = param1.physicalType;
            if (_loc_2 == 0)
            {
                _loc_2 = param1.attackTypePhysical;
            }
            switch(_loc_2)
            {
                case 1:
                {
                    this._attackAttribute = this._attackAttribute | CharacterConstant.ATTRIBUTE_SLASH;
                    break;
                }
                case 2:
                {
                    this._attackAttribute = this._attackAttribute | CharacterConstant.ATTRIBUTE_PUNCH;
                    break;
                }
                case 3:
                {
                    this._attackAttribute = this._attackAttribute | CharacterConstant.ATTRIBUTE_THRUST;
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_3:* = param1.attributeType;
            if (_loc_3 == 0)
            {
                _loc_3 = param1.attackTypeAttribute;
            }
            switch(_loc_3)
            {
                case 1:
                {
                    this._attackAttribute = this._attackAttribute | CharacterConstant.ATTRIBUTE_HEAT;
                    break;
                }
                case 2:
                {
                    this._attackAttribute = this._attackAttribute | CharacterConstant.ATTRIBUTE_ICY;
                    break;
                }
                case 3:
                {
                    this._attackAttribute = this._attackAttribute | CharacterConstant.ATTRIBUTE_THUNDER;
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(int(param1.rangeTarget))
            {
                case 1:
                {
                    this._targetType = SkillConstant.TARGET_TYPE_PLAYER;
                    break;
                }
                case 2:
                {
                    this._targetType = SkillConstant.TARGET_TYPE_ENEMY;
                    break;
                }
                case 3:
                {
                    this._targetType = SkillConstant.TARGET_TYPE_SELF;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._mainTarget = int(param1.mainTarget);
            this._effectRange = int(param1.effectRange);
            this._specifySex = param1.specifySex;
            this._specifySpecies = param1.specifySpecies;
            this._specialQualityFlags = 0;
            if (int(param1.flagUncounterable) == 1)
            {
                this._specialQualityFlags = this._specialQualityFlags | BattleConstant.SPECIAL_QUALITY_FLAG_IMPOSSIBLE_COUNTER;
            }
            if (int(param1.flagHpAbsorb) == 1)
            {
                this._specialQualityFlags = this._specialQualityFlags | BattleConstant.SPECIAL_QUALITY_FLAG_HP_ABSORPTION;
            }
            if (int(param1.flagLpDamage) == 1)
            {
                this._specialQualityFlags = this._specialQualityFlags | BattleConstant.SPECIAL_QUALITY_FLAG_LP_DAMAGE;
            }
            if (int(param1.flagUnaffectedDefence) == 1)
            {
                this._specialQualityFlags = this._specialQualityFlags | BattleConstant.SPECIAL_QUALITY_FLAG_DEFENSE_IGNORED;
            }
            if (int(param1.flagHpRecover) == 1)
            {
                this._specialQualityFlags = this._specialQualityFlags | BattleConstant.SPECIAL_QUALITY_FLAG_HP_RECOVERY;
            }
            if (int(param1.flagStatusRecoverBody) == 1)
            {
                this._specialQualityFlags = this._specialQualityFlags | BattleConstant.SPECIAL_QUALITY_FLAG_BAD_STATUS_1_RECOVERY;
            }
            if (int(param1.flagStatusRecoverMind) == 1)
            {
                this._specialQualityFlags = this._specialQualityFlags | BattleConstant.SPECIAL_QUALITY_FLAG_BAD_STATUS_2_RECOVERY;
            }
            if (int(param1.flagStatusRecoverParamDown) == 1)
            {
                this._specialQualityFlags = this._specialQualityFlags | BattleConstant.SPECIAL_QUALITY_FLAG_BAD_STATUS_3_RECOVERY;
            }
            if (int(param1.flagStatusRecoverParamUp) == 1)
            {
                this._specialQualityFlags = this._specialQualityFlags | BattleConstant.SPECIAL_QUALITY_FLAG_BAD_STATUS_4_RECOVERY;
            }
            if (int(param1.flagStatusRecoverPhysicalDown) == 1)
            {
                this._specialQualityFlags = this._specialQualityFlags | BattleConstant.SPECIAL_QUALITY_FLAG_BAD_STATUS_5_RECOVERY;
            }
            if (int(param1.flagStatusRecoverPhysicalUp) == 1)
            {
                this._specialQualityFlags = this._specialQualityFlags | BattleConstant.SPECIAL_QUALITY_FLAG_BAD_STATUS_6_RECOVERY;
            }
            if (int(param1.flagStatusRecoverAttributeDown) == 1)
            {
                this._specialQualityFlags = this._specialQualityFlags | BattleConstant.SPECIAL_QUALITY_FLAG_BAD_STATUS_7_RECOVERY;
            }
            if (int(param1.flagStatusRecoverAttributeUp) == 1)
            {
                this._specialQualityFlags = this._specialQualityFlags | BattleConstant.SPECIAL_QUALITY_FLAG_BAD_STATUS_8_RECOVERY;
            }
            if (int(param1.flagStatusRecoverAddAttribute) == 1)
            {
                this._specialQualityFlags = this._specialQualityFlags | BattleConstant.SPECIAL_QUALITY_FLAG_BAD_STATUS_9_RECOVERY;
            }
            this._addStatus = int(param1.addStatus);
            this._addStatusRate = param1.addStatusRate;
            this._addStatusTurnMin = param1.addStatusTurnMin;
            this._addStatusTurnMax = param1.addStatusTurnMax;
            this._linkSkillNameHead = param1.linkSkillLater;
            if (this._linkSkillNameHead == null)
            {
                this._linkSkillNameHead = "";
            }
            this._linkSkillNameNext = param1.linkSkillFront;
            if (this._linkSkillNameNext == null)
            {
                this._linkSkillNameNext = "";
            }
            this._bComboFront = Boolean(int(param1.comboFront));
            this._bComboLater = Boolean(int(param1.comboLater));
            if (param1.detailDescriptionBattle == 0)
            {
                this._detailDescription = null;
                this._detailDescriptionBattle = null;
            }
            else
            {
                this._detailDescription = StringTools.xmlLineToStringLine(param1.detailDescription);
                this._detailDescriptionBattle = StringTools.xmlLineToStringLine(param1.detailDescriptionBattle);
            }
            return;
        }// end function

        public function isLearnable(param1:uint) : Boolean
        {
            var _loc_2:* = false;
            switch(this._skillType)
            {
                case CommonConstant.SKILL_TYPE_FIRE:
                {
                    _loc_2 = (param1 & CharacterConstant.MAGIC_TYPE_FLAME) > 0;
                    break;
                }
                case CommonConstant.SKILL_TYPE_WATER:
                {
                    _loc_2 = (param1 & CharacterConstant.MAGIC_TYPE_WATER) > 0;
                    break;
                }
                case CommonConstant.SKILL_TYPE_EARTH:
                {
                    _loc_2 = (param1 & CharacterConstant.MAGIC_TYPE_EARTH) > 0;
                    break;
                }
                case CommonConstant.SKILL_TYPE_WIND:
                {
                    _loc_2 = (param1 & CharacterConstant.MAGIC_TYPE_WIND) > 0;
                    break;
                }
                case CommonConstant.SKILL_TYPE_LIGHT:
                {
                    _loc_2 = (param1 & CharacterConstant.MAGIC_TYPE_LIGHT) > 0;
                    break;
                }
                case CommonConstant.SKILL_TYPE_DARK:
                {
                    _loc_2 = (param1 & CharacterConstant.MAGIC_TYPE_HADES) > 0;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
