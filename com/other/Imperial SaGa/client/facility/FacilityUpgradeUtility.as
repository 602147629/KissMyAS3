package facility
{
    import message.*;
    import payment.*;
    import user.*;

    public class FacilityUpgradeUtility extends Object
    {
        private static const _BARRACKS_EFFICACY_TEXT_TABLE:Array = ["", MessageManager.getInstance().getMessage(MessageId.BARRACKS_EFFICACY_TEXT_BED_PLUS), MessageManager.getInstance().getMessage(MessageId.BARRACKS_EFFICACY_TEXT_BED_PLUS), MessageManager.getInstance().getMessage(MessageId.BARRACKS_EFFICACY_TEXT_BED_PLUS), MessageManager.getInstance().getMessage(MessageId.BARRACKS_EFFICACY_TEXT_BEST_CONDITION), MessageManager.getInstance().getMessage(MessageId.BARRACKS_EFFICACY_TEXT_BEST_CONDITION), MessageManager.getInstance().getMessage(MessageId.BARRACKS_EFFICACY_TEXT_BEST_CONDITION), MessageManager.getInstance().getMessage(MessageId.BARRACKS_EFFICACY_TEXT_BEST_CONDITION), MessageManager.getInstance().getMessage(MessageId.BARRACKS_EFFICACY_TEXT_BEST_CONDITION), MessageManager.getInstance().getMessage(MessageId.BARRACKS_EFFICACY_TEXT_BEST_CONDITION)];
        private static const _MAGICLABORATORY_EFFICACY_TEXT_TABLE:Array = ["", "", "", MessageManager.getInstance().getMessage(MessageId.MAGIC_DEVELOP_EFFICACY_TEXT_PEOPLEUP), "", "", MessageManager.getInstance().getMessage(MessageId.MAGIC_DEVELOP_EFFICACY_TEXT_PEOPLEUP), "", "", MessageManager.getInstance().getMessage(MessageId.MAGIC_DEVELOP_EFFICACY_TEXT_PEOPLEUP)];

        public function FacilityUpgradeUtility()
        {
            return;
        }// end function

        private static function getTblId(param1:int) : int
        {
            switch(param1)
            {
                case CommonConstant.FACILITY_ID_BARRACKS:
                {
                    return Constant.EMPTY_ID;
                }
                case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                {
                    return Constant.EMPTY_ID;
                }
                case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                {
                    return CommonConstant.FACILITY_LIST_ID_MAGIC_DEVELOP;
                }
                case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                {
                    return Constant.EMPTY_ID;
                }
                case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                {
                    return CommonConstant.FACILITY_LIST_ID_MAKE_EQUIP;
                }
                default:
                {
                    break;
                }
            }
            return Constant.EMPTY_ID;
        }// end function

        public static function isMaxExp(param1:int, param2:int, param3:int) : Boolean
        {
            switch(param1)
            {
                case CommonConstant.FACILITY_ID_BARRACKS:
                {
                    return true;
                }
                case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                {
                    return true;
                }
                case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                {
                    return isMaxExpHelper(CommonConstant.FACILITY_LIST_ID_MAGIC_DEVELOP, param2, param3);
                }
                case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                {
                    return true;
                }
                case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                {
                    return isMaxExpHelper(CommonConstant.FACILITY_LIST_ID_MAKE_EQUIP, param2, param3);
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private static function isMaxExpHelper(param1:int, param2:int, param3:int) : Boolean
        {
            var _loc_4:* = FacilityListManager.getInstance().getFacilityListTable(param1);
            if (param2 < 0 || param2 >= _loc_4.length)
            {
                return true;
            }
            var _loc_5:* = _loc_4[param2];
            return _loc_4[param2].point <= param3;
        }// end function

        public static function getMaxExp(param1:int, param2:int) : int
        {
            switch(param1)
            {
                case CommonConstant.FACILITY_ID_BARRACKS:
                {
                    return 0;
                }
                case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                {
                    return 0;
                }
                case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                {
                    return getMaxExpHelper(CommonConstant.FACILITY_LIST_ID_MAGIC_DEVELOP, param2);
                }
                case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                {
                    return 0;
                }
                case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                {
                    return getMaxExpHelper(CommonConstant.FACILITY_LIST_ID_MAKE_EQUIP, param2);
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        private static function getMaxExpHelper(param1:int, param2:int) : int
        {
            var _loc_3:* = FacilityListManager.getInstance().getFacilityListTable(param1);
            if (param2 < 0 || param2 >= _loc_3.length)
            {
                return 0;
            }
            var _loc_4:* = _loc_3[param2];
            return _loc_3[param2].point;
        }// end function

        public static function isMaxGrade(param1:int, param2:int) : Boolean
        {
            switch(param1)
            {
                case CommonConstant.FACILITY_ID_BARRACKS:
                {
                    return isMaxGradeAtNoUpgrade(param2);
                }
                case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                {
                    return isMaxGradeAtNoUpgrade(param2);
                }
                case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                {
                    return isMaxGradeHelper(CommonConstant.FACILITY_LIST_ID_MAGIC_DEVELOP, param2);
                }
                case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                {
                    return isMaxGradeAtNoUpgrade(param2);
                }
                case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                {
                    return isMaxGradeHelper(CommonConstant.FACILITY_LIST_ID_MAKE_EQUIP, param2);
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private static function isMaxGradeHelper(param1:int, param2:int) : Boolean
        {
            var _loc_3:* = FacilityListManager.getInstance().getFacilityListTable(param1);
            return param2 >= _loc_3.length;
        }// end function

        private static function isMaxGradeAtNoUpgrade(param1:int) : Boolean
        {
            return param1 > 0;
        }// end function

        public static function getTime(param1:int, param2:int) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = getTblId(param1);
            if (_loc_3 != Constant.EMPTY_ID)
            {
                _loc_4 = FacilityListManager.getInstance().getFacilityListTable(_loc_3);
                if (param2 < 0 || param2 >= _loc_4.length)
                {
                    return 0;
                }
                _loc_5 = _loc_4[param2];
                return _loc_5.time;
            }
            return 0;
        }// end function

        public static function getType(param1:uint) : int
        {
            if (param1 == 0)
            {
                return 0;
            }
            var _loc_2:* = PaymentManager.getInstance().getPaymentStepTable(PaymentStep.ID_INSTANT_INSTANT_LEARNING);
            return 1 + PaymentManager.searchIdx(_loc_2, param1);
        }// end function

        private static function upgradeCrown(param1:uint) : String
        {
            return PaymentManager.getInstance().getInstantCrownBySecond(param1).toString();
        }// end function

        public static function getUpgradeInstantLearningNum(param1:uint) : int
        {
            return PaymentManager.getInstance().getInstantLearningNumBySecond(param1);
        }// end function

        public static function getIntesificationExp(param1:int, param2:int) : Number
        {
            var _loc_3:* = CommonConstant.FACILITY_UPGRADE_GROWTH_BONUS_FACTOR;
            _loc_3 = _loc_3 / 1000;
            var _loc_4:* = param2 / CommonConstant.CHARACTER_GROWTH_PARAMETER_LIMIT;
            if (param2 / CommonConstant.CHARACTER_GROWTH_PARAMETER_LIMIT > 1)
            {
                _loc_4 = 1;
            }
            var _loc_5:* = _loc_3 * _loc_4 + 1;
            var _loc_6:* = getRarityBonus(param1);
            return int(_loc_6 * _loc_5);
        }// end function

        private static function getRarityBonus(param1:int) : int
        {
            switch(param1)
            {
                case CommonConstant.CHARACTER_RARITY_NORMAL:
                {
                    return CommonConstant.FACILITY_UPGRADE_RARITY_BONUS_NORMAL;
                }
                case CommonConstant.CHARACTER_RARITY_HIGHNORMAL:
                {
                    return CommonConstant.FACILITY_UPGRADE_RARITY_BONUS_HIGHNORMAL;
                }
                case CommonConstant.CHARACTER_RARITY_RARE:
                {
                    return CommonConstant.FACILITY_UPGRADE_RARITY_BONUS_RARE;
                }
                case CommonConstant.CHARACTER_RARITY_SUPERRARE:
                {
                    return CommonConstant.FACILITY_UPGRADE_RARITY_BONUS_SUPERRARE;
                }
                case CommonConstant.CHARACTER_RARITY_ULTLARARE:
                {
                    return CommonConstant.FACILITY_UPGRADE_RARITY_BONUS_ULTLARARE;
                }
                case CommonConstant.CHARACTER_RARITY_SECRET:
                {
                    return CommonConstant.FACILITY_UPGRADE_RARITY_BONUS_SECRET;
                }
                case CommonConstant.CHARACTER_RARITY_LEGEND:
                {
                    return CommonConstant.FACILITY_UPGRADE_RARITY_BONUS_LEGEND;
                }
                case CommonConstant.CHARACTER_RARITY_PR:
                {
                    return CommonConstant.FACILITY_UPGRADE_RARITY_BONUS_PR;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        public static function getIconLabel(param1:int, param2:int) : String
        {
            if (param2 == 0)
            {
                return "lv0";
            }
            var _loc_3:* = "barracks";
            switch(param1)
            {
                case CommonConstant.FACILITY_ID_BARRACKS:
                {
                    _loc_3 = "barracks";
                    break;
                }
                case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                {
                    _loc_3 = "itemCreation";
                    break;
                }
                case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                {
                    _loc_3 = "magicLabo";
                    break;
                }
                case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                {
                    _loc_3 = "training";
                    break;
                }
                case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                {
                    _loc_3 = "skillInitiate";
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_4:* = UserFacilityLv.getFacilityLv(param2);
            return _loc_3 + "Lv" + _loc_4;
        }// end function

        public static function getEfficacyText(param1:int, param2:int) : String
        {
            switch(param1)
            {
                case CommonConstant.FACILITY_ID_BARRACKS:
                {
                    return MessageManager.getInstance().getMessage(MessageId.EFFICACY_GRADEUP_TEXT_BARRACKS) + _BARRACKS_EFFICACY_TEXT_TABLE[param2];
                }
                case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                {
                    return MessageManager.getInstance().getMessage(MessageId.EFFICACY_GRADEUP_TEXT_SKILL_INITIATE);
                }
                case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                {
                    return MessageManager.getInstance().getMessage(MessageId.EFFICACY_GRADEUP_TEXT_MAGIC_DEVELOP) + _MAGICLABORATORY_EFFICACY_TEXT_TABLE[param2];
                }
                case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                {
                    return MessageManager.getInstance().getMessage(MessageId.EFFICACY_GRADEUP_TEXT_TRAINING_ROOM);
                }
                case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                {
                    return MessageManager.getInstance().getMessage(MessageId.EFFICACY_GRADEUP_TEXT_MAKE_EQUIP);
                }
                default:
                {
                    break;
                }
            }
            return "";
        }// end function

    }
}
