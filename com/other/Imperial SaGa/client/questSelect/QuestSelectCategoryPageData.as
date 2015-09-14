package questSelect
{

    public class QuestSelectCategoryPageData extends Object
    {
        private var _category:int;
        private var _areaId:int;
        private var _campaignId:int;
        private var _startTime:uint;
        private var _endTime:uint;
        public static const CATEGORY_QUEST_MAIN:int = 0;
        public static const CATEGORY_QUEST_BATTLE:int = 1;
        public static const CATEGORY_QUEST_CAMPATIN:int = 2;

        public function QuestSelectCategoryPageData()
        {
            this._category = 0;
            this._areaId = 0;
            this._campaignId = 0;
            this._startTime = 0;
            this._endTime = 0;
            return;
        }// end function

        public function get category() : int
        {
            return this._category;
        }// end function

        public function get areaId() : int
        {
            return this._areaId;
        }// end function

        public function get campaignId() : int
        {
            return this._campaignId;
        }// end function

        public function relase() : void
        {
            return;
        }// end function

        public function setData(param1:int, param2:int, param3:int) : void
        {
            this._category = param1;
            this._areaId = param2;
            this._campaignId = param3;
            this._startTime = 0;
            this._endTime = 0;
            return;
        }// end function

        public static function isMatchData(param1:QuestSelectCategoryPageData, param2:QuestSelectCategoryPageData) : Boolean
        {
            if (param1.category == param2.category && param1.areaId == param2.areaId && param1.campaignId == param2.campaignId)
            {
                return true;
            }
            return false;
        }// end function

    }
}
