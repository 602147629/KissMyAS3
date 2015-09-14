package status
{
    import PlayerCard.*;
    import button.*;
    import character.*;
    import flash.display.*;
    import flash.events.*;
    import player.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class PlayerCardViewer extends Object
    {
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _mcCardNull:MovieClip;
        private var _mcStand:MovieClip;
        private var _playerBigCard:PlayerBigCard;
        private var _cbClose:Function;
        private var _playerId:int;
        private var _fade:Fade;
        private static const _PHASE_LOADING:int = 0;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_CARD:int = 2;
        private static const _PHASE_BUSTUP:int = 3;
        private static const _PHASE_CLOSE:int = 4;

        public function PlayerCardViewer(param1:MovieClip, param2:int, param3:Function = null)
        {
            this._playerId = param2;
            this._cbClose = param3;
            this._mcBase = new MovieClip();
            this._fade = new Fade(this._mcBase);
            this._fade.maxAlpha = 0.5;
            this._fade.setFadeIn(0);
            this._mcCardNull = new MovieClip();
            this._mcCardNull.x = Constant.SCREEN_WIDTH / 2;
            this._mcCardNull.y = Constant.SCREEN_HEIGHT / 2;
            this._mcBase.addChild(this._mcCardNull);
            this._mcStand = new MovieClip();
            this._mcStand.x = Constant.SCREEN_WIDTH / 2;
            this._mcStand.y = Constant.SCREEN_HEIGHT / 2;
            this._mcBase.addChild(this._mcStand);
            this._playerBigCard = new PlayerBigCard(this._mcCardNull);
            this._playerBigCard.hide();
            this._mcBase.mouseEnabled = false;
            param1.addChild(this._mcBase);
            var _loc_4:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            ResourceManager.getInstance().loadResource(ResourcePath.CARD_BIG_PATH + CharacterConstant.ID_CARD + _loc_4.cardFileName);
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_BUSTUP_PATH + _loc_4.bustUpFileName);
            this.setPhase(_PHASE_LOADING);
            return;
        }// end function

        public function get mcBase() : MovieClip
        {
            return this._mcBase;
        }// end function

        public function get bClose() : Boolean
        {
            return this._phase == _PHASE_CLOSE && (this._fade && this._fade.isFadeEnd());
        }// end function

        private function resourceLoaded() : void
        {
            this._playerBigCard.setPlayerId(this._playerId);
            var _loc_1:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            var _loc_2:* = ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + _loc_1.bustUpFileName);
            _loc_2.smoothing = true;
            _loc_2.x = -_loc_2.width / 2;
            _loc_2.y = -_loc_2.height / 2;
            this._mcStand.addChild(_loc_2);
            this._mcStand.visible = false;
            return;
        }// end function

        public function release() : void
        {
            this._mcBase.removeEventListener(MouseEvent.CLICK, this.cbMouseClick);
            if (this._playerBigCard)
            {
                this._playerBigCard.release();
            }
            this._playerBigCard = null;
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_LOADING:
                {
                    this.initPhaseLoading();
                    break;
                }
                case _PHASE_OPEN:
                {
                    this.initPhaseOpen();
                    break;
                }
                case _PHASE_CARD:
                {
                    this.initPhaseCard();
                    break;
                }
                case _PHASE_BUSTUP:
                {
                    this.initPhaseBustUp();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.initPhaseClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case _PHASE_LOADING:
                {
                    this.controlPhaseLoading(param1);
                    break;
                }
                case _PHASE_OPEN:
                {
                    this.controlPhaseOpen(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._fade)
            {
                this._fade.control(param1);
            }
            return;
        }// end function

        public function initPhaseLoading() : void
        {
            this._fade.setFadeOut(Constant.FADE_OUT_TIME);
            return;
        }// end function

        public function controlPhaseLoading(param1:Number) : void
        {
            if (ResourceManager.getInstance().isLoaded())
            {
                this.resourceLoaded();
                this.setPhase(_PHASE_OPEN);
            }
            return;
        }// end function

        public function initPhaseOpen() : void
        {
            this._mcBase.addEventListener(MouseEvent.CLICK, this.cbMouseClick);
            return;
        }// end function

        public function controlPhaseOpen(param1:Number) : void
        {
            if (this._fade.isFadeEnd())
            {
                this.setPhase(_PHASE_CARD);
            }
            return;
        }// end function

        public function initPhaseCard() : void
        {
            this._playerBigCard.show();
            this._mcStand.visible = false;
            return;
        }// end function

        public function initPhaseBustUp() : void
        {
            this._playerBigCard.hide();
            this._mcStand.visible = true;
            return;
        }// end function

        public function initPhaseClose() : void
        {
            this._mcBase.removeEventListener(MouseEvent.CLICK, this.cbMouseClick);
            this._mcStand.visible = false;
            this._fade.maxAlpha = 0.5;
            this._fade.setFadeIn(Constant.FADE_IN_TIME, function () : void
            {
                if (_cbClose != null)
                {
                    _cbClose();
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function closeViewer() : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbMouseClick(event:MouseEvent) : void
        {
            if (!this._fade.isFadeEnd())
            {
                return;
            }
            if (Main.GetProcess().topBar.bConfigWindowOpend)
            {
                return;
            }
            if (this._phase == _PHASE_CARD)
            {
                if (this._mcCardNull.hitTestPoint(event.stageX, event.stageY))
                {
                    this.setPhase(_PHASE_BUSTUP);
                    SoundManager.getInstance().playSe(ButtonBase.SE_CURSOR_ID);
                }
            }
            else if (this._phase == _PHASE_BUSTUP)
            {
                if (this._mcStand.hitTestPoint(event.stageX, event.stageY))
                {
                    this.setPhase(_PHASE_CLOSE);
                    SoundManager.getInstance().playSe(ButtonBase.SE_CURSOR_ID);
                }
            }
            return;
        }// end function

    }
}
