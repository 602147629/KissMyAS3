package script
{
    import flash.display.*;
    import flash.geom.*;
    import sound.*;
    import utility.*;

    public class ScriptComSelectPassive extends ScriptComBase
    {
        private var _aChoice:Array;
        private var _pos:Point;

        public function ScriptComSelectPassive()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            this._aChoice = new Array();
            this._pos = new Point();
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            super.setXml(param1);
            this._pos = new Point(param1.pos.@x, param1.pos.@y);
            var _loc_2:* = 0;
            for each (param1 in param1.ChoiceList.children())
            {
                
                _loc_3 = param1.passiveFlag;
                _loc_4 = new ScriptSelectChoice();
                _loc_4.setParam(param1.message, param1.label, _loc_2, _loc_3 == 1);
                this._aChoice.push(_loc_4);
                _loc_2++;
            }
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = ScriptManager.getInstance().getBalloonLayer();
            if (_loc_1 == null)
            {
                Assert.print("表示スプライトが有りません");
            }
            var _loc_2:* = ScriptManager.getInstance().createSelect();
            _loc_2.setParam(this._aChoice.concat(), this._pos);
            _loc_1.addChild(_loc_2.mc);
            SoundManager.getInstance().playSe(SoundId.SE_SIGNBOARD);
            return;
        }// end function

        override public function commandSkip() : int
        {
            return ScriptComConstant.COMMAND_SKIP_RESULT_DONT;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return false;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_2 = ScriptManager.getInstance().getSelect();
            if (_loc_2.bClose)
            {
                for each (_loc_3 in this._aChoice)
                {
                    
                    if (_loc_3.no == _loc_2.selectNo)
                    {
                        ScriptManager.getInstance().gotoLabel(_loc_3.label);
                        break;
                    }
                }
                _bCommandEnd = true;
            }
            return;
        }// end function

    }
}
