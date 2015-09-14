package employment
{
    import PlayerCard.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import icon.*;
    import input.*;
    import message.*;
    import player.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EmploymentSpecialAnimation extends Object
    {
        private var _phase:int;
        private var _wait:Number;
        private var _mcBase:MovieClip;
        private var _mcCutInMessage:MovieClip;
        private var _mcNaviMessage:MovieClip;
        private var _isoMain:InStayOut;
        private var _isoStartEffect:InStayOut;
        private var _isoEndEffect:InStayOut;
        private var _isoCutInMessage:InStayOut;
        private var _isoNaviMessage:InStayOut;
        private var _cbOpen:Function;
        private var _cbClose:Function;
        private var _cbRetry:Function;
        private var _type:int;
        private var _aRunner:Array;
        private var _employPlayerInfo:PlayerInformation;
        private var _aCandidatePlayerId:Array;
        private var _bReturn:Boolean;
        private var _limitedParts:EmploymentLimitedParts;
        private var _playerBigCard:PlayerBigCard;
        private var _playerStatusWindow:EmploymentPlayerStatusWindow;
        private static const _PHASE_OPEN:int = 0;
        private static const _PHASE_STOP:int = 1;
        private static const _PHASE_READY_JUMP:int = 2;
        private static const _PHASE_READY_WAIT:int = 3;
        private static const _PHASE_READY_LIMITED_CUTIN:int = 4;
        private static const _PHASE_READY_START:int = 5;
        private static const _PHASE_RUNNING:int = 6;
        private static const _PHASE_GOAL:int = 7;
        private static const _PHASE_GOAL_LIMITED_CUTIN:int = 8;
        private static const _PHASE_CARD_OPEN:int = 9;
        private static const _PHASE_MESSAGE_IN:int = 10;
        private static const _PHASE_MESSAGE_WAIT:int = 11;
        private static const _PHASE_MESSAGE_STATUS_WAIT:int = 12;
        private static const _PHASE_MESSAGE_OUT:int = 13;
        private static const _PHASE_CLOSE:int = 14;
        private static const _READY_WAIT:Number = 1.2;
        private static const _START_WAIT:Number = 0.6;
        private static const _END_WAIT:Number = 0.6;
        private static const _LIMITED_CUTIN_WAIT:Number = 1.8;

        public function EmploymentSpecialAnimation(param1:DisplayObjectContainer, param2:int, param3:EmploymentLimitedData, param4:Function, param5:Function)
        {
            var _loc_8:* = null;
            this._cbOpen = param4;
            this._cbRetry = param5;
            this._cbClose = null;
            this._type = param2;
            this._wait = 0;
            this._aRunner = null;
            this._aCandidatePlayerId = null;
            this._bReturn = false;
            this._employPlayerInfo = null;
            this._playerBigCard = null;
            this._playerStatusWindow = null;
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonProduction.swf", Random.range(0, 1) == 0 ? ("summonFlatMc") : ("summonCliffMc"));
            this._mcCutInMessage = this._mcBase.ChrCutInBalloonMc;
            this._mcNaviMessage = this._mcBase.popupNaviChara2Mc;
            param1.addChild(this._mcBase);
            this._isoMain = new InStayOut(this._mcBase);
            this._isoStartEffect = new InStayOut(this._mcBase.signalStart);
            this._isoEndEffect = new InStayOut(this._mcBase.signalEnd);
            this._isoCutInMessage = new InStayOut(this._mcCutInMessage);
            this._isoNaviMessage = new InStayOut(this._mcNaviMessage);
            var _loc_6:* = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
            ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH).smoothing = true;
            this._mcNaviMessage.naviCharaNull.addChild(_loc_6);
            _loc_6.x = _loc_6.x - _loc_6.width / 2;
            _loc_6.y = _loc_6.y - _loc_6.height;
            InputManager.getInstance().addMouseCallback(this, null, this.cbMouseClick, null, null);
            TextControl.setText(this._mcCutInMessage.textMc.textDt, "");
            TextControl.setText(this._mcNaviMessage.ChrCutInBalloon2Mc.infoBalloonText1Mc.textDt, "");
            TextControl.setText(this._mcNaviMessage.ChrCutInBalloon2Mc.infoBalloonText2Mc.textDt, "");
            this._mcBase.charaStatusSetMc.visible = false;
            this._playerStatusWindow = new EmploymentPlayerStatusWindow(this._mcBase.statusPopNull);
            var _loc_7:* = [{mcStart:this._mcBase.chrNull1Jump, mcEnd:this._mcBase.chrNullOya1}, {mcStart:this._mcBase.chrNull2Jump, mcEnd:this._mcBase.chrNullOya2}, {mcStart:this._mcBase.chrNull3Jump, mcEnd:this._mcBase.chrNullOya3}];
            this._aRunner = [];
            for each (_loc_8 in _loc_7)
            {
                
                this._aRunner.push(new EmploymentRunner(_loc_8.mcEnd, _loc_8.mcStart, Constant.EMPTY_ID));
            }
            this._limitedParts = null;
            if (this._type == CommonConstant.EMPLOYMENT_TYPE_LIMITED)
            {
                this._limitedParts = new EmploymentLimitedParts(this._mcBase, param3.playerId, param3.bannerFileName, param3.bannerClickedJumpUrl);
            }
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
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
            if (this._limitedParts)
            {
                this._limitedParts.release();
            }
            this._limitedParts = null;
            for each (_loc_1 in this._aRunner)
            {
                
                _loc_1.release();
            }
            this._aRunner = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._isoStartEffect)
            {
                this._isoStartEffect.release();
            }
            this._isoStartEffect = null;
            if (this._isoEndEffect)
            {
                this._isoEndEffect.release();
            }
            this._isoEndEffect = null;
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
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            InputManager.getInstance().delMouseCallback(this);
            EmploymentRunner.resetWinLoseAnimation();
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_OPEN:
                {
                    this.initPhaseOpen();
                    break;
                }
                case _PHASE_STOP:
                {
                    this.initPhaseStop();
                    break;
                }
                case _PHASE_READY_JUMP:
                {
                    this.initPhaseReadyJump();
                    break;
                }
                case _PHASE_READY_WAIT:
                {
                    this.initPhaseReadyWait();
                    break;
                }
                case _PHASE_READY_LIMITED_CUTIN:
                {
                    this.initPhaseReadyLimitedCutin();
                    break;
                }
                case _PHASE_READY_START:
                {
                    this.initPhaseReadyStart();
                    break;
                }
                case _PHASE_RUNNING:
                {
                    this.initPhaseRunning();
                    break;
                }
                case _PHASE_GOAL:
                {
                    this.initPhaseGoal();
                    break;
                }
                case _PHASE_GOAL_LIMITED_CUTIN:
                {
                    this.initPhaseGoalLimitedCutin();
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
                case _PHASE_READY_JUMP:
                {
                    this.controlPhaseReadyJump(param1);
                    break;
                }
                case _PHASE_READY_WAIT:
                {
                    this.controlPhaseReadyWait(param1);
                    break;
                }
                case _PHASE_READY_LIMITED_CUTIN:
                {
                    this.controlPhaseReadyLimitedCutin(param1);
                    break;
                }
                case _PHASE_READY_START:
                {
                    this.controlPhaseReadyStart(param1);
                    break;
                }
                case _PHASE_RUNNING:
                {
                    this.controlPhaseRunning(param1);
                    break;
                }
                case _PHASE_GOAL:
                {
                    this.controlPhaseGoal(param1);
                    break;
                }
                case _PHASE_GOAL_LIMITED_CUTIN:
                {
                    this.controlPhaseGoalLimitedCutin(param1);
                    break;
                }
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
            if (this._limitedParts)
            {
                this._limitedParts.control();
            }
            return;
        }// end function

        private function initPhaseOpen() : void
        {
            this._isoMain.setIn(function () : void
            {
                setPhase(_PHASE_STOP);
                return;
            }// end function
            );
            return;
        }// end function

        private function initPhaseStop() : void
        {
            if (this._cbOpen != null)
            {
                this._cbOpen();
            }
            return;
        }// end function

        private function initPhaseReadyJump() : void
        {
            var _loc_1:* = 0;
            var _loc_6:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            if (this._playerBigCard == null)
            {
                this._playerBigCard = new PlayerBigCard(this._mcBase.cardNull);
            }
            this._playerBigCard.setPlayerId(this._employPlayerInfo.id);
            this._playerStatusWindow.setPlayerInformation(this._employPlayerInfo);
            if (this._limitedParts)
            {
                this._limitedParts.closeBanner();
            }
            this._isoMain.setInLabel("summonAnim");
            var _loc_2:* = new Array(this._aRunner.length);
            var _loc_3:* = new Array(this._aRunner.length);
            var _loc_4:* = [];
            var _loc_5:* = [];
            _loc_1 = 0;
            while (_loc_1 < EmploymentRunner.numLoseAnimation)
            {
                
                _loc_5.push(EmploymentRunner.getLoseAnimationNo(_loc_1));
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_9 = Random.range(0, (_loc_5.length - 1));
                _loc_2[_loc_1] = _loc_5[_loc_9];
                _loc_5.splice(_loc_9, 1);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < EmploymentRunner.numWinAnimation)
            {
                
                _loc_4.push(EmploymentRunner.getWinAnimationNo(_loc_1));
                _loc_1++;
            }
            _loc_6 = _loc_4[Random.range(0, (_loc_4.length - 1))];
            _loc_2[Random.range(0, (_loc_2.length - 1))] = _loc_6;
            var _loc_7:* = 0;
            _loc_1 = 0;
            while (_loc_1 < this._aCandidatePlayerId.length && _loc_1 < _loc_2.length)
            {
                
                if (_loc_2[_loc_1] == _loc_6)
                {
                    _loc_3[_loc_1] = this._aCandidatePlayerId[0];
                }
                else
                {
                    _loc_3[_loc_1] = this._aCandidatePlayerId[(_loc_7 + 1)];
                    _loc_7++;
                }
                _loc_1++;
            }
            _loc_7 = 0;
            for each (_loc_8 in this._aRunner)
            {
                
                _loc_8.setAnimationNo(_loc_2[_loc_7]);
                _loc_8.setId(_loc_3[_loc_7]);
                _loc_8.jump();
                _loc_7++;
            }
            return;
        }// end function

        private function controlPhaseReadyJump(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = true;
            for each (_loc_3 in this._aRunner)
            {
                
                _loc_3.control(param1);
                if (!_loc_3.isEndJump())
                {
                    _loc_2 = false;
                }
            }
            if (_loc_2)
            {
                this.setPhase(_PHASE_READY_WAIT);
            }
            return;
        }// end function

        private function initPhaseReadyWait() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aRunner)
            {
                
                _loc_1.ready();
            }
            this._wait = _READY_WAIT;
            return;
        }// end function

        private function controlPhaseReadyWait(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._wait > 0)
            {
                this._wait = this._wait - param1;
            }
            if (this._wait <= 0)
            {
                this.setPhase(_PHASE_READY_START);
            }
            for each (_loc_2 in this._aRunner)
            {
                
                _loc_2.control(param1);
            }
            return;
        }// end function

        private function initPhaseReadyLimitedCutin() : void
        {
            if (this._limitedParts)
            {
                this._limitedParts.openStartCutin();
            }
            this._wait = _LIMITED_CUTIN_WAIT;
            return;
        }// end function

        private function controlPhaseReadyLimitedCutin(param1:Number) : void
        {
            var t:* = param1;
            if (this._limitedParts && !this._limitedParts.bOpenedCutin)
            {
                return;
            }
            if (this._wait > 0)
            {
                this._wait = this._wait - t;
            }
            if (this._wait <= 0)
            {
                this._limitedParts.closeCutin(function () : void
            {
                setPhase(_PHASE_READY_START);
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function initPhaseReadyStart() : void
        {
            this._isoStartEffect.setIn();
            SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_SYOUBU);
            this._wait = _START_WAIT;
            return;
        }// end function

        private function controlPhaseReadyStart(param1:Number) : void
        {
            if (!this._isoStartEffect.bOpened)
            {
                return;
            }
            if (this._wait > 0)
            {
                this._wait = this._wait - param1;
            }
            if (this._wait <= 0)
            {
                this._isoStartEffect.setOut();
                this.setPhase(_PHASE_RUNNING);
            }
            return;
        }// end function

        private function initPhaseRunning() : void
        {
            var _loc_1:* = null;
            this._mcBase.gotoAndPlay("runStart");
            for each (_loc_1 in this._aRunner)
            {
                
                _loc_1.run();
            }
            return;
        }// end function

        private function controlPhaseRunning(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._mcBase.currentLabel == "goal")
            {
                this.setPhase(_PHASE_GOAL);
            }
            for each (_loc_2 in this._aRunner)
            {
                
                _loc_2.control(param1);
            }
            return;
        }// end function

        private function initPhaseGoal() : void
        {
            SoundManager.getInstance().playSe(SoundId.SE_GACHA_RESULT);
            this._isoEndEffect.setIn();
            if (this._limitedParts)
            {
                this._limitedParts.playFirework();
            }
            this._wait = _END_WAIT;
            return;
        }// end function

        private function controlPhaseGoal(param1:Number) : void
        {
            var t:* = param1;
            if (!this._isoEndEffect.bOpened)
            {
                return;
            }
            if (this._limitedParts && this._limitedParts.bPlayingFirework)
            {
                return;
            }
            if (this._wait > 0)
            {
                this._wait = this._wait - t;
            }
            if (this._wait <= 0)
            {
                this._isoEndEffect.setOut(function () : void
            {
                setPhase(_PHASE_CARD_OPEN);
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function initPhaseGoalLimitedCutin() : void
        {
            if (this._limitedParts)
            {
                this._limitedParts.openEndCutin();
            }
            this._wait = _LIMITED_CUTIN_WAIT;
            return;
        }// end function

        private function controlPhaseGoalLimitedCutin(param1:Number) : void
        {
            var t:* = param1;
            if (this._limitedParts && !this._limitedParts.bOpenedCutin)
            {
                return;
            }
            if (this._wait > 0)
            {
                this._wait = this._wait - t;
            }
            if (this._wait <= 0)
            {
                this._limitedParts.closeCutin(function () : void
            {
                setPhase(_PHASE_CARD_OPEN);
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function initPhaseCardOpen() : void
        {
            var runner:EmploymentRunner;
            var pos:Point;
            SoundManager.getInstance().playSe(SoundId.SE_REV_FLASHGATHER);
            this._isoMain.setInLabel("effStart", function () : void
            {
                setPhase(_PHASE_MESSAGE_IN);
                return;
            }// end function
            );
            var _loc_2:* = 0;
            var _loc_3:* = this._aRunner;
            while (_loc_3 in _loc_2)
            {
                
                runner = _loc_3[_loc_2];
                runner.effectStart();
            }
            var _loc_2:* = 0;
            var _loc_3:* = this._aRunner;
            while (_loc_3 in _loc_2)
            {
                
                runner = _loc_3[_loc_2];
                if (runner.isWinAnimation())
                {
                    pos = runner.mc.localToGlobal(new Point());
                    this._mcBase.effWinMc.x = pos.x;
                    this._mcBase.effWinMc.y = pos.y;
                    break;
                }
            }
            this._mcBase.effWinMc.gotoAndPlay("start");
            return;
        }// end function

        private function controlPhaseCardOpen() : void
        {
            if (this._mcBase.currentFrameLabel == "se1001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_CARDINCIDENT_ONE);
            }
            return;
        }// end function

        private function initPhaseMessageIn() : void
        {
            var _loc_1:* = PlayerManager.getInstance().getWordEmployment(this._employPlayerInfo.characterId);
            TextControl.setText(this._mcCutInMessage.textMc.textDt, _loc_1);
            TextControl.setText(this._mcNaviMessage.ChrCutInBalloon2Mc.infoBalloonText1Mc.textDt, TextControl.formatIdText(MessageId.EMPLOYMENT_GET_CHARACTER_NAVI_TEXT01, this._employPlayerInfo.name));
            TextControl.setIdText(this._mcNaviMessage.ChrCutInBalloon2Mc.infoBalloonText2Mc.textDt, MessageId.EMPLOYMENT_GET_CHARACTER_NAVI_TEXT02);
            var _loc_2:* = new PlayerRarityIcon(this._mcNaviMessage.ChrCutInBalloon2Mc.setCharaRankMc, this._employPlayerInfo.rarity);
            this._isoMain.setInLabel("commentOut");
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
            var runner:EmploymentRunner;
            if (!this._bReturn)
            {
                this._isoMain.setOut(function () : void
            {
                if (_cbRetry != null)
                {
                    _cbRetry();
                }
                return;
            }// end function
            );
                var _loc_2:* = 0;
                var _loc_3:* = this._aRunner;
                while (_loc_3 in _loc_2)
                {
                    
                    runner = _loc_3[_loc_2];
                    runner.out();
                }
            }
            else
            {
                this._mcBase.diorama_set1.visible = false;
                this._mcBase.diorama_set2.visible = false;
                this._mcBase.diorama_iwa.visible = false;
                this._mcBase.startLine.visible = false;
                this._mcBase.outSetMC.gotoAndPlay("start");
                this._isoMain.setInLabel("summonAnim");
                if (this._limitedParts)
                {
                    this._limitedParts.closeBanner();
                }
            }
            return;
        }// end function

        private function controlPhaseClose() : void
        {
            if (this._bReturn)
            {
                if (this._mcBase.outSetMC.currentLabel == "end")
                {
                    if (this._cbClose != null)
                    {
                        this._cbClose();
                        this._cbClose = null;
                    }
                }
            }
            return;
        }// end function

        public function playAnimation(param1:PlayerInformation, param2:Array) : void
        {
            this._employPlayerInfo = param1;
            this._aCandidatePlayerId = param2;
            this.setPhase(_PHASE_READY_JUMP);
            return;
        }// end function

        public function open() : void
        {
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function close(param1:Function) : void
        {
            this._cbClose = param1;
            this._bReturn = true;
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        public function openBanner() : void
        {
            if (this._limitedParts)
            {
                this._limitedParts.openBanner();
            }
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
