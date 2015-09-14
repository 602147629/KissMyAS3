package movie
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import message.*;
    import popup.*;
    import sound.*;
    import utility.*;

    public class CommonMovieUi extends Object
    {
        private const _PHASE_PLAY:int = 1;
        private const _PHASE_PAUSE:int = 2;
        private const _PHASE_CLOSE:int = 3;
        private var _backScreen:ColorScreen;
        private var _baseMc:MovieClip;
        private var _movie:MovieClip;
        private var _skipButton:ButtonBase;
        private var _skipClickLayer:Sprite;
        private var _phase:int;
        private var _isPause:Boolean;
        private var _btnEnable:Boolean;

        public function CommonMovieUi(param1:DisplayObjectContainer, param2:MovieClip, param3:MovieClip, param4:Boolean = true)
        {
            this._backScreen = new ColorScreen(param1);
            this._baseMc = param2;
            this._movie = param3;
            if (param4)
            {
                this._baseMc.skipMc.visible = false;
                this._skipClickLayer = new Sprite();
                this._skipClickLayer.x = 0;
                this._skipClickLayer.y = 0;
                this._skipClickLayer.graphics.beginFill(16777215, 0);
                this._skipClickLayer.graphics.drawRect(0, 0, Constant.SCREEN_WIDTH, Constant.SCREEN_HEIGHT);
                this._skipClickLayer.graphics.endFill();
                this._skipClickLayer.addEventListener(MouseEvent.CLICK, this.cbClick);
            }
            else
            {
                this._baseMc.skipMc.visible = false;
            }
            this.setBtnEnable(false);
            param1.addChild(this._baseMc);
            this._baseMc.movieNull.addChild(this._movie);
            if (this._skipClickLayer)
            {
                this._baseMc.movieNull.addChild(this._skipClickLayer);
            }
            this._baseMc.visible = true;
            this._isPause = false;
            this.setPhase(this._PHASE_PLAY);
            return;
        }// end function

        public function release() : void
        {
            if (this._skipClickLayer)
            {
                if (this._skipClickLayer.hasEventListener(MouseEvent.CLICK))
                {
                    this._skipClickLayer.removeEventListener(MouseEvent.CLICK, this.cbClick);
                }
                this._skipClickLayer.parent.removeChild(this._skipClickLayer);
                this._skipClickLayer = null;
            }
            if (this._skipButton)
            {
                ButtonManager.getInstance().removeButton(this._skipButton);
            }
            this._skipButton = null;
            if (this._movie && this._movie.parent)
            {
                this._movie.parent.removeChild(this._movie);
            }
            this._movie = null;
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            if (this._backScreen)
            {
                this._backScreen.release();
            }
            this._backScreen = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_PLAY:
                {
                    this.controlPlay(param1);
                    break;
                }
                case this._PHASE_PAUSE:
                {
                    this.controlPause();
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
                    case this._PHASE_PLAY:
                    {
                        this.phasePlay();
                        break;
                    }
                    case this._PHASE_PAUSE:
                    {
                        this.phasePause();
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

        private function phasePlay() : void
        {
            this.mcAllPlay(this._movie);
            if (this._isPause)
            {
                SoundManager.getInstance().resumeBgm();
            }
            this.setBtnEnable(true);
            this._isPause = false;
            return;
        }// end function

        private function controlPlay(param1:Number) : void
        {
            if (this._movie.currentFrame >= this._movie.totalFrames)
            {
                this._movie.stop();
                this.setPhase(this._PHASE_CLOSE);
            }
            return;
        }// end function

        private function phasePause() : void
        {
            this.setBtnEnable(false);
            this._isPause = true;
            this.mcAllStop(this._movie);
            SoundManager.getInstance().pauseBgm();
            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.ENDING_SKIP_POPUP), this.cbCheckSkip);
            return;
        }// end function

        private function controlPause() : void
        {
            return;
        }// end function

        private function phaseClose() : void
        {
            this.setBtnEnable(false);
            this._baseMc.visible = false;
            this._isPause = false;
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function cbClick(param1:int) : void
        {
            if (this._btnEnable)
            {
                this.setPhase(this._PHASE_PAUSE);
            }
            return;
        }// end function

        private function cbCheckSkip(param1:Boolean) : void
        {
            if (param1)
            {
                this._movie.gotoAndStop(this._movie.totalFrames);
                this.setPhase(this._PHASE_CLOSE);
            }
            else
            {
                this.setPhase(this._PHASE_PLAY);
            }
            return;
        }// end function

        private function mcAllStop(param1:Object) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (param1 is MovieClip)
            {
                param1.stop();
                _loc_2 = param1.numChildren;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    this.mcAllStop(param1.getChildAt(_loc_3));
                    _loc_3++;
                }
            }
            return;
        }// end function

        private function mcAllPlay(param1:Object) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (param1 is MovieClip)
            {
                param1.play();
                _loc_2 = param1.numChildren;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    this.mcAllPlay(param1.getChildAt(_loc_3));
                    _loc_3++;
                }
            }
            return;
        }// end function

        private function setBtnEnable(param1:Boolean) : void
        {
            this._btnEnable = param1;
            if (this._skipButton)
            {
                this._skipButton.setDisable(!param1);
            }
            return;
        }// end function

    }
}
