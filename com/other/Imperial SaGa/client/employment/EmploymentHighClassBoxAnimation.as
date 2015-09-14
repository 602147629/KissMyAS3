package employment
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import message.*;
    import player.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EmploymentHighClassBoxAnimation extends EmploymentBoxAnimationBase
    {
        private var _phase:int;
        private var _wait:Number;
        private var _mcBase:MovieClip;
        private var _mcNaviMessage:MovieClip;
        private var _mcStartLine:MovieClip;
        private var _isoStartEffect:InStayOut;
        private var _isoEndEffect:InStayOut;
        private var _isoNaviMessage:InStayOut;
        private var _cbClose:Function;
        private var _aWinnerPlayerId:Array;
        private var _aOtherPlayerId:Array;
        private var _aRunnerAll:Array;
        private var _aRunnerForLoser:Array;
        private var _aRunnerForWinner:Array;
        private var _aRunnerForStronger:Array;
        private var _prevCurrentLabel:String;
        private var _aWinner:Array;
        private static const _PHASE_STOP:int = 1;
        private static const _PHASE_READY:int = 2;
        private static const _PHASE_RUNNING:int = 3;
        private static const _PHASE_GOAL:int = 4;
        private static const _PHASE_WINNER_IN:int = 5;
        private static const _PHASE_CARD_OPEN:int = 6;
        private static const _PHASE_MESSAGE_IN_WAIT:int = 7;
        private static const _PHASE_MESSAGE_IN:int = 8;
        private static const _PHASE_MESSAGE_OUT_WAIT:int = 9;
        private static const _PHASE_MESSAGE_OUT:int = 10;
        private static const _PHASE_CLOSE:int = 11;
        private static const _START_WAIT:Number = 0.6;
        private static const _END_WAIT:Number = 0.6;

        public function EmploymentHighClassBoxAnimation(param1:MovieClip)
        {
            var exp:RegExp;
            var mc:* = param1;
            super(mc);
            this._cbClose = null;
            this._wait = 0;
            this._aWinnerPlayerId = null;
            this._aOtherPlayerId = null;
            this._mcBase = mc;
            this._mcNaviMessage = this._mcBase.popupNaviChara2Mc;
            this._mcStartLine = this._mcBase.startLine;
            this._isoStartEffect = new InStayOut(this._mcBase.signalStart);
            this._isoEndEffect = new InStayOut(this._mcBase.signalEnd);
            this._isoNaviMessage = new InStayOut(this._mcNaviMessage);
            var naviPng:* = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
            naviPng.smoothing = true;
            this._mcNaviMessage.naviCharaNull.addChild(naviPng);
            naviPng.x = naviPng.x - naviPng.width / 2;
            naviPng.y = naviPng.y - naviPng.height;
            InputManager.getInstance().addMouseCallback(this, null, this.cbMouseClick, null, null);
            TextControl.setIdText(this._mcNaviMessage.ChrCutInBalloon2Mc.infoBalloonText2Mc.textDt, MessageId.EMPLOYMENT_GET_CHARACTER_NAVI_TEXT03);
            this._aRunnerAll = [];
            this._aRunnerForLoser = [];
            this._aRunnerForWinner = [];
            this._aRunnerForStronger = [];
            var i:int;
            while (i < this._mcBase.numChildren)
            {
                
                mc = this._mcBase.getChildAt(i) as MovieClip;
                if (mc)
                {
                    exp = new RegExp(/chrNull([0-9][0-9])(.*)""chrNull([0-9][0-9])(.*)/);
                    mc.name.replace(exp, function () : void
            {
                arguments = new EmploymentBoxRunner(mc, parseInt(arguments[1]));
                _aRunnerAll.push(arguments);
                switch(arguments[2])
                {
                    case "_rare":
                    {
                        _aRunnerForStronger.push(arguments);
                        break;
                    }
                    case "_lose":
                    {
                        _aRunnerForLoser.push(arguments);
                        break;
                    }
                    default:
                    {
                        _aRunnerForWinner.push(arguments);
                        break;
                        break;
                    }
                }
                return;
            }// end function
            );
                }
                i = (i + 1);
            }
            var sortFunc:* = function (param1:EmploymentBoxRunner, param2:EmploymentBoxRunner) : int
            {
                return param1.index - param2.index;
            }// end function
            ;
            this._aRunnerAll.sort(sortFunc);
            this._aRunnerForLoser.sort(sortFunc);
            this._aRunnerForWinner.sort(sortFunc);
            this._aRunnerForStronger.sort(sortFunc);
            this._prevCurrentLabel = "";
            this._aWinner = [];
            this.setPhase(_PHASE_STOP);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._phase == _PHASE_STOP;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.release();
            for each (_loc_1 in this._aRunnerAll)
            {
                
                _loc_1.releaseRunner();
            }
            this._aRunnerAll = null;
            this._aRunnerForLoser = null;
            this._aRunnerForWinner = null;
            this._aRunnerForStronger = null;
            for each (_loc_2 in this._aWinner)
            {
                
                _loc_2.release();
            }
            this._aWinner = null;
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
                case _PHASE_READY:
                {
                    this.initPhaseReady();
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
                case _PHASE_WINNER_IN:
                {
                    this.initPhaseWinnerIn();
                    break;
                }
                case _PHASE_CARD_OPEN:
                {
                    this.initPhaseCardOpen();
                    break;
                }
                case _PHASE_MESSAGE_IN_WAIT:
                {
                    this.initPhaseMessageInWait();
                    break;
                }
                case _PHASE_MESSAGE_IN:
                {
                    this.initPhaseMessageIn();
                    break;
                }
                case _PHASE_MESSAGE_OUT_WAIT:
                {
                    this.initPhaseMessageOutWait();
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
                case _PHASE_READY:
                {
                    this.controlPhaseReady(param1);
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
                case _PHASE_WINNER_IN:
                {
                    this.controlPhaseWinnerIn();
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
            this._mcBase.visible = false;
            return;
        }// end function

        private function initPhaseReady() : void
        {
            var i:int;
            var aLotLoser:Array;
            var aLotWinner:Array;
            var aLotStronger:Array;
            var runner:EmploymentBoxRunner;
            var pInfo:PlayerInformation;
            var winner:EmploymentBoxWinner;
            this._mcBase.visible = true;
            var aMcWinner:Array;
            aLotLoser;
            aLotWinner;
            aLotStronger;
            i;
            while (i < this._aRunnerForLoser.length)
            {
                
                runner = this._aRunnerForLoser[i];
                aLotLoser.push(runner);
                i = (i + 1);
            }
            i;
            while (i < this._aRunnerForWinner.length)
            {
                
                runner = this._aRunnerForWinner[i];
                aLotWinner.push(runner);
                i = (i + 1);
            }
            i;
            while (i < this._aRunnerForStronger.length)
            {
                
                runner = this._aRunnerForStronger[i];
                aLotStronger.push(runner);
                i = (i + 1);
            }
            var lotFunc:* = function (param1:int, param2:Array) : void
            {
                var _loc_3:* = Random.range(0, (param2.length - 1));
                var _loc_4:* = param2[_loc_3];
                param2[_loc_3].setPlayerId(param1);
                var _loc_5:* = aLotLoser.indexOf(_loc_4);
                if (aLotLoser.indexOf(_loc_4) != -1)
                {
                    aLotLoser.splice(_loc_5, 1);
                }
                _loc_5 = aLotWinner.indexOf(_loc_4);
                if (_loc_5 != -1)
                {
                    aLotWinner.splice(_loc_5, 1);
                }
                _loc_5 = aLotStronger.indexOf(_loc_4);
                if (_loc_5 != -1)
                {
                    aLotStronger.splice(_loc_5, 1);
                }
                return;
            }// end function
            ;
            var aInfo:Array;
            i;
            while (i < this._aWinnerPlayerId.length)
            {
                
                pInfo = PlayerManager.getInstance().getPlayerInformation(this._aWinnerPlayerId[i]);
                this.lotFunc(this._aWinnerPlayerId[i], PlayerManager.getInstance().cmpRaritySuperRare(pInfo.rarity) >= 0 && aLotStronger.length > 0 ? (aLotStronger) : (aLotWinner));
                aInfo.push(pInfo);
                i = (i + 1);
            }
            i;
            while (i < this._aOtherPlayerId.length)
            {
                
                this.lotFunc(this._aOtherPlayerId[i], aLotLoser);
                i = (i + 1);
            }
            i;
            while (i < aMcWinner.length && i < aInfo.length)
            {
                
                winner = new EmploymentBoxWinner(aMcWinner[i].charaNull, aMcWinner[i].cardNull, aInfo[i], cbCardMouseOver, cbCardMouseOut);
                this._aWinner.push(winner);
                i = (i + 1);
            }
            this._mcBase.gotoAndStop("signalStart");
            this._isoStartEffect.setIn();
            SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_SYOUBU);
            this._wait = _START_WAIT;
            return;
        }// end function

        private function controlPhaseReady(param1:Number) : void
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
            this._mcBase.gotoAndPlay("signalStart");
            return;
        }// end function

        private function controlPhaseRunning(param1:Number) : void
        {
            var runner:EmploymentBoxRunner;
            var exp:RegExp;
            var t:* = param1;
            var _loc_3:* = 0;
            var _loc_4:* = this._aRunnerAll;
            while (_loc_4 in _loc_3)
            {
                
                runner = _loc_4[_loc_3];
                if (runner.bEnable)
                {
                    runner.checkStarted(this._mcStartLine);
                    runner.control(t);
                }
            }
            if (this._mcBase.currentLabel != this._prevCurrentLabel)
            {
                if (this._mcBase.currentLabel == "se1001")
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_EXPSMALL);
                }
                if (this._mcBase.currentLabel == "se1002")
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_EXPSMALL);
                }
                if (this._mcBase.currentLabel == "se1101")
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_EXPBIG);
                }
                this._prevCurrentLabel = this._mcBase.currentLabel;
                exp = new RegExp(/chrNull([0-9][0-9])(([_:][0-9][0-9])*)_(.*)""chrNull([0-9][0-9])(([_:][0-9][0-9])*)_(.*)/);
                this._prevCurrentLabel.replace(exp, function () : void
            {
                arguments = new activation;
                var actionLabel:String;
                var idx:int;
                var e:int;
                var i:int;
                var arguments:* = arguments;
                var args:* = ;
                var s:* = parseInt([1]);
                actionLabel = [length - 3];
                var setupFunc:* = function (param1:int) : void
                {
                    if (param1 >= _aRunnerAll.length)
                    {
                        return;
                    }
                    var _loc_2:* = _aRunnerAll[param1];
                    if (!_loc_2.bEnable)
                    {
                        return;
                    }
                    switch(actionLabel)
                    {
                        case "jump":
                        {
                            jumpIn(_loc_2);
                            break;
                        }
                        default:
                        {
                            _loc_2.setAnimation(actionLabel);
                            break;
                            break;
                        }
                    }
                    return;
                }// end function
                ;
                arguments.(( - 1));
                var com:* = [2];
                while (true)
                {
                    
                    idx = search(new RegExp(/[_:][0-9][0-9]""[_:][0-9][0-9]/));
                    if ( == -1)
                    {
                        break;
                    }
                    e = parseInt(slice(( + 1),  + 3));
                    if ( != 0)
                    {
                        if (charAt() == "_")
                        {
                            i = ;
                            while ( < )
                            {
                                
                                arguments.();
                                i = ( + 1);
                            }
                        }
                        else if (charAt() == ":")
                        {
                            arguments.(( - 1));
                            s = ;
                        }
                    }
                    com = slice( + 3);
                }
                return;
            }// end function
            );
            }
            if (this._mcBase.currentLabel == "signalEnd")
            {
                this.setPhase(_PHASE_GOAL);
            }
            return;
        }// end function

        private function initPhaseGoal() : void
        {
            SoundManager.getInstance().playSe(SoundId.SE_GACHA_RESULT);
            this._isoEndEffect.setIn();
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
            if (this._wait > 0)
            {
                this._wait = this._wait - t;
            }
            if (this._wait <= 0)
            {
                this._isoEndEffect.setOut(function () : void
            {
                setPhase(_PHASE_WINNER_IN);
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function initPhaseWinnerIn() : void
        {
            var _loc_1:* = null;
            this._mcBase.gotoAndPlay("signalEnd");
            this._prevCurrentLabel = "";
            for each (_loc_1 in this._aWinner)
            {
                
                _loc_1.show();
            }
            return;
        }// end function

        private function controlPhaseWinnerIn() : void
        {
            var exp:RegExp;
            if (this._mcBase.currentLabel != this._prevCurrentLabel)
            {
                this._prevCurrentLabel = this._mcBase.currentLabel;
                exp = new RegExp(/chrCardNull([0-9][0-9])(_([0-9][0-9]))?_(.*)""chrCardNull([0-9][0-9])(_([0-9][0-9]))?_(.*)/);
                this._prevCurrentLabel.replace(exp, function () : void
            {
                var _loc_5:* = null;
                arguments = parseInt(arguments[1]);
                var _loc_3:* = parseInt(arguments[3]);
                if (_loc_3 == 0)
                {
                    arguments = _loc_3;
                }
                var _loc_4:* = arguments - 1;
                while (_loc_4 < _loc_3 && _loc_4 < _aWinner.length)
                {
                    
                    _loc_5 = _aWinner[_loc_4];
                    _loc_5.setAnimation(arguments[4]);
                    _loc_4++;
                }
                return;
            }// end function
            );
            }
            if (this._mcBase.currentLabel == "stay")
            {
                this.setPhase(_PHASE_CARD_OPEN);
            }
            return;
        }// end function

        private function initPhaseCardOpen() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 1;
            SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_CARDINCIDENT_MANY);
            for each (_loc_2 in this._aWinner)
            {
                
                _loc_2.delayOpen(0.1 * _loc_1);
                _loc_1++;
            }
            return;
        }// end function

        private function controlPhaseCardOpen(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = true;
            for each (_loc_3 in this._aWinner)
            {
                
                _loc_3.control(param1);
                if (!_loc_3.isOpened())
                {
                    _loc_2 = false;
                }
            }
            if (_loc_2)
            {
                this.setPhase(_PHASE_MESSAGE_IN_WAIT);
            }
            return;
        }// end function

        private function initPhaseMessageInWait() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aRunnerAll)
            {
                
                _loc_1.releaseRunner();
            }
            return;
        }// end function

        private function initPhaseMessageIn() : void
        {
            setCardMouseEnable(true);
            this._isoNaviMessage.setIn();
            return;
        }// end function

        private function controlPhaseMessageIn(param1:Number) : void
        {
            if (this._isoNaviMessage.bOpened)
            {
                this.setPhase(_PHASE_MESSAGE_OUT_WAIT);
            }
            return;
        }// end function

        private function initPhaseMessageOutWait() : void
        {
            return;
        }// end function

        private function initPhaseMessageOut() : void
        {
            var _loc_1:* = null;
            setCardMouseEnable(false);
            this._isoNaviMessage.setOut();
            for each (_loc_1 in this._aWinner)
            {
                
                _loc_1.close();
            }
            return;
        }// end function

        private function controlPhaseMessageOut(param1:Number) : void
        {
            if (!this._isoNaviMessage.bEnd)
            {
                return;
            }
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this._mcBase.gotoAndPlay("out");
            this._prevCurrentLabel = "";
            return;
        }// end function

        private function controlPhaseClose() : void
        {
            var exp:RegExp;
            var winner:EmploymentBoxWinner;
            if (this._mcBase.currentLabel != this._prevCurrentLabel)
            {
                this._prevCurrentLabel = this._mcBase.currentLabel;
                exp = new RegExp(/chrCardNull([0-9][0-9])(_([0-9][0-9]))?_(.*)""chrCardNull([0-9][0-9])(_([0-9][0-9]))?_(.*)/);
                this._prevCurrentLabel.replace(exp, function () : void
            {
                var _loc_5:* = null;
                arguments = parseInt(arguments[1]);
                var _loc_3:* = parseInt(arguments[3]);
                if (_loc_3 == 0)
                {
                    arguments = _loc_3;
                }
                var _loc_4:* = arguments - 1;
                while (_loc_4 < _loc_3 && _loc_4 < _aWinner.length)
                {
                    
                    _loc_5 = _aWinner[_loc_4];
                    _loc_5.setAnimation(arguments[4]);
                    _loc_4++;
                }
                return;
            }// end function
            );
            }
            if (this._mcBase.currentLabel == "end")
            {
                var _loc_2:* = 0;
                var _loc_3:* = this._aWinner;
                while (_loc_3 in _loc_2)
                {
                    
                    winner = _loc_3[_loc_2];
                    winner.release();
                }
                this._aWinner.length = 0;
                this.setPhase(_PHASE_STOP);
            }
            return;
        }// end function

        public function setRunnerId(param1:Array, param2:Array) : void
        {
            this._aWinnerPlayerId = param1;
            this._aOtherPlayerId = param2;
            return;
        }// end function

        public function playAnimation() : void
        {
            this.setPhase(_PHASE_READY);
            return;
        }// end function

        private function jumpIn(param1:EmploymentBoxRunner) : void
        {
            var _loc_2:* = [this._mcBase.chrNull1Jump, this._mcBase.chrNull2Jump, this._mcBase.chrNull3Jump];
            var _loc_3:* = _loc_2[Random.range(0, (_loc_2.length - 1))];
            param1.setJumper(this._mcBase, new Point(_loc_3.x, _loc_3.y));
            return;
        }// end function

        private function cbMouseClick(event:MouseEvent) : void
        {
            if (this._phase == _PHASE_MESSAGE_IN_WAIT)
            {
                this.setPhase(_PHASE_MESSAGE_IN);
            }
            else if (this._phase == _PHASE_MESSAGE_OUT_WAIT)
            {
                SoundManager.getInstance().playSe(SoundId.SE_CANCEL);
                this.setPhase(_PHASE_MESSAGE_OUT);
            }
            return;
        }// end function

    }
}
