package network
{
    import tutorial.*;
    import user.*;

    public class NetTaskMagicDevelop extends NetTask
    {
        private var _resourceCost:int;

        public function NetTaskMagicDevelop(param1:int, param2:Function)
        {
            super(NetId.PROTOCOL_MAGIC_DEVELOP_DEVELOP, param2);
            this._resourceCost = param1;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                TutorialManager.getInstance().ClearNoCost_MagicDevelop();
                UserDataManager.getInstance().userData.setMagicResource(UserDataManager.getInstance().userData.magicResource - this._resourceCost);
                return true;
            }
            if (param1.resultCode == NetId.RESULT_ERROR_MAGIC_DEVELOP_DEVELOP_CANT_DEVELOP)
            {
                return true;
            }
            if (param1.resultCode == NetId.RESULT_ERROR_MAGIC_DEVELOP_DEVELOP_CRWON_SHORTAGE)
            {
                return true;
            }
            return false;
        }// end function

    }
}
