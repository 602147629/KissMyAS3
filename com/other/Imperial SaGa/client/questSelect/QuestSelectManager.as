package questSelect
{
    import area.*;
    import user.*;

    public class QuestSelectManager extends Object
    {
        private var _questSelectPageData:QuestSelectCategoryPageData;
        private static var _instance:QuestSelectManager = null;

        public function QuestSelectManager()
        {
            return;
        }// end function

        public function relase() : void
        {
            return;
        }// end function

        public function getSelectPageCategory() : int
        {
            if (this._questSelectPageData != null)
            {
                return this._questSelectPageData.category;
            }
            return 0;
        }// end function

        public function getPageData() : QuestSelectCategoryPageData
        {
            if (this._questSelectPageData != null)
            {
                return this._questSelectPageData;
            }
            return null;
        }// end function

        public function savePageData(param1:int, param2:int, param3:int) : void
        {
            if (this._questSelectPageData == null)
            {
                this._questSelectPageData = new QuestSelectCategoryPageData();
            }
            this._questSelectPageData.setData(param1, param2, param3);
            return;
        }// end function

        public function clearPageData() : void
        {
            if (this._questSelectPageData != null)
            {
                this._questSelectPageData.relase();
            }
            this._questSelectPageData = null;
            return;
        }// end function

        public static function getInstance() : QuestSelectManager
        {
            if (_instance == null)
            {
                _instance = new QuestSelectManager;
            }
            return _instance;
        }// end function

        public static function getLabelNameQuestLv(param1:AreaQuest) : String
        {
            var _loc_2:* = "lv1";
            var _loc_3:* = UserDataManager.getInstance().userData;
            if (param1)
            {
                if (_loc_3.chapter == 4 && param1.questType == CommonConstant.QUEST_TYPE_PROGRESS)
                {
                    _loc_2 = "lvLast";
                }
                else
                {
                    _loc_2 = "lv" + param1.questLv.toString();
                }
            }
            return _loc_2;
        }// end function

    }
}
