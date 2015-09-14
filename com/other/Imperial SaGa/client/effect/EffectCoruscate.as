package effect
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;
    import sound.*;

    public class EffectCoruscate extends EffectMc
    {
        private var _frame:int;

        public function EffectCoruscate(param1:DisplayObjectContainer, param2:Point)
        {
            super(param1, ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf", "Hirameki_Efc", param2);
            this._frame = _mcEffect.currentFrame;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            var _loc_2:* = _mcEffect.currentFrame;
            if (_loc_2 == 9 && this._frame < 9)
            {
                SoundManager.getInstance().playSe(SoundId.SE_RS3_OTHER_FLASH);
            }
            this._frame = _loc_2;
            return;
        }// end function

    }
}
