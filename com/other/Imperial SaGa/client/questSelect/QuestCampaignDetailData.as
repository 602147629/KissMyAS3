package questSelect
{

    public class QuestCampaignDetailData extends Object
    {
        private var _campaignSubId:int;
        private var _scriptId:int;
        private var _scriptFileName:String;
        private var _bRead:Boolean;
        private var _startTime:uint;
        private var _endTime:uint;
        private var _subTitle:String;

        public function QuestCampaignDetailData()
        {
            this._campaignSubId = Constant.UNDECIDED;
            this._scriptFileName = "";
            this._scriptId = Constant.UNDECIDED;
            this._bRead = false;
            this._startTime = 0;
            this._endTime = 0;
            this._subTitle = "";
            return;
        }// end function

        public function get campaignSubId() : int
        {
            return this._campaignSubId;
        }// end function

        public function get scriptId() : int
        {
            return this._scriptId;
        }// end function

        public function get scriptFileName() : String
        {
            return this._scriptFileName;
        }// end function

        public function get bRead() : Boolean
        {
            return this._bRead;
        }// end function

        public function set bRead(param1:Boolean) : void
        {
            this._bRead = param1;
            return;
        }// end function

        public function get startTime() : uint
        {
            return this._startTime;
        }// end function

        public function get endTime() : uint
        {
            return this._endTime;
        }// end function

        public function get subTitle() : String
        {
            return this._subTitle;
        }// end function

        public function setReceiveData(param1:Object) : void
        {
            this._campaignSubId = param1.campaignSubId;
            this._scriptFileName = param1.scriptFileName;
            this._scriptId = param1.scriptId;
            this._bRead = param1.bRead;
            this._startTime = param1.startTime;
            this._endTime = param1.endTime;
            this._subTitle = param1.subTitle;
            return;
        }// end function

    }
}
