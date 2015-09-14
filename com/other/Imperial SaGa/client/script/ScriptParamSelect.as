package script
{
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class ScriptParamSelect extends ScriptParamBase
    {
        protected var _mc:MovieClip;
        protected var _isoMain:InStayOut;
        protected var _aButton:Array;
        protected var _aChoice:Array;
        protected var _selectNo:int;
        private var _bClose:Boolean;

        public function ScriptParamSelect()
        {
            this._aButton = new Array();
            this._aChoice = new Array();
            this._selectNo = Constant.UNDECIDED;
            return;
        }// end function

        public function get mc() : MovieClip
        {
            return this._mc;
        }// end function

        public function get selectNo() : int
        {
            return this._selectNo;
        }// end function

        public function get bClose() : Boolean
        {
            return this._bClose;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aButton = null;
            this._aChoice = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            return;
        }// end function

        public function setParam(param1:Array, param2:Point) : void
        {
            if (param1.length < 2 || param1.length > 4)
            {
                Assert.print("選択肢の数が範囲内に有りません");
            }
            this._bClose = false;
            ButtonManager.getInstance().push();
            this._mc = ResourceManager.getInstance().createMovieClip(ScriptManager.getResourcePath(), "EventChoiceBalloonMc");
            switch(param1.length)
            {
                case 2:
                {
                    this._mc.choiceBalloonMc.gotoAndStop("choiceBalloon1");
                    break;
                }
                case 3:
                {
                    this._mc.choiceBalloonMc.gotoAndStop("choiceBalloon2");
                    break;
                }
                case 4:
                {
                    this._mc.choiceBalloonMc.gotoAndStop("choiceBalloon3");
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._mc.x = param2.x;
            this._mc.y = param2.y;
            var _loc_3:* = [this._mc.choiceBalloonMc.choice1Mc, this._mc.choiceBalloonMc.choice2Mc, this._mc.choiceBalloonMc.choice3Mc, this._mc.choiceBalloonMc.choice4Mc];
            var _loc_4:* = 0;
            while (_loc_4 < param1.length)
            {
                
                this._aButton.push(this.addButton(param1[_loc_4], _loc_3[_loc_4]));
                _loc_4++;
            }
            this._isoMain = new InStayOut(this._mc);
            this._isoMain.setIn(this.cbIn);
            return;
        }// end function

        protected function addButton(param1:ScriptSelectChoice, param2:MovieClip) : ButtonBase
        {
            var _loc_4:* = null;
            this._aChoice.push(param1);
            var _loc_3:* = new ScriptButton(param2, this.cbButton);
            _loc_3.setId(param1.no);
            _loc_3.enterSeId = SoundId.SE_STAGE_APPIER;
            _loc_3.overSeId = SoundId.SE_SELECT_WINDOW;
            ButtonManager.getInstance().addButtonBase(_loc_3);
            TextControl.setText(param2.textMc.textDt, param1.message);
            if (param1.passive == false)
            {
                _loc_3.setDisable(true);
                _loc_4 = new ColorTransform(1, 1, 1, 1, -128, -128, -128);
                param2.transform.colorTransform = _loc_4;
            }
            return _loc_3;
        }// end function

        private function cbButton(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = false;
            for each (_loc_3 in this._aChoice)
            {
                
                if (_loc_3.no == param1)
                {
                    _loc_2 = _loc_3.passive;
                    break;
                }
            }
            if (_loc_2 == false)
            {
                return;
            }
            for each (_loc_4 in this._aButton)
            {
                
                _loc_4.setDisableFlag(true);
            }
            this._selectNo = param1;
            this.closeSelect();
            return;
        }// end function

        public function closeSelect() : void
        {
            this._isoMain.setOut(this.cbOut);
            return;
        }// end function

        protected function cbIn() : void
        {
            return;
        }// end function

        protected function cbOut() : void
        {
            if (this._bClose == false)
            {
                this._bClose = true;
                ButtonManager.getInstance().pop();
            }
            return;
        }// end function

    }
}
