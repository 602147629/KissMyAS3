package network
{

    public class NetTaskEquipmentChange extends NetTask
    {

        public function NetTaskEquipmentChange(param1:Array, param2:Function)
        {
            super(NetId.PROTOCOL_EQUIPMENT_CHANGE, param2);
            _param.aEquipment = param1;
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
