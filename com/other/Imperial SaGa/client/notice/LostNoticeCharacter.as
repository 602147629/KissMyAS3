package notice
{
    import character.*;
    import flash.display.*;
    import flash.geom.*;
    import icon.*;
    import message.*;
    import player.*;
    import resource.*;
    import utility.*;

    public class LostNoticeCharacter extends Object
    {
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_FADE_IN:int = 10;
        private const _PHASE_FADE_GRAY:int = 20;
        private const _PHASE_CLOSE:int = 99;
        private const _CARD_FADEIN_TIME:Number = 1;
        private const _CARD_GRAY_TIME:Number = 1;
        private var _phase:int;
        private var _waitTime:Number;
        private var _mc:MovieClip;
        private var _playerDisp:PlayerDisplay;
        private var _card:Bitmap;
        private var _cardMc:MovieClip;
        private var _bEndGrayScale:Boolean;

        public function LostNoticeCharacter(param1:MovieClip, param2:PlayerLostData)
        {
            this._mc = param1;
            this._playerDisp = new PlayerDisplay(this._mc.charaNull, param2.playerId, param2.uniqueId);
            this._playerDisp.setAnimCrouch();
            this._playerDisp.bGrayScale = true;
            this._playerDisp.control(1);
            TextControl.setText(this._mc.charaNameMc.textDt, this._playerDisp.info.name);
            var _loc_3:* = new PlayerRarityIcon(this._mc.charaRankMc, this._playerDisp.info.rarity);
            this._card = ResourceManager.getInstance().createBitmap(ResourcePath.CARD_SMALL_PATH + CharacterConstant.ID_CARD + this._playerDisp.info.cardFileName);
            var _loc_4:* = new Matrix();
            new Matrix().translate((-this._card.width) / 2, (-this._card.height) / 2);
            this._card.transform.matrix = _loc_4;
            this._cardMc = this._mc.cardNull;
            this._cardMc.alpha = 0;
            this._cardMc.addChild(this._card);
            this._bEndGrayScale = false;
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        public function get bEndGrayScale() : Boolean
        {
            return this._bEndGrayScale;
        }// end function

        public function release() : void
        {
            if (this._card.parent)
            {
                this._card.parent.removeChild(this._card);
            }
            this._cardMc = null;
            this._card = null;
            this._playerDisp = null;
            this._mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_FADE_IN:
                {
                    this.controlFadeIn(param1);
                    break;
                }
                case this._PHASE_FADE_GRAY:
                {
                    this.controlFadeGray(param1);
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
                    case this._PHASE_FADE_IN:
                    {
                        this.phaseFadeIn();
                        break;
                    }
                    case this._PHASE_FADE_GRAY:
                    {
                        this.phaseFadeGray();
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

        public function startFade() : void
        {
            if (this._phase == this._PHASE_OPEN)
            {
                this.setPhase(this._PHASE_FADE_IN);
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            return;
        }// end function

        private function controlOpen() : void
        {
            return;
        }// end function

        private function phaseFadeIn() : void
        {
            this._waitTime = 0;
            return;
        }// end function

        private function controlFadeIn(param1:Number) : void
        {
            this._waitTime = this._waitTime + param1;
            this._cardMc.alpha = this._waitTime / this._CARD_FADEIN_TIME;
            if (this._cardMc.alpha >= 1)
            {
                this.setPhase(this._PHASE_FADE_GRAY);
            }
            return;
        }// end function

        private function phaseFadeGray() : void
        {
            this._waitTime = 0;
            return;
        }// end function

        private function controlFadeGray(param1:Number) : void
        {
            this._waitTime = this._waitTime + param1;
            if (this._waitTime > this._CARD_GRAY_TIME)
            {
                this._waitTime = this._CARD_GRAY_TIME;
                this._bEndGrayScale = true;
            }
            this._cardMc.filters = [ColorFilter.getGrayscaleAvg(this._waitTime, this._CARD_GRAY_TIME)];
            return;
        }// end function

        private function phaseClose() : void
        {
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

    }
}
