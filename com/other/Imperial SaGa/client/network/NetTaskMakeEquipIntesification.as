package network
{

    public class NetTaskMakeEquipIntesification extends NetTask
    {

        public function NetTaskMakeEquipIntesification(param1:Array, param2:Function)
        {
            super(NetId.PROTOCOL_MAKE_EQUIP_INTENSIFICATION, param2);
            _param.aUniqueId = param1;
            return;
        }// end function

    }
}
