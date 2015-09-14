package network
{

    public class NetTask extends Object
    {
        private var _protocolId:int;
        private var _cbReceive:Function;
        protected var _param:Object;

        public function NetTask(param1:int, param2:Function)
        {
            this._protocolId = param1;
            this._cbReceive = param2;
            this._param = NetManager.getInstance().createParam();
            return;
        }// end function

        public function relelase() : void
        {
            this._cbReceive = null;
            this._param = null;
            return;
        }// end function

        public function get protocolId() : int
        {
            return this._protocolId;
        }// end function

        public function get cbReceive() : Function
        {
            return this._cbReceive;
        }// end function

        public function get param() : Object
        {
            return this._param;
        }// end function

        public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                return true;
            }
            return false;
        }// end function

        public function tutorialProtocol(param1:NetResult) : void
        {
            return;
        }// end function

    }
}
