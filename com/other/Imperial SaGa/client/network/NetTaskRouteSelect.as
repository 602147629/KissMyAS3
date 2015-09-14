package network
{
    import user.*;

    public class NetTaskRouteSelect extends NetTask
    {

        public function NetTaskRouteSelect(param1:int, param2:Function)
        {
            super(NetId.PROTOCOL_ROUTE_SELECT, param2);
            _param.routeId = param1;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                UserDataManager.getInstance().userData.setRoute(_param.routeId);
                return true;
            }
            return false;
        }// end function

    }
}
