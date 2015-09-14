package home
{
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class HomeCurrentPartyMenu extends Object
    {
        private var _cbMenu:Function;
        private var _baseMc:MovieClip;
        private var _isoMain:InStayOut;
        private var _btn:ButtonBase;
        private var _mouseEnable:Boolean;

        public function HomeCurrentPartyMenu(param1:DisplayObjectContainer, param2:Function)
        {
            this._cbMenu = param2;
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Home.swf", "MedicineBtn");
            param1.addChild(this._baseMc);
            this._isoMain = new InStayOut(this._baseMc);
            this._btn = ButtonManager.getInstance().addButton(this._baseMc.Btn, this.cbHealingBtn);
            this._btn.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._btn.setDisable(true);
            TextControl.setIdText(this._baseMc.Btn.textMc.textDt, MessageId.BARRACKS_BUTTON_QUICK_RECOVER);
            this._mouseEnable = false;
            return;
        }// end function

        public function release() : void
        {
            if (this._btn)
            {
                ButtonManager.getInstance().removeButton(this._btn);
            }
            this._btn = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._baseMc != null && this._baseMc.parent != null)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            this._cbMenu = null;
            return;
        }// end function

        public function setMouseEnable(param1:Boolean) : void
        {
            this._mouseEnable = param1;
            if (this._isoMain.bOpened)
            {
                this.cbIn();
            }
            return;
        }// end function

        public function setPos(param1:MovieClip) : void
        {
            var _loc_2:* = new Point(param1.x, param1.y);
            _loc_2 = param1.parent.localToGlobal(_loc_2);
            _loc_2 = this._baseMc.parent.globalToLocal(_loc_2);
            this._baseMc.x = _loc_2.x;
            this._baseMc.y = _loc_2.y;
            return;
        }// end function

        public function open() : void
        {
            if (!this._isoMain.bOpened)
            {
                this._isoMain.setIn(this.cbIn);
            }
            else
            {
                this.cbIn();
            }
            return;
        }// end function

        private function cbIn() : void
        {
            this._btn.setDisable(!this._mouseEnable);
            return;
        }// end function

        public function close() : void
        {
            this._btn.setDisable(true);
            if (!this._isoMain.bClosed)
            {
                this._isoMain.setOut();
            }
            return;
        }// end function

        private function cbHealingBtn(param1:int) : void
        {
            if (this._cbMenu != null)
            {
                this._cbMenu();
            }
            return;
        }// end function

    }
}
