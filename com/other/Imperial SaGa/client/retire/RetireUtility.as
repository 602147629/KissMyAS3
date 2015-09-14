package retire
{
    import player.*;
    import user.*;

    public class RetireUtility extends Object
    {

        public function RetireUtility()
        {
            return;
        }// end function

        private static function getRarityInsigniaType(param1:int) : int
        {
            switch(param1)
            {
                case CommonConstant.CHARACTER_RARITY_NORMAL:
                {
                    return CommonConstant.RETIRE_INSIGNIA_TYPE_NORMAL;
                }
                case CommonConstant.CHARACTER_RARITY_HIGHNORMAL:
                {
                    return CommonConstant.RETIRE_INSIGNIA_TYPE_HIGHNORMAL;
                }
                case CommonConstant.CHARACTER_RARITY_RARE:
                {
                    return CommonConstant.RETIRE_INSIGNIA_TYPE_RARE;
                }
                case CommonConstant.CHARACTER_RARITY_SUPERRARE:
                {
                    return CommonConstant.RETIRE_INSIGNIA_TYPE_SUPERRARE;
                }
                case CommonConstant.CHARACTER_RARITY_ULTLARARE:
                {
                    return CommonConstant.RETIRE_INSIGNIA_TYPE_ULTLARARE;
                }
                case CommonConstant.CHARACTER_RARITY_LEGEND:
                {
                    return CommonConstant.RETIRE_INSIGNIA_TYPE_LEGEND;
                }
                case CommonConstant.CHARACTER_RARITY_PR:
                {
                    return CommonConstant.RETIRE_INSIGNIA_TYPE_PR;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        private static function getRarityInsigniaNum(param1:int) : int
        {
            switch(param1)
            {
                case CommonConstant.CHARACTER_RARITY_NORMAL:
                {
                    return CommonConstant.RETIRE_INSIGNIA_NUM_NORMAL;
                }
                case CommonConstant.CHARACTER_RARITY_HIGHNORMAL:
                {
                    return CommonConstant.RETIRE_INSIGNIA_NUM_HIGHNORMAL;
                }
                case CommonConstant.CHARACTER_RARITY_RARE:
                {
                    return CommonConstant.RETIRE_INSIGNIA_NUM_RARE;
                }
                case CommonConstant.CHARACTER_RARITY_SUPERRARE:
                {
                    return CommonConstant.RETIRE_INSIGNIA_NUM_SUPERRARE;
                }
                case CommonConstant.CHARACTER_RARITY_ULTLARARE:
                {
                    return CommonConstant.RETIRE_INSIGNIA_NUM_ULTLARARE;
                }
                case CommonConstant.CHARACTER_RARITY_LEGEND:
                {
                    return CommonConstant.RETIRE_INSIGNIA_NUM_LEGEND;
                }
                case CommonConstant.CHARACTER_RARITY_PR:
                {
                    return CommonConstant.RETIRE_INSIGNIA_NUM_PR;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        private static function calcInsigniaNum(param1:int, param2:Array) : int
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = UserDataManager.getInstance().userData;
            for each (_loc_5 in param2)
            {
                
                _loc_6 = _loc_4.getPlayerPersonal(_loc_5);
                _loc_7 = PlayerManager.getInstance().getPlayerInformation(_loc_6.playerId);
                if (getRarityInsigniaType(_loc_7.rarity) == param1)
                {
                    _loc_3 = _loc_3 + getRarityInsigniaNum(_loc_7.rarity);
                }
            }
            return _loc_3;
        }// end function

        public static function calcGoldInsigniaNum(param1:Array) : int
        {
            return calcInsigniaNum(CommonConstant.INSIGNIA_TYPE_GOLD, param1);
        }// end function

        public static function calcSilverInsigniaNum(param1:Array) : int
        {
            return calcInsigniaNum(CommonConstant.INSIGNIA_TYPE_SILVER, param1);
        }// end function

    }
}
