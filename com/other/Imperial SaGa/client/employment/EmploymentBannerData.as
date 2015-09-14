package employment
{

    public class EmploymentBannerData extends Object
    {
        private var _bannerFileName:String;
        private var _bannerUrl:String;
        private var _startTime:uint;
        private var _endTime:uint;
        private var _priority:int;

        public function EmploymentBannerData()
        {
            this._bannerFileName = "";
            this._bannerUrl = "";
            this._startTime = 0;
            this._endTime = 0;
            this._priority = 0;
            return;
        }// end function

        public function get bannerFileName() : String
        {
            return this._bannerFileName;
        }// end function

        public function get bannerUrl() : String
        {
            return this._bannerUrl;
        }// end function

        public function get startTime() : uint
        {
            return this._startTime;
        }// end function

        public function get endTime() : uint
        {
            return this._endTime;
        }// end function

        public function get priority() : int
        {
            return this._priority;
        }// end function

        public function setReceiveData(param1:Object) : void
        {
            this._bannerFileName = param1.bannerFileName;
            this._bannerUrl = param1.bannerUrl;
            this._startTime = param1.startTime;
            this._endTime = param1.endTime;
            this._priority = param1.priority;
            return;
        }// end function

    }
}
