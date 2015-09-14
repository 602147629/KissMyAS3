package quest
{
    import flash.display.*;
    import layer.*;
    import player.*;
    import resource.*;
    import status.*;
    import utility.*;

    public class QuestDividePlayerDisplay extends PlayerDisplay
    {
        private var _setTeamNo:int;
        private var _index:int;
        private var _bChange:Boolean;
        private var _personal:PlayerPersonal;
        private var _miniStatus:PlayerMiniStatus;
        private var _hitTarget:HitTarget;

        public function QuestDividePlayerDisplay(param1:PlayerPersonal, param2:int, param3:Boolean)
        {
            super(null, param1.playerId, param1.uniqueId);
            this._personal = param1;
            this._setTeamNo = param2;
            this._index = 0;
            if (param3)
            {
                this._miniStatus = new PlayerMiniStatus(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", _layer.getLayer(LayerCharacter.CHARACTER), null, false, 0, true);
                this._miniStatus.setInvisible(PlayerMiniStatus.INVISIBLE_FLAG_ALL);
            }
            this._hitTarget = new HitTarget();
            _layer.getLayer(LayerCharacter.CHARACTER).addChild(this._hitTarget.target);
            return;
        }// end function

        public function get setTeamNo() : int
        {
            return this._setTeamNo;
        }// end function

        public function set setTeamNo(param1:int) : void
        {
            this._setTeamNo = param1;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        public function get bChange() : Boolean
        {
            return this._bChange;
        }// end function

        public function set bChange(param1:Boolean) : void
        {
            this._bChange = param1;
            return;
        }// end function

        public function get personal() : PlayerPersonal
        {
            return this._personal;
        }// end function

        public function get hitTarget() : HitTarget
        {
            return this._hitTarget;
        }// end function

        override public function release() : void
        {
            if (this._hitTarget)
            {
                this._hitTarget.release();
            }
            this._hitTarget = null;
            if (this._miniStatus)
            {
                this._miniStatus.release();
            }
            this._miniStatus = null;
            super.release();
            return;
        }// end function

        public function setHitTarget(param1:Number) : void
        {
            this._hitTarget.resetMc(this.mc, param1);
            return;
        }// end function

        override public function setParent(param1:DisplayObjectContainer) : void
        {
            if (_layer.parent != null)
            {
                _layer.parent.removeChild(_layer);
            }
            super.setParent(param1);
            return;
        }// end function

        public function setMiniStatusVisible(param1:Boolean) : void
        {
            if (this._miniStatus)
            {
                if (param1)
                {
                    this._miniStatus.show();
                }
                else
                {
                    this._miniStatus.hide();
                }
            }
            return;
        }// end function

    }
}
