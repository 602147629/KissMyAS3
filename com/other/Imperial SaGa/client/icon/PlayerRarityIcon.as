package icon
{
    import flash.display.*;
    import player.*;

    public class PlayerRarityIcon extends Object
    {
        private var _mc:MovieClip;

        public function PlayerRarityIcon(param1:MovieClip, param2:int = 0)
        {
            this._mc = param1;
            this.setRarity(param2);
            return;
        }// end function

        public function get mc() : MovieClip
        {
            return this._mc;
        }// end function

        public function setRarity(param1:int) : void
        {
            this._mc.gotoAndStop(PlayerManager.getInstance().getRarityIconLabel(param1));
            return;
        }// end function

    }
}
