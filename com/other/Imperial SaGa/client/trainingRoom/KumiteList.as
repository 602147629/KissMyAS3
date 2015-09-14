package trainingRoom
{

    public class KumiteList extends Object
    {
        private var _id:uint;
        private var _baseItemNum:int;
        private var _baseTime:uint;
        private var _countFactor:int;
        private var _countLimit:int;

        public function KumiteList()
        {
            return;
        }// end function

        public function get rank() : uint
        {
            return this._id;
        }// end function

        public function get baseItemNum() : int
        {
            return this._baseItemNum;
        }// end function

        public function get baseTime() : uint
        {
            return this._baseTime;
        }// end function

        public function get countFactor() : int
        {
            return this._countFactor;
        }// end function

        public function get countLimit() : int
        {
            return this._countLimit;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._id = param1.id;
            this._baseItemNum = param1.baseItemNum;
            this._baseTime = param1.baseTime;
            this._countFactor = param1.countFactor;
            this._countLimit = param1.countLimit;
            return;
        }// end function

    }
}
