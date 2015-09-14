package formation
{
    import player.*;

    public class FormationBonusUtility extends Object
    {

        public function FormationBonusUtility()
        {
            return;
        }// end function

        public static function resetFormationBonus(param1:Array) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in param1)
            {
                
                _loc_2.resetFormationBonus();
            }
            return;
        }// end function

        public static function updateFormationBonus(param1:int, param2:Array, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            resetFormationBonus(param3);
            var _loc_6:* = 0;
            var _loc_7:* = [];
            _loc_5 = 0;
            while (_loc_5 < param2.length)
            {
                
                _loc_7[_loc_5] = null;
                for each (_loc_4 in param3)
                {
                    
                    if (param2[_loc_5] == _loc_4.uniqueId)
                    {
                        if (_loc_4.bDead == false)
                        {
                            _loc_7[_loc_5] = _loc_4;
                            if (_loc_5 < FormationSetData.FORMATION_INDEX_COMMANDER)
                            {
                                _loc_6++;
                            }
                        }
                        break;
                    }
                }
                _loc_5++;
            }
            var _loc_8:* = FormationManager.getInstance().getFormationInformation(param1);
            if (FormationManager.getInstance().getFormationInformation(param1) == null || _loc_6 < _loc_8.member)
            {
                return;
            }
            _loc_5 = 0;
            while (_loc_5 < _loc_7.length)
            {
                
                _loc_4 = _loc_7[_loc_5];
                if (_loc_4)
                {
                    _loc_4.setFormationBonus(_loc_8, _loc_5);
                }
                _loc_5++;
            }
            return;
        }// end function

    }
}
