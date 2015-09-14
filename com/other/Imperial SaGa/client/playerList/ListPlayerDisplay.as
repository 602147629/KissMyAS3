package playerList
{
    import player.*;
    import status.*;

    public class ListPlayerDisplay extends Object
    {
        private var _playerData:ListPlayerData;
        private var _playerActionController:ListPlayerActionController;
        private var _status:PlayerMiniStatus;
        private var _bShow:Boolean;
        private var _bMouseOver:Boolean;

        public function ListPlayerDisplay(param1:PlayerMiniStatus)
        {
            this._playerData = null;
            this._status = param1;
            this._playerActionController = new ListPlayerActionController(new PlayerDisplay(this._status.charaNull, Constant.EMPTY_ID, Constant.EMPTY_ID));
            this._bMouseOver = false;
            this._bShow = false;
            return;
        }// end function

        public function get playerData() : ListPlayerData
        {
            return this._playerData;
        }// end function

        public function get playerActionController() : ListPlayerActionController
        {
            return this._playerActionController;
        }// end function

        public function get playerDisplay() : PlayerDisplay
        {
            return this._playerActionController.playerDisplay;
        }// end function

        public function get status() : PlayerMiniStatus
        {
            return this._status;
        }// end function

        public function get bShow() : Boolean
        {
            return this._bShow;
        }// end function

        public function get bMouseOver() : Boolean
        {
            return this._bMouseOver;
        }// end function

        public function set bMouseOver(param1:Boolean) : void
        {
            this._bMouseOver = param1;
            return;
        }// end function

        public function release() : void
        {
            this._playerData = null;
            if (this._playerActionController.playerDisplay)
            {
                this._playerActionController.playerDisplay.release();
            }
            if (this._playerActionController)
            {
                this._playerActionController.release();
            }
            this._playerActionController = null;
            if (this._status)
            {
                this._status.release();
            }
            this._status = null;
            return;
        }// end function

        public function setPlayerData(param1:ListPlayerData) : void
        {
            this._playerData = param1;
            if (this._playerData.personal)
            {
                this._playerActionController.setPlayerPersonal(this._playerData.personal);
            }
            else
            {
                this._playerActionController.setPlayerId(this._playerData.info.id);
            }
            this._status.show();
            if (this._playerData.personal)
            {
                this._status.setPlayerPersonal(this._playerData.personal);
            }
            else
            {
                this._status.setPlayerId(this._playerData.info.id);
            }
            this.show();
            return;
        }// end function

        public function reset() : void
        {
            this._playerData = null;
            this._playerActionController.setPlayerPersonal(null);
            this._status.hide();
            this.hide();
            return;
        }// end function

        public function show() : void
        {
            if (this._playerActionController.bEnable == false)
            {
                return;
            }
            this._bShow = true;
            this._status.mcBase.parent.visible = true;
            return;
        }// end function

        public function hide() : void
        {
            this._bShow = false;
            this._status.mcBase.parent.visible = false;
            return;
        }// end function

        public function setPosition(param1:int, param2:int) : void
        {
            if (this._status)
            {
                this._status.setPosition(param1, param2);
            }
            return;
        }// end function

    }
}
