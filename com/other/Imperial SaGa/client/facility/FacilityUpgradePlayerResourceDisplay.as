package facility
{
    import flash.display.*;
    import icon.*;
    import player.*;

    public class FacilityUpgradePlayerResourceDisplay extends Object
    {
        private var _mc:MovieClip;
        private var _mcRarity:MovieClip;
        private var _playerDisplay:PlayerDisplay;
        private var _rarityIcon:PlayerRarityIcon;
        private var _bMouseOver:Boolean;

        public function FacilityUpgradePlayerResourceDisplay(param1:DisplayObjectContainer, param2:MovieClip)
        {
            this._mc = param2;
            this._mcRarity = param2.setCharaRankMc;
            param1.addChild(this._mc);
            this._playerDisplay = new PlayerDisplay(this._mc.charaNull, Constant.EMPTY_ID, Constant.EMPTY_ID);
            this._rarityIcon = new PlayerRarityIcon(this._mcRarity);
            this._mcRarity.visible = false;
            this._bMouseOver = false;
            return;
        }// end function

        public function get playerDisplay() : PlayerDisplay
        {
            return this._playerDisplay;
        }// end function

        public function get bShow() : Boolean
        {
            return this._mcRarity.visible;
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
            if (this._playerDisplay)
            {
                this._playerDisplay.release();
            }
            this._playerDisplay = null;
            return;
        }// end function

        public function setPlayer(param1:int, param2:int, param3:int) : void
        {
            this._playerDisplay.setId(param1, param2);
            this._rarityIcon.setRarity(param3);
            this._mcRarity.visible = true;
            return;
        }// end function

        public function play() : void
        {
            if (this._playerDisplay.uniqueId != Constant.EMPTY_ID)
            {
                this._mc.gotoAndPlay("disappear");
            }
            return;
        }// end function

        public function reset() : void
        {
            this._mc.gotoAndStop("stop");
            this._playerDisplay.setSelect(false);
            this._playerDisplay.setId(Constant.EMPTY_ID, Constant.EMPTY_ID);
            this._mcRarity.visible = false;
            this._bMouseOver = false;
            return;
        }// end function

    }
}
