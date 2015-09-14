package utility
{
    import flash.display.*;
    import flash.geom.*;

    public class HitTarget extends Object
    {
        private var _target:Sprite;

        public function HitTarget()
        {
            this._target = new Sprite();
            this._target.mouseEnabled = false;
            this._target.visible = false;
            return;
        }// end function

        public function get target() : Sprite
        {
            return this._target;
        }// end function

        public function release() : void
        {
            if (this._target && this._target.parent)
            {
                this._target.parent.removeChild(this._target);
            }
            this._target = null;
            return;
        }// end function

        public function setPos(param1:Point) : void
        {
            if (this._target.parent)
            {
                param1 = this._target.parent.globalToLocal(param1);
            }
            this._target.x = int(param1.x);
            this._target.y = int(param1.y);
            return;
        }// end function

        public function setSize(param1:Number, param2:Number) : void
        {
            this._target.graphics.clear();
            this._target.graphics.beginFill(16777215);
            this._target.graphics.drawRect(0, 0, int(param1), int(param2));
            this._target.graphics.endFill();
            return;
        }// end function

        public function resetMc(param1:MovieClip, param2:Number = 0) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            if (param1.parent)
            {
                _loc_3 = param1.getRect(param1.parent);
                _loc_4 = param1.parent.localToGlobal(_loc_3.topLeft);
                _loc_5 = _loc_3.width;
                _loc_6 = _loc_3.height;
            }
            else
            {
                _loc_3 = param1.getRect(Main.GetProcess().stage);
                _loc_4 = _loc_3.topLeft;
                _loc_5 = _loc_3.width;
                _loc_6 = _loc_3.height;
            }
            if (param2 > 0 && _loc_5 > param2)
            {
                _loc_7 = (_loc_5 - param2) * 0.5;
                _loc_4.x = _loc_4.x + _loc_7;
                _loc_5 = param2;
            }
            this.setPos(_loc_4);
            this.setSize(_loc_5, _loc_6);
            return;
        }// end function

    }
}
