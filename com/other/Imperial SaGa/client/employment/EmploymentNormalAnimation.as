package employment
{
    import PlayerCard.*;
    import flash.display.*;
    import flash.events.*;
    import icon.*;
    import input.*;
    import message.*;
    import player.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EmploymentNormalAnimation extends Object
    {
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _mcCutInMessage:MovieClip;
        private var _mcNaviMessage:MovieClip;
        private var _isoCutInMessage:InStayOut;
        private var _isoNaviMessage:InStayOut;
        private var _cbClose:Function;
        private var _playerDisplay:PlayerDisplay;
        private var _bEntered:Boolean;
        private var _playerBigCard:PlayerBigCard;
        private var _playerStatusWindow:EmploymentPlayerStatusWindow;
        private static const _PHASE_STOP:int = 0;
        private static const _PHASE_CARD_OPEN:int = 1;
        private static const _PHASE_MESSAGE_IN:int = 2;
        private static const _PHASE_MESSAGE_WAIT:int = 3;
        private static const _PHASE_MESSAGE_STATUS_WAIT:int = 4;
        private static const _PHASE_MESSAGE_OUT:int = 5;
        private static const _PHASE_CLOSE:int = 6;

        public function EmploymentNormalAnimation(param1:DisplayObjectContainer, param2:Function)
        {
            this._cbClose = param2;
            this._bEntered = false;
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonFree.swf", "summonSoldierMc");
            this._mcCutInMessage = this._mcBase.ChrCutInBalloonMc;
            this._mcNaviMessage = this._mcBase.popupNaviChara2Mc;
            param1.addChild(this._mcBase);
            this._isoCutInMessage = new InStayOut(this._mcCutInMessage);
            this._isoNaviMessage = new InStayOut(this._mcNaviMessage);
            this._playerDisplay = new PlayerDisplay(this._mcBase.chrNull, Constant.EMPTY_ID, Constant.EMPTY_ID);
            var _loc_3:* = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
            _loc_3.smoothing = true;
            _loc_3.x = _loc_3.x - _loc_3.width / 2;
            _loc_3.y = _loc_3.y - _loc_3.height;
            this._mcNaviMessage.naviCharaNull.addChild(_loc_3);
            this._playerBigCard = null;
            this._playerStatusWindow = null;
            InputManager.getInstance().addMouseCallback(this, null, this.cbMouseClick, null, null);
            this.setPhase(_PHASE_STOP);
            return;
        }// end function

        public function release() : void
        {
            if (this._playerStatusWindow)
            {
                this._playerStatusWindow.release();
            }
            this._playerStatusWindow = null;
            if (this._playerBigCard)
            {
                this._playerBigCard.release();
            }
            this._playerBigCard = null;
            if (this._isoCutInMessage)
            {
                this._isoCutInMessage.release();
            }
            this._isoCutInMessage = null;
            if (this._isoNaviMessage)
            {
                this._isoNaviMessage.release();
            }
            this._isoNaviMessage = null;
            if (this._playerDisplay)
            {
                this._playerDisplay.release();
            }
            this._playerDisplay = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            InputManager.getInstance().delMouseCallback(this);
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_STOP:
                {
                    this.initPhaseStop();
                    break;
                }
                case _PHASE_CARD_OPEN:
                {
                    this.initPhaseCardOpen();
                    break;
                }
                case _PHASE_MESSAGE_IN:
                {
                    this.initPhaseMessageIn();
                    break;
                }
                case _PHASE_MESSAGE_WAIT:
                {
                    this.initPhaseMessageWait();
                    break;
                }
                case _PHASE_MESSAGE_STATUS_WAIT:
                {
                    this.initPhaseMessageStatusWait();
                    break;
                }
                case _PHASE_MESSAGE_OUT:
                {
                    this.initPhaseMessageOut();
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
                case _PHASE_CARD_OPEN:
                {
                    this.controlPhaseCardOpen();
                    break;
                }
                case _PHASE_MESSAGE_IN:
                {
                    this.controlPhaseMessageIn(param1);
                    break;
                }
                case _PHASE_MESSAGE_STATUS_WAIT:
                {
                    this.controlPhaseMessageStatusWait(param1);
                    break;
                }
                case _PHASE_MESSAGE_OUT:
                {
                    this.controlPhaseMessageOut(param1);
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.controlPhaseClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function initPhaseStop() : void
        {
            return;
        }// end function

        private function initPhaseCardOpen() : void
        {
            this._bEntered = false;
            this._mcBase.gotoAndPlay("in");
            return;
        }// end function

        private function controlPhaseCardOpen() : void
        {
            if (!this._bEntered && this._mcBase.currentLabel == "winStart")
            {
                SoundManager.getInstance().playSe(SoundId.SE_GACHA_RESULT);
                this._playerDisplay.setAnimation(PlayerDisplay.LABEL_WIN);
                this._bEntered = true;
            }
            else if (this._mcBase.currentLabel == "stay")
            {
                this.setPhase(_PHASE_MESSAGE_IN);
            }
            return;
        }// end function

        private function initPhaseMessageIn() : void
        {
            this._isoCutInMessage.setIn();
            this._isoNaviMessage.setEnd();
            return;
        }// end function

        private function controlPhaseMessageIn(param1:Number) : void
        {
            if (!this._isoCutInMessage.bOpened)
            {
                return;
            }
            this.setPhase(_PHASE_MESSAGE_WAIT);
            return;
        }// end function

        private function initPhaseMessageWait() : void
        {
            return;
        }// end function

        private function initPhaseMessageStatusWait() : void
        {
            this._playerStatusWindow.open();
            return;
        }// end function

        private function controlPhaseMessageStatusWait(param1:Number) : void
        {
            if (!this._playerStatusWindow.bOpened)
            {
                return;
            }
            if (this._isoNaviMessage.bEnd)
            {
                this._isoNaviMessage.setIn();
            }
            return;
        }// end function

        private function initPhaseMessageOut() : void
        {
            this._playerStatusWindow.close();
            this._isoNaviMessage.setOut();
            return;
        }// end function

        private function controlPhaseMessageOut(param1:Number) : void
        {
            var t:* = param1;
            if (!this._isoNaviMessage.bEnd)
            {
                return;
            }
            if (this._isoCutInMessage.bOpened)
            {
                this._isoCutInMessage.setOut(function () : void
            {
                setPhase(_PHASE_CLOSE);
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this._mcBase.gotoAndPlay("out");
            return;
        }// end function

        private function controlPhaseClose() : void
        {
            if (this._mcBase.currentLabel == "end")
            {
                if (this._cbClose != null)
                {
                    this._cbClose();
                }
                this.setPhase(_PHASE_STOP);
            }
            return;
        }// end function

        public function playAnimation(param1:PlayerInformation) : void
        {
            var _loc_2:* = PlayerManager.getInstance().getWordEmployment(param1.characterId);
            TextControl.setText(this._mcCutInMessage.textMc.textDt, _loc_2);
            TextControl.setText(this._mcNaviMessage.ChrCutInBalloon2Mc.infoBalloonText1Mc.textDt, TextControl.formatIdText(MessageId.EMPLOYMENT_GET_CHARACTER_NAVI_TEXT01, param1.name));
            TextControl.setIdText(this._mcNaviMessage.ChrCutInBalloon2Mc.infoBalloonText2Mc.textDt, MessageId.EMPLOYMENT_GET_CHARACTER_NAVI_TEXT02);
            var _loc_3:* = new PlayerRarityIcon(this._mcNaviMessage.ChrCutInBalloon2Mc.setCharaRankMc, param1.rarity);
            this._playerDisplay.setId(param1.id, Constant.EMPTY_ID);
            if (this._playerBigCard == null)
            {
                this._playerBigCard = new PlayerBigCard(this._mcBase.cardNull);
            }
            this._playerBigCard.setPlayerId(param1.id);
            if (this._playerStatusWindow == null)
            {
                this._mcBase.charaStatusSetMc.visible = false;
                this._playerStatusWindow = new EmploymentPlayerStatusWindow(this._mcBase.statusPopNull);
            }
            this._playerStatusWindow.setPlayerInformation(param1);
            this.setPhase(_PHASE_CARD_OPEN);
            return;
        }// end function

        private function cbClosePopup() : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbMouseClick(event:MouseEvent) : void
        {
            if (this._phase == _PHASE_MESSAGE_WAIT)
            {
                this.setPhase(_PHASE_MESSAGE_STATUS_WAIT);
            }
            else if (this._phase == _PHASE_MESSAGE_STATUS_WAIT)
            {
                SoundManager.getInstance().playSe(SoundId.SE_CANCEL);
                this.setPhase(_PHASE_MESSAGE_OUT);
            }
            return;
        }// end function

    }
}
