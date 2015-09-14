package cooperateCode
{
    import message.*;

    public class CooperateCodeInformation extends Object
    {
        private const _CAMPAIN_NAME_BASE_ID:int = 200000;
        private var _id:int;
        private var _cooperate_id:int;
        private var _getTime:uint;
        private var _serialCode:String;

        public function CooperateCodeInformation()
        {
            this.setData(Constant.EMPTY_ID, Constant.EMPTY_ID, 0, "");
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get campaignName() : String
        {
            return this._cooperate_id ? (MessageManager.getInstance().getMessage(this._CAMPAIN_NAME_BASE_ID + this._cooperate_id)) : ("");
        }// end function

        public function get getTime() : uint
        {
            return this._getTime;
        }// end function

        public function get serialCode() : String
        {
            return this._serialCode;
        }// end function

        public function setReceive(param1:Object) : void
        {
            this._id = param1.id;
            this._cooperate_id = param1.cooperate_id;
            this._getTime = param1.give_time;
            this._serialCode = param1.serial;
            return;
        }// end function

        public function setData(param1:int, param2:int, param3:uint, param4:String) : void
        {
            this._id = param1;
            this._cooperate_id = param2;
            this._getTime = param3;
            this._serialCode = param4 != null ? (param4) : ("");
            return;
        }// end function

    }
}
