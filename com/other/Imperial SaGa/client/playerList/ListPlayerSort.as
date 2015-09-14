package playerList
{
    import player.*;

    public class ListPlayerSort extends Object
    {
        public static const SORT_ID_NEW:int = 0;
        public static const SORT_ID_CHARACTER_NAME:int = 1;
        public static const SORT_ID_RARITY:int = 2;
        public static const SORT_ID_HP:int = 3;
        public static const SORT_ID_ATTACK:int = 4;
        public static const SORT_ID_DEFENSE:int = 5;
        public static const SORT_ID_SPEED:int = 6;
        public static const SORT_ID_BATTLE_COUNT:int = 7;
        public static const SORT_ID_RESTORE_TIME:int = 8;
        public static const SORT_ID_CARD:int = 100;

        public function ListPlayerSort()
        {
            return;
        }// end function

        public static function sortListPlayer(param1:Array, param2:int, param3:Boolean) : void
        {
            var aListPlayer:* = param1;
            var sortId:* = param2;
            var bAscend:* = param3;
            var sortCompare:* = sortCompareId;
            switch(sortId)
            {
                case SORT_ID_CHARACTER_NAME:
                {
                    sortCompare = sortCompareCharacter;
                    break;
                }
                case SORT_ID_RARITY:
                {
                    sortCompare = sortCompareRarity;
                    break;
                }
                case SORT_ID_NEW:
                {
                    sortCompare = sortCompareNew;
                    break;
                }
                case SORT_ID_BATTLE_COUNT:
                {
                    sortCompare = sortCompareBattleCount;
                    break;
                }
                case SORT_ID_HP:
                {
                    sortCompare = sortCompareHP;
                    break;
                }
                case SORT_ID_ATTACK:
                {
                    sortCompare = sortCompareAttack;
                    break;
                }
                case SORT_ID_DEFENSE:
                {
                    sortCompare = sortCompareDefense;
                    break;
                }
                case SORT_ID_SPEED:
                {
                    sortCompare = sortCompareSpeed;
                    break;
                }
                case SORT_ID_RESTORE_TIME:
                {
                    sortCompare = sortCompareRestoreTime;
                    break;
                }
                default:
                {
                    break;
                }
            }
            aListPlayer.sort(function (param1:ListPlayerData, param2:ListPlayerData) : int
            {
                var _loc_3:* = sortCompare(param1, param2);
                return bAscend ? (-_loc_3) : (_loc_3);
            }// end function
            );
            return;
        }// end function

        private static function sortCompareId(param1:ListPlayerData, param2:ListPlayerData) : int
        {
            var _loc_3:* = param2.info.id == param1.info.id ? (0) : (param2.info.id > param1.info.id ? (1) : (-1));
            if (_loc_3 == 0)
            {
                _loc_3 = param2.personal.gotTime - param1.personal.gotTime;
            }
            return _loc_3;
        }// end function

        private static function sortCompareCharacter(param1:ListPlayerData, param2:ListPlayerData) : int
        {
            var _loc_3:* = param2.info.yomigana == param1.info.yomigana ? (0) : (param2.info.yomigana > param1.info.yomigana ? (1) : (-1));
            if (_loc_3 == 0)
            {
                _loc_3 = PlayerManager.getInstance().cmpRarityValue(param2.info.rarity, param1.info.rarity);
            }
            if (_loc_3 == 0)
            {
                _loc_3 = param2.personal.gotTime - param1.personal.gotTime;
            }
            return _loc_3;
        }// end function

        private static function sortCompareRarity(param1:ListPlayerData, param2:ListPlayerData) : int
        {
            var _loc_3:* = PlayerManager.getInstance().cmpRarityValue(param2.info.rarity, param1.info.rarity);
            if (_loc_3 == 0)
            {
                _loc_3 = param2.info.yomigana == param1.info.yomigana ? (0) : (param2.info.yomigana > param1.info.yomigana ? (1) : (-1));
            }
            if (_loc_3 == 0)
            {
                _loc_3 = param2.personal.gotTime - param1.personal.gotTime;
            }
            return _loc_3;
        }// end function

        private static function sortCompareNew(param1:ListPlayerData, param2:ListPlayerData) : int
        {
            var _loc_3:* = param2.personal.gotTime - param1.personal.gotTime;
            if (_loc_3 == 0)
            {
                _loc_3 = param2.info.yomigana == param1.info.yomigana ? (0) : (param2.info.yomigana > param1.info.yomigana ? (1) : (-1));
            }
            if (_loc_3 == 0)
            {
                _loc_3 = PlayerManager.getInstance().cmpRarityValue(param2.info.rarity, param1.info.rarity);
            }
            return _loc_3;
        }// end function

        private static function sortCompareBattleCount(param1:ListPlayerData, param2:ListPlayerData) : int
        {
            var _loc_3:* = param2.personal.battleCount - param1.personal.battleCount;
            if (_loc_3 == 0)
            {
                _loc_3 = param2.info.yomigana == param1.info.yomigana ? (0) : (param2.info.yomigana > param1.info.yomigana ? (1) : (-1));
            }
            if (_loc_3 == 0)
            {
                _loc_3 = PlayerManager.getInstance().cmpRarityValue(param2.info.rarity, param1.info.rarity);
            }
            return _loc_3;
        }// end function

        private static function sortCompareHP(param1:ListPlayerData, param2:ListPlayerData) : int
        {
            var _loc_3:* = param2.personal.hpMax - param1.personal.hpMax;
            if (_loc_3 == 0)
            {
                _loc_3 = param2.info.yomigana == param1.info.yomigana ? (0) : (param2.info.yomigana > param1.info.yomigana ? (1) : (-1));
            }
            if (_loc_3 == 0)
            {
                _loc_3 = PlayerManager.getInstance().cmpRarityValue(param2.info.rarity, param1.info.rarity);
            }
            return _loc_3;
        }// end function

        private static function sortCompareAttack(param1:ListPlayerData, param2:ListPlayerData) : int
        {
            var _loc_3:* = param2.personal.attack - param1.personal.attack;
            if (_loc_3 == 0)
            {
                _loc_3 = param2.info.yomigana == param1.info.yomigana ? (0) : (param2.info.yomigana > param1.info.yomigana ? (1) : (-1));
            }
            if (_loc_3 == 0)
            {
                _loc_3 = PlayerManager.getInstance().cmpRarityValue(param2.info.rarity, param1.info.rarity);
            }
            return _loc_3;
        }// end function

        private static function sortCompareDefense(param1:ListPlayerData, param2:ListPlayerData) : int
        {
            var _loc_3:* = param2.personal.defense - param1.personal.defense;
            if (_loc_3 == 0)
            {
                _loc_3 = param2.info.yomigana == param1.info.yomigana ? (0) : (param2.info.yomigana > param1.info.yomigana ? (1) : (-1));
            }
            if (_loc_3 == 0)
            {
                _loc_3 = PlayerManager.getInstance().cmpRarityValue(param2.info.rarity, param1.info.rarity);
            }
            return _loc_3;
        }// end function

        private static function sortCompareSpeed(param1:ListPlayerData, param2:ListPlayerData) : int
        {
            var _loc_3:* = param2.personal.speed - param1.personal.speed;
            if (_loc_3 == 0)
            {
                _loc_3 = param2.info.yomigana == param1.info.yomigana ? (0) : (param2.info.yomigana > param1.info.yomigana ? (1) : (-1));
            }
            if (_loc_3 == 0)
            {
                _loc_3 = PlayerManager.getInstance().cmpRarityValue(param2.info.rarity, param1.info.rarity);
            }
            return _loc_3;
        }// end function

        private static function sortCompareRestoreTime(param1:ListPlayerData, param2:ListPlayerData) : int
        {
            var _loc_3:* = param2.personal.getRestoreTimeSec() - param1.personal.getRestoreTimeSec();
            if (_loc_3 == 0)
            {
                _loc_3 = param2.info.yomigana == param1.info.yomigana ? (0) : (param2.info.yomigana > param1.info.yomigana ? (1) : (-1));
            }
            if (_loc_3 == 0)
            {
                _loc_3 = PlayerManager.getInstance().cmpRarityValue(param2.info.rarity, param1.info.rarity);
            }
            return _loc_3;
        }// end function

    }
}
