package herovsdragon.game.hero.hiteffect
{
    import flash.display.*;
    import flash.geom.*;
    import herovsdragon.game.hero.view.*;

    public class HitEffect extends Object
    {
        private var hitEffectBody:HitEffectBody;
        private static var box2dScale:uint;

        public function HitEffect(param1:Sprite, param2:Number, param3:Number, param4:Boolean)
        {
            this.hitEffectBody = new HitEffectBody();
            this.hitEffectBody.x = Math.floor(param2 * box2dScale);
            this.hitEffectBody.y = Math.floor(param3 * box2dScale);
            this.hitEffectBody.scaleY = Math.floor(Math.random() * 2) == 0 ? (1) : (-1);
            param1.addChild(this.hitEffectBody);
            if (param4)
            {
                this.hitEffectBody.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 180, 0, 0, 0);
            }
            return;
        }// end function

        public function removeChild() : void
        {
            this.hitEffectBody.parent.removeChild(this.hitEffectBody);
            return;
        }// end function

        public function run() : Boolean
        {
            this.hitEffectBody.nextFrame();
            return this.hitEffectBody.currentFrame == this.hitEffectBody.totalFrames;
        }// end function

        public static function initializeStatic(param1:uint) : void
        {
            HitEffect.box2dScale = param1;
            return;
        }// end function

    }
}
