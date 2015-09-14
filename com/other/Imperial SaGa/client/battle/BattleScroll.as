package battle
{
    import flash.geom.*;
    import formation.*;
    import player.*;
    import sound.*;

    public class BattleScroll extends Object
    {
        private var _battleManager:BattleManager;
        private var _formationData:FormationData;
        private var _cam:BattleCamera;
        private var _scrollMode:int;
        private var _bBusy:Boolean;
        public static const SCROLL_NOMAL:int = 0;
        public static const SCROLL_COMMANDER_FOCUS:int = 1;

        public function BattleScroll(param1:BattleManager, param2:FormationData, param3:BattleCamera)
        {
            this._battleManager = param1;
            this._formationData = param2;
            this._cam = param3;
            this._scrollMode = SCROLL_NOMAL;
            this._bBusy = false;
            return;
        }// end function

        public function isScroll(param1:int) : Boolean
        {
            return this._scrollMode == param1;
        }// end function

        public function isBusy() : Boolean
        {
            return this._bBusy;
        }// end function

        public function release() : void
        {
            this._cam = null;
            this._formationData = null;
            this._battleManager = null;
            return;
        }// end function

        public function control() : void
        {
            var _loc_1:* = null;
            if (this._bBusy)
            {
                if (this._cam.isMoveEnd == false)
                {
                    return;
                }
                _loc_1 = this._battleManager.commanderPlayer;
                if (_loc_1)
                {
                    if ((_loc_1.characterAction.characterDisplay as PlayerDisplay).bMoveing)
                    {
                        return;
                    }
                    SoundManager.getInstance().playSe(SoundId.SE_LANDING1016B);
                }
                this._bBusy = false;
            }
            return;
        }// end function

        public function changeScroll(param1:int) : void
        {
            var _loc_2:* = null;
            if (this._scrollMode != param1)
            {
                this._scrollMode = param1;
                if (this._scrollMode == SCROLL_COMMANDER_FOCUS)
                {
                    _loc_2 = this.getCommanderCameraPosition();
                    this._cam.moveCamera(_loc_2, 1, 0.2);
                }
                else
                {
                    this._cam.moveDefaultCamera(0.2);
                }
                this.setCommanderTargetPosition(this._battleManager.commanderPlayer);
                this._bBusy = true;
            }
            return;
        }// end function

        public function setCommanderTargetPosition(param1:BattlePlayer, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            if (param1)
            {
                if (this._scrollMode == SCROLL_COMMANDER_FOCUS)
                {
                    _loc_3 = this._formationData.getCommanderPosition();
                }
                else
                {
                    _loc_3 = this._formationData.getCommanderOutPosition();
                }
                if (param1.playerPersonal.bDead)
                {
                    (param1.characterAction.characterDisplay as PlayerDisplay).setTargetPoint(_loc_3, 0);
                }
                else
                {
                    (param1.characterAction.characterDisplay as PlayerDisplay).setTargetJump(_loc_3);
                    if (param2)
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_JUMP2);
                    }
                }
            }
            return;
        }// end function

        public function getCommanderPosition() : Point
        {
            if (this._scrollMode == SCROLL_COMMANDER_FOCUS)
            {
                return this._formationData.getCommanderPosition();
            }
            return this._formationData.getCommanderOutPosition();
        }// end function

        public function getCommanderCameraPosition() : Point
        {
            var _loc_1:* = BattleCamera.getDefaultPosition();
            _loc_1.x = (_loc_1.x + this.getCommanderPosition().x) * 0.5;
            return _loc_1;
        }// end function

    }
}
