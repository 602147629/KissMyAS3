package network
{

    public class NetTaskEmperorSelectEnd extends NetTask
    {

        public function NetTaskEmperorSelectEnd(param1:int, param2:Array, param3:Array, param4:Function)
        {
            super(NetId.PROTOCOL_EMPEROR_SELECT_END, param4);
            _param.uniqueId = param1;
            _param.aEquipment = param2;
            _param.aFlag = param3;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                return true;
            }
            return false;
        }// end function

    }
}
