package script
{
    import utility.*;

    public class ScriptComHippopotamusCheck extends ScriptComIfBase
    {
        private var _type:int;
        private var _aLabel:Array;

        public function ScriptComHippopotamusCheck()
        {
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            var _loc_2:* = null;
            super.setXml(param1);
            this._type = parseInt(param1.type);
            this._aLabel = [];
            for each (_loc_2 in param1.label)
            {
                
                this._aLabel.push(String(_loc_2));
            }
            return;
        }// end function

        override protected function checkLabel() : String
        {
            var _loc_1:* = 0;
            if (this._type == 1)
            {
                _loc_1 = this.HippopotamusCheck();
            }
            return this._aLabel[_loc_1];
        }// end function

        private function HippopotamusCheck() : int
        {
            var _loc_1:* = TimeClock.getNowTimeDate();
            var _loc_2:* = _loc_1.getDay();
            var _loc_3:* = _loc_1.getHours();
            return (_loc_2 + _loc_3) % 3;
        }// end function

    }
}
