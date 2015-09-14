package quest
{
    import flash.display.*;
    import flash.geom.*;
    import player.*;

    public class QuestPiecePlayer extends QuestSprite
    {
        private var _playerId:int;
        private var _playerDisplay:PlayerDisplay;
        private var _bMoveing:Boolean;
        private var _bVanish:Boolean;
        private var _bArrival:Boolean;

        public function QuestPiecePlayer(param1:DisplayObjectContainer, param2:int)
        {
            super(QuestConstant.PIECE_PRIORITY_PLAYER, 0);
            param1.addChild(this);
            this._bVanish = false;
            this._playerId = param2;
            this._playerDisplay = new PlayerDisplay(this, param2, Constant.UNDECIDED);
            this._playerDisplay.layer.scaleX = 1.5;
            this._playerDisplay.layer.scaleY = 1.5;
            this.setAnimation(PlayerDisplay.LABEL_SIDE_WALK);
            return;
        }// end function

        public function get playerId() : int
        {
            return this._playerId;
        }// end function

        public function get bMoveing() : Boolean
        {
            return this._bMoveing;
        }// end function

        public function get bVanish() : Boolean
        {
            return this._bVanish == true && this.alpha == 0;
        }// end function

        public function get bArrival() : Boolean
        {
            return this._bArrival;
        }// end function

        public function set bArrival(param1:Boolean) : void
        {
            this._bArrival = param1;
            return;
        }// end function

        public function getPosition() : Point
        {
            var _loc_1:* = this._playerDisplay.pos;
            _loc_1.x = _loc_1.x + this.x;
            _loc_1.y = _loc_1.y + this.y;
            return _loc_1;
        }// end function

        public function release() : void
        {
            if (this._playerDisplay != null)
            {
                this._playerDisplay.release();
            }
            this._playerDisplay = null;
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            if (this._playerDisplay)
            {
                this._playerDisplay.control(param1);
            }
            if (this._bMoveing)
            {
                if (this._playerDisplay.bMoveing == false)
                {
                    _loc_2 = this._playerDisplay.pos;
                    this.x = this.x + _loc_2.x;
                    this.y = this.y + _loc_2.y;
                    this._playerDisplay.pos = new Point();
                    this._bMoveing = false;
                    this._bArrival = true;
                    this.setAnimation(PlayerDisplay.LABEL_SIDE_STOP);
                }
            }
            if (this._bVanish)
            {
                if (this._bVanish && this.alpha > 0)
                {
                    _loc_3 = this.alpha;
                    _loc_3 = _loc_3 - 0.05;
                    if (_loc_3 < 0)
                    {
                        _loc_3 = 0;
                    }
                    this.alpha = _loc_3;
                    if (this.alpha == 0)
                    {
                        this.visible = false;
                    }
                }
            }
            return;
        }// end function

        public function setMovePos(param1:int, param2:int) : void
        {
            var _loc_3:* = new Point(param1 - this.x, param2 - this.y);
            this.setReverse(_loc_3.x > 0);
            this.setAnimation(PlayerDisplay.LABEL_SIDE_WALK);
            if (this._playerDisplay != null)
            {
                this._playerDisplay.setTargetPoint(_loc_3, 1 / 1.5);
            }
            this._bMoveing = true;
            return;
        }// end function

        public function setPos(param1:int, param2:int) : void
        {
            this.x = param1;
            this.y = param2;
            this.setAnimation(PlayerDisplay.LABEL_SIDE_STOP);
            return;
        }// end function

        public function setReverse(param1:Boolean) : void
        {
            if (this._playerDisplay != null)
            {
                this._playerDisplay.setReverse(param1);
            }
            return;
        }// end function

        public function setVanish() : void
        {
            this._bVanish = true;
            return;
        }// end function

        public function setAnimation(param1:String) : void
        {
            if (this._playerDisplay != null)
            {
                this._playerDisplay.setAnimation(param1);
            }
            return;
        }// end function

    }
}
