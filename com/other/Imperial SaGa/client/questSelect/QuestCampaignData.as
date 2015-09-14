package questSelect
{
    import area.*;
    import subdualPoint.*;

    public class QuestCampaignData extends Object
    {
        private var _campaignId:int;
        private var _swfFileName:String;
        private var _startTime:uint;
        private var _endTime:uint;
        private var _aDetail:Array;
        private var _areaInfo:AreaInformation;
        private var _subdualPoint:SubdualPointData;

        public function QuestCampaignData()
        {
            this._aDetail = [];
            return;
        }// end function

        public function get campaignId() : int
        {
            return this._campaignId;
        }// end function

        public function get swfFileName() : String
        {
            return this._swfFileName;
        }// end function

        public function get startTime() : uint
        {
            return this._startTime;
        }// end function

        public function get endTime() : uint
        {
            return this._endTime;
        }// end function

        public function get aDetail() : Array
        {
            return this._aDetail;
        }// end function

        public function get areaInfo() : AreaInformation
        {
            return this._areaInfo;
        }// end function

        public function get subdualPoint() : SubdualPointData
        {
            return this._subdualPoint;
        }// end function

        public function setReceiveData(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._campaignId = param1.campaignId;
            this._swfFileName = param1.swfFileName;
            this._startTime = param1.startTime;
            this._endTime = param1.endTime;
            this._aDetail = [];
            for each (_loc_2 in param1.aDetail)
            {
                
                _loc_3 = new QuestCampaignDetailData();
                _loc_3.setReceiveData(_loc_2);
                this._aDetail.push(_loc_3);
            }
            if (!this._areaInfo)
            {
                this._areaInfo = new AreaInformation();
            }
            this.areaInfo.setReceive(param1.area, false);
            this._subdualPoint = new SubdualPointData();
            this._subdualPoint.setRecieve(param1);
            return;
        }// end function

        public function getQuestCampaignDetailData(param1:int) : QuestCampaignDetailData
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aDetail)
            {
                
                if (_loc_2.campaignSubId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getQuestCampaignDetailNoReadNum() : int
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            for each (_loc_2 in this._aDetail)
            {
                
                if (_loc_2 && !_loc_2.bRead)
                {
                    _loc_1++;
                }
            }
            return _loc_1;
        }// end function

        public function getQuestCampaignQuestNoReadNum() : int
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            for each (_loc_2 in this._areaInfo.aQuest)
            {
                
                if (_loc_2 && _loc_2.bNewQuest)
                {
                    _loc_1++;
                }
            }
            return _loc_1;
        }// end function

    }
}
