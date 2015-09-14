package magicLaboratory
{
    import button.*;
    import flash.display.*;
    import message.*;
    import resource.*;
    import skill.*;
    import sound.*;
    import utility.*;

    public class MagicDevelopResult extends MagicDevelopBase
    {
        private var _fade:Fade;

        public function MagicDevelopResult(param1:DisplayObjectContainer, param2:int)
        {
            this._fade = new Fade(param1, 0.5);
            this._fade.setFadeOut(Constant.FADE_OUT_TIME);
            var _loc_3:* = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_MagicLaboratory.swf", "DevelopMagicResultMc");
            super(_loc_3, true);
            var _loc_4:* = SkillManager.getInstance().getSkillInformation(param2);
            TextControl.setText(_mc.resultInfoMc.skillMc.skillNameMc.textDt, _loc_4.name, true);
            var _loc_5:* = SkillManager.getInstance().getMagicTypeLabel(_loc_4.skillType);
            _loc_3.resultInfoMc.skillMc.attributeTypeMc.gotoAndStop(_loc_5);
            var _loc_6:* = ButtonManager.getInstance().addButton(_mc.nextBtnMc, this.cbResultClick);
            ButtonManager.getInstance().addButton(_mc.nextBtnMc, this.cbResultClick).enterSeId = ButtonBase.SE_DECIDE_ID;
            _aButton.push(_loc_6);
            TextControl.setIdText(_mc.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_OK);
            TextControl.setIdText(_mc.resultInfoMc.textMc.textDt, MessageId.MAGIC_DEVELOP_INFO_SUCCESS, true);
            SoundManager.getInstance().playSe(SoundId.SE_COMPOSE_SUCSESS);
            param1.addChild(_loc_3);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            this._fade.control(param1);
            return;
        }// end function

        public function cbResultClick(param1:int) : void
        {
            this._fade.setFadeIn(Constant.FADE_IN_TIME);
            close();
            return;
        }// end function

    }
}
