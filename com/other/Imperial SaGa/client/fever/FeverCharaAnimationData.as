package fever
{
    import flash.display.*;
    import player.*;

    public class FeverCharaAnimationData extends Object
    {
        private var _playerDisplay:PlayerDisplay;
        private var _animationMc:MovieClip;
        private var _aWeaponMc:Array;

        public function FeverCharaAnimationData(param1:PlayerDisplay)
        {
            this._playerDisplay = param1;
            this._aWeaponMc = [];
            return;
        }// end function

        public function get playerDisplay() : PlayerDisplay
        {
            return this._playerDisplay;
        }// end function

        public function get animationMc() : MovieClip
        {
            return this._animationMc;
        }// end function

        public function set animationMc(param1:MovieClip) : void
        {
            this._animationMc = param1;
            return;
        }// end function

        public function release() : void
        {
            this.releaseAnimationMc();
            if (this._playerDisplay && this._playerDisplay.uniqueId == Constant.EMPTY_ID)
            {
                this._playerDisplay.release();
            }
            return;
        }// end function

        public function setWeapon(param1:MovieClip) : void
        {
            if (this._animationMc == null)
            {
                return;
            }
            if (this._animationMc.weaponNull)
            {
                param1.gotoAndStop(1);
                this._animationMc.weaponNull.addChild(param1);
                if (this._aWeaponMc)
                {
                    this._aWeaponMc.push(param1);
                }
            }
            return;
        }// end function

        public function addSetWeapon(param1:MovieClip, param2:MovieClip) : void
        {
            if (param1 == null)
            {
                return;
            }
            if (param1)
            {
                param1.addChild(param2);
                if (this._aWeaponMc)
                {
                    this._aWeaponMc.push(param2);
                }
            }
            return;
        }// end function

        public function releaseAnimationMc() : void
        {
            var _loc_1:* = null;
            if (this._aWeaponMc)
            {
                for each (_loc_1 in this._aWeaponMc)
                {
                    
                    if (_loc_1)
                    {
                        _loc_1.parent.removeChild(_loc_1);
                        _loc_1 = null;
                    }
                }
                this._aWeaponMc = [];
            }
            if (this._animationMc && this._animationMc.parent)
            {
                this._animationMc.parent.removeChild(this._animationMc);
                this._animationMc = null;
            }
            return;
        }// end function

    }
}
