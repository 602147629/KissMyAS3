package player
{
    import flash.display.*;
    import formation.*;
    import message.*;
    import status.*;
    import tutorial.*;
    import user.*;

    public class CommanderSkillUtility extends Object
    {

        public function CommanderSkillUtility()
        {
            return;
        }// end function

        public static function isUnlockCommander() : Boolean
        {
            return TutorialManager.getInstance().isTutorial() == false && UserDataManager.getInstance().isUnlockCommanderSkill();
        }// end function

        public static function setupCommanderSkillField(param1:MovieClip, param2:MovieClip, param3:PlayerInformation, param4:int, param5:PlayerMiniStatus = null, param6:Boolean = true) : void
        {
            var _loc_7:* = false;
            TextControl.setText(param1.textDt, "");
            TextControl.setText(param2.textDt, "");
            param1.visible = false;
            param2.visible = false;
            if (param3)
            {
                _loc_7 = param4 < FormationSetData.FORMATION_INDEX_NUM;
                if (param5)
                {
                    if (_loc_7)
                    {
                        param5.setWarning(MessageManager.getInstance().getMessage(MessageId.QUEST_SELECT_WITHOUT_COMMANDER));
                    }
                    else
                    {
                        param5.clearWarning();
                    }
                    param5.update();
                }
                if (_loc_7 && param6)
                {
                    TextControl.setText(param2.textDt, MessageManager.getInstance().getMessage(MessageId.QUEST_SELECT_COMMANDER_NUMBER_SHORTAGE));
                    param2.visible = true;
                }
                else
                {
                    TextControl.setText(param1.textDt, PlayerManager.getInstance().getCommanderSkillEffectsText(param3));
                    param1.visible = true;
                }
            }
            else
            {
                TextControl.setText(param1.textDt, MessageManager.getInstance().getMessage(MessageId.FORMATION_COMMANDER_SKILL_NOT_SET));
                param1.visible = true;
            }
            return;
        }// end function

        public static function resetCommanderSkillBonus(param1:Array) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in param1)
            {
                
                _loc_2.resetCommanderSkillBonus();
            }
            return;
        }// end function

        public static function updateCommanderSkillBonus(param1:Array, param2:Array, param3:Boolean = true, param4:Boolean = false) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            resetCommanderSkillBonus(param2);
            if (param4)
            {
                return;
            }
            var _loc_5:* = getFormationPlayerPersonal(param1, param2);
            var _loc_6:* = getCommanderSkillId(_loc_5, param3);
            if (getCommanderSkillId(_loc_5, param3) == Constant.EMPTY_ID)
            {
                return;
            }
            var _loc_7:* = PlayerManager.getInstance().getCommanderSkill(_loc_6);
            for each (_loc_8 in _loc_5)
            {
                
                if (_loc_8 == null)
                {
                    continue;
                }
                _loc_9 = PlayerManager.getInstance().getPlayerInformation(_loc_8.playerId);
                if (PlayerManager.getInstance().isCommanderSkillTarget(_loc_9, _loc_7))
                {
                    _loc_8.setCommanderSkillBonus(_loc_7);
                }
            }
            return;
        }// end function

        private static function getFormationPlayerPersonal(param1:Array, param2:Array) : Array
        {
            var _loc_5:* = null;
            var _loc_3:* = [];
            var _loc_4:* = 0;
            while (_loc_4 < param1.length)
            {
                
                _loc_3[_loc_4] = null;
                for each (_loc_5 in param2)
                {
                    
                    if (param1[_loc_4] == _loc_5.uniqueId)
                    {
                        _loc_3[_loc_4] = _loc_5;
                        break;
                    }
                }
                _loc_4++;
            }
            return _loc_3;
        }// end function

        private static function getCommanderSkillId(param1:Array, param2:Boolean) : int
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (param2)
            {
                _loc_5 = 0;
                _loc_6 = 0;
                while (_loc_6 < param1.length)
                {
                    
                    if (param1[_loc_6] != null)
                    {
                        _loc_5++;
                    }
                    _loc_6++;
                }
                if (_loc_5 < FormationSetData.FORMATION_INDEX_NUM)
                {
                    return Constant.EMPTY_ID;
                }
            }
            var _loc_3:* = param1[FormationSetData.FORMATION_INDEX_COMMANDER];
            if (_loc_3 == null || _loc_3.bDead)
            {
                return Constant.EMPTY_ID;
            }
            var _loc_4:* = PlayerManager.getInstance().getPlayerInformation(_loc_3.playerId);
            return PlayerManager.getInstance().getPlayerInformation(_loc_3.playerId).commanderSkillId;
        }// end function

    }
}
