package employment
{
    import PlayerCard.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import icon.*;
    import input.*;
    import layer.*;
    import message.*;
    import player.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EmploymentFightAnimation extends Object
    {
        private var _phase:int;
        private var _cbClose:Function;
        private var _mcAnimPositionNull:MovieClip;
        private var _mcBaseAnim:MovieClip;
        private var _mcCutInMessage:MovieClip;
        private var _mcFree1Set:MovieClip;
        private var _mcNaviMessage:MovieClip;
        private var _mcSignalEnd:MovieClip;
        private var _mcSignalStart:MovieClip;
        private var _isoNaviMessage:InStayOut;
        private var _isoCutInMessage:InStayOut;
        private var _isoFree1Set:InStayOut;
        private var _isoMain:InStayOut;
        private var _isoSignalEnd:InStayOut;
        private var _isoSignalStart:InStayOut;
        private var _bEntered:Boolean;
        private var _bIsoeffStart:Boolean;
        private var _bIsoEndFlag:Boolean;
        private var _bIsoStartFlag:Boolean;
        private var _bFightStarted:Boolean = false;
        private var _playerBigCard:PlayerBigCard;
        private var _playerStatusWindow:EmploymentPlayerStatusWindow;
        private var _aCandidatePlayerId:Array;
        private var _aFightGroup:Array;
        private var _aPlayerInfo:Array;
        private var _parent:LayerEmployment;
        private static const _PHASE_STOP:int = 0;
        private static const _PHASE_READY_TO_FIGHT:int = 1;
        private static const _PHASE_SIGNAL_START:int = 2;
        private static const _PHASE_START_FIGHT:int = 3;
        private static const _PHASE_FIGHT_OVER:int = 4;
        private static const _PHASE_CARD_OPEN:int = 5;
        private static const _PHASE_MESSAGE_IN:int = 6;
        private static const _PHASE_MESSAGE_WAIT:int = 7;
        private static const _PHASE_MESSAGE_STATUS_WAIT:int = 8;
        private static const _PHASE_MESSAGE_OUT:int = 9;
        private static const _PHASE_CLOSE:int = 10;

        public function EmploymentFightAnimation(param1:LayerEmployment, param2:Array, param3:Array, param4:Function)
        {
            this._parent = param1;
            this._aPlayerInfo = param3;
            this._aCandidatePlayerId = param2;
            this._aFightGroup = [];
            this._cbClose = param4;
            this._bEntered = false;
            this._bIsoStartFlag = false;
            this._bIsoEndFlag = false;
            this._bIsoeffStart = false;
            this._mcBaseAnim = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonFree.swf", "summonFreeMain");
            this._parent.getLayer(LayerEmployment.ANIMATION_FRONT).addChild(this._mcBaseAnim);
            this._isoMain = new InStayOut(this._mcBaseAnim);
            this._mcAnimPositionNull = this._mcBaseAnim.Free1Set.animPositionNull;
            this._parent.getLayer(LayerEmployment.ANIMATION_FRONT).addChild(this._mcAnimPositionNull);
            this._mcFree1Set = this._mcBaseAnim.Free1Set;
            this._parent.getLayer(LayerEmployment.ANIMATION_FRONT).addChild(this._mcFree1Set);
            this._isoFree1Set = new InStayOut(this._mcBaseAnim.Free1Set);
            this._mcSignalStart = this._mcBaseAnim.Free1Set.signalStart;
            this._parent.getLayer(LayerEmployment.ANIMATION_FRONT).addChild(this._mcSignalStart);
            this._isoSignalStart = new InStayOut(this._mcBaseAnim.Free1Set.signalStart);
            this._mcSignalEnd = this._mcBaseAnim.Free1Set.signalEnd;
            this._parent.getLayer(LayerEmployment.ANIMATION_FRONT).addChild(this._mcSignalEnd);
            this._isoSignalEnd = new InStayOut(this._mcBaseAnim.Free1Set.signalEnd);
            this._mcCutInMessage = this._mcBaseAnim.Free1Set.ChrCutInBalloonMc;
            this._parent.getLayer(LayerEmployment.ANIMATION_FRONT).addChild(this._mcCutInMessage);
            this._isoCutInMessage = new InStayOut(this._mcBaseAnim.Free1Set.ChrCutInBalloonMc);
            TextControl.setText(this._mcCutInMessage.textMc.textDt, "");
            this._mcNaviMessage = this._mcBaseAnim.Free1Set.popupNaviChara2Mc;
            this._isoNaviMessage = new InStayOut(this._mcNaviMessage);
            var _loc_5:* = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
            ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH).smoothing = true;
            _loc_5.x = _loc_5.x - _loc_5.width / 2;
            _loc_5.y = _loc_5.y - _loc_5.height;
            this._mcNaviMessage.naviCharaNull.addChild(_loc_5);
            InputManager.getInstance().addMouseCallback(this, null, this.cbMouseClick, null, null);
            this._playerStatusWindow = null;
            if (this._playerStatusWindow == null)
            {
                this._mcBaseAnim.Free1Set.charaStatusSetMc.visible = false;
                this._playerStatusWindow = new EmploymentPlayerStatusWindow(this._mcBaseAnim.Free1Set.statusPopNull);
            }
            this._playerStatusWindow.setPlayerInformation(this._aPlayerInfo[0]);
            this._playerBigCard = null;
            if (this._playerBigCard == null)
            {
                this._playerBigCard = new PlayerBigCard(this._mcFree1Set.cardNull);
            }
            this._playerBigCard.setPlayerId(this._aPlayerInfo[0].id);
            this.setPhase(_PHASE_STOP);
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            this._aCandidatePlayerId = null;
            this._aPlayerInfo = null;
            for each (_loc_1 in this._aFightGroup)
            {
                
                _loc_1.release();
            }
            this._aFightGroup = null;
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
            if (this._isoFree1Set)
            {
                this._isoFree1Set.release();
            }
            this._isoFree1Set = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._isoSignalStart)
            {
                this._isoSignalStart.release();
            }
            this._isoSignalStart = null;
            if (this._isoSignalEnd)
            {
                this._isoSignalEnd.release();
            }
            this._isoSignalEnd = null;
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
            if (this._mcBaseAnim && this._mcBaseAnim.parent)
            {
                this._mcBaseAnim.parent.removeChild(this._mcBaseAnim);
            }
            this._mcBaseAnim = null;
            if (this._mcAnimPositionNull && this._mcAnimPositionNull.parent)
            {
                this._mcAnimPositionNull.parent.removeChild(this._mcAnimPositionNull);
            }
            this._mcAnimPositionNull = null;
            if (this._mcCutInMessage && this._mcCutInMessage.parent)
            {
                this._mcCutInMessage.parent.removeChild(this._mcCutInMessage);
            }
            this._mcCutInMessage = null;
            if (this._mcFree1Set && this._mcFree1Set.parent)
            {
                this._mcFree1Set.parent.removeChild(this._mcFree1Set);
            }
            this._mcFree1Set = null;
            if (this._mcNaviMessage && this._mcNaviMessage.parent)
            {
                this._mcNaviMessage.parent.removeChild(this._mcNaviMessage);
            }
            this._mcNaviMessage = null;
            if (this._mcSignalEnd && this._mcSignalEnd.parent)
            {
                this._mcSignalEnd.parent.removeChild(this._mcSignalEnd);
            }
            this._mcSignalEnd = null;
            if (this._mcSignalStart && this._mcSignalStart.parent)
            {
                this._mcSignalStart.parent.removeChild(this._mcSignalStart);
            }
            this._mcSignalStart = null;
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
                case _PHASE_READY_TO_FIGHT:
                {
                    this.initReadyToFight();
                    break;
                }
                case _PHASE_SIGNAL_START:
                {
                    this.initSignalStart();
                    break;
                }
                case _PHASE_START_FIGHT:
                {
                    this.initStartFight();
                    break;
                }
                case _PHASE_FIGHT_OVER:
                {
                    this.initFightOver();
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
                case _PHASE_READY_TO_FIGHT:
                {
                    this.controlReadyToFight();
                    break;
                }
                case _PHASE_SIGNAL_START:
                {
                    this.controlSignalStart();
                    break;
                }
                case _PHASE_START_FIGHT:
                {
                    this.controlStartFight();
                    break;
                }
                case _PHASE_FIGHT_OVER:
                {
                    this.controlFightOver();
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
            this.controlFightGroup(param1);
            if (this._mcBaseAnim.Free1Set.currentFrameLabel == "se1001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_CARDINCIDENT_ONE);
            }
            return;
        }// end function

        private function initPhaseStop() : void
        {
            return;
        }// end function

        private function initReadyToFight() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this._isoFree1Set.setInLabel("finish");
            var _loc_3:* = Random.range(1, 3);
            var _loc_4:* = "";
            switch(_loc_3)
            {
                case 1:
                {
                    _loc_4 = "AnimGroupFree000100";
                    break;
                }
                case 2:
                {
                    _loc_4 = "AnimGroupFree000200";
                    break;
                }
                case 3:
                {
                    _loc_4 = "AnimGroupFree000300";
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_1 = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonFree.swf", _loc_4);
            this._mcAnimPositionNull.addChild(_loc_1);
            _loc_2 = new EmploymentFightGroup(_loc_1, this._aPlayerInfo[0].id, this._aCandidatePlayerId[0], this._aCandidatePlayerId[1], null);
            this._aFightGroup.push(_loc_2);
            this.setFightIn();
            return;
        }// end function

        private function controlReadyToFight() : void
        {
            var timerSignalStart:Timer;
            if (this.checkFightIn() && !this._bIsoStartFlag)
            {
                this._bIsoStartFlag = true;
                this._mcFree1Set.alpha = 1;
                timerSignalStart = new Timer(1000, 1);
                timerSignalStart.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                setPhase(_PHASE_SIGNAL_START);
                return;
            }// end function
            );
                timerSignalStart.start();
            }
            return;
        }// end function

        private function initSignalStart() : void
        {
            this._isoFree1Set.setInLabel("stay");
            SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_SYOUBU);
            this._isoSignalStart.setIn(function () : void
            {
                _isoSignalStart.setOut(function () : void
                {
                    _mcFree1Set.alpha = 1;
                    _isoFree1Set.setInLabel("set");
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        private function controlSignalStart() : void
        {
            var timerStartFight:Timer;
            if (!this._isoSignalStart.bAnimetionOpen)
            {
                timerStartFight = new Timer(500, 1);
                timerStartFight.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                setPhase(_PHASE_START_FIGHT);
                return;
            }// end function
            );
                timerStartFight.start();
            }
            return;
        }// end function

        private function initStartFight() : void
        {
            if (!this._bFightStarted)
            {
                this.setFightStart();
                this._bFightStarted = true;
            }
            return;
        }// end function

        private function controlStartFight() : void
        {
            if (this.checkFightOver() && !this._bIsoEndFlag)
            {
                this._bIsoEndFlag = true;
                this._mcFree1Set.alpha = 1;
                this._isoFree1Set.setInLabel("finish");
                this.setPhase(_PHASE_FIGHT_OVER);
            }
            return;
        }// end function

        private function initFightOver() : void
        {
            SoundManager.getInstance().playSe(SoundId.SE_GACHA_RESULT);
            this._isoSignalEnd.setIn(function () : void
            {
                _isoSignalEnd.setOut(function () : void
                {
                    setFightOut();
                    return;
                }// end function
                );
                _isoFree1Set.setInLabel("effStart", function () : void
                {
                    setPhase(_PHASE_MESSAGE_IN);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            SoundManager.getInstance().playSe(SoundId.SE_REV_FLASHGATHER);
            return;
        }// end function

        private function controlFightOver() : void
        {
            if (this.checkFightOut() && !this._bIsoeffStart)
            {
                this._bIsoeffStart = true;
                this._mcFree1Set.alpha = 1;
            }
            return;
        }// end function

        private function initPhaseMessageIn() : void
        {
            var _loc_1:* = PlayerManager.getInstance().getWordEmployment(this._aPlayerInfo[0].characterId);
            TextControl.setText(this._mcCutInMessage.textMc.textDt, _loc_1);
            TextControl.setText(this._mcNaviMessage.ChrCutInBalloon2Mc.infoBalloonText1Mc.textDt, TextControl.formatIdText(MessageId.EMPLOYMENT_GET_CHARACTER_NAVI_TEXT01, this._aPlayerInfo[0].name));
            TextControl.setIdText(this._mcNaviMessage.ChrCutInBalloon2Mc.infoBalloonText2Mc.textDt, MessageId.EMPLOYMENT_GET_CHARACTER_NAVI_TEXT02);
            var _loc_2:* = new PlayerRarityIcon(this._mcNaviMessage.ChrCutInBalloon2Mc.setCharaRankMc, this._aPlayerInfo[0].rarity);
            this._mcCutInMessage.alpha = 1;
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
            this._mcBaseAnim.Free1Set.gotoAndPlay("out");
            this._cbClose();
            return;
        }// end function

        private function controlPhaseClose() : void
        {
            if (this._mcBaseAnim.currentLabel == "end")
            {
                this.setPhase(_PHASE_STOP);
            }
            return;
        }// end function

        public function playAnimation() : void
        {
            this.setPhase(_PHASE_READY_TO_FIGHT);
            return;
        }// end function

        private function controlFightGroup(param1:Number) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aFightGroup)
            {
                
                _loc_2.control(param1);
            }
            return;
        }// end function

        private function setFightIn() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aFightGroup)
            {
                
                _loc_1.playAnimation();
            }
            return;
        }// end function

        private function checkFightIn() : Boolean
        {
            var _loc_2:* = null;
            var _loc_1:* = true;
            for each (_loc_2 in this._aFightGroup)
            {
                
                if (_loc_2.bIn == false)
                {
                    _loc_1 = false;
                }
            }
            return _loc_1;
        }// end function

        private function setFightStart() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aFightGroup)
            {
                
                _loc_1.playFighting();
            }
            return;
        }// end function

        private function checkFightOver() : Boolean
        {
            var _loc_2:* = null;
            var _loc_1:* = true;
            for each (_loc_2 in this._aFightGroup)
            {
                
                if (_loc_2.bFinish == false)
                {
                    _loc_1 = false;
                }
            }
            return _loc_1;
        }// end function

        private function setFightOut() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aFightGroup)
            {
                
                _loc_1.close(this._cbClose);
            }
            return;
        }// end function

        private function checkFightOut() : Boolean
        {
            var _loc_2:* = null;
            var _loc_1:* = true;
            for each (_loc_2 in this._aFightGroup)
            {
                
                if (_loc_2.bEnd == false)
                {
                    _loc_1 = false;
                }
            }
            return _loc_1;
        }// end function

        private function setSignalStart() : void
        {
            this._isoSignalStart.setIn();
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
