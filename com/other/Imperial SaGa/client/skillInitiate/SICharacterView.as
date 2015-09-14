package skillInitiate
{
    import flash.display.*;
    import flash.geom.*;
    import icon.*;
    import player.*;
    import resource.*;
    import user.*;

    public class SICharacterView extends Object
    {
        private var _baseMc:MovieClip;
        private var _rarityIcon:PlayerRarityIcon;
        private var _playerDisplay:PlayerDisplay;
        private var _animationMc:MovieClip;

        public function SICharacterView(param1:DisplayObjectContainer)
        {
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_SkillInitiate.swf", "LayoutMiniChara");
            param1.addChild(this._baseMc);
            this._rarityIcon = new PlayerRarityIcon(this._baseMc.setCharaRankMc);
            this._playerDisplay = new PlayerDisplay(param1, Constant.UNDECIDED, Constant.UNDECIDED);
            this._playerDisplay.pos = new Point(this._baseMc.x + this._baseMc.charaNull.x, this._baseMc.y + this._baseMc.charaNull.y);
            this._playerDisplay.mc.x = this._playerDisplay.pos.x;
            this._playerDisplay.mc.y = this._playerDisplay.pos.y;
            this.setFromUniqueId(Constant.UNDECIDED);
            return;
        }// end function

        public function get mc() : MovieClip
        {
            return this._baseMc;
        }// end function

        public function get playerDisplay() : PlayerDisplay
        {
            return this._playerDisplay;
        }// end function

        public function get animationMc() : MovieClip
        {
            return this._animationMc;
        }// end function

        public function release() : void
        {
            this._playerDisplay.release();
            this._rarityIcon = null;
            if (this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            this._playerDisplay.control(param1);
            if (this._animationMc)
            {
                _loc_2 = this._animationMc.transform.matrix;
                _loc_2.tx = 0;
                _loc_2.ty = 0;
                this._playerDisplay.mc.transform.matrix = _loc_2;
                this._playerDisplay.mc.transform.colorTransform = this._animationMc.transform.colorTransform;
            }
            return;
        }// end function

        public function setFromUniqueId(param1:int) : void
        {
            var _loc_2:* = UserDataManager.getInstance().userData;
            var _loc_3:* = _loc_2.getPlayerPersonal(param1);
            this.setFromPlayerPersonal(_loc_3);
            return;
        }// end function

        public function setFromPlayerPersonal(param1:PlayerPersonal) : void
        {
            if (!param1)
            {
                this._playerDisplay.setId(Constant.UNDECIDED, Constant.UNDECIDED);
                this.setRarity(Constant.UNDECIDED);
            }
            else
            {
                this._playerDisplay.setId(param1.playerId, param1.uniqueId);
                this.setRarity(this._playerDisplay.info.rarity);
            }
            this._playerDisplay.mc.transform.matrix = new Matrix();
            this._playerDisplay.mc.transform.colorTransform = new ColorTransform();
            return;
        }// end function

        public function setSelect(param1:int) : void
        {
            this._playerDisplay.setSelect(this._playerDisplay.uniqueId != Constant.UNDECIDED && param1 == this._playerDisplay.uniqueId);
            return;
        }// end function

        public function setPosition(param1:Point) : void
        {
            this._baseMc.x = param1.x;
            this._baseMc.y = param1.y;
            return;
        }// end function

        public function setPositionFromMc(param1:MovieClip) : void
        {
            this._baseMc.x = param1.x;
            this._baseMc.y = param1.y;
            return;
        }// end function

        public function getPosition() : Point
        {
            return new Point(this._baseMc.x, this._baseMc.y);
        }// end function

        public function getCharaPosition() : Point
        {
            return new Point(this._baseMc.x + this._baseMc.charaNull.x, this._baseMc.y + this._baseMc.charaNull.y);
        }// end function

        private function setRarity(param1:int) : void
        {
            this._baseMc.setCharaRankMc.visible = param1 != Constant.UNDECIDED;
            if (param1 == Constant.UNDECIDED)
            {
                return;
            }
            this._rarityIcon.setRarity(param1);
            return;
        }// end function

        public function setAnimationMc(param1:MovieClip) : void
        {
            this._animationMc = param1;
            return;
        }// end function

    }
}
