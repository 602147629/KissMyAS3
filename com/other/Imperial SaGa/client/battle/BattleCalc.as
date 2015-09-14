package battle
{
    import character.*;
    import formationSkill.*;
    import skill.*;
    import utility.*;

    public class BattleCalc extends Object
    {
        private static const _PHYSICAL_ATTRIBUTE:Array = [CharacterConstant.ATTRIBUTE_SLASH, CharacterConstant.ATTRIBUTE_PUNCH, CharacterConstant.ATTRIBUTE_THRUST];
        private static const _ATTRIBUTE:Array = [CharacterConstant.ATTRIBUTE_HEAT, CharacterConstant.ATTRIBUTE_ICY, CharacterConstant.ATTRIBUTE_THUNDER];

        public function BattleCalc()
        {
            return;
        }// end function

        public static function calcDamageFormationSkill(param1:Array, param2:FormationSkillInformation) : int
        {
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            for each (_loc_5 in param1)
            {
                
                _loc_4 = _loc_4 + _loc_5.status.attack;
            }
            _loc_4 = _loc_4 / param1.length;
            _loc_6 = _loc_4 * param2.attackPower;
            _loc_3 = _loc_6 + BattleManager.getRandomParam() % param2.attackPower;
            return _loc_3;
        }// end function

        public static function calcFeverDamage(param1:Array) : int
        {
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_10:* = 0;
            var _loc_2:* = CommonConstant.FEVER_DAMAGE_MIN;
            var _loc_3:* = CommonConstant.FEVER_DAMAGE_MAX;
            var _loc_4:* = CommonConstant.FEVER_DAMAGE_GROWTH_CORRECTION_MIN;
            var _loc_5:* = CommonConstant.FEVER_DAMAGE_GROWTH_CORRECTION_MAX;
            var _loc_6:* = (_loc_3 - _loc_2) / (_loc_5 - _loc_4);
            var _loc_7:* = 0;
            for each (_loc_8 in param1)
            {
                
                _loc_7 = _loc_7 + _loc_8.getGrowthTotal();
            }
            _loc_9 = Random.range(CommonConstant.FEVER_DAMAGE_RANDOM_FACTOR_MIN, CommonConstant.FEVER_DAMAGE_RANDOM_FACTOR_MAX) / 1000;
            _loc_10 = (_loc_2 + _loc_6 * _loc_7) * _loc_9;
            return _loc_10;
        }// end function

        public static function calcDamage(param1:BattleCharacterBase, param2:AttackCharacterStatus, param3:BattleCharacterBase, param4:AttackCharacterStatus, param5:SkillInformation, param6:int, param7:Boolean, param8:Boolean) : int
        {
            var _loc_19:* = 0;
            var _loc_20:* = NaN;
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_9:* = SkillManager.isMagicSkillInfo(param5);
            var _loc_10:* = param1.getSkillPower(param5);
            var _loc_11:* = getAttackAttribute(param5, param2);
            var _loc_12:* = 0;
            if (_loc_9)
            {
                _loc_19 = getFinalMag(param1, param2, param5);
                _loc_20 = getMagicFactor(_loc_19);
                _loc_12 = _loc_10 * _loc_20;
            }
            else
            {
                _loc_21 = getFinalAtk(param1, param2, param5);
                _loc_22 = getFinalDef(param3, param4);
                _loc_23 = getAtkFactor(_loc_21);
                if (param5.hasSpecialQuality(BattleConstant.SPECIAL_QUALITY_FLAG_DEFENSE_IGNORED))
                {
                    _loc_24 = 1;
                }
                else
                {
                    _loc_24 = getDiffFactor(_loc_21, _loc_22);
                }
                _loc_12 = _loc_10 * _loc_23 * _loc_24;
            }
            var _loc_13:* = getPhysicalToleranceFactor(_loc_11, param3, param4);
            var _loc_14:* = getAttributeToleranceFactor(_loc_11, param3, param4);
            var _loc_15:* = getDefenseCommandFactor(param4);
            var _loc_16:* = getDamageComboFactor(param6);
            var _loc_17:* = getAttackRandamFactor(param7, param8);
            var _loc_18:* = _loc_12 * _loc_13 * _loc_14 * _loc_15 * _loc_16 * _loc_17;
            return _loc_12 * _loc_13 * _loc_14 * _loc_15 * _loc_16 * _loc_17;
        }// end function

        private static function getAtkFactor(param1:int) : Number
        {
            var _loc_2:* = CommonConstant.BATTLE_DAMAGE_ATK_FACTOR_MIN;
            var _loc_3:* = CommonConstant.BATTLE_DAMAGE_ATK_FACTOR_MAX;
            var _loc_4:* = CommonConstant.BATTLE_DAMAGE_ATK_CORRECTION_MIN;
            var _loc_5:* = CommonConstant.BATTLE_DAMAGE_ATK_CORRECTION_MAX;
            var _loc_6:* = param1 - _loc_4;
            var _loc_7:* = (_loc_3 - _loc_2) / (_loc_5 - _loc_4);
            var _loc_8:* = _loc_2 + _loc_6 * _loc_7;
            if (_loc_2 + _loc_6 * _loc_7 > _loc_3)
            {
                _loc_8 = _loc_3;
            }
            if (_loc_8 < _loc_2)
            {
                _loc_8 = _loc_2;
            }
            return _loc_8 / 1000;
        }// end function

        private static function getDiffFactor(param1:int, param2:int) : Number
        {
            var _loc_3:* = CommonConstant.BATTLE_DAMAGE_DEF_FACTOR_MIN;
            var _loc_4:* = CommonConstant.BATTLE_DAMAGE_DEF_FACTOR_MAX;
            var _loc_5:* = CommonConstant.BATTLE_DAMAGE_DIFFERENCE_CORRECTION_MIN;
            var _loc_6:* = CommonConstant.BATTLE_DAMAGE_DIFFERENCE_CORRECTION_MAX;
            var _loc_7:* = param1 - param2;
            var _loc_8:* = 0;
            if (_loc_7 >= 0)
            {
                _loc_8 = (_loc_4 - 1000) / _loc_6;
            }
            else
            {
                _loc_8 = (1000 - _loc_3) / (-_loc_5);
            }
            var _loc_9:* = 1000 + _loc_7 * _loc_8;
            if (1000 + _loc_7 * _loc_8 > _loc_4)
            {
                _loc_9 = _loc_4;
            }
            if (_loc_9 < _loc_3)
            {
                _loc_9 = _loc_3;
            }
            return _loc_9 / 1000;
        }// end function

        private static function getMagicFactor(param1:int) : Number
        {
            var _loc_2:* = CommonConstant.BATTLE_DAMAGE_MAGIC_FACTOR_MIN;
            var _loc_3:* = CommonConstant.BATTLE_DAMAGE_MAGIC_FACTOR_MAX;
            var _loc_4:* = CommonConstant.BATTLE_DAMAGE_MAGIC_CORRECTION_MIN;
            var _loc_5:* = CommonConstant.BATTLE_DAMAGE_MAGIC_CORRECTION_MAX;
            var _loc_6:* = param1 - _loc_4;
            var _loc_7:* = (_loc_3 - _loc_2) / (_loc_5 - _loc_4);
            var _loc_8:* = _loc_2 + _loc_6 * _loc_7;
            if (_loc_2 + _loc_6 * _loc_7 > _loc_3)
            {
                _loc_8 = _loc_3;
            }
            if (_loc_8 < _loc_2)
            {
                _loc_8 = _loc_2;
            }
            return _loc_8 / 1000;
        }// end function

        private static function getPhysicalToleranceFactor(param1:uint, param2:BattleCharacterBase, param3:AttackCharacterStatus) : Number
        {
            return getDefenseToleranceFactor(param1, param2, param3, _PHYSICAL_ATTRIBUTE);
        }// end function

        private static function getAttributeToleranceFactor(param1:uint, param2:BattleCharacterBase, param3:AttackCharacterStatus) : Number
        {
            return getDefenseToleranceFactor(param1, param2, param3, _ATTRIBUTE);
        }// end function

        private static function getDefenseToleranceFactor(param1:uint, param2:BattleCharacterBase, param3:AttackCharacterStatus, param4:Array) : Number
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_5:* = int.MIN_VALUE;
            for each (_loc_6 in param4)
            {
                
                if (param1 & _loc_6)
                {
                    _loc_7 = getDefenseToleranceRate(param2, param3, _loc_6);
                    if (_loc_5 < _loc_7)
                    {
                        _loc_5 = _loc_7;
                    }
                }
            }
            if (_loc_5 == int.MIN_VALUE)
            {
                _loc_5 = 0;
            }
            else
            {
                _loc_5 = BattleToleranceData.clampRate(_loc_5);
            }
            return (1000 - _loc_5) / 1000;
        }// end function

        private static function getDefenseCommandFactor(param1:AttackCharacterStatus) : Number
        {
            if (param1.isDefense())
            {
                return CommonConstant.BATTLE_DAMAGE_DEFENSE_COMMAND_FACTOR / 1000;
            }
            return 1;
        }// end function

        private static function getDamageComboFactor(param1:int) : Number
        {
            if (param1 == 2)
            {
                return CommonConstant.BATTLE_DAMAGE_COMBO_FACTOR_2 / 1000;
            }
            if (param1 == 3)
            {
                return CommonConstant.BATTLE_DAMAGE_COMBO_FACTOR_3 / 1000;
            }
            if (param1 == 4)
            {
                return CommonConstant.BATTLE_DAMAGE_COMBO_FACTOR_4 / 1000;
            }
            if (param1 >= 5)
            {
                return CommonConstant.BATTLE_DAMAGE_COMBO_FACTOR_5 / 1000;
            }
            return 1;
        }// end function

        private static function getAttackRandamFactor(param1:Boolean, param2:Boolean) : Number
        {
            if (param1)
            {
                return CommonConstant.BATTLE_DAMAGE_RANDOM_FACTOR_CRITICAL / 1000;
            }
            return Random.range(CommonConstant.BATTLE_DAMAGE_RANDOM_FACTOR_MIN, CommonConstant.BATTLE_DAMAGE_RANDOM_FACTOR_MAX) / 1000;
        }// end function

        private static function getAttackAttribute(param1:SkillInformation, param2:AttackCharacterStatus) : uint
        {
            var _loc_3:* = param1.attackAttribute;
            if (SkillManager.isMagicSkillInfo(param1) == false && (_loc_3 & CharacterConstant.ATTRIBUTE_FLAGS_FILTER_ATTRIBUTE) == 0)
            {
                _loc_3 = _loc_3 | param2.badStatus.getAddAttributeFlags();
            }
            return _loc_3;
        }// end function

        private static function getDefenseToleranceRate(param1:BattleCharacterBase, param2:AttackCharacterStatus, param3:int) : int
        {
            var _loc_4:* = param1.status.getDefenseToleranceRate(param3);
            _loc_4 = param1.status.getDefenseToleranceRate(param3) + param2.badStatus.getDefenseToleranceBonus(param3);
            return _loc_4;
        }// end function

        public static function checkHit(param1:BattleCharacterBase, param2:AttackCharacterStatus, param3:BattleCharacterBase, param4:AttackCharacterStatus, param5:SkillInformation) : Boolean
        {
            if (SkillManager.isMagicSkillInfo(param5))
            {
                return true;
            }
            var _loc_6:* = getFinalHitProbability(param1, param2.badStatus, param3, param4.badStatus, param5);
            return Random.range(0, 999) < _loc_6;
        }// end function

        private static function getFinalHitProbability(param1:BattleCharacterBase, param2:BattleBadStatus, param3:BattleCharacterBase, param4:BattleBadStatus, param5:SkillInformation) : int
        {
            var _loc_11:* = null;
            var _loc_6:* = param1.getSkillHit(param5);
            var _loc_7:* = getHitSpdFactor(getFinalSpd(param1, param2, param5), getFinalSpd(param3, param4, null));
            var _loc_8:* = 1;
            if (BattleManager.isBadStatusDarkness(param2))
            {
                _loc_11 = BattleInformationManager.getInstance().getStatusListData(BattleConstant.BAD_STATUS_ID_DARKNESS);
                _loc_8 = _loc_11.param0 / 1000;
            }
            var _loc_9:* = CommonConstant.BATTLE_HIT_ADJUST_FACTOR / 1000;
            var _loc_10:* = _loc_6 * _loc_7 * _loc_8 * _loc_9;
            if (_loc_6 * _loc_7 * _loc_8 * _loc_9 > CommonConstant.BATTLE_HIT_PROBABIRITY_MAX)
            {
                _loc_10 = CommonConstant.BATTLE_HIT_PROBABIRITY_MAX;
            }
            if (_loc_10 < CommonConstant.BATTLE_HIT_PROBABIRITY_MIN)
            {
                _loc_10 = CommonConstant.BATTLE_HIT_PROBABIRITY_MIN;
            }
            return _loc_10;
        }// end function

        private static function getHitSpdFactor(param1:int, param2:int) : Number
        {
            var _loc_3:* = CommonConstant.BATTLE_HIT_SPD_FACTOR_MIN;
            var _loc_4:* = CommonConstant.BATTLE_HIT_SPD_FACTOR_MAX;
            var _loc_5:* = CommonConstant.BATTLE_HIT_SPD_CORRECTION_MIN;
            var _loc_6:* = CommonConstant.BATTLE_HIT_SPD_CORRECTION_MAX;
            var _loc_7:* = param1 - param2;
            var _loc_8:* = 0;
            if (_loc_7 >= 0)
            {
                _loc_8 = (_loc_4 - 1000) / _loc_6;
            }
            else
            {
                _loc_8 = (1000 - _loc_3) / (-_loc_5);
            }
            var _loc_9:* = 1000 + _loc_7 * _loc_8;
            if (1000 + _loc_7 * _loc_8 > _loc_4)
            {
                _loc_9 = _loc_4;
            }
            if (_loc_9 < _loc_3)
            {
                _loc_9 = _loc_3;
            }
            return _loc_9 / 1000;
        }// end function

        public static function checkCritical(param1:BattleCharacterBase, param2:AttackCharacterStatus, param3:BattleCharacterBase, param4:AttackCharacterStatus, param5:SkillInformation) : Boolean
        {
            if (param5.specifySex || param5.specifySpecies)
            {
                if (param5.specifySex != 0 && param5.specifySex == param3.sex || param5.specifySpecies != 0 && param5.specifySpecies == param3.armyType)
                {
                    return true;
                }
            }
            var _loc_6:* = getCriticalProbability(param1, param2, param3, param4, param5);
            var _loc_7:* = Random.range(0, 999);
            return Random.range(0, 999) < _loc_6;
        }// end function

        private static function getCriticalProbability(param1:BattleCharacterBase, param2:AttackCharacterStatus, param3:BattleCharacterBase, param4:AttackCharacterStatus, param5:SkillInformation) : int
        {
            var _loc_6:* = CommonConstant.BATTLE_CRITICAL_PROBABIRITY_MIN;
            var _loc_7:* = CommonConstant.BATTLE_CRITICAL_PROBABIRITY_MAX;
            var _loc_8:* = CommonConstant.BATTLE_HIT_SPD_CORRECTION_MIN;
            var _loc_9:* = CommonConstant.BATTLE_HIT_SPD_CORRECTION_MAX;
            var _loc_10:* = getFinalSpd(param1, param2.badStatus, param5) - getFinalSpd(param3, param4.badStatus, null);
            var _loc_11:* = (_loc_7 - _loc_6) / (_loc_9 - _loc_8);
            var _loc_12:* = _loc_6 + _loc_10 * _loc_11;
            if (_loc_6 + _loc_10 * _loc_11 > _loc_7)
            {
                _loc_12 = _loc_7;
            }
            if (_loc_12 < _loc_6)
            {
                _loc_12 = _loc_6;
            }
            return _loc_12;
        }// end function

        public static function checkCounterSuccess(param1:BattleCharacterBase, param2:AttackCharacterStatus, param3:int) : Boolean
        {
            return Random.range(0, 999) < CommonConstant.BATTLE_COUNTER_RATE;
        }// end function

        public static function calcSpeed(param1:BattleCharacterBase, param2:SkillInformation) : Number
        {
            var _loc_3:* = getFinalSpd(param1, param1.status.badStatus, param2);
            var _loc_4:* = Random.range(CommonConstant.BATTLE_SPEED_JUDGEMENT_RANDOM_FACTOR_MIN, CommonConstant.BATTLE_SPEED_JUDGEMENT_RANDOM_FACTOR_MAX);
            return Math.floor(_loc_3 * _loc_4 / 100) / 10;
        }// end function

        public static function calcAttackRecoverSp(param1:BattlePlayer, param2:int) : int
        {
            var _loc_3:* = CommonConstant.SP_BATTLE_RECOVERY_CORRECTION_MIN;
            var _loc_4:* = CommonConstant.SP_BATTLE_RECOVERY_CORRECTION_MAX;
            var _loc_5:* = CommonConstant.SP_BATTLE_RECOVERY_BATTLE_COUNT_MIN;
            var _loc_6:* = CommonConstant.SP_BATTLE_RECOVERY_BATTLE_COUNT_MAX;
            var _loc_7:* = param1.playerPersonal.battleCount;
            if (param1.playerPersonal.battleCount > _loc_6)
            {
                _loc_7 = _loc_6;
            }
            if (_loc_7 < 0)
            {
                _loc_7 = 0;
            }
            var _loc_8:* = (_loc_4 - _loc_3) / (_loc_6 - _loc_5);
            var _loc_9:* = Math.floor(_loc_7 * _loc_8);
            return CommonConstant.SP_BATTLE_RECOVERY_BASE + _loc_9;
        }// end function

        public static function calcAfterHp(param1:BattlePlayer) : int
        {
            var _loc_2:* = calcAfterRecoverHp(param1);
            var _loc_3:* = param1.playerPersonal.hp + _loc_2;
            if (_loc_3 > param1.playerPersonal.hpMax)
            {
                _loc_3 = param1.playerPersonal.hpMax;
            }
            return _loc_3;
        }// end function

        public static function calcAfterRecoverHp(param1:BattlePlayer) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = param1.playerPersonal.hp;
            if (_loc_3 > 0)
            {
                _loc_2 = param1.getRecoverTargetDamage() * param1.playerPersonal.damageRecoverRateTotal / 1000;
                if (_loc_2 < 0)
                {
                    _loc_2 = 0;
                }
            }
            return _loc_2;
        }// end function

        public static function checkAddStatus(param1:int, param2:BattleCharacterBase, param3:AttackCharacterStatus, param4:SkillInformation, param5:int) : int
        {
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_6:* = BattleInformationManager.getInstance().getStatusListData(param1);
            var _loc_7:* = BattleInformationManager.getInstance().getStatusListData(param1) ? (_loc_6.effectRate) : (0);
            var _loc_8:* = param4.addStatusRate ? (param4.addStatusRate) : (_loc_7);
            var _loc_9:* = SkillManager.getBadStateType(param4);
            var _loc_10:* = BattleToleranceData.clampRate(param2.status.getBadStatusToleranceRate(_loc_9));
            var _loc_11:* = getBadStatusComboFactor(param5);
            var _loc_12:* = _loc_8 * (1000 - _loc_10) / 1000 * _loc_11;
            var _loc_13:* = Random.range(0, 999);
            var _loc_14:* = -1;
            if (_loc_12 > _loc_13)
            {
                _loc_15 = _loc_6 ? (_loc_6.turnMin) : (0);
                _loc_16 = _loc_6 ? (_loc_6.turnMax) : (0);
                _loc_15 = param4.addStatusTurnMin ? (param4.addStatusTurnMin) : (_loc_15);
                _loc_16 = param4.addStatusTurnMax ? (param4.addStatusTurnMax) : (_loc_16);
                _loc_14 = Random.range(_loc_15, _loc_16);
            }
            return _loc_14;
        }// end function

        private static function getBadStatusComboFactor(param1:int) : Number
        {
            if (param1 == 2)
            {
                return CommonConstant.BATTLE_BAD_STATUS_COMBO_FACTOR_2 / 1000;
            }
            if (param1 == 3)
            {
                return CommonConstant.BATTLE_BAD_STATUS_COMBO_FACTOR_3 / 1000;
            }
            if (param1 == 4)
            {
                return CommonConstant.BATTLE_BAD_STATUS_COMBO_FACTOR_4 / 1000;
            }
            if (param1 >= 5)
            {
                return CommonConstant.BATTLE_BAD_STATUS_COMBO_FACTOR_5 / 1000;
            }
            return 1;
        }// end function

        private static function getFinalAtk(param1:BattleCharacterBase, param2:AttackCharacterStatus, param3:SkillInformation) : int
        {
            var _loc_4:* = param1.personal.attackTotal;
            var _loc_5:* = param2.badStatus.getAttackBonus(_loc_4);
            return _loc_4 + _loc_5;
        }// end function

        private static function getFinalDef(param1:BattleCharacterBase, param2:AttackCharacterStatus) : int
        {
            var _loc_3:* = param1.personal.defenseTotal;
            var _loc_4:* = param2.badStatus.getDefenseBonus(_loc_3);
            return _loc_3 + _loc_4;
        }// end function

        private static function getFinalSpd(param1:BattleCharacterBase, param2:BattleBadStatus, param3:SkillInformation) : int
        {
            var _loc_4:* = param1.personal.speedTotal + (param3 ? (param3.speedCorrection) : (0));
            var _loc_5:* = param2.getSpeedBonus(_loc_4);
            return _loc_4 + _loc_5;
        }// end function

        private static function getFinalMag(param1:BattleCharacterBase, param2:AttackCharacterStatus, param3:SkillInformation) : int
        {
            var _loc_4:* = param1.personal.magicReasonableTotal;
            var _loc_5:* = param2.badStatus.getMagicBonus(_loc_4);
            return _loc_4 + _loc_5;
        }// end function

    }
}
