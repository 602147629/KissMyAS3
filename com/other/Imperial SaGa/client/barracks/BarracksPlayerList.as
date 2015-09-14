package barracks
{
    import flash.display.*;
    import message.*;
    import player.*;
    import playerList.*;
    import status.*;

    public class BarracksPlayerList extends PlayerListBase
    {
        private var _bBedPopup:Boolean;
        private var _bTutorial:Boolean;
        private var _bBtnEnable:Boolean;
        private var _overlay:Shape;

        public function BarracksPlayerList(param1:MovieClip, param2:Array)
        {
            this._bBedPopup = false;
            this._bTutorial = false;
            this._bBtnEnable = false;
            super(param1, param2);
            this._overlay = new Shape();
            this._overlay.graphics.beginFill(4473924);
            this._overlay.graphics.drawRect(0, 0, 486, 456);
            this._overlay.graphics.endFill();
            this._overlay.alpha = 0.5;
            _mcBase.addChild(this._overlay);
            this._overlay.visible = false;
            var _loc_3:* = _aSortId.length;
            _aSortTextId.push(MessageId.PLAYER_LIST_SORT_RESTORE_TIME);
            _aSortId.push(ListPlayerSort.SORT_ID_RESTORE_TIME);
            _selectSortId = ListPlayerSort.SORT_ID_RESTORE_TIME;
            sortList(_loc_3);
            return;
        }// end function

        public function get bBedPopup() : Boolean
        {
            return this._bBedPopup;
        }// end function

        public function setBedPopup(param1:Boolean) : void
        {
            if (_balloonStatus && _balloonStatus.isShow())
            {
                _balloonStatus.hide();
            }
            this._bBedPopup = param1;
            return;
        }// end function

        override protected function createBalloonStatus() : PlayerSimpleStatus
        {
            return new PlayerSimpleStatus(Main.GetProcess(), PlayerSimpleStatus.LABEL_RESTORE_TIME);
        }// end function

        override protected function setupBalloonStatus(param1:int, param2:ListPlayerDisplay) : void
        {
            super.setupBalloonStatus(param1, param2);
            var _loc_3:* = PlayerPersonal.getRestoreTimeSec(param2.playerData.personal.hp, param2.playerData.personal, param2.playerData.info);
            var _loc_4:* = _loc_3 % 60;
            var _loc_5:* = _loc_3 / 60 % 60;
            var _loc_6:* = _loc_3 / 60 / 60;
            _balloonStatus.setRestoreTime(_loc_6 * 10000 + _loc_5 * 100 + _loc_4);
            return;
        }// end function

        override protected function isEnableBalloonStatus() : Boolean
        {
            return super.isEnableBalloonStatus() && !this._bBedPopup;
        }// end function

        override public function setSelectEnable(param1:Boolean) : void
        {
            this._bBtnEnable = param1;
            if (this._bTutorial)
            {
                param1 = false;
            }
            super.setSelectEnable(param1);
            return;
        }// end function

        public function setTutorialSelectEnable(param1:Boolean) : void
        {
            this._bTutorial = !param1;
            this.setSelectEnable(this._bBtnEnable);
            return;
        }// end function

        public function overlayVisible(param1:Boolean) : void
        {
            this._overlay.visible = param1;
            return;
        }// end function

        public static function loadResource() : void
        {
            loadSoundResourceBase();
            PlayerSimpleStatus.loadResource();
            return;
        }// end function

    }
}
