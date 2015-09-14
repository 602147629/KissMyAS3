package network
{

    public class NetResult extends Object
    {
        private var _protocolId:int;
        private var _resultCode:int;
        private var _data:Object;

        public function NetResult(param1:int)
        {
            this._protocolId = param1;
            this._data = new Object();
            return;
        }// end function

        public function get protocolId() : int
        {
            return this._protocolId;
        }// end function

        public function get resultCode() : int
        {
            return this._resultCode;
        }// end function

        public function set resultCode(param1:int) : void
        {
            this._resultCode = param1;
            return;
        }// end function

        public function get data() : Object
        {
            return this._data;
        }// end function

        public function set data(param1:Object) : void
        {
            this._data = param1;
            return;
        }// end function

    }
}
