package formationSettings
{
    import layer.*;
    import player.*;
    import playerList.*;
    import resource.*;
    import status.*;

    public class FormationPlayerDisplay extends Object
    {
        private var _playerPersonal:PlayerPersonal;
        private var _playerActionController:ListPlayerActionController;
        private var _status:PlayerMiniStatus;
        private var _formationMark:FormationNumberMark;
        private var _statusUpDownIcon:FormationStatusUpDown;
        private var _bMouseOver:Boolean;

        public function FormationPlayerDisplay(param1:LayerFormationSettings, param2:int, param3:int, param4:PlayerPersonal = null)
        {
            this._playerPersonal = param4;
            this._status = new PlayerMiniStatus(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", param1.getLayer(LayerFormationSettings.PLAYER));
            this._formationMark = new FormationNumberMark(param1.getLayer(LayerFormationSettings.FORMATION_NUMBER_MARK), param2);
            this._statusUpDownIcon = new FormationStatusUpDown(param1.getLayer(LayerFormationSettings.FORMATION_EFFECT_MARK), param2, param3, this._playerPersonal ? (this._playerPersonal.playerId) : (Constant.EMPTY_ID));
            this._playerActionController = new ListPlayerActionController(new PlayerDisplay(this._status.charaNull, this._playerPersonal ? (this._playerPersonal.playerId) : (Constant.EMPTY_ID), this._playerPersonal ? (this._playerPersonal.uniqueId) : (Constant.EMPTY_ID)));
            this._bMouseOver = false;
            return;
        }// end function

        public function get playerPersonal() : PlayerPersonal
        {
            return this._playerPersonal;
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

        public function get formationMark() : FormationNumberMark
        {
            return this._formationMark;
        }// end function

        public function get statusUpDownIcon() : FormationStatusUpDown
        {
            return this._statusUpDownIcon;
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

        public function setPlayerPersonal(param1:PlayerPersonal) : void
        {
            this._playerPersonal = param1;
            this._playerActionController.setPlayerPersonal(this._playerPersonal);
            this._statusUpDownIcon.setPlayerId(this._playerPersonal ? (this._playerPersonal.playerId) : (Constant.EMPTY_ID));
            return;
        }// end function

        public function setFormationBonusOccurrence(param1:Boolean) : void
        {
            this._statusUpDownIcon.setFormationBonusOccurrence(param1);
            return;
        }// end function

        public function release() : void
        {
            this._playerPersonal = null;
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
            if (this._formationMark)
            {
                this._formationMark.release();
            }
            this._formationMark = null;
            if (this._statusUpDownIcon)
            {
                this._statusUpDownIcon.release();
            }
            this._statusUpDownIcon = null;
            return;
        }// end function

        public function setPosition(param1:int, param2:int) : void
        {
            if (this._status)
            {
                this._status.setPosition(param1, param2);
            }
            if (this._formationMark)
            {
                this._formationMark.setPosition(param1, param2);
            }
            if (this._statusUpDownIcon)
            {
                this._statusUpDownIcon.setPosition(param1, param2);
            }
            return;
        }// end function

    }
}
