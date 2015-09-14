package network
{
    import develop.*;
    import formation.*;

    public class NetTaskFormationSet extends NetTask
    {

        public function NetTaskFormationSet(param1:FormationSetData, param2:Array, param3:Function)
        {
            super(NetId.PROTOCOL_FORMATION_SET, param3);
            _param.formationData = param1.toObject();
            _param.aEquipment = param2;
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

        override public function tutorialProtocol(param1:NetResult) : void
        {
            DebugLog.print("TUTORIAL_PROTOCOL: FORMATION_SET");
            return;
        }// end function

    }
}
