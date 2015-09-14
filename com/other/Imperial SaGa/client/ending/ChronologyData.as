package ending
{

    public class ChronologyData extends Object
    {
        private var _questNo:int;
        private var _year:int;
        private var _chapter:int;
        private var _questTitle:String;
        private var _totalComplete:int;

        public function ChronologyData()
        {
            return;
        }// end function

        public function setChronologyData(param1:Object) : void
        {
            this._questNo = param1.questNo;
            this._year = param1.year;
            this._questTitle = param1.questTitle;
            this._totalComplete = param1.totalComplete;
            this._chapter = param1.chapter;
            return;
        }// end function

        public function get questNo() : int
        {
            return this._questNo;
        }// end function

        public function get year() : int
        {
            return this._year;
        }// end function

        public function get chapter() : int
        {
            return this._chapter;
        }// end function

        public function get questTitle() : String
        {
            return this._questTitle;
        }// end function

        public function get totalComplete() : int
        {
            return this._totalComplete;
        }// end function

    }
}
