﻿package script
{
    import quest.*;

    public class ScriptComIfQuestFlagOr extends ScriptComIfBase
    {
        private var _aFlagId:Array;
        private var _labelOk:String;
        private var _labelNg:String;

        public function ScriptComIfQuestFlagOr()
        {
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            var _loc_2:* = null;
            super.setXml(param1);
            this._aFlagId = [];
            for each (_loc_2 in param1.flag)
            {
                
                this._aFlagId.push(parseInt(_loc_2));
            }
            this._labelOk = param1.labelOk;
            this._labelNg = param1.labelNg;
            return;
        }// end function

        override protected function checkLabel() : String
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = false;
            for each (_loc_2 in this._aFlagId)
            {
                
                _loc_3 = QuestManager.getInstance().getQuestFlag(_loc_2);
                if (_loc_3 != null && _loc_3.bState == true)
                {
                    _loc_1 = true;
                    break;
                }
            }
            if (_loc_1)
            {
                return this._labelOk;
            }
            return this._labelNg;
        }// end function

    }
}
