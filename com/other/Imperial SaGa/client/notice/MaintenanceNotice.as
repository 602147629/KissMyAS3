package notice
{
    import button.*;
    import flash.display.*;
    import flash.net.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class MaintenanceNotice extends Object
    {
        private var _baseMc:MovieClip;
        private var _isoMc:InStayOut;
        private var _closeBtn:ButtonBase;
        private var _bClose:Boolean;
        private var _type:int;
        private var _cbClose:Function;

        public function MaintenanceNotice(param1:DisplayObjectContainer, param2:int)
        {
            ButtonManager.getInstance().push();
            this._baseMc = ResourceManager.getInstance().createMovieClip(this.resourcePath, "LoginInfoPopup");
            this._baseMc.loginInfoPopupMc.gotoAndStop("warning");
            this._baseMc.loginInfoPopupMc.loginInfoPageMc.infoPage_Lamp1Mc.gotoAndStop("on");
            this._isoMc = new InStayOut(this._baseMc);
            this._baseMc.closeBtnMc.visible = false;
            this._closeBtn = null;
            this._bClose = false;
            this._type = param2;
            this.setMaintenanceInfomation(param2);
            this._isoMc.setIn();
            param1.addChild(this._baseMc);
            return;
        }// end function

        public function get resourcePath() : String
        {
            return ResourcePath.COMMON_DATA_PATH + "UI_AnnouncePopup.swf";
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMc == null || this._isoMc != null && this._isoMc.bClosed;
        }// end function

        public function release() : void
        {
            if (this._closeBtn)
            {
                ButtonManager.getInstance().removeButton(this._closeBtn);
            }
            this._closeBtn = null;
            if (this._isoMc != null)
            {
                this._isoMc.release();
            }
            this._isoMc = null;
            if (this._baseMc != null && this._baseMc.parent != null)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function cbCloseFunction(param1:Function) : void
        {
            this._cbClose = param1;
            return;
        }// end function

        private function setMaintenanceInfomation(param1:int) : void
        {
            var _loc_2:* = Main.GetApplicationData().maintenanceData;
            if (_loc_2 == null)
            {
                Assert.print("メンテナンス情報がnull");
            }
            var _loc_3:* = "";
            var _loc_4:* = "";
            var _loc_5:* = "";
            var _loc_6:* = _loc_2.getMaintenanceTime();
            var _loc_7:* = _loc_2.getMaintenanceTimeByDate();
            if (param1 == MaintenanceData.MAINTENANCE_TYPE_MAINTENANCE)
            {
                _loc_3 = _loc_2.maintenanceTitle;
                _loc_4 = _loc_2.maintenanceMessage;
            }
            if (param1 == MaintenanceData.MAINTENANCE_TYPE_COUNTDOWN)
            {
                _loc_3 = MessageManager.getInstance().getMessage(MessageId.MAINTENANCE_NOTICE_TITLE);
                _loc_4 = MessageManager.getInstance().getMessage(MessageId.MAINTENANCE_NOTICE_MESSAGE_TIME);
                _loc_4 = _loc_4.replace("HH", _loc_7.getHours());
                _loc_4 = _loc_4.replace("MM", _loc_7.getMinutes() >= 10 ? (_loc_7.getMinutes()) : (String("0" + _loc_7.getMinutes())));
                _loc_5 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CLOSE);
            }
            if (param1 == MaintenanceData.MAINTENANCE_TYPE_WORNING)
            {
                _loc_3 = MessageManager.getInstance().getMessage(MessageId.MAINTENANCE_WORNING_TITLE);
                _loc_4 = MessageManager.getInstance().getMessage(MessageId.MAINTENANCE_WORNING_MESSAGE_TIME);
                _loc_4 = _loc_4.replace("HH", _loc_7.getHours());
                _loc_4 = _loc_4.replace("MM", _loc_7.getMinutes() >= 10 ? (_loc_7.getMinutes()) : (String("0" + _loc_7.getMinutes())));
                _loc_5 = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CLOSE);
            }
            if (this._type == MaintenanceData.MAINTENANCE_TYPE_COUNTDOWN || this._type == MaintenanceData.MAINTENANCE_TYPE_WORNING)
            {
                this._baseMc.nextBtnMc.visible = true;
                this._closeBtn = ButtonManager.getInstance().addButton(this._baseMc.nextBtnMc, this.cbCloseClick);
                this._closeBtn.enterSeId = ButtonBase.SE_CANCEL_ID;
                TextControl.setText(this._baseMc.nextBtnMc.textMc.textDt, _loc_5);
            }
            else
            {
                this._baseMc.nextBtnMc.visible = false;
            }
            if (_loc_3 == "" || _loc_4 == "")
            {
                Assert.print("メンテナンスの告知内容を設定できませんでした");
            }
            TextControl.setText(this._baseMc.loginInfoPopupMc.loginInfoTitleMc.textDt, _loc_3);
            TextControl.setText(this._baseMc.loginInfoPopupMc.loginInfoTextMc.textDt, _loc_4);
            return;
        }// end function

        private function cbCloseClick(param1:int) : void
        {
            var _loc_2:* = null;
            if (this._bClose)
            {
                return;
            }
            Main.GetApplicationData().maintenanceData.updateCheckType();
            if (this._type == MaintenanceData.MAINTENANCE_TYPE_MAINTENANCE)
            {
                _loc_2 = new URLRequest(Main.GetApplicationData().getOfficialJumpUrl());
                navigateToURL(_loc_2, "_self");
            }
            if (this._type == MaintenanceData.MAINTENANCE_TYPE_COUNTDOWN || this._type == MaintenanceData.MAINTENANCE_TYPE_WORNING)
            {
                this._bClose = true;
                this._isoMc.setOut(this.cbOut);
            }
            return;
        }// end function

        private function cbOut() : void
        {
            if (this._cbClose != null)
            {
                this._cbClose();
            }
            ButtonManager.getInstance().pop();
            return;
        }// end function

    }
}
