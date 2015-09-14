package effect
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;

    public class EffectCoercionParts extends EffectMc
    {
        public static const RESOURCE_PATH:String = ResourcePath.ENEMY_EFFECT_SWF_PATH + "Effect_Noel_Wave01.swf";

        public function EffectCoercionParts(param1:DisplayObjectContainer)
        {
            super(param1, RESOURCE_PATH, "EffectMc", new Point());
            return;
        }// end function

    }
}
