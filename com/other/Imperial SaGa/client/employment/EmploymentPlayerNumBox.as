package employment
{
    import button.*;
    import flash.display.*;
    import message.*;
    import user.*;

    public class EmploymentPlayerNumBox extends Object
    {
        private var _mcBase:MovieClip;
        private var _btnRetire:ButtonBase;

        public function EmploymentPlayerNumBox(param1:MovieClip, param2:Function)
        {
            this._mcBase = param1;
            TextControl.setIdText(this._mcBase.textMc.textDt, MessageId.EMPLOYMENT_PLAYER_COUNT_TITLE);
            this._btnRetire = ButtonManager.getInstance().addButton(this._mcBase.retreatBtnMc, param2);
            this._btnRetire.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcBase.retreatBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_GOTO_RETIREMENT);
            this.updatePlayerNum();
            return;
        }// end function

        public function release() : void
        {
            ButtonManager.getInstance().removeButton(this._btnRetire);
            this._btnRetire = null;
            this._mcBase = null;
            return;
        }// end function

        public function updatePlayerNum() : void
        {
            var _loc_1:* = UserDataManager.getInstance().userData;
            var _loc_2:* = UserDataManager.getInstance().getReserveMax() + _loc_1.warriorIncrease;
            var _loc_3:* = UserDataManager.getInstance().getCurrentPlayerNum();
            TextControl.setText(this._mcBase.numMc.textDt, TextControl.formatIdText(MessageId.EMPLOYMENT_PLAYER_COUNT, _loc_3.toString(), _loc_2.toString()));
            return;
        }// end function

        public function setDisable(param1:Boolean) : void
        {
            this._btnRetire.setDisable(param1);
            return;
        }// end function

        public function setDisableFlag(param1:Boolean) : void
        {
            this._btnRetire.setDisableFlag(param1);
            return;
        }// end function

    }
}
