package quest
{
    import user.*;

    public class QuestResultData extends Object
    {
        private var _resultMessageType:int;
        private var _resultType:int;
        private var _achievementRate:int;
        private var _aQuestHistory:Array;
        private var _bEmperorChange:Boolean;
        private var _totalExp:int;
        private var _bWarehouse:Boolean;
        private var _aRoadRemuneration:Array;
        private var _aClearRemuneration:Array;
        private var _aFirstRemuneration:Array;
        private var _aFirstClearRemuneration:Array;

        public function QuestResultData()
        {
            return;
        }// end function

        public function get resultMessageType() : int
        {
            return this._resultMessageType;
        }// end function

        public function get resultType() : int
        {
            return this._resultType;
        }// end function

        public function get achievementRate() : int
        {
            return this._achievementRate;
        }// end function

        public function get aQuestHistory() : Array
        {
            return this._aQuestHistory;
        }// end function

        public function get bEmperorChange() : Boolean
        {
            return this._bEmperorChange;
        }// end function

        public function get totalExp() : int
        {
            return this._totalExp;
        }// end function

        public function get bWarehouse() : Boolean
        {
            return this._bWarehouse;
        }// end function

        public function get aRoadRemuneration() : Array
        {
            return this._aRoadRemuneration;
        }// end function

        public function get aClearRemuneration() : Array
        {
            return this._aClearRemuneration;
        }// end function

        public function get aFirstRemuneration() : Array
        {
            return this._aFirstRemuneration;
        }// end function

        public function get aFirstClearRemuneration() : Array
        {
            return this._aFirstClearRemuneration;
        }// end function

        public function setQuestResultData(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._resultMessageType = param1.resultMessageType;
            this._resultType = param1.resultType;
            this._achievementRate = param1.achievementRate;
            var _loc_2:* = new Object();
            this._aQuestHistory = [];
            for each (_loc_2 in param1.aQuestHistory)
            {
                
                _loc_3 = new QuestHistoryData();
                _loc_3.setHistoryData(_loc_2);
                this._aQuestHistory.push(_loc_3);
            }
            this._totalExp = param1.totalExp;
            this._bEmperorChange = param1.bEmperorChange;
            this._bWarehouse = GetItemInfo.checkMaskedWarehouse(param1.getItemInfo, CommonConstant.ITEM_HOW_TO_GET_EMPEROR_LEVEL);
            this._aRoadRemuneration = [];
            for each (_loc_2 in param1.aRoadRemuneration)
            {
                
                _loc_4 = new QuestRemunerationData();
                _loc_4.setRemunerationData(_loc_2);
                this._aRoadRemuneration.push(_loc_4);
            }
            this._aClearRemuneration = [];
            for each (_loc_2 in param1.aClearRemuneration)
            {
                
                _loc_5 = new QuestRemunerationData();
                _loc_5.setRemunerationData(_loc_2);
                this._aClearRemuneration.push(_loc_5);
            }
            this._aFirstRemuneration = [];
            for each (_loc_2 in param1.aFirstRemuneration)
            {
                
                _loc_6 = new QuestRemunerationData();
                _loc_6.setRemunerationData(_loc_2);
                this._aFirstRemuneration.push(_loc_6);
            }
            this._aFirstClearRemuneration = [];
            for each (_loc_2 in param1.aFirstClearRemuneration)
            {
                
                _loc_7 = new QuestRemunerationData();
                _loc_7.setRemunerationData(_loc_2);
                this._aFirstClearRemuneration.push(_loc_7);
            }
            return;
        }// end function

    }
}
