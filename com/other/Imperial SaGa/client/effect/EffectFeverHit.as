package effect
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;
    import sound.*;

    public class EffectFeverHit extends EffectBase
    {

        public function EffectFeverHit(param1:DisplayObjectContainer, param2:Point, param3:Boolean)
        {
            var _loc_4:* = ResourceManager.getInstance().createMovieClip(getResourcePath(), "feverHit");
            if (param3)
            {
                SoundManager.getInstance().playSe(SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK, 0.5);
            }
            super(param1, _loc_4, param2);
            return;
        }// end function

        override public function isEnd() : Boolean
        {
            if (_mcEffect.currentFrame >= _mcEffect.totalFrames)
            {
                return true;
            }
            return false;
        }// end function

        public static function getResourcePath() : String
        {
            return ResourcePath.BATTLE_PATH + "FeverHit.swf";
        }// end function

        public static function getSeId() : Array
        {
            return [SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK];
        }// end function

    }
}
