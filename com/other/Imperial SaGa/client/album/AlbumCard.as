package album
{
    import PlayerCard.*;
    import button.*;
    import flash.display.*;
    import player.*;

    public class AlbumCard extends Object
    {
        private var _baseMc:MovieClip;
        private var _button:ButtonBase;
        private var _chara:PlayerDisplay;
        private var _card:PlayerSmallCard;
        private var _playerId:int;

        public function AlbumCard(param1:MovieClip, param2:Function)
        {
            this._baseMc = param1;
            this._button = ButtonManager.getInstance().addButton(this._baseMc, param2);
            this._button.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._chara = new PlayerDisplay(this._baseMc, Constant.UNDECIDED, Constant.UNDECIDED);
            this._chara.mc.x = this._baseMc.charaNull.x;
            this._chara.mc.y = this._baseMc.charaNull.y;
            this.setPlayerId(Constant.UNDECIDED);
            this._card = null;
            return;
        }// end function

        public function release() : void
        {
            if (this._card)
            {
                this._card.release();
            }
            this._card = null;
            if (this._button)
            {
                ButtonManager.getInstance().removeButton(this._button);
            }
            this._button = null;
            if (this._chara)
            {
                this._chara.release();
            }
            this._chara = null;
            this._baseMc = null;
            return;
        }// end function

        public function setPlayerId(param1:int) : void
        {
            this._playerId = param1;
            this._button.setId(this._playerId);
            this._chara.setId(this._playerId, Constant.UNDECIDED);
            this.setUnknown(this._playerId == Constant.UNDECIDED);
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(param1);
            if (this._playerId != Constant.UNDECIDED)
            {
                if (this._card == null)
                {
                    this._card = new PlayerSmallCard(this._baseMc.cardNull);
                }
                this._card.setPlayerId(this._playerId);
                this._card.show();
            }
            else if (this._card)
            {
                this._card.hide();
            }
            return;
        }// end function

        public function setUnknown(param1:Boolean) : void
        {
            if (param1 == true)
            {
                this._playerId = Constant.UNDECIDED;
            }
            this._button.setDisableFlag(param1);
            this._chara.mc.visible = !param1;
            this._button.getMoveClip().gotoAndStop(param1 ? ("unknown") : ("offMouse"));
            return;
        }// end function

        public function setDisableButton(param1:Boolean) : void
        {
            if (this._playerId == Constant.UNDECIDED)
            {
                return;
            }
            if (this._button != null)
            {
                this._button.setDisableFlag(param1);
            }
            return;
        }// end function

        public function offMouseClick() : void
        {
            if (this._playerId == Constant.UNDECIDED)
            {
                return;
            }
            this._button.setMouseOut();
            return;
        }// end function

    }
}
