package employment
{
    import PlayerCard.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import input.*;
    import layer.*;
    import message.*;
    import player.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EmploymentFightAnimation10 extends EmploymentBoxAnimationBase
    {
        private var _phase:int;
        private var _cbClose:Function;
        private var _mcBaseAnim:MovieClip;
        private var _mcFree10Set:MovieClip;
        private var _mcCutInMessage:MovieClip;
        private var _mcNaviMessage:MovieClip;
        private var _mcSignalStart:MovieClip;
        private var _mcSignalEnd:MovieClip;
        private var _isoCutInMessage:InStayOut;
        private var _isoFree10Set:InStayOut;
        private var _isoMain:InStayOut;
        private var _isoNaviMessage:InStayOut;
        private var _isoSignalEnd:InStayOut;
        private var _isoSignalStart:InStayOut;
        private var _aAnimPositionSet:Array;
        private var _aCandidatePlayerId:Array;
        private var _aCardAnim:Array;
        private var _aCardDisplayPlayer:Array;
        private var _aCardDisplayPlayerLastLabel:Array;
        private var _aIsoCard:Array;
        private var _aIsoCardAnim:Array;
        private var _aFightGroup:Array;
        private var _aPlayerInfo:Array;
        private var _aUsedAnimPositionSet:Array;
        private var _bFightStarted:Boolean = false;
        private var _bIsoeffStart:Boolean;
        private var _bIsoEndFlag:Boolean;
        private var _bIsoStartFlag:Boolean;
        private var _parent:LayerEmployment;
        private var _aBoxCardHit:Array;
        private static const _POSITION_NULL_NUM:int = 22;
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

        public function EmploymentFightAnimation10(param1:LayerEmployment, param2:Array, param3:Array, param4:Function)
        {
            this._parent = param1;
            super(this._parent);
            this._cbClose = param4;
            this._bIsoStartFlag = false;
            this._bIsoEndFlag = false;
            this._bIsoeffStart = false;
            this._aPlayerInfo = param3;
            this._aCandidatePlayerId = param2;
            this._aFightGroup = [];
            this._aAnimPositionSet = [];
            this._aUsedAnimPositionSet = [];
            this._aIsoCard = [];
            this._aIsoCardAnim = [];
            this._aCardDisplayPlayer = [];
            this._aCardAnim = [];
            this._aCardDisplayPlayerLastLabel = [];
            this._mcBaseAnim = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonFree.swf", "summonFreeMain");
            this._parent.getLayer(LayerEmployment.ANIMATION_FRONT).addChild(this._mcBaseAnim);
            this._isoMain = new InStayOut(this._mcBaseAnim);
            this._mcFree10Set = this._mcBaseAnim.Free10Set;
            this._parent.getLayer(LayerEmployment.ANIMATION_FRONT).addChild(this._mcFree10Set);
            this._isoFree10Set = new InStayOut(this._mcBaseAnim.Free10Set);
            this._mcFree10Set.visible = true;
            this._mcFree10Set.alpha = 1;
            this._mcFree10Set.popupNaviChara2Mc.mouseChildren = false;
            this._mcFree10Set.popupNaviChara2Mc.mouseEnabled = false;
            this.createFightPositions(this._mcBaseAnim, this._aAnimPositionSet);
            this._mcSignalStart = this._mcBaseAnim.Free10Set.signalStart;
            this._parent.getLayer(LayerEmployment.ANIMATION_FRONT).addChild(this._mcSignalStart);
            this._isoSignalStart = new InStayOut(this._mcBaseAnim.Free10Set.signalStart);
            this._mcSignalStart.alpha = 1;
            this._mcSignalEnd = this._mcBaseAnim.Free10Set.signalEnd;
            this._parent.getLayer(LayerEmployment.ANIMATION_FRONT).addChild(this._mcSignalEnd);
            this._isoSignalEnd = new InStayOut(this._mcBaseAnim.Free10Set.signalEnd);
            this._mcSignalEnd.alpha = 1;
            this._mcCutInMessage = this._mcBaseAnim.Free1Set.ChrCutInBalloonMc;
            this._parent.getLayer(LayerEmployment.ANIMATION_FRONT).addChild(this._mcCutInMessage);
            this._isoCutInMessage = new InStayOut(this._mcCutInMessage);
            this._mcNaviMessage = this._mcBaseAnim.Free10Set.popupNaviChara2Mc;
            this._parent.getLayer(LayerEmployment.ANIMATION_FRONT).addChild(this._mcNaviMessage);
            this._isoNaviMessage = new InStayOut(this._mcBaseAnim.Free10Set.popupNaviChara2Mc);
            var _loc_5:* = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
            ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH).smoothing = true;
            _loc_5.x = _loc_5.x - _loc_5.width / 2;
            _loc_5.y = _loc_5.y - _loc_5.height;
            this._mcNaviMessage.naviCharaNull.addChild(_loc_5);
            InputManager.getInstance().addMouseCallback(this, null, this.cbMouseClick, null, null);
            this.createCard();
            this.setPhase(_PHASE_STOP);
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            super.release();
            for each (_loc_1 in this._aBoxCardHit)
            {
                
                _loc_1.release();
            }
            this._aBoxCardHit = null;
            for each (_loc_2 in this._aFightGroup)
            {
                
                _loc_2.release();
            }
            this._aFightGroup = null;
            for each (_loc_3 in this._aAnimPositionSet)
            {
                
                if (_loc_3 && _loc_3.parent)
                {
                    _loc_3.parent.removeChild(_loc_3);
                }
                _loc_3 = null;
            }
            this._aAnimPositionSet = null;
            for each (_loc_4 in this._aCardAnim)
            {
                
                if (_loc_4 && _loc_4.parent)
                {
                    _loc_4.parent.removeChild(_loc_4);
                }
                _loc_4 = null;
            }
            this._aCardAnim = null;
            for each (_loc_5 in this._aCardDisplayPlayer)
            {
                
                _loc_5 = null;
            }
            this._aCardDisplayPlayer = null;
            for each (_loc_6 in this._aIsoCard)
            {
                
                if (_loc_6)
                {
                    _loc_6.release();
                }
                _loc_6 = null;
            }
            this._aIsoCard = null;
            for each (_loc_7 in this._aIsoCardAnim)
            {
                
                if (_loc_7)
                {
                    _loc_7.release();
                }
                _loc_7 = null;
            }
            this._aIsoCardAnim = null;
            this._aPlayerInfo = null;
            this._aUsedAnimPositionSet = null;
            this._aCardDisplayPlayerLastLabel = null;
            this._aCandidatePlayerId = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._isoFree10Set)
            {
                this._isoFree10Set.release();
            }
            this._isoFree10Set = null;
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
            if (this._mcFree10Set && this._mcFree10Set.parent)
            {
                this._mcFree10Set.parent.removeChild(this._mcFree10Set);
            }
            this._mcFree10Set = null;
            if (this._mcCutInMessage && this._mcCutInMessage.parent)
            {
                this._mcCutInMessage.parent.removeChild(this._mcCutInMessage);
            }
            this._mcCutInMessage = null;
            if (this._mcNaviMessage && this._mcNaviMessage.parent)
            {
                this._mcNaviMessage.parent.removeChild(this._mcNaviMessage);
            }
            this._mcBaseAnim = null;
            if (this._mcSignalStart && this._mcSignalStart.parent)
            {
                this._mcSignalStart.parent.removeChild(this._mcSignalStart);
            }
            this._mcSignalStart = null;
            if (this._mcSignalEnd && this._mcSignalEnd.parent)
            {
                this._mcSignalEnd.parent.removeChild(this._mcSignalEnd);
            }
            this._mcSignalEnd = null;
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
                case _PHASE_CARD_OPEN:
                {
                    this.controlPhaseCardOpen(param1);
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
            this.controlCardPlayers(param1);
            return;
        }// end function

        private function initPhaseStop() : void
        {
            return;
        }// end function

        private function initReadyToFight() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._aPlayerInfo.length)
            {
                
                _loc_2 = this._aPlayerInfo[_loc_1];
                this.createFightGroup(_loc_2.id, this._aCandidatePlayerId[_loc_1]);
                _loc_1++;
            }
            this.setFightIn();
            return;
        }// end function

        private function controlReadyToFight() : void
        {
            var timerSignalStart:Timer;
            if (this.checkFightIn() && !this._bIsoStartFlag)
            {
                this._bIsoStartFlag = true;
                this._mcFree10Set.alpha = 1;
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
            this._isoFree10Set.setInLabel("stay");
            SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_SYOUBU);
            this._isoSignalStart.setIn(function () : void
            {
                _isoSignalStart.setOut(function () : void
                {
                    _mcFree10Set.alpha = 1;
                    _isoFree10Set.setInLabel("set");
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
                this._mcFree10Set.alpha = 1;
                this._isoFree10Set.setInLabel("finish");
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
                    var timerCard:* = new Timer(1000, 1);
                    timerCard.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
                    {
                        setPhase(_PHASE_CARD_OPEN);
                        return;
                    }// end function
                    );
                    timerCard.start();
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        private function controlFightOver() : void
        {
            return;
        }// end function

        private function initPhaseCardOpen() : void
        {
            var timerStartCard:Array;
            var i:int;
            var cardtimer:Timer;
            var cardDisplayPlayer:EmploymentFighterDisplay;
            var timerCardOpen1:Timer;
            var isocard1:InStayOut;
            var isocardAnim1:InStayOut;
            var timerCardOpen2:Timer;
            var isocard2:InStayOut;
            var isocardAnim2:InStayOut;
            var timerCardOpen3:Timer;
            var isocard3:InStayOut;
            var isocardAnim3:InStayOut;
            var timerCardOpen4:Timer;
            var isocard4:InStayOut;
            var isocardAnim4:InStayOut;
            var timerCardOpen5:Timer;
            var isocard5:InStayOut;
            var isocardAnim5:InStayOut;
            var timerCardOpen6:Timer;
            var isocard6:InStayOut;
            var isocardAnim6:InStayOut;
            var timerCardOpen7:Timer;
            var isocard7:InStayOut;
            var isocardAnim7:InStayOut;
            var timerCardOpen8:Timer;
            var isocard8:InStayOut;
            var isocardAnim8:InStayOut;
            var timerCardOpen9:Timer;
            var isocard9:InStayOut;
            var isocardAnim9:InStayOut;
            var timerCardOpen10:Timer;
            var isocard10:InStayOut;
            var isocardAnim10:InStayOut;
            if (!this._bIsoeffStart)
            {
                this._bIsoeffStart = true;
                timerStartCard = new Array();
                this._isoFree10Set.setInLabel("finish");
                SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_CARDINCIDENT_MANY);
                i;
                while (i < this._aIsoCard.length)
                {
                    
                    switch(i)
                    {
                        case 0:
                        {
                            timerCardOpen1 = new Timer(i * 50, 1);
                            isocard1 = this._aIsoCard[0];
                            isocardAnim1 = this._aIsoCardAnim[0];
                            timerCardOpen1.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isocard1.setIn();
                isocardAnim1.setIn();
                _aCardAnim[0].gotoAndPlay(2);
                return;
            }// end function
            );
                            timerStartCard.push(timerCardOpen1);
                            break;
                        }
                        case 1:
                        {
                            timerCardOpen2 = new Timer(i * 50, 1);
                            isocard2 = this._aIsoCard[1];
                            isocardAnim2 = this._aIsoCardAnim[1];
                            timerCardOpen2.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isocard2.setIn();
                isocardAnim2.setIn();
                _aCardAnim[1].gotoAndPlay(2);
                return;
            }// end function
            );
                            timerStartCard.push(timerCardOpen2);
                            break;
                        }
                        case 2:
                        {
                            timerCardOpen3 = new Timer(i * 50, 1);
                            isocard3 = this._aIsoCard[2];
                            isocardAnim3 = this._aIsoCardAnim[2];
                            timerCardOpen3.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isocard3.setIn();
                isocardAnim3.setIn();
                _aCardAnim[2].gotoAndPlay(2);
                return;
            }// end function
            );
                            timerStartCard.push(timerCardOpen3);
                            break;
                        }
                        case 3:
                        {
                            timerCardOpen4 = new Timer(i * 50, 1);
                            isocard4 = this._aIsoCard[3];
                            isocardAnim4 = this._aIsoCardAnim[3];
                            timerCardOpen4.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isocard4.setIn();
                isocardAnim4.setIn();
                _aCardAnim[3].gotoAndPlay(2);
                return;
            }// end function
            );
                            timerStartCard.push(timerCardOpen4);
                            break;
                        }
                        case 4:
                        {
                            timerCardOpen5 = new Timer(i * 50, 1);
                            isocard5 = this._aIsoCard[4];
                            isocardAnim5 = this._aIsoCardAnim[4];
                            timerCardOpen5.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isocard5.setIn();
                isocardAnim5.setIn();
                _aCardAnim[4].gotoAndPlay(2);
                return;
            }// end function
            );
                            timerStartCard.push(timerCardOpen5);
                            break;
                        }
                        case 5:
                        {
                            timerCardOpen6 = new Timer(i * 50, 1);
                            isocard6 = this._aIsoCard[5];
                            isocardAnim6 = this._aIsoCardAnim[5];
                            timerCardOpen6.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isocard6.setIn();
                isocardAnim6.setIn();
                _aCardAnim[5].gotoAndPlay(2);
                return;
            }// end function
            );
                            timerStartCard.push(timerCardOpen6);
                            break;
                        }
                        case 6:
                        {
                            timerCardOpen7 = new Timer(i * 50, 1);
                            isocard7 = this._aIsoCard[6];
                            isocardAnim7 = this._aIsoCardAnim[6];
                            timerCardOpen7.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isocard7.setIn();
                isocardAnim7.setIn();
                _aCardAnim[6].gotoAndPlay(2);
                return;
            }// end function
            );
                            timerStartCard.push(timerCardOpen7);
                            break;
                        }
                        case 7:
                        {
                            timerCardOpen8 = new Timer(i * 50, 1);
                            isocard8 = this._aIsoCard[7];
                            isocardAnim8 = this._aIsoCardAnim[7];
                            timerCardOpen8.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isocard8.setIn();
                isocardAnim8.setIn();
                _aCardAnim[7].gotoAndPlay(2);
                return;
            }// end function
            );
                            timerStartCard.push(timerCardOpen8);
                            break;
                        }
                        case 8:
                        {
                            timerCardOpen9 = new Timer(i * 50, 1);
                            isocard9 = this._aIsoCard[8];
                            isocardAnim9 = this._aIsoCardAnim[8];
                            timerCardOpen9.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isocard9.setIn();
                isocardAnim9.setIn();
                _aCardAnim[8].gotoAndPlay(2);
                return;
            }// end function
            );
                            timerStartCard.push(timerCardOpen9);
                            break;
                        }
                        case 9:
                        {
                            timerCardOpen10 = new Timer(i * 50, 1);
                            isocard10 = this._aIsoCard[9];
                            isocardAnim10 = this._aIsoCardAnim[9];
                            timerCardOpen10.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isocard10.setIn();
                isocardAnim10.setIn();
                _aCardAnim[9].gotoAndPlay(2);
                return;
            }// end function
            );
                            timerStartCard.push(timerCardOpen10);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    i = (i + 1);
                }
                var _loc_2:* = 0;
                var _loc_3:* = timerStartCard;
                while (_loc_3 in _loc_2)
                {
                    
                    cardtimer = _loc_3[_loc_2];
                    cardtimer.start();
                }
                var _loc_2:* = 0;
                var _loc_3:* = this._aCardDisplayPlayer;
                while (_loc_3 in _loc_2)
                {
                    
                    cardDisplayPlayer = _loc_3[_loc_2];
                    cardDisplayPlayer.mc.play();
                    this._aCardDisplayPlayerLastLabel.push("");
                }
            }
            return;
        }// end function

        private function controlPhaseCardOpen(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = true;
            for each (_loc_3 in this._aIsoCard)
            {
                
                if (!_loc_3.bOpened)
                {
                    _loc_2 = false;
                }
            }
            for each (_loc_4 in this._aIsoCardAnim)
            {
                
                if (!_loc_4.bOpened)
                {
                    _loc_2 = false;
                }
            }
            if (_loc_2)
            {
                this.setPhase(_PHASE_MESSAGE_IN);
            }
            return;
        }// end function

        private function initPhaseMessageIn() : void
        {
            TextControl.setIdText(this._mcNaviMessage.ChrCutInBalloon2Mc.infoBalloonText2Mc.textDt, MessageId.EMPLOYMENT_GET_CHARACTER_NAVI_TEXT03);
            this._mcNaviMessage.ChrCutInBalloon2Mc.alpha = 1;
            return;
        }// end function

        private function controlPhaseMessageIn(param1:Number) : void
        {
            this.setPhase(_PHASE_MESSAGE_WAIT);
            this._mcFree10Set.signalStart.visible = false;
            this._mcFree10Set.signalEnd.visible = false;
            this._mcFree10Set.animPositionSet.visible = false;
            return;
        }// end function

        private function initPhaseMessageWait() : void
        {
            return;
        }// end function

        private function initPhaseMessageStatusWait() : void
        {
            return;
        }// end function

        private function controlPhaseMessageStatusWait(param1:Number) : void
        {
            this._mcNaviMessage.alpha = 1;
            this._isoNaviMessage.setIn();
            setCardMouseEnable(true);
            return;
        }// end function

        private function initPhaseMessageOut() : void
        {
            var listener:Function;
            var isocardAnim:InStayOut;
            listener = function (event:Event) : void
            {
                var _loc_2:* = null;
                if (_aIsoCardAnim[(_aIsoCardAnim.length - 1)].bEnd)
                {
                    _mcFree10Set.removeEventListener(Event.ENTER_FRAME, listener);
                    for each (_loc_2 in _aIsoCard)
                    {
                        
                        _loc_2.setOut();
                    }
                }
                return;
            }// end function
            ;
            setCardMouseEnable(false);
            this._mcFree10Set.addEventListener(Event.ENTER_FRAME, listener);
            var i:int;
            while (i < this._aIsoCardAnim.length)
            {
                
                isocardAnim = this._aIsoCardAnim[i] as InStayOut;
                isocardAnim.setOutLabel("jumpExit");
                i = (i + 1);
            }
            this._isoNaviMessage.setOut();
            return;
        }// end function

        private function controlPhaseMessageOut(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = true;
            if (!this._isoNaviMessage.bEnd)
            {
                return;
            }
            for each (_loc_3 in this._aIsoCard)
            {
                
                if (!_loc_3.bEnd)
                {
                    _loc_2 = false;
                }
            }
            if (_loc_2)
            {
                this.setPhase(_PHASE_CLOSE);
            }
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this._mcBaseAnim.Free10Set.gotoAndPlay("out");
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
                
                _loc_1.playOver();
            }
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

        private function controlCardPlayers(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aCardDisplayPlayer.length)
            {
                
                _loc_3 = this._aCardDisplayPlayer[_loc_2];
                _loc_4 = this._aCardAnim[_loc_2];
                if (_loc_4.currentLabel != "stop" && _loc_4.currentLabel != "in" && _loc_4.currentLabel != "out" && _loc_4.currentLabel != "end")
                {
                    if (_loc_4.currentLabel != this._aCardDisplayPlayerLastLabel[_loc_2])
                    {
                        _loc_3.setAnimation(_loc_4.currentLabel);
                        this._aCardDisplayPlayerLastLabel[_loc_2] = _loc_4.currentLabel;
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        private function createFightPositions(param1:MovieClip, param2:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 1;
            while (_loc_5 <= _POSITION_NULL_NUM)
            {
                
                _loc_4 = "PositionNull" + (_loc_5 < 10 ? ("0" + _loc_5) : (_loc_5));
                _loc_3 = param1.Free10Set.animPositionSet[_loc_4];
                param2.push(_loc_3);
                _loc_5++;
            }
            return;
        }// end function

        private function createFightGroup(param1:int, param2:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_5:* = Random.range(1, 3);
            var _loc_6:* = "";
            switch(_loc_5)
            {
                case 1:
                {
                    _loc_6 = "AnimGroupFree010100";
                    break;
                }
                case 2:
                {
                    _loc_6 = "AnimGroupFree010200";
                    break;
                }
                case 3:
                {
                    _loc_6 = "AnimGroupFree010300";
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_3 = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonFree.swf", _loc_6);
            _loc_3.mouseChildren = false;
            _loc_3.mouseEnabled = false;
            var _loc_7:* = Random.range(1, 22);
            var _loc_8:* = true;
            for each (_loc_9 in this._aUsedAnimPositionSet)
            {
                
                if (_loc_7 == _loc_9)
                {
                    _loc_8 = false;
                }
            }
            if (!_loc_8)
            {
                this.createFightGroup(param1, param2);
            }
            else if (_loc_8)
            {
                _loc_10 = new MovieClip();
                switch(_loc_7)
                {
                    case 1:
                    {
                        _loc_10 = this._aAnimPositionSet[0];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 2:
                    {
                        _loc_10 = this._aAnimPositionSet[1];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 3:
                    {
                        _loc_10 = this._aAnimPositionSet[2];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 4:
                    {
                        _loc_10 = this._aAnimPositionSet[3];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 5:
                    {
                        _loc_10 = this._aAnimPositionSet[4];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 6:
                    {
                        _loc_10 = this._aAnimPositionSet[5];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 7:
                    {
                        _loc_10 = this._aAnimPositionSet[6];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 8:
                    {
                        _loc_10 = this._aAnimPositionSet[7];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 9:
                    {
                        _loc_10 = this._aAnimPositionSet[8];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 10:
                    {
                        _loc_10 = this._aAnimPositionSet[9];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 11:
                    {
                        _loc_10 = this._aAnimPositionSet[10];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 12:
                    {
                        _loc_10 = this._aAnimPositionSet[11];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 13:
                    {
                        _loc_10 = this._aAnimPositionSet[12];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 14:
                    {
                        _loc_10 = this._aAnimPositionSet[13];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 15:
                    {
                        _loc_10 = this._aAnimPositionSet[14];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 16:
                    {
                        _loc_10 = this._aAnimPositionSet[15];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 17:
                    {
                        _loc_10 = this._aAnimPositionSet[16];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 18:
                    {
                        _loc_10 = this._aAnimPositionSet[17];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 19:
                    {
                        _loc_10 = this._aAnimPositionSet[18];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 20:
                    {
                        _loc_10 = this._aAnimPositionSet[19];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 21:
                    {
                        _loc_10 = this._aAnimPositionSet[20];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    case 22:
                    {
                        _loc_10 = this._aAnimPositionSet[21];
                        this._aUsedAnimPositionSet.push(_loc_7);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_10.addChild(_loc_3);
                _loc_4 = new EmploymentFightGroup10(_loc_3, param1, param2, null);
                this._aFightGroup.push(_loc_4);
            }
            return;
        }// end function

        private function createCard() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = new MovieClip();
            _loc_1.visible = true;
            _loc_1.alpha = 1;
            this._aBoxCardHit = [];
            var _loc_2:* = 0;
            while (_loc_2 < this._aPlayerInfo.length)
            {
                
                switch(_loc_2)
                {
                    case 0:
                    {
                        _loc_1 = this._mcFree10Set.cardInOutSet01Mc;
                        break;
                    }
                    case 1:
                    {
                        _loc_1 = this._mcFree10Set.cardInOutSet02Mc;
                        break;
                    }
                    case 2:
                    {
                        _loc_1 = this._mcFree10Set.cardInOutSet03Mc;
                        break;
                    }
                    case 3:
                    {
                        _loc_1 = this._mcFree10Set.cardInOutSet04Mc;
                        break;
                    }
                    case 4:
                    {
                        _loc_1 = this._mcFree10Set.cardInOutSet05Mc;
                        break;
                    }
                    case 5:
                    {
                        _loc_1 = this._mcFree10Set.cardInOutSet06Mc;
                        break;
                    }
                    case 6:
                    {
                        _loc_1 = this._mcFree10Set.cardInOutSet07Mc;
                        break;
                    }
                    case 7:
                    {
                        _loc_1 = this._mcFree10Set.cardInOutSet08Mc;
                        break;
                    }
                    case 8:
                    {
                        _loc_1 = this._mcFree10Set.cardInOutSet09Mc;
                        break;
                    }
                    case 9:
                    {
                        _loc_1 = this._mcFree10Set.cardInOutSet10Mc;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_3 = new EmploymentFighterDisplay(_loc_1.anim.chrNull, this._aPlayerInfo[_loc_2].id, false);
                _loc_3.setAnimationPattern(_loc_1.anim);
                this._aCardDisplayPlayer.push(_loc_3);
                _loc_4 = new PlayerSmallCard(_loc_1.cardInOut1Mc.cardNull);
                _loc_4.setPlayerId(this._aPlayerInfo[_loc_2].id);
                _loc_5 = new InStayOut(_loc_1.cardInOut1Mc);
                this._aIsoCard.push(_loc_5);
                _loc_6 = new InStayOut(_loc_1.anim);
                this._aIsoCardAnim.push(_loc_6);
                this._aCardAnim.push(_loc_1.anim);
                _loc_7 = new EmploymentBoxCardHit(_loc_1, cbCardMouseOver, cbCardMouseOut, this._aPlayerInfo[_loc_2]);
                _loc_1.anim.mouseEnabled = false;
                _loc_1.anim.mouseChildren = false;
                this._aBoxCardHit.push(_loc_7);
                _loc_2++;
            }
            return;
        }// end function

    }
}
