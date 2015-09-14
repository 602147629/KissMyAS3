package retire
{
    import flash.display.*;
    import icon.*;
    import player.*;
    import resource.*;

    public class RetirePlayerDisplay extends Object
    {
        private var _mc:MovieClip;
        private var _mcRarity:MovieClip;
        private var _playerDisplay:PlayerDisplay;
        private var _rarityIcon:PlayerRarityIcon;
        private var _bMouseOver:Boolean;

        public function RetirePlayerDisplay(param1:DisplayObjectContainer)
        {
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.RETIRE_PATH + "UI_Retreat.swf", "SelectCharaParts");
            param1.addChild(this._mc);
            var _loc_2:* = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "MiniCharaParts");
            this._mcRarity = _loc_2.setCharaRankMc;
            this._mcRarity.x = 0;
            this._mcRarity.y = 0;
            this._playerDisplay = new PlayerDisplay(this._mc.charaNull, Constant.EMPTY_ID, Constant.EMPTY_ID);
            this._rarityIcon = new PlayerRarityIcon(this._mcRarity);
            this._mc.RankNull.addChild(this._mcRarity);
            this._mcRarity.visible = false;
            this._bMouseOver = false;
            return;
        }// end function

        public function get playerDisplay() : PlayerDisplay
        {
            return this._playerDisplay;
        }// end function

        public function get uniqueId() : int
        {
            return this._playerDisplay.uniqueId;
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
            this._rarityIcon = null;
            if (this._mcRarity && this._mcRarity.parent)
            {
                this._mcRarity.parent.removeChild(this._mcRarity);
            }
            this._mcRarity = null;
            if (this._mc && this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
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
