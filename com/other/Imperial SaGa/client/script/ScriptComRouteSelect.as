package script
{
    import network.*;

    public class ScriptComRouteSelect extends ScriptComBase
    {
        private var _bReciveEnd:Boolean;
        private var _routeId:int;

        public function ScriptComRouteSelect()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_WAIT);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            var _loc_2:* = param1.routeSelect;
            var _loc_3:* = CommonConstant[_loc_2];
            if (_loc_3 == null)
            {
                this._routeId = int(_loc_2);
            }
            else
            {
                this._routeId = int(_loc_3);
            }
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            NetManager.getInstance().request(new NetTaskRouteSelect(this._routeId, this.cbRecive));
            return;
        }// end function

        override public function commandSkip() : int
        {
            return ScriptComConstant.COMMAND_SKIP_RESULT_WAIT;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        private function cbRecive(param1:NetResult) : void
        {
            if (param1.resultCode != NetId.RESULT_ERROR)
            {
                _bCommandEnd = true;
                return;
            }
            return;
        }// end function

    }
}
