package skillInitiate
{
    import payment.*;
    import player.*;
    import skill.*;
    import user.*;

    public class SkillInitiateUtility extends Object
    {
        public static const CHARA_LIST_FILTER_LEARNABLE:int = 0;
        public static const CHARA_LIST_FILTER_TEACHABLE:int = 1;
        public static const CHARA_LIST_FILTER_SUPPORTABLE:int = 2;
        private static var _aBonusStep:Array = [];

        public function SkillInitiateUtility()
        {
            return;
        }// end function

        public static function init() : void
        {
            _aBonusStep = PaymentManager.getInstance().getPaymentStepTable(PaymentStep.ID_ADD_PROBABILITY_PROBABILITY_ITEM);
            return;
        }// end function

        public static function setBonusDataList(param1:Array) : void
        {
            return;
        }// end function

        public static function setBasePriceList(param1:Array) : void
        {
            return;
        }// end function

        public static function getBonusNum() : int
        {
            return _aBonusStep.length;
        }// end function

        public static function getBonusProbability(param1:int) : Number
        {
            var _loc_2:* = _aBonusStep[param1];
            if (!_loc_2)
            {
                return 0;
            }
            return _loc_2.jadge / 10;
        }// end function

        private static function getBonusItemCost(param1:int) : int
        {
            var _loc_2:* = _aBonusStep[param1];
            if (!_loc_2)
            {
                return 0;
            }
            return _loc_2.value;
        }// end function

        public static function getItemCost(param1:int, param2:int) : int
        {
            var _loc_3:* = getBonusItemCost(param2);
            var _loc_4:* = UserDataManager.getInstance().userData.getPlayerPersonal(param1);
            if (!UserDataManager.getInstance().userData.getPlayerPersonal(param1))
            {
                return _loc_3;
            }
            var _loc_5:* = PlayerManager.getInstance().getPlayerInformation(_loc_4.playerId);
            if (!PlayerManager.getInstance().getPlayerInformation(_loc_4.playerId))
            {
                return _loc_3;
            }
            return _loc_3;
        }// end function

        public static function getBaseProbability(param1:int, param2:Array) : Number
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (param1 == Constant.EMPTY_ID)
            {
                return 0;
            }
            var _loc_3:* = 0;
            var _loc_4:* = UserDataManager.getInstance().userData.getPlayerPersonal(param1);
            var _loc_5:* = PlayerManager.getInstance().getPlayerInformation(_loc_4.playerId);
            _loc_3 = _loc_3 + baseRarityProbability(_loc_5.rarity);
            var _loc_6:* = 0;
            while (_loc_6 < param2.length)
            {
                
                _loc_7 = UserDataManager.getInstance().userData.getPlayerPersonal(param2[_loc_6]);
                _loc_8 = PlayerManager.getInstance().getPlayerInformation(_loc_7.playerId);
                _loc_3 = _loc_3 + addRarityProbability(_loc_8.rarity);
                _loc_6++;
            }
            return _loc_3 / 100;
        }// end function

        private static function baseRarityProbability(param1:int) : int
        {
            switch(param1)
            {
                case CommonConstant.CHARACTER_RARITY_NORMAL:
                {
                    return CommonConstant.SKILL_INITIATE_BASE_PROBABIRITY_NORMAL;
                }
                case CommonConstant.CHARACTER_RARITY_HIGHNORMAL:
                {
                    return CommonConstant.SKILL_INITIATE_BASE_PROBABIRITY_HIGHNORMAL;
                }
                case CommonConstant.CHARACTER_RARITY_RARE:
                {
                    return CommonConstant.SKILL_INITIATE_BASE_PROBABIRITY_RARE;
                }
                case CommonConstant.CHARACTER_RARITY_SUPERRARE:
                {
                    return CommonConstant.SKILL_INITIATE_BASE_PROBABIRITY_SUPERRARE;
                }
                case CommonConstant.CHARACTER_RARITY_ULTLARARE:
                {
                    return CommonConstant.SKILL_INITIATE_BASE_PROBABIRITY_ULTLARARE;
                }
                case CommonConstant.CHARACTER_RARITY_SECRET:
                {
                    return CommonConstant.SKILL_INITIATE_BASE_PROBABIRITY_SECRET;
                }
                case CommonConstant.CHARACTER_RARITY_LEGEND:
                {
                    return CommonConstant.SKILL_INITIATE_BASE_PROBABIRITY_LEGEND;
                }
                case CommonConstant.CHARACTER_RARITY_PR:
                {
                    return CommonConstant.SKILL_INITIATE_BASE_PROBABIRITY_PR;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        private static function addRarityProbability(param1:int) : int
        {
            switch(param1)
            {
                case CommonConstant.CHARACTER_RARITY_NORMAL:
                {
                    return CommonConstant.SKILL_INITIATE_ADD_PROBABIRITY_NORMAL;
                }
                case CommonConstant.CHARACTER_RARITY_HIGHNORMAL:
                {
                    return CommonConstant.SKILL_INITIATE_ADD_PROBABIRITY_HIGHNORMAL;
                }
                case CommonConstant.CHARACTER_RARITY_RARE:
                {
                    return CommonConstant.SKILL_INITIATE_ADD_PROBABIRITY_RARE;
                }
                case CommonConstant.CHARACTER_RARITY_SUPERRARE:
                {
                    return CommonConstant.SKILL_INITIATE_ADD_PROBABIRITY_SUPERRARE;
                }
                case CommonConstant.CHARACTER_RARITY_ULTLARARE:
                {
                    return CommonConstant.SKILL_INITIATE_ADD_PROBABIRITY_ULTLARARE;
                }
                case CommonConstant.CHARACTER_RARITY_SECRET:
                {
                    return CommonConstant.SKILL_INITIATE_ADD_PROBABIRITY_SECRET;
                }
                case CommonConstant.CHARACTER_RARITY_LEGEND:
                {
                    return CommonConstant.SKILL_INITIATE_ADD_PROBABIRITY_LEGEND;
                }
                case CommonConstant.CHARACTER_RARITY_PR:
                {
                    return CommonConstant.SKILL_INITIATE_ADD_PROBABIRITY_PR;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        public static function getTeachablePlayerList(param1:int) : Array
        {
            var _loc_5:* = null;
            var _loc_2:* = [];
            if (SkillManager.getInstance().getSkillInformation(param1) == null)
            {
                return _loc_2;
            }
            var _loc_3:* = UserDataManager.getInstance().userData.aPlayerPersonal;
            var _loc_4:* = UserDataManager.getInstance().userData.aFormationPlayerUniqueId;
            for each (_loc_5 in _loc_3)
            {
                
                if (_loc_5.isUseFacility() || _loc_4.indexOf(_loc_5.uniqueId) != -1 || _loc_5.isEmperor())
                {
                    continue;
                }
                if (_loc_5.isHaveSkill(param1))
                {
                    _loc_2.push(_loc_5);
                }
            }
            return _loc_2;
        }// end function

        public static function getLearnablePlayerList() : Array
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_1:* = [];
            var _loc_2:* = UserDataManager.getInstance().userData.aPlayerPersonal;
            var _loc_3:* = UserDataManager.getInstance().userData.aFormationPlayerUniqueId;
            for each (_loc_4 in _loc_2)
            {
                
                if (_loc_4.isUseFacility() || _loc_3.indexOf(_loc_4.uniqueId) != -1)
                {
                    continue;
                }
                _loc_5 = PlayerManager.getInstance().getPlayerInformation(_loc_4.playerId);
                _loc_6 = SkillManager.getInstance().getLearnableSkill(_loc_5.weaponType);
                for each (_loc_7 in _loc_6)
                {
                    
                    _loc_8 = getTeachablePlayerList(_loc_7);
                    if (_loc_8.length > 0)
                    {
                        if (_loc_8.length > 1 || _loc_8.indexOf(_loc_4) == -1)
                        {
                            _loc_1.push(_loc_4);
                            break;
                        }
                    }
                }
            }
            return _loc_1;
        }// end function

        public static function getSupportablePlayerList() : Array
        {
            var _loc_4:* = null;
            var _loc_1:* = [];
            var _loc_2:* = UserDataManager.getInstance().userData.aPlayerPersonal;
            var _loc_3:* = UserDataManager.getInstance().userData.aFormationPlayerUniqueId;
            for each (_loc_4 in _loc_2)
            {
                
                if (_loc_4.isUseFacility() || _loc_3.indexOf(_loc_4.uniqueId) != -1 || _loc_4.isEmperor())
                {
                    continue;
                }
                _loc_1.push(_loc_4);
            }
            return _loc_1;
        }// end function

        public static function checkFilterPlayer(param1:PlayerPersonal, param2:int, param3:int = 0) : Boolean
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_4:* = UserDataManager.getInstance().userData.aFormationPlayerUniqueId;
            switch(param2)
            {
                case CHARA_LIST_FILTER_LEARNABLE:
                {
                    if (param1.isUseFacility() || _loc_4.indexOf(param1.uniqueId) != -1)
                    {
                        return false;
                    }
                    _loc_5 = PlayerManager.getInstance().getPlayerInformation(param1.playerId);
                    _loc_6 = SkillManager.getInstance().getLearnableSkill(_loc_5.weaponType);
                    for each (param3 in _loc_6)
                    {
                        
                        _loc_7 = getTeachablePlayerList(param3);
                        if (_loc_7.length > 0)
                        {
                            if (_loc_7.length > 1 || _loc_7.indexOf(param1) == -1)
                            {
                                return true;
                            }
                        }
                    }
                    break;
                }
                case CHARA_LIST_FILTER_TEACHABLE:
                {
                    if (param1.isUseFacility() || _loc_4.indexOf(param1.uniqueId) != -1)
                    {
                        return false;
                    }
                    if (param1.isHaveSkill(param3))
                    {
                        return true;
                    }
                    break;
                }
                case CHARA_LIST_FILTER_SUPPORTABLE:
                {
                    if (param1.isUseFacility() || _loc_4.indexOf(param1.uniqueId) != -1)
                    {
                        return false;
                    }
                    return true;
                }
                default:
                {
                    return true;
                    break;
                }
            }
            return false;
        }// end function

    }
}
