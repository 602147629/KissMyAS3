package barracks
{

    public class BarracksData extends Object
    {
        private var _uniqueId:int;
        private var _index:int;
        private var _restoreTime:uint;
        private var _noticeId:int;

        public function BarracksData(param1:int, param2:int, param3:uint, param4:int)
        {
            this._uniqueId = param1;
            this._index = param2;
            this._restoreTime = param3;
            this._noticeId = param4;
            return;
        }// end function

        public function get uniqueId() : int
        {
            return this._uniqueId;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function get restoreTime() : uint
        {
            return this._restoreTime;
        }// end function

        public function get noticeId() : int
        {
            return this._noticeId;
        }// end function

        public function setData(param1:int, param2:uint, param3:int) : void
        {
            this._uniqueId = param1;
            this._restoreTime = param2;
            this._noticeId = param3;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.uniqueId = this._uniqueId;
            _loc_1.restoreTime = this._restoreTime;
            _loc_1.noticeId = this._noticeId;
            return _loc_1;
        }// end function

    }
}
