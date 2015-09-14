package employment
{
    import flash.display.*;
    import icon.*;
    import layer.*;
    import player.*;
    import resource.*;

    public class EmploymentRunnerDisplay extends PlayerDisplay
    {
        private var _iconRarity:PlayerRarityIcon;
        private var _bRarity:Boolean;
        public static const LABEL_WIN_POSE:String = "winPose";

        public function EmploymentRunnerDisplay(param1:DisplayObjectContainer, param2:int, param3:Boolean = true)
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

        override protected function createResource() : void
        {
            _mc = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonProduction.swf", "CharacterMc");
            if (this._bRarity)
            {
                this._iconRarity = new PlayerRarityIcon(_mc.setCharaRankMc);
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

        override protected function get labelJump() : String
        {
            return "jumpShort";
        }// end function

    }
}
