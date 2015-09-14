package battle
{
    import formation.*;
    import formationSkill.*;
    import player.*;

    public class BattleFormationCheck extends Object
    {
        private var equipWeponArray:Array;

        public function BattleFormationCheck()
        {
            this.equipWeponArray = [CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD, CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD, CommonConstant.CHARACTER_WEAPONTYPE_SWORD];
            return;
        }// end function

        public function skillMemberCheck(param1:FormationSkillInformation, param2:FormationInformation, param3:BattleManager) : Array
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = false;
            var _loc_10:* = 0;
            var _loc_4:* = [];
            var _loc_5:* = [];
            _loc_5 = param3.getEntryPlayer();
            _loc_5 = _loc_5.sortOn("formationIndex", Array.NUMERIC);
            for each (_loc_6 in _loc_5)
            {
                
                _loc_7 = PlayerManager.getInstance().getPlayerInformation(_loc_6.playerPersonal.playerId);
                _loc_8 = _loc_6.formationIndex;
                _loc_9 = false;
                if (_loc_6.personal.bDead)
                {
                    continue;
                }
                if (_loc_6.playerPersonal.sp < param1.skillPoint)
                {
                    continue;
                }
                if (isFormationSkillNoBe(_loc_6.status.badStatus))
                {
                    continue;
                }
                _loc_10 = 0;
                switch(param1.id)
                {
                    case FormationSkillId.ID_EXCEL_DRIVER:
                    {
                        _loc_10 = 0;
                        while (_loc_10 < param2.aColumnPosition.length)
                        {
                            
                            if (param2.aColumnPosition[_loc_6.formationIndex] == 1 && _loc_7.weaponType == CommonConstant.CHARACTER_WEAPONTYPE_SPEAR)
                            {
                                _loc_4.push(_loc_6.personal.questUniqueId);
                                break;
                            }
                            _loc_10++;
                        }
                        break;
                    }
                    case FormationSkillId.ID_AXE_STREAM:
                    {
                        switch(_loc_8)
                        {
                            case 0:
                            case 1:
                            case 2:
                            {
                                if (_loc_7.weaponType == CommonConstant.CHARACTER_WEAPONTYPE_AX)
                                {
                                    _loc_4.push(_loc_6.personal.questUniqueId);
                                    break;
                                }
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        break;
                    }
                    case FormationSkillId.ID_DRAGON_QUAKE:
                    {
                        _loc_10 = 0;
                        while (_loc_10 < param2.aColumnPosition.length)
                        {
                            
                            if (param2.aColumnPosition[_loc_6.formationIndex] == 3 && _loc_7.weaponType == CommonConstant.CHARACTER_WEAPONTYPE_BOW)
                            {
                                _loc_4.push(_loc_6.personal.questUniqueId);
                                break;
                            }
                            _loc_10++;
                        }
                        break;
                    }
                    case FormationSkillId.ID_ARROW_STORM:
                    {
                        if (_loc_7.weaponType == CommonConstant.CHARACTER_WEAPONTYPE_BOW)
                        {
                            _loc_4.push(_loc_6.personal.questUniqueId);
                            break;
                        }
                        break;
                    }
                    default:
                    {
                        if (this.skillWeaponTypeCondition(param1.equipWeponConditions, _loc_7))
                        {
                            _loc_4.push(_loc_6.personal.questUniqueId);
                            break;
                        }
                        if (param1.equipWeponConditions == 0)
                        {
                            _loc_4.push(_loc_6.personal.questUniqueId);
                        }
                        break;
                        break;
                    }
                }
                if (_loc_4.length >= param1.memberMaxNum)
                {
                    break;
                }
            }
            return _loc_4;
        }// end function

        private function skillWeaponTypeCondition(param1:int, param2:PlayerInformation) : Boolean
        {
            var _loc_3:* = false;
            if (param1 == BattleConstant.FORMATION_SKILL_WEAPON_TYPE_SOWRD)
            {
                if (this.equipWeponArray.indexOf(param2.weaponType) != -1)
                {
                    _loc_3 = true;
                }
            }
            if (param1 == BattleConstant.FORMATION_SKILL_WEAPON_TYPE_AX)
            {
                if (param2.weaponType == CommonConstant.CHARACTER_WEAPONTYPE_AX)
                {
                    _loc_3 = true;
                }
            }
            if (param1 == BattleConstant.FORMATION_SKILL_WEAPON_TYPE_BOW)
            {
                if (param2.weaponType == CommonConstant.CHARACTER_WEAPONTYPE_BOW)
                {
                    _loc_3 = true;
                }
            }
            return _loc_3;
        }// end function

        public static function isFormationSkillNoBe(param1:BattleBadStatus) : Boolean
        {
            if (BattleManager.isBadStatusParalysis(param1) || BattleManager.isBadStatusSleep(param1) || BattleManager.isBadStatusCharm(param1) || BattleManager.isBadStatusConfusion(param1) || BattleManager.isBadStatusStone(param1))
            {
                return true;
            }
            return false;
        }// end function

    }
}
