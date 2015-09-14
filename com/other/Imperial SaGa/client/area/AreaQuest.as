package area
{
    import flash.geom.*;
    import quest.*;
    import utility.*;

    public class AreaQuest extends Object
    {
        private var _id:String;
        private var _no:int;
        private var _bNewQuest:Boolean;
        private var _newQuest:int;
        private var _bEasyQuest:Boolean;
        private var _bStoryQuest:Boolean;
        private var _questType:int;
        private var _questTitle:String;
        private var _kana:String;
        private var _iconPos:Point;
        private var _questLv:int;
        private var _explanation:String;
        private var _aDispatchCondition:Array;
        private var _dispatchCondition:String;
        private var _aReward:Array;
        private var _useAp:int;
        private var _maxMember:int;
        private var _totalClearCount:int;
        private var _clearCount:int;
        private var _achievementRate:Number;
        private var _clearTime:int;
        private var _bSelect:Boolean;
        private var _eventId:int;
        private var _endTime:int;
        private var _endTimeMsg:String;

        public function AreaQuest()
        {
            return;
        }// end function

        public function get id() : String
        {
            return this._id;
        }// end function

        public function get no() : int
        {
            return this._no;
        }// end function

        public function get bNewQuest() : Boolean
        {
            return this._bNewQuest;
        }// end function

        public function get newQuest() : int
        {
            return this._newQuest;
        }// end function

        public function get bEasyQuest() : Boolean
        {
            return this._bEasyQuest;
        }// end function

        public function setEasyQuest(param1:Boolean) : void
        {
            this._bEasyQuest = param1;
            return;
        }// end function

        public function get bStoryQuest() : Boolean
        {
            return this._bStoryQuest;
        }// end function

        public function get questType() : int
        {
            return this._questType;
        }// end function

        public function get questTitle() : String
        {
            return this._questTitle;
        }// end function

        public function get kana() : String
        {
            return this._kana;
        }// end function

        public function get iconPos() : Point
        {
            return this._iconPos.clone();
        }// end function

        public function get questLv() : int
        {
            return this._questLv;
        }// end function

        public function get explanation() : String
        {
            return this._explanation;
        }// end function

        public function get aDispatchCondition() : Array
        {
            return this._aDispatchCondition.concat();
        }// end function

        public function get dispatchCondition() : String
        {
            return this._dispatchCondition;
        }// end function

        public function get aReward() : Array
        {
            return this._aReward;
        }// end function

        public function get useAp() : int
        {
            return this._useAp;
        }// end function

        public function get maxMember() : int
        {
            return this._maxMember;
        }// end function

        public function get totalClearCount() : int
        {
            return this._totalClearCount;
        }// end function

        public function get clearCount() : int
        {
            return this._clearCount;
        }// end function

        public function get bCurrentCycleClear() : Boolean
        {
            return this._clearCount > 0;
        }// end function

        public function get achievementRate() : Number
        {
            return this._achievementRate;
        }// end function

        public function get clearTime() : int
        {
            return this._clearTime;
        }// end function

        public function get bSelect() : Boolean
        {
            return this._bSelect;
        }// end function

        public function get eventId() : int
        {
            return this._eventId;
        }// end function

        public function get endTime() : uint
        {
            return this._endTime;
        }// end function

        public function get endTimeMsg() : String
        {
            return this._endTimeMsg;
        }// end function

        public function setReceive(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._id = param1.id;
            this._no = param1.no;
            this._bNewQuest = param1.bNewQuest;
            this._newQuest = this._bNewQuest == true ? (1) : (0);
            this._bEasyQuest = false;
            this._bStoryQuest = false;
            this._questType = param1.questType;
            this._questTitle = param1.questTitle;
            this._kana = param1.kana;
            this._questLv = param1.questLv;
            this._iconPos = new Point(param1.iconPosX, param1.iconPosY);
            this._explanation = StringTools.xmlLineToStringLine(param1.explanation);
            this._aDispatchCondition = new Array();
            this._dispatchCondition = "";
            for each (_loc_2 in param1.aDispatchCondition)
            {
                
                this._aDispatchCondition.push(_loc_2);
                this._dispatchCondition = this._dispatchCondition + _loc_2;
            }
            _loc_3 = /\\\
n""\\n/g;
            this._dispatchCondition = this._dispatchCondition.replace(_loc_3, "\n");
            this._aReward = new Array();
            this._useAp = param1.useAp;
            this._maxMember = param1.maxMember;
            this._totalClearCount = param1.totalClearCount;
            this._clearCount = param1.clearCount;
            this._achievementRate = param1.achievementRate;
            this._clearTime = param1.clearTime;
            this._bSelect = param1.bSelect;
            this._eventId = param1.eventId;
            this._endTime = param1.endTime;
            this._endTimeMsg = QuestManager.getInstance().getQuestEndTime(this._endTime);
            this._bStoryQuest = this._questType == CommonConstant.QUEST_TYPE_MAIN || this._questType == CommonConstant.QUEST_TYPE_KEY || this._questType == CommonConstant.QUEST_TYPE_PROGRESS;
            return;
        }// end function

    }
}
