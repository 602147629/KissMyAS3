package battle
{
    import character.*;
    import skill.*;

    public class BattleAddStatusCalc extends Object
    {

        public function BattleAddStatusCalc()
        {
            return;
        }// end function

        public static function isAddStatusMiss(param1:SkillInformation, param2:BattleCharacterBase, param3:BattleCharacterBase, param4:AttackCharacterStatus) : Boolean
        {
            var _loc_5:* = null;
            if (param1.hasSpecialQuality(BattleConstant.SPECIAL_QUALITY_FLAG_HP_ABSORPTION))
            {
                if (param2.characterAction.type == CharacterDisplayBase.TYPE_PLAYER)
                {
                    return true;
                }
            }
            if (param1.hasSpecialQuality(BattleConstant.SPECIAL_QUALITY_FLAG_LP_DAMAGE))
            {
                if (param2.characterAction.type != CharacterDisplayBase.TYPE_PLAYER)
                {
                    _loc_5 = param3 as BattlePlayer;
                    if (_loc_5 && _loc_5.playerPersonal.isEmperor())
                    {
                        return true;
                    }
                }
            }
            if (param1.hasSpecialQuality(BattleConstant.SPECIAL_QUALITY_FLAG_HP_RECOVERY))
            {
                if (param2.characterAction.type == CharacterDisplayBase.TYPE_PLAYER)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public static function executionAddStatusCounter(param1:SkillInformation, param2:BattleCharacterBase) : BattleAddStatusResult
        {
            var _loc_3:* = new BattleAddStatusResult();
            if (param1.invokeType == SkillConstant.INVOKE_TYPE_COUNTER)
            {
                _loc_3.setCounterSkillId(param1.id);
                _loc_3.setDamageHp(0);
            }
            return _loc_3;
        }// end function

        public static function executionAddStatus(param1:SkillInformation, param2:BattleCharacterBase, param3:BattleCharacterBase, param4:AttackCharacterStatus, param5:int) : BattleAddStatusResult
        {
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_6:* = new BattleAddStatusResult();
            if (param1.hasSpecialQuality(BattleConstant.SPECIAL_QUALITY_FLAG_HP_ABSORPTION))
            {
                if (param2.characterAction.type == CharacterDisplayBase.TYPE_PLAYER)
                {
                    _loc_6.setMiss();
                }
            }
            if (param1.hasSpecialQuality(BattleConstant.SPECIAL_QUALITY_FLAG_LP_DAMAGE))
            {
                _loc_6.setDamageHp(0);
                if (param2.characterAction.type == CharacterDisplayBase.TYPE_PLAYER)
                {
                    if (judgmentBadStatus(BattleConstant.BAD_STATUS_ID_INSTANT_DEATH, param3.status))
                    {
                        _loc_6.badStatus.addStatusData(new BattleBadStatusData(BattleConstant.BAD_STATUS_ID_INSTANT_DEATH));
                    }
                }
                else
                {
                    _loc_8 = param3 as BattlePlayer;
                    if (_loc_8 && _loc_8.playerPersonal.isEmperor())
                    {
                        _loc_6.setMiss();
                    }
                    else
                    {
                        _loc_6.setDamageLp();
                    }
                }
            }
            if (param1.hasSpecialQuality(BattleConstant.SPECIAL_QUALITY_FLAG_HP_RECOVERY))
            {
                if (param2.characterAction.type == CharacterDisplayBase.TYPE_PLAYER)
                {
                    _loc_6.setMiss();
                }
                else
                {
                    _loc_6.setDamageHp(0);
                    _loc_9 = param3.personal.hpMax * CommonConstant.BATTLE_HP_RECOVERY_FACTOR / 1000;
                    if (_loc_9 > param3.personal.hpMax - param4.hp)
                    {
                        _loc_9 = param3.personal.hpMax - param4.hp;
                    }
                    _loc_6.setRecoveryHp(_loc_9);
                }
            }
            var _loc_7:* = recoveryBadStatusIdArray(param1);
            if (recoveryBadStatusIdArray(param1).length > 0)
            {
                _loc_6.recoveryBadStatus.addStatusIdArray(_loc_7);
            }
            if (param1.addStatus)
            {
                switch(param1.addStatus)
                {
                    case BattleConstant.ADD_STATUS_POISON:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_POISON, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_PARALYSIS:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_PARALYSIS, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_DARKNESS:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_DARKNESS, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_SLEEP:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_SLEEP, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_CONFUSION:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_CONFUSION, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_STAN:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_STAN, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_CHARM:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_CHARM, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_CHARM_MAN:
                    {
                        if (param3.sex == CharacterConstant.SEX_MAN)
                        {
                            checkAddStatusOne(BattleConstant.BAD_STATUS_ID_CHARM, param3, param4, param1, param5, _loc_6);
                        }
                        break;
                    }
                    case BattleConstant.ADD_STATUS_INSTANT_DEATH:
                    {
                        if (judgmentBadStatus(BattleConstant.BAD_STATUS_ID_INSTANT_DEATH, param3.status))
                        {
                            checkAddStatusOne(BattleConstant.BAD_STATUS_ID_INSTANT_DEATH, param3, param4, param1, param5, _loc_6);
                        }
                        break;
                    }
                    case BattleConstant.ADD_STATUS_STONE:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_STONE, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_ATTACK_DOWN:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_ATTACK_DOWN, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_ATTACK_UP:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_ATTACK_UP, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_DEFENSE_DOWN:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_DEFENSE_DOWN, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_DEFENSE_UP:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_DEFENSE_UP, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_SPEED_DOWN:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_SPEED_DOWN, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_SPEED_UP:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_SPEED_UP, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_MAGIC_DOWN:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_MAGIC_DOWN, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_MAGIC_UP:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_MAGIC_UP, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_ALL_DOWN:
                    {
                        checkAddStatusArray([BattleConstant.BAD_STATUS_ID_ATTACK_DOWN, BattleConstant.BAD_STATUS_ID_DEFENSE_DOWN, BattleConstant.BAD_STATUS_ID_SPEED_DOWN, BattleConstant.BAD_STATUS_ID_MAGIC_DOWN], param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_ALL_UP:
                    {
                        checkAddStatusArray([BattleConstant.BAD_STATUS_ID_ATTACK_UP, BattleConstant.BAD_STATUS_ID_DEFENSE_UP, BattleConstant.BAD_STATUS_ID_SPEED_UP, BattleConstant.BAD_STATUS_ID_MAGIC_UP], param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_SLASH_TOLERANCE_DOWN:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_SLASH_TOLERANCE_DOWN, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_SLASH_TOLERANCE_UP:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_SLASH_TOLERANCE_UP, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_PUNCH_TOLERANCE_DOWN:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_PUNCH_TOLERANCE_DOWN, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_PUNCH_TOLERANCE_UP:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_PUNCH_TOLERANCE_UP, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_THRUST_TOLERANCE_DOWN:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_THRUST_TOLERANCE_DOWN, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_THRUST_TOLERANCE_UP:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_THRUST_TOLERANCE_UP, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_HEAT_TOLERANCE_DOWN:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_HEAT_TOLERANCE_DOWN, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_HEAT_TOLERANCE_UP:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_HEAT_TOLERANCE_UP, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_ICY_TOLERANCE_DOWN:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_ICY_TOLERANCE_DOWN, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_ICY_TOLERANCE_UP:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_ICY_TOLERANCE_UP, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_THUNDER_TOLERANCE_DOWN:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_THUNDER_TOLERANCE_DOWN, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_THUNDER_TOLERANCE_UP:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_THUNDER_TOLERANCE_UP, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_ADD_ATTRIBUTE_HEAT:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_ADD_ATTRIBUTE_HEAT, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_ADD_ATTRIBUTE_ICY:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_ADD_ATTRIBUTE_ICY, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    case BattleConstant.ADD_STATUS_ADD_ATTRIBUTE_THUNDER:
                    {
                        checkAddStatusOne(BattleConstant.BAD_STATUS_ID_ADD_ATTRIBUTE_THUNDER, param3, param4, param1, param5, _loc_6);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return _loc_6;
        }// end function

        public static function recoveryBadStatusIdArray(param1:SkillInformation) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = 1;
            var _loc_4:* = BattleConstant.SPECIAL_QUALITY_FLAG_BAD_STATUS_1_RECOVERY;
            while (_loc_4 <= BattleConstant.SPECIAL_QUALITY_FLAG_BAD_STATUS_9_RECOVERY)
            {
                
                if (param1.hasSpecialQuality(_loc_4))
                {
                    _loc_2 = _loc_2.concat(BattleInformationManager.getInstance().getGorupBadStatusId(_loc_3));
                }
                _loc_3++;
                _loc_4 = _loc_4 << 1;
            }
            return _loc_2;
        }// end function

        private static function judgmentBadStatus(param1:int, param2:BattleCharacterStatus) : Boolean
        {
            if (param2.badStatus.isBadStatus(param1))
            {
                return false;
            }
            return true;
        }// end function

        private static function checkAddStatusOne(param1:int, param2:BattleCharacterBase, param3:AttackCharacterStatus, param4:SkillInformation, param5:int, param6:BattleAddStatusResult) : void
        {
            var _loc_7:* = BattleCalc.checkAddStatus(param1, param2, param3, param4, param5);
            if (BattleCalc.checkAddStatus(param1, param2, param3, param4, param5) >= 0)
            {
                param6.badStatus.addStatusData(new BattleBadStatusData(param1, _loc_7));
            }
            else
            {
                param6.setResist();
            }
            return;
        }// end function

        private static function checkAddStatusArray(param1:Array, param2:BattleCharacterBase, param3:AttackCharacterStatus, param4:SkillInformation, param5:int, param6:BattleAddStatusResult) : void
        {
            var _loc_8:* = 0;
            var _loc_7:* = BattleCalc.checkAddStatus(param1[0], param2, param3, param4, param5);
            if (BattleCalc.checkAddStatus(param1[0], param2, param3, param4, param5) >= 0)
            {
                _loc_8 = 0;
                while (_loc_8 < param1.length)
                {
                    
                    param6.badStatus.addStatusData(new BattleBadStatusData(param1[_loc_8], _loc_7));
                    _loc_8++;
                }
            }
            else
            {
                param6.setResist();
            }
            return;
        }// end function

    }
}
