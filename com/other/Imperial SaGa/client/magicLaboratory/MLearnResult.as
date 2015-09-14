package magicLaboratory
{
    import button.*;
    import flash.display.*;
    import message.*;
    import player.*;
    import resource.*;
    import skill.*;
    import sound.*;
    import user.*;
    import utility.*;

    public class MLearnResult extends Object
    {
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_WAIT:int = 10;
        private const _PHASE_CLOSE:int = 99;
        private var _phase:int;
        private var _baseMcGetMagic:MovieClip;
        private var _isoBase:InStayOut;
        private var _closeBtn:ButtonBase;
        private var _playerDisplay:PlayerDisplay;
        private var _fade:Fade;

        public function MLearnResult(param1:DisplayObjectContainer)
        {
            this._fade = new Fade(param1, 0.5);
            ButtonManager.getInstance().push();
            this._baseMcGetMagic = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_MagicLaboratory.swf", "LearningMagicFinishMc");
            param1.addChild(this._baseMcGetMagic);
            this._isoBase = new InStayOut(this._baseMcGetMagic);
            this._closeBtn = ButtonManager.getInstance().addButton(this._baseMcGetMagic.nextBtnMc, this.cbClose);
            this._closeBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._baseMcGetMagic.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_OK);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoBase.bClosed;
        }// end function

        public function release() : void
        {
            if (this._isoBase)
            {
                this._isoBase.release();
            }
            this._isoBase = null;
            if (this._closeBtn)
            {
                ButtonManager.getInstance().removeButton(this._closeBtn);
            }
            this._closeBtn = null;
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            if (this._playerDisplay)
            {
                this._playerDisplay.release();
            }
            this._playerDisplay = null;
            if (this._baseMcGetMagic.parent)
            {
                this._baseMcGetMagic.parent.removeChild(this._baseMcGetMagic);
            }
            this._baseMcGetMagic = null;
            ButtonManager.getInstance().pop();
            return;
        }// end function

        public function control(param1:Number) : void
        {
            this._fade.control(param1);
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.controlWait();
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_WAIT:
                    {
                        this.phaseWait();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function open() : void
        {
            if (this._isoBase.bClosed)
            {
                this.setPhase(this._PHASE_OPEN);
            }
            return;
        }// end function

        public function close() : void
        {
            if (this._isoBase.bOpened)
            {
                this.setPhase(this._PHASE_CLOSE);
            }
            return;
        }// end function

        public function setData(param1:int, param2:int) : void
        {
            this._baseMcGetMagic.larningFinishBGMc.learningBGMc.gotoAndPlay("start");
            var _loc_3:* = UserDataManager.getInstance().userData.getPlayerPersonal(param1);
            if (_loc_3)
            {
                this._playerDisplay = new PlayerDisplay(this._baseMcGetMagic.larningFinishBGMc.charaNull, _loc_3.playerId, param1);
                this._playerDisplay.setAnimation(PlayerDisplay.LABEL_ACTION_SELECT_MAGIC);
            }
            var _loc_4:* = SkillManager.getInstance().getSkillInformation(param2);
            if (SkillManager.getInstance().getSkillInformation(param2))
            {
                TextControl.setText(this._baseMcGetMagic.resultInfoMc.skillMc.skillNameMc.textDt, _loc_4.name);
                this._baseMcGetMagic.resultInfoMc.skillMc.attributeTypeMc.gotoAndStop(SkillManager.getInstance().getMagicTypeLabel(_loc_4.skillType));
                this._baseMcGetMagic.resultInfoMc.skillMc.skillBgMc.gotoAndStop(SkillManager.getInstance().getMagicTypeLabel(_loc_4.skillType));
            }
            else
            {
                TextControl.setText(this._baseMcGetMagic.resultInfoMc.skillMc.skillNameMc.textDt, "");
            }
            TextControl.setIdText(this._baseMcGetMagic.resultInfoMc.textMc.textDt, MessageId.MAGIC_LEARN_CAPTION_MESSAGE_SUCCESS);
            return;
        }// end function

        private function phaseOpen() : void
        {
            SoundManager.getInstance().playSe(SoundId.SE_COMPOSE_SUCSESS);
            this._closeBtn.setDisable(true);
            this._isoBase.setIn();
            this._fade.setFadeOut(Constant.FADE_OUT_TIME);
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoBase.bOpened)
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseWait() : void
        {
            return;
        }// end function

        private function controlWait() : void
        {
            if (this._baseMcGetMagic.larningFinishBGMc.learningBGMc.currentFrame == 40)
            {
                this._playerDisplay.setAnimation(PlayerDisplay.LABEL_WIN);
            }
            if (this._baseMcGetMagic.larningFinishBGMc.learningBGMc.currentFrame > 45 && this._playerDisplay.bAnimationEnd)
            {
                if (this._closeBtn.getDisableFlag())
                {
                    this._closeBtn.setDisable(false);
                }
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._isoBase.setOut();
            this._fade.setFadeIn(Constant.FADE_IN_TIME);
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function cbClose(param1:int) : void
        {
            this.close();
            return;
        }// end function

    }
}
