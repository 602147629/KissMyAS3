package battle
{
    import button.*;
    import flash.display.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class BattlePopup extends Object
    {
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _aButton:Array;
        private var _cbCloseFunc:Function;
        private var _select:int;
        public static const SELECT_YES:int = 1;
        public static const SELECT_NO:int = 2;

        public function BattlePopup(param1:DisplayObjectContainer, param2:String, param3:String, param4:String, param5:String, param6:String, param7:Function)
        {
            this._cbCloseFunc = param7;
            this._select = Constant.UNDECIDED;
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf", "RetreatConfirmationPopup");
            param1.addChild(this._mc);
            this._isoMain = new InStayOut(this._mc);
            this._aButton = [];
            var _loc_8:* = ButtonManager.getInstance().addButton(this._mc.YesBtnMc, this.cbYes, SELECT_YES);
            ButtonManager.getInstance().addButton(this._mc.YesBtnMc, this.cbYes, SELECT_YES).enterSeId = ButtonBase.SE_DECIDE_ID;
            this._aButton.push(_loc_8);
            _loc_8 = ButtonManager.getInstance().addButton(this._mc.NoBtnMc, this.cbNo, SELECT_NO);
            _loc_8.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._aButton.push(_loc_8);
            TextControl.setText(this._mc.sortieSoldierNumWindowMc.retreatText1Mc.textDt, param2);
            TextControl.setText(this._mc.sortieSoldierNumWindowMc.retreatText2Mc.textDt, param3);
            TextControl.setText(this._mc.sortieSoldierNumWindowMc.retreatText3Mc.textDt, param4);
            TextControl.setText(this._mc.YesBtnMc.textMc.textDt, param5);
            TextControl.setText(this._mc.NoBtnMc.textMc.textDt, param6);
            this.setButtonDisable();
            this._isoMain.setIn(this.cbOpen);
            return;
        }// end function

        public function get select() : int
        {
            return this._select;
        }// end function

        public function get bOpen() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain.bEnd;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aButton = [];
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

        private function setButtonDisable() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                _loc_1.setDisable(true);
            }
            return;
        }// end function

        private function setButtonEnable() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                _loc_1.setDisable(false);
            }
            return;
        }// end function

        public function cbYes(param1:int) : void
        {
            this._select = SELECT_YES;
            this.setButtonDisable();
            this._isoMain.setOut(this.cbClose);
            return;
        }// end function

        public function cbNo(param1:int) : void
        {
            this._select = SELECT_NO;
            this.setButtonDisable();
            this._isoMain.setOut(this.cbClose);
            return;
        }// end function

        public function cbOpen() : void
        {
            this.setButtonEnable();
            return;
        }// end function

        private function cbClose() : void
        {
            if (this._cbCloseFunc != null)
            {
                this._cbCloseFunc();
            }
            return;
        }// end function

    }
}
