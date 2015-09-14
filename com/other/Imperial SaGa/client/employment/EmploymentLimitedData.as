package employment
{

    public class EmploymentLimitedData extends Object
    {
        private var _startTime:uint;
        private var _endTime:uint;
        private var _endDispFlag:Boolean;
        private var _bannerClickedJumpUrl:String;
        private var _bannerFileName:String;
        private var _price:int;
        private var _boxFlag:Boolean;
        private var _boxPrice:int;
        private var _bBoxFirstBonus:Boolean;
        private var _playerId:int;

        public function EmploymentLimitedData(param1:uint, param2:uint, param3:Boolean, param4:String, param5:String, param6:int, param7:Boolean, param8:int, param9:int)
        {
            this._startTime = param1;
            this._endTime = param2;
            this._endDispFlag = param3;
            this._bannerClickedJumpUrl = param4;
            this._bannerFileName = param5;
            this._price = param6;
            this._boxFlag = param7;
            this._boxPrice = param8;
            this._bBoxFirstBonus = false;
            this._playerId = param9;
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

        public function get endDispFlag() : Boolean
        {
            return this._endDispFlag;
        }// end function

        public function get bannerClickedJumpUrl() : String
        {
            return this._bannerClickedJumpUrl;
        }// end function

        public function get bannerFileName() : String
        {
            return this._bannerFileName;
        }// end function

        public function get price() : uint
        {
            return this._price;
        }// end function

        public function get boxFlag() : Boolean
        {
            return this._boxFlag;
        }// end function

        public function get boxPrice() : int
        {
            return this._boxPrice;
        }// end function

        public function get bBoxFirstBonus() : Boolean
        {
            return this._bBoxFirstBonus;
        }// end function

        public function set bBoxFirstBonus(param1:Boolean) : void
        {
            this._bBoxFirstBonus = param1;
            return;
        }// end function

        public function get playerId() : int
        {
            return this._playerId;
        }// end function

    }
}
