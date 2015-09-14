package formationSkill
{
    import flash.display.*;
    import flash.geom.*;
    import formation.*;
    import resource.*;

    public class FormationSkillNaturesChaosBullet extends Object
    {
        private var _bEnd:Boolean;
        private var _endParent:DisplayObjectContainer;
        private var _baseMc:MovieClip;
        private var _weapon:MovieClip;
        private var _rotateX:Number;
        private var _rotateY:Number;
        private var _pos:Point;
        private var _rotateV:Number;
        private var _bReversal:Boolean;
        private var bX:Boolean;
        private static const ROTATE_MAX:Number = 360;
        private static const ROTATE_VALUE:Number = 8;
        private static const LENGTH_X:Number = 200;
        private static const LENGTH_Y:Number = 180;

        public function FormationSkillNaturesChaosBullet(param1:DisplayObjectContainer, param2:DisplayObjectContainer, param3:int, param4:Boolean = false)
        {
            this._endParent = param2;
            this._baseMc = ResourceManager.getInstance().createMovieClip(FormationSkillNaturesChaos.getResource(), "bullet");
            var _loc_5:* = this._baseMc.getChildByName("weaponNull") as MovieClip;
            var _loc_6:* = FormationManager.getInstance().getWeaponClassName(param3);
            this._weapon = this.createWeapon(_loc_6);
            this._weapon.gotoAndStop(1);
            _loc_5.addChild(this._weapon);
            param1.addChild(this._baseMc);
            this._rotateX = 0;
            this._rotateY = 0;
            this._bEnd = false;
            this._rotateV = ROTATE_VALUE;
            this._bReversal = param4;
            var _loc_7:* = Math.sin(this._rotateY * Math.PI / 180);
            var _loc_8:* = Math.cos(this._rotateX * Math.PI / 180);
            this._pos = new Point();
            this._pos.x = _loc_8 * LENGTH_X;
            this._pos.y = _loc_7 * LENGTH_Y;
            return;
        }// end function

        public function release() : void
        {
            if (this._weapon && this._weapon.parent)
            {
                this._weapon.parent.removeChild(this._weapon);
            }
            this._weapon = null;
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            if (this._baseMc && this._bEnd == false)
            {
                this._rotateX = this._rotateX + this._rotateV;
                if (this._bReversal)
                {
                    this._rotateY = this._rotateY + this._rotateV;
                }
                else
                {
                    this._rotateY = this._rotateY - this._rotateV;
                }
                _loc_2 = Math.cos(this._rotateX * Math.PI / 180);
                _loc_3 = Math.sin(this._rotateY * Math.PI / 180);
                this._baseMc.x = _loc_2 * LENGTH_X - this._pos.x;
                this._baseMc.y = _loc_3 * LENGTH_Y - this._pos.y;
                if (this._rotateX >= ROTATE_MAX / 2 && this.bX == false)
                {
                    this.bX = true;
                    this._baseMc.parent.removeChild(this._baseMc);
                    this._endParent.addChild(this._baseMc);
                }
                if (this._rotateX >= ROTATE_MAX || this._rotateY >= ROTATE_MAX)
                {
                    this._bEnd = true;
                    this._baseMc.visible = false;
                }
            }
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        private function createWeapon(param1:String) : MovieClip
        {
            var _loc_2:* = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Weapons.swf", param1);
            return _loc_2;
        }// end function

    }
}
