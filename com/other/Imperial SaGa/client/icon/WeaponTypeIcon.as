package icon
{
    import flash.display.*;
    import player.*;

    public class WeaponTypeIcon extends Object
    {
        private var _mc:MovieClip;

        public function WeaponTypeIcon(param1:MovieClip, param2:int = 1)
        {
            this._mc = param1;
            this.setWeaponType(param2);
            return;
        }// end function

        public function setWeaponType(param1:int) : void
        {
            var _loc_2:* = PlayerManager.getInstance().getWeaponType((param1 - 1));
            this._mc.gotoAndStop(_loc_2);
            return;
        }// end function

    }
}
