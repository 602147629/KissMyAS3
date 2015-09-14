package employment
{
    import flash.display.*;
    import icon.*;
    import layer.*;
    import player.*;
    import resource.*;

    public class EmploymentFighterDisplay extends PlayerDisplay
    {
        private var _iconRarity:PlayerRarityIcon;
        private var _bRarity:Boolean;
        public var RarityParent:MovieClip;

        public function EmploymentFighterDisplay(param1:DisplayObjectContainer, param2:int, param3:Boolean = true)
        {
            this._iconRarity = null;
            this._bRarity = param3;
            super(param1, param2, Constant.EMPTY_ID);
            return;
        }// end function

        public function get iconRarity() : PlayerRarityIcon
        {
            return this._iconRarity;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override protected function createResource() : void
        {
            _mc = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonFree.swf", "CharacterMc");
            if (this._bRarity)
            {
                this.RarityParent = _mc.setCharaRankMc;
                this._iconRarity = new PlayerRarityIcon(_mc.setCharaRankMc.RankMc);
            }
            else
            {
                _mc.setCharaRankMc.visible = false;
            }
            _layer.getLayer(LayerCharacter.CHARACTER).addChild(_mc);
            return;
        }// end function

        override public function setAnimation(param1:String) : void
        {
            var _loc_2:* = new RegExp(/([0-9]+)""([0-9]+)/);
            param1 = param1.replace(_loc_2, "");
            super.setAnimation(param1);
            return;
        }// end function

    }
}
