package trainingRoom
{
    import message.*;
    import payment.*;
    import player.*;
    import skill.*;
    import tutorial.*;

    public class TrainingRoomTable extends Object
    {
        private static const _PARAM_REINFORCE_TYPE:Array = [CommonConstant.TRAINING_ROOM_KUMITE_TYPE_POWER, CommonConstant.TRAINING_ROOM_KUMITE_TYPE_HIT];
        private static const _PARAM_REINFORCE_TEXT:Array = [MessageId.TRAINING_ROOM_KUMITE_POWER_REINFORCE, MessageId.TRAINING_ROOM_KUMITE_HIT_REINFORCE];

        public function TrainingRoomTable()
        {
            return;
        }// end function

        public static function calcTrainingSkillNum(param1:Array) : int
        {
            var _loc_2:* = param1.length;
            if (_loc_2 > CommonConstant.TRAINING_PARALLEL_SKILL_LIMIT)
            {
                _loc_2 = CommonConstant.TRAINING_PARALLEL_SKILL_LIMIT;
            }
            return _loc_2;
        }// end function

        private static function getTrainingCountFactor(param1:PlayerPersonal) : Number
        {
            var _loc_2:* = param1 != null ? (param1.trainingCount) : (0);
            var _loc_3:* = _loc_2 / CommonConstant.TRAINING_COUNT_JUDGEMENT_LIMIT;
            if (_loc_3 > 1)
            {
                _loc_3 = 1;
            }
            return CommonConstant.TRAINING_COUNT_FACTOR * _loc_3 + 1;
        }// end function

        public static function getTrainingTimeSec(param1:PlayerPersonal, param2:int) : int
        {
            return CommonConstant.TRAINING_REQUIRE_TIME_BASE * getTrainingCountFactor(param1) * param2;
        }// end function

        public static function getTrainingTimeText(param1:PlayerPersonal, param2:int) : String
        {
            var _loc_3:* = getTrainingTimeSec(param1, param2);
            var _loc_4:* = _loc_3 % 60;
            var _loc_5:* = _loc_3 / 60 % 60;
            var _loc_6:* = _loc_3 / 60 / 60;
            return (_loc_3 / 60 / 60 < 10 ? ("0" + _loc_6.toString()) : (_loc_6)) + ":" + (_loc_5 < 10 ? ("0" + _loc_5.toString()) : (_loc_5)) + ":" + (_loc_4 < 10 ? ("0" + _loc_4.toString()) : (_loc_4));
        }// end function

        public static function getTrainingResourceNum(param1:PlayerPersonal, param2:int) : int
        {
            if (TutorialManager.getInstance().isNoCost_Training())
            {
                return 0;
            }
            return CommonConstant.TRAINING_REQUIRE_ITEM_BASE * getTrainingCountFactor(param1) * param2;
        }// end function

        public static function getReduceSpText() : String
        {
            return TextControl.formatIdText(MessageId.COMMON_FROM_TO, CommonConstant.TRAINING_SP_DOWN_RANGE_MIN.toString(), CommonConstant.TRAINING_SP_DOWN_RANGE_MAX.toString());
        }// end function

        public static function getTrainingInstantLearningNum(param1:uint, param2:uint) : int
        {
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_TRAINING_4))
            {
                return 0;
            }
            return PaymentManager.getInstance().getInstantLearningNumBySecondCmp(param1, param2);
        }// end function

        private static function getParamReinforceIndex(param1:int) : int
        {
            var _loc_2:* = 0;
            while (_loc_2 < _PARAM_REINFORCE_TYPE.length)
            {
                
                if (_PARAM_REINFORCE_TYPE[_loc_2] == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return Constant.UNDECIDED;
        }// end function

        public static function getParamReinforceText(param1:int) : String
        {
            var _loc_2:* = getParamReinforceIndex(param1);
            return _loc_2 != Constant.UNDECIDED ? (MessageManager.getInstance().getMessage(_PARAM_REINFORCE_TEXT[_loc_2])) : ("");
        }// end function

        private static function checkTrainingKumiteGreatSuccessProbabilityBonusPlayer(param1:OwnSkillData, param2:PlayerInformation) : Boolean
        {
            var _loc_3:* = null;
            if (param1 && param1.skillInfo)
            {
                _loc_3 = param1.skillInfo;
                if (SkillManager.isMagicSkill(_loc_3.id))
                {
                    return _loc_3.isLearnable(param2.magicType);
                }
                return _loc_3.skillType == SkillManager.getInstance().getSkillTypeFromWeaponType(param2.weaponType);
            }
            return false;
        }// end function

        public static function getTrainingKumiteGreatSuccessProbabilityBonus(param1:OwnSkillData, param2:TrainingRoomKumitePlayerData) : Number
        {
            var _loc_3:* = NaN;
            if (checkTrainingKumiteGreatSuccessProbabilityBonusPlayer(param1, PlayerManager.getInstance().getPlayerInformation(param2.playerId)))
            {
                _loc_3 = param2.getGrowthTotal() / CommonConstant.CHARACTER_GROWTH_PARAMETER_LIMIT;
                if (_loc_3 > 1)
                {
                    _loc_3 = 1;
                }
                return CommonConstant.KUMITE_GREAT_SUCCESS_BONUS_PROBABIRITY_MAX * _loc_3;
            }
            return 0;
        }// end function

        public static function getTrainingKumiteGreatSuccessProbability(param1:OwnSkillData, param2:TrainingRoomKumitePlayerData) : int
        {
            var _loc_3:* = getTrainingKumiteGreatSuccessProbabilityBonus(param1, param2);
            var _loc_4:* = CommonConstant.KUMITE_GREAT_SUCCESS_BASE_PROBABIRITY + _loc_3;
            var _loc_5:* = (CommonConstant.KUMITE_GREAT_SUCCESS_BASE_PROBABIRITY + _loc_3) * 10;
            return (CommonConstant.KUMITE_GREAT_SUCCESS_BASE_PROBABIRITY + _loc_3) * 10;
        }// end function

        private static function getKumiteCountFactor(param1:KumiteList, param2:int) : Number
        {
            var _loc_3:* = NaN;
            if (param1)
            {
                _loc_3 = param2 / param1.countLimit;
                if (_loc_3 > 1)
                {
                    _loc_3 = 1;
                }
                return param1.countFactor * _loc_3 + 1;
            }
            return 0;
        }// end function

        public static function getKumiteTimeSec(param1:OwnSkillData) : uint
        {
            var _loc_2:* = KumiteListManager.getInstance().getKumiteList(param1.skillInfo.rank);
            if (_loc_2)
            {
                return _loc_2.baseTime * getKumiteCountFactor(_loc_2, param1.kumiteCount);
            }
            return 0;
        }// end function

        public static function getKumiteResourceNum(param1:OwnSkillData) : int
        {
            if (TutorialManager.getInstance().isNoCost_Kumite())
            {
                return 0;
            }
            var _loc_2:* = KumiteListManager.getInstance().getKumiteList(param1.skillInfo.rank);
            if (_loc_2)
            {
                return _loc_2.baseItemNum * getKumiteCountFactor(_loc_2, param1.kumiteCount);
            }
            return 0;
        }// end function

        public static function getKumiteInstantLearningNum(param1:uint, param2:uint) : int
        {
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_TRAINING_ROOM_KUMITE_6))
            {
                return 0;
            }
            return PaymentManager.getInstance().getInstantLearningNumBySecondCmp(param1, param2);
        }// end function

    }
}
