package magicLaboratory
{
    import home.*;
    import payment.*;
    import player.*;
    import skill.*;
    import tutorial.*;
    import user.*;

    public class MagicLearnUtility extends Object
    {

        public function MagicLearnUtility()
        {
            return;
        }// end function

        private static function mulDevelopCountFactor(param1:int, param2:int) : int
        {
            var _loc_3:* = param1 * CommonConstant.MAGIC_DEVELOP_COUNT_FACTOR;
            var _loc_4:* = _loc_3 * param2 / CommonConstant.MAGIC_DEVELOP_COUNT_JUDGEMENT_LIMIT;
            if (_loc_3 * param2 / CommonConstant.MAGIC_DEVELOP_COUNT_JUDGEMENT_LIMIT > _loc_3)
            {
                _loc_4 = _loc_3;
            }
            return _loc_4 + param1;
        }// end function

        public static function getDevelopSecond(param1:int) : uint
        {
            return mulDevelopCountFactor(CommonConstant.MAGIC_DEVELOP_TIME_BASE, param1);
        }// end function

        public static function getDevelopResourceNum(param1:int) : int
        {
            if (TutorialManager.getInstance().isNoCost_MagicDevelop())
            {
                return 0;
            }
            return mulDevelopCountFactor(CommonConstant.MAGIC_DEVELOP_ITEM_BASE, param1);
        }// end function

        public static function getDevelopInstantLearningNum(param1:uint, param2:uint) : int
        {
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP_3))
            {
                return 0;
            }
            return PaymentManager.getInstance().getInstantLearningNumBySecondCmp(param1, param2);
        }// end function

        private static function mulSkillRankFactor(param1:int, param2:SkillInformation) : int
        {
            var _loc_3:* = param2 != null ? (param2.rank) : (1);
            var _loc_4:* = param1 * CommonConstant.MAGIC_LEARN_RANK_FACTOR;
            var _loc_5:* = param1 * CommonConstant.MAGIC_LEARN_RANK_FACTOR * (_loc_3 - 1) / (CommonConstant.MAGIC_LEARN_RANK_JUDGEMENT_LIMIT - 1);
            if (param1 * CommonConstant.MAGIC_LEARN_RANK_FACTOR * (_loc_3 - 1) / (CommonConstant.MAGIC_LEARN_RANK_JUDGEMENT_LIMIT - 1) > _loc_4)
            {
                _loc_5 = _loc_4;
            }
            return _loc_5 + param1;
        }// end function

        public static function getLearnSecond(param1:SkillInformation) : uint
        {
            return mulSkillRankFactor(CommonConstant.MAGIC_LEARN_TIME_BASE, param1);
        }// end function

        public static function getLearnResourceNum(param1:SkillInformation) : int
        {
            if (TutorialManager.getInstance().isNoCost_MagicLearn())
            {
                return 0;
            }
            return mulSkillRankFactor(CommonConstant.MAGIC_LEARN_ITEM_BASE, param1);
        }// end function

        public static function getLearnInstantLearningNum(param1:uint, param2:uint) : int
        {
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_4))
            {
                return 0;
            }
            return PaymentManager.getInstance().getInstantLearningNumBySecondCmp(param1, param2);
        }// end function

        public static function getLearnCount() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = UserDataManager.getInstance().userData.getInstitutionInfo(CommonConstant.FACILITY_ID_MAGIC_DEVELOP);
            if (_loc_2 != null)
            {
                if (_loc_2.grade > 0)
                {
                    _loc_1 = 1;
                }
            }
            return _loc_1;
        }// end function

        public static function getLearnableSkillId(param1:int) : Array
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_2:* = [];
            var _loc_3:* = UserDataManager.getInstance().userData.getPlayerPersonal(param1);
            var _loc_4:* = PlayerManager.getInstance().getPlayerInformation(_loc_3.playerId);
            var _loc_5:* = MagicLabolatoryManager.getInstance().aLearningSkillId;
            for each (_loc_6 in _loc_5)
            {
                
                _loc_7 = SkillManager.getInstance().getSkillInformation(_loc_6);
                if (_loc_3.isHaveSkill(_loc_6))
                {
                    continue;
                }
                if (_loc_7.isLearnable(_loc_4.magicType))
                {
                    _loc_2.push(_loc_6);
                }
            }
            return _loc_2;
        }// end function

    }
}
