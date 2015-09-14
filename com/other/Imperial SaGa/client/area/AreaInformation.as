package area
{

    public class AreaInformation extends Object
    {
        private var _areaId:int;
        private var _bNotClearQuest:Boolean;
        private var _bNewArea:Boolean;
        private var _bNewQuest:Boolean;
        private var _bEasyArea:Boolean;
        private var _bStoryArea:Boolean;
        private var _aQuest:Array;
        private var _questCount:int;
        private var _questClearCount:int;
        private var _questCompleteCount:int;

        public function AreaInformation()
        {
            return;
        }// end function

        public function get areaId() : int
        {
            return this._areaId;
        }// end function

        public function get bNotClearQuest() : Boolean
        {
            return this._bNotClearQuest;
        }// end function

        public function get bNewArea() : Boolean
        {
            return this._bNewArea;
        }// end function

        public function get bNewQuest() : Boolean
        {
            return this._bNewQuest;
        }// end function

        public function get bEasyArea() : Boolean
        {
            return this._bEasyArea;
        }// end function

        public function setEasyArea(param1:Boolean) : void
        {
            this._bEasyArea = param1;
            return;
        }// end function

        public function get bStoryArea() : Boolean
        {
            return this._bStoryArea;
        }// end function

        public function get aQuest() : Array
        {
            return this._aQuest.concat();
        }// end function

        public function get questCount() : int
        {
            return this._questCount;
        }// end function

        public function get questClearCount() : int
        {
            return this._questClearCount;
        }// end function

        public function get questCompleteCount() : int
        {
            return this._questCompleteCount;
        }// end function

        public function setReceive(param1:Object, param2:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = false;
            this._areaId = param1.areaId;
            this._bNewArea = param1.bNewArea;
            this._bNewQuest = false;
            this._bEasyArea = false;
            this._bStoryArea = false;
            this._aQuest = new Array();
            for each (_loc_5 in param1.aQuest)
            {
                
                _loc_4 = new AreaQuest();
                _loc_4.setReceive(_loc_5);
                if (param2 && _loc_4.questType == CommonConstant.QUEST_TYPE_SUB && _loc_4.achievementRate <= 0)
                {
                    _loc_3 = true;
                    continue;
                }
                this._aQuest.push(_loc_4);
            }
            this._questCount = param1.questCount;
            this._questClearCount = param1.questClearCount;
            this._questCompleteCount = param1.questCompleteCount;
            if (_loc_3)
            {
                this._questCount = this._aQuest.length;
            }
            for each (_loc_4 in this._aQuest)
            {
                
                if (_loc_4.bNewQuest)
                {
                    this._bNewQuest = true;
                }
                if (_loc_4.bStoryQuest)
                {
                    this._bStoryArea = true;
                }
            }
            return;
        }// end function

    }
}
