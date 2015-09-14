package area
{
    import message.*;
    import quest.*;

    public class AreaQuestSort extends Object
    {
        private var _sortId:int;
        private var _aSortTypes:Array;
        private var validated:Boolean = false;
        public static const SORT_ID_DIFICALTY_UP:int = 1;
        public static const SORT_ID_DIFICALTY_DOWN:int = 2;
        public static const SORT_ID_NEW_QUEST:int = 3;
        public static const SORT_ID_CLEAR_QUEST:int = 4;
        public static const SORT_ID_NAME:int = 5;
        public static const SORT_ID_CLEAR_COUNT_MANY:int = 6;
        public static const SORT_ID_CLEAR_COUNT_SMALL:int = 7;
        public static const SORT_ID_RATE_MANY:int = 8;
        public static const SORT_ID_RATE_SMALL:int = 9;
        public static const SORT_ID_QUEST_NO:int = 10;
        private static var _instance:AreaQuestSort = null;

        public function AreaQuestSort()
        {
            var _loc_1:* = 0;
            this._aSortTypes = [SORT_ID_DIFICALTY_UP, SORT_ID_DIFICALTY_DOWN, SORT_ID_NEW_QUEST, SORT_ID_CLEAR_QUEST, SORT_ID_NAME, SORT_ID_CLEAR_COUNT_MANY, SORT_ID_CLEAR_COUNT_SMALL, SORT_ID_RATE_MANY, SORT_ID_RATE_SMALL, SORT_ID_QUEST_NO];
            this._sortId = Main.GetApplicationData().userConfigData.questSortType;
            for each (_loc_1 in this._aSortTypes)
            {
                
                if (this._sortId == _loc_1)
                {
                    this.validated = true;
                }
            }
            if (this.validated == false)
            {
                this._sortId = SORT_ID_DIFICALTY_UP;
            }
            return;
        }// end function

        public function get sortId() : int
        {
            return this._sortId;
        }// end function

        public function set sortId(param1:int) : void
        {
            this._sortId = param1;
            return;
        }// end function

        public static function getInstance() : AreaQuestSort
        {
            if (_instance == null)
            {
                _instance = new AreaQuestSort;
            }
            return _instance;
        }// end function

        public static function getSortTitle(param1:int) : String
        {
            switch(param1)
            {
                case SORT_ID_DIFICALTY_UP:
                {
                    return MessageManager.getInstance().getMessage(MessageId.QUEST_SORT_DIFFICULTY_HIGH);
                }
                case SORT_ID_DIFICALTY_DOWN:
                {
                    return MessageManager.getInstance().getMessage(MessageId.QUEST_SORT_DIFFICULTY_LOW);
                }
                case SORT_ID_NEW_QUEST:
                {
                    return MessageManager.getInstance().getMessage(MessageId.QUEST_SORT_NEW_QUEST);
                }
                case SORT_ID_CLEAR_QUEST:
                {
                    return MessageManager.getInstance().getMessage(MessageId.QUEST_SORT_NEW_ATTAINMENT);
                }
                case SORT_ID_NAME:
                {
                    return MessageManager.getInstance().getMessage(MessageId.QUEST_SORT_MISSION_SYLLABARY_ORDER);
                }
                case SORT_ID_CLEAR_COUNT_MANY:
                {
                    return MessageManager.getInstance().getMessage(MessageId.QUEST_SORT_ACHIEVE_NUMBER_HIGH);
                }
                case SORT_ID_CLEAR_COUNT_SMALL:
                {
                    return MessageManager.getInstance().getMessage(MessageId.QUEST_SORT_ACHIEVE_NUMBER_LOW);
                }
                case SORT_ID_RATE_MANY:
                {
                    return MessageManager.getInstance().getMessage(MessageId.QUEST_SORT_ACHIEVEMENT_HIGH);
                }
                case SORT_ID_RATE_SMALL:
                {
                    return MessageManager.getInstance().getMessage(MessageId.QUEST_SORT_ACHIEVEMENT_LOW);
                }
                case SORT_ID_QUEST_NO:
                {
                    return MessageManager.getInstance().getMessage(MessageId.QUEST_SORT_QUEST_NUMBER);
                }
                default:
                {
                    break;
                }
            }
            return "";
        }// end function

        public static function sortAreaQuest(param1:Array, param2:int, param3:int) : Array
        {
            var _loc_4:* = param1.concat();
            var _loc_5:* = [];
            var _loc_6:* = [];
            if (param3 == QuestConstant.BATTLE_QUEST_AREA_ID)
            {
                _loc_5.push("questType");
                _loc_6.push(Array.DESCENDING);
            }
            switch(param2)
            {
                case SORT_ID_DIFICALTY_UP:
                {
                    _loc_5 = _loc_5.concat(["questLv", "newQuest", "no"]);
                    _loc_6 = _loc_6.concat([Array.NUMERIC | Array.DESCENDING, Array.NUMERIC | Array.DESCENDING, Array.DESCENDING]);
                    break;
                }
                case SORT_ID_DIFICALTY_DOWN:
                {
                    _loc_5 = _loc_5.concat(["questLv", "newQuest", "no"]);
                    _loc_6 = _loc_6.concat([Array.NUMERIC, Array.NUMERIC | Array.DESCENDING, Array.DESCENDING]);
                    break;
                }
                case SORT_ID_NEW_QUEST:
                {
                    _loc_5 = _loc_5.concat(["newQuest", "totalClearCount", "clearTime"]);
                    _loc_6 = _loc_6.concat([Array.NUMERIC | Array.DESCENDING, Array.NUMERIC, Array.NUMERIC]);
                    break;
                }
                case SORT_ID_CLEAR_QUEST:
                {
                    _loc_5 = _loc_5.concat(["clearTime", "kana", "newQuest"]);
                    _loc_6 = _loc_6.concat([Array.NUMERIC | Array.DESCENDING, Array.CASEINSENSITIVE, Array.NUMERIC | Array.DESCENDING]);
                    break;
                }
                case SORT_ID_NAME:
                {
                    _loc_5 = _loc_5.concat(["kana", "newQuest", "clearTime"]);
                    _loc_6 = _loc_6.concat([Array.CASEINSENSITIVE, Array.NUMERIC | Array.DESCENDING, Array.NUMERIC | Array.DESCENDING]);
                    break;
                }
                case SORT_ID_CLEAR_COUNT_MANY:
                {
                    _loc_5 = _loc_5.concat(["totalClearCount", "newQuest", "no"]);
                    _loc_6 = _loc_6.concat([Array.NUMERIC | Array.DESCENDING, Array.NUMERIC | Array.DESCENDING, Array.DESCENDING]);
                    break;
                }
                case SORT_ID_CLEAR_COUNT_SMALL:
                {
                    _loc_5 = _loc_5.concat(["totalClearCount", "newQuest", "no"]);
                    _loc_6 = _loc_6.concat([Array.NUMERIC, Array.NUMERIC | Array.DESCENDING, Array.NUMERIC]);
                    break;
                }
                case SORT_ID_RATE_MANY:
                {
                    _loc_5 = _loc_5.concat(["achievementRate", "newQuest", "no"]);
                    _loc_6 = _loc_6.concat([Array.NUMERIC | Array.DESCENDING, Array.NUMERIC | Array.DESCENDING, Array.DESCENDING]);
                    break;
                }
                case SORT_ID_RATE_SMALL:
                {
                    _loc_5 = _loc_5.concat(["achievementRate", "newQuest", "no"]);
                    _loc_6 = _loc_6.concat([Array.NUMERIC, Array.NUMERIC | Array.DESCENDING, Array.DESCENDING]);
                    break;
                }
                case SORT_ID_QUEST_NO:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_4.length > 1 && _loc_5.length > 0 && _loc_6.length > 0 && _loc_5.length == _loc_6.length)
            {
                _loc_4 = _loc_4.sortOn(_loc_5, _loc_6);
            }
            return _loc_4;
        }// end function

    }
}
