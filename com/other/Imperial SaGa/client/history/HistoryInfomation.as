package history
{
    import quest.*;

    public class HistoryInfomation extends Object
    {
        private var _questId:int;
        private var _title:String;
        private var _questName:String;
        private var _chapter:int;
        private var _cycle:int;
        private var _playCount:int;
        private var _clearCount:int;
        private var _killCount:int;
        private var _deadCount:int;
        private var _emperorId:int;
        private var _achievementRate:int;
        private var _aParty:Array;
        private var _year:int;

        public function HistoryInfomation()
        {
            return;
        }// end function

        public function setParameter(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._questId = param1.questId;
            this._title = param1.title;
            this._questName = param1.questName;
            this._chapter = param1.chapter;
            this._cycle = param1.cycle;
            this._playCount = param1.playCount;
            this._clearCount = param1.clearCount;
            this._killCount = param1.killCount;
            this._deadCount = param1.deadCount;
            this._emperorId = param1.emperorId;
            this._achievementRate = param1.achievementRate;
            this._year = QuestManager.getYear(param1.chapter, param1.year);
            this._aParty = [];
            for each (_loc_2 in param1.aParty)
            {
                
                if (_loc_2.id != 0)
                {
                    _loc_3 = new HisoryPersonal();
                    _loc_3.setParameter(_loc_2);
                    this._aParty.push(_loc_3);
                    continue;
                }
                this._aParty.push(null);
            }
            return;
        }// end function

        public function get questId() : int
        {
            return this._questId;
        }// end function

        public function get title() : String
        {
            return this._title;
        }// end function

        public function get questName() : String
        {
            return this._questName;
        }// end function

        public function get chapter() : int
        {
            return this._chapter;
        }// end function

        public function get cycle() : int
        {
            return this._cycle;
        }// end function

        public function get playCount() : int
        {
            return this._playCount;
        }// end function

        public function get clearCount() : int
        {
            return this._clearCount;
        }// end function

        public function get killCount() : int
        {
            return this._killCount;
        }// end function

        public function get deadCount() : int
        {
            return this._deadCount;
        }// end function

        public function get emperorId() : int
        {
            return this._emperorId;
        }// end function

        public function get achievementRate() : int
        {
            return this._achievementRate;
        }// end function

        public function get aParty() : Array
        {
            return this._aParty;
        }// end function

        public function get year() : int
        {
            return this._year;
        }// end function

    }
}
