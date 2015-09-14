package enemy
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;

    public class EnemyBossVagaDaraBg extends Object
    {
        private var _target:EnemyDisplay;
        private var _mc:MovieClip;
        private var _befLabel:String;

        public function EnemyBossVagaDaraBg(param1:DisplayObjectContainer, param2:EnemyDisplay)
        {
            this._target = param2;
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.ENEMY_PATH + this._target.info.swf, "MonsterBgMc");
            var _loc_3:* = this._target.mc.currentLabel;
            this._mc.gotoAndPlay(_loc_3);
            this._befLabel = _loc_3;
            this.updatePosition(this._target.pos);
            param1.addChild(this._mc);
            param1.setChildIndex(this._mc, 0);
            return;
        }// end function

        public function release() : void
        {
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            this._target = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._target == null)
            {
                return;
            }
            var _loc_2:* = this._target.mc.currentLabel;
            if (_loc_2 == this._befLabel)
            {
                return;
            }
            this._mc.gotoAndPlay(_loc_2);
            this._befLabel = _loc_2;
            return;
        }// end function

        public function updatePosition(param1:Point) : void
        {
            this._mc.x = param1.x;
            this._mc.y = param1.y;
            return;
        }// end function

    }
}
