package battle
{
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import player.*;
    import quest.*;
    import utility.*;

    public class PartyStatusbar extends Object
    {
        private const MOVE_TIME:Number = 1;
        private var _baseMc:MovieClip;
        private var _bAutoHide:Boolean;
        private var _phase:int;
        private var _openTime:Number;
        private var _isoUi:InStayOut;
        private var _aTargetNode:Array;
        private var _selectedMc:MovieClip;
        private var _targetNode:MovieClip;
        private var _aCharaNull:Array;
        private var _aTargetPoint:Array;
        private var _distance:int;
        private var _aPartyUnit:Array;
        private var _bAnimation:Boolean;
        private var _bClosing:Boolean;
        public static const PHASE_HIDE:int = 1;
        public static const PHASE_OPEN:int = 2;
        public static const PHASE_INTER_UNIT:int = 3;
        public static const PHASE_REOPEN:int = 4;
        public static const PHASE_SHOW:int = 10;
        public static const PHASE_MOVE:int = 11;
        public static const PHASE_JOIN:int = 20;
        public static const PHASE_LOSE:int = 97;
        public static const PHASE_WIN:int = 98;
        public static const PHASE_CLOSE:int = 99;
        public static const DISTANCE_LIMIT:int = 6;

        public function PartyStatusbar(param1:MovieClip, param2:Boolean)
        {
            this._aCharaNull = [];
            this._baseMc = param1;
            this._bAutoHide = param2;
            this._isoUi = new InStayOut(this._baseMc);
            return;
        }// end function

        public function get bAutoHide() : Boolean
        {
            return this._bAutoHide;
        }// end function

        public function get aPartyUnit() : Array
        {
            return this._aPartyUnit;
        }// end function

        public function get bAnimation() : Boolean
        {
            return this._bAnimation;
        }// end function

        public function get bClosing() : Boolean
        {
            return this._bClosing;
        }// end function

        public function get bMoving() : Boolean
        {
            return this._phase == PHASE_MOVE;
        }// end function

        public function get bJoinable() : Boolean
        {
            return !(this._aTargetNode && this._aTargetNode.length > 0);
        }// end function

        public function release() : void
        {
            this._isoUi.release();
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case PHASE_HIDE:
                {
                    this.controlHide();
                    break;
                }
                case PHASE_OPEN:
                {
                    this.controlOpen(param1);
                    break;
                }
                case PHASE_INTER_UNIT:
                {
                    this.controlInterUnit();
                    break;
                }
                case PHASE_REOPEN:
                {
                    this.controlReopen(param1);
                    break;
                }
                case PHASE_SHOW:
                {
                    this.controlShow();
                    break;
                }
                case PHASE_MOVE:
                {
                    this.controlMove();
                    break;
                }
                case PHASE_JOIN:
                {
                    this.controlJoin();
                    break;
                }
                case PHASE_LOSE:
                {
                    this.controlLose();
                    break;
                }
                case PHASE_WIN:
                {
                    this.controlWin();
                    break;
                }
                case PHASE_CLOSE:
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
                    case PHASE_HIDE:
                    {
                        this.phaseHide();
                        break;
                    }
                    case PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case PHASE_INTER_UNIT:
                    {
                        this.phaseInterUnit();
                        break;
                    }
                    case PHASE_REOPEN:
                    {
                        this.phaseReopen();
                        break;
                    }
                    case PHASE_SHOW:
                    {
                        this.phaseShow();
                        break;
                    }
                    case PHASE_MOVE:
                    {
                        this.phaseMove();
                        break;
                    }
                    case PHASE_JOIN:
                    {
                        this.phaseJoin();
                        break;
                    }
                    case PHASE_LOSE:
                    {
                        this.phaseLose();
                        break;
                    }
                    case PHASE_WIN:
                    {
                        this.phaseWin();
                        break;
                    }
                    case PHASE_CLOSE:
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

        public function openWindow(param1:Number = 0) : void
        {
            if (this._isoUi.bOpened == false && this._isoUi.bAnimetionOpen == false)
            {
                this._openTime = param1;
                this._bAnimation = true;
                this.setPhase(PHASE_OPEN);
            }
            return;
        }// end function

        public function reopenWindow(param1:Number = 0) : void
        {
            if (this._isoUi.bOpened == false && this._isoUi.bAnimetionOpen == false)
            {
                this._openTime = param1;
                this._bAnimation = true;
                this.setPhase(PHASE_REOPEN);
            }
            return;
        }// end function

        public function closeWindow() : void
        {
            if (this._isoUi.bClosed == false && this._isoUi.bAnimetionClose == false)
            {
                this.setPhase(PHASE_CLOSE);
            }
            return;
        }// end function

        public function setParty(param1:QuestUnit, param2:int, param3:int) : void
        {
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_4:* = param1.teamNo;
            TextControl.setText(this._baseMc.textMc.textDt, TextControl.formatIdText(MessageId.QUEST_DIVIDE_DESIGNATION, _loc_4));
            var _loc_5:* = param1.aPlayer.length;
            var _loc_6:* = param1.aPlayer.length;
            if (param1.aPlayer.length > param3)
            {
                _loc_6 = param3 > 0 ? (param3) : (1);
            }
            this._baseMc.unitMergeMc.gotoAndStop("No" + _loc_6);
            this._selectedMc = MovieClip(this._baseMc.unitMergeMc).getChildByName("mergeChara" + _loc_6 + "Mc") as MovieClip;
            this._selectedMc.unitNameBGMc.gotoAndStop("0" + _loc_4);
            this._distance = param2;
            var _loc_7:* = param2 < DISTANCE_LIMIT ? (param2) : (DISTANCE_LIMIT);
            this._selectedMc.mergeRouteMc.gotoAndStop("masN0" + _loc_7);
            this._aPartyUnit = [];
            var _loc_8:* = 0;
            while (_loc_8 < _loc_5)
            {
                
                _loc_10 = param1.aPlayer[_loc_8] as PlayerDisplay;
                if (_loc_10 != null)
                {
                    this._aPartyUnit.push(_loc_10);
                    _loc_10.setParent(this._baseMc);
                    if (param2 < DISTANCE_LIMIT)
                    {
                        _loc_10.pos = new Point(this._selectedMc.charaJumpInMc.x, this._selectedMc.charaJumpInMc.y);
                        _loc_10.mc.x = this._selectedMc.charaJumpInMc.x;
                        _loc_10.mc.y = this._selectedMc.charaJumpInMc.y;
                    }
                    else
                    {
                        _loc_11 = this._selectedMc.mergeRouteMc;
                        _loc_12 = this._selectedMc.mergeRouteMc.mass01Mc;
                        _loc_10.pos = new Point(_loc_12.x + _loc_11.x, _loc_12.y + _loc_11.y);
                    }
                    _loc_10.setAnimSideDashMerge();
                    this._aCharaNull.push(this._selectedMc.charaJumpInMc.getChildByName("charaNull" + this._aPartyUnit.length + "Mc"));
                }
                _loc_8++;
            }
            this._aTargetNode = [];
            var _loc_9:* = 0;
            while (_loc_9 < this._selectedMc.mergeRouteMc.numChildren)
            {
                
                if (MovieClip(this._selectedMc.mergeRouteMc).getChildAt(_loc_9).alpha > 0)
                {
                    this._aTargetNode.push(this._selectedMc.mergeRouteMc.getChildAt(_loc_9));
                }
                _loc_9++;
            }
            return;
        }// end function

        public function goForward() : Boolean
        {
            if (this._aTargetNode && this._aTargetNode.length > 0)
            {
                this.setPhase(PHASE_MOVE);
                return false;
            }
            return true;
        }// end function

        public function setCharacterVisible(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aPartyUnit)
            {
                
                _loc_2.mc.visible = param1;
            }
            return;
        }// end function

        public function mergeParty(param1:Array) : void
        {
            this._aTargetPoint = param1;
            var _loc_2:* = 0;
            while (_loc_2 < this._aTargetPoint.length)
            {
                
                this._aTargetPoint[_loc_2] = Point(this._aTargetPoint[_loc_2]).subtract(new Point(this._baseMc.x, this._baseMc.y));
                _loc_2++;
            }
            this.setPhase(PHASE_JOIN);
            return;
        }// end function

        public function setWin() : void
        {
            this.setPhase(PHASE_WIN);
            return;
        }// end function

        public function setLose() : void
        {
            this.setPhase(PHASE_LOSE);
            return;
        }// end function

        public function setDefault() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aPartyUnit)
            {
                
                _loc_1.setAnimSideDashMerge();
            }
            this.setPhase(PHASE_SHOW);
            return;
        }// end function

        private function phaseHide() : void
        {
            return;
        }// end function

        private function controlHide() : void
        {
            return;
        }// end function

        private function phaseOpen() : void
        {
            return;
        }// end function

        private function controlOpen(param1:Number) : void
        {
            if (this._isoUi.bOpened == false && this._isoUi.bAnimetionOpen == false)
            {
                if (this._openTime <= 0)
                {
                    this._isoUi.setIn(this.cbOpen);
                }
                else
                {
                    this._openTime = this._openTime - param1;
                }
            }
            return;
        }// end function

        private function cbOpen() : void
        {
            this.setPhase(PHASE_INTER_UNIT);
            return;
        }// end function

        private function phaseReopen() : void
        {
            return;
        }// end function

        private function controlReopen(param1:Number) : void
        {
            if (this._isoUi.bOpened == false && this._isoUi.bAnimetionOpen == false)
            {
                if (this._openTime <= 0)
                {
                    this._isoUi.setIn(this.cbReopen);
                }
                else
                {
                    this._openTime = this._openTime - param1;
                }
            }
            return;
        }// end function

        private function cbReopen() : void
        {
            this.setPhase(PHASE_SHOW);
            return;
        }// end function

        private function phaseInterUnit() : void
        {
            if (this._distance >= DISTANCE_LIMIT)
            {
                this._selectedMc.charaJumpInMc.gotoAndPlay("end");
                return;
            }
            this._selectedMc.charaJumpInMc.gotoAndPlay("in");
            return;
        }// end function

        private function controlInterUnit() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._aPartyUnit.length)
            {
                
                _loc_2 = new Matrix();
                _loc_3 = this._aCharaNull[_loc_1];
                _loc_2.translate(_loc_3.x, _loc_3.y);
                this._aPartyUnit[_loc_1].mc.transform.matrix = _loc_2;
                _loc_1++;
            }
            if (this._selectedMc.charaJumpInMc.currentFrameLabel == "end")
            {
                this.setPhase(PHASE_MOVE);
            }
            return;
        }// end function

        private function phaseShow() : void
        {
            this._bAnimation = false;
            return;
        }// end function

        private function controlShow() : void
        {
            return;
        }// end function

        private function phaseMove() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._distance <= DISTANCE_LIMIT)
            {
                this._targetNode = this._aTargetNode.pop();
                _loc_1 = this._selectedMc.mergeRouteMc;
                _loc_2 = new Point(this._targetNode.x + _loc_1.x, this._targetNode.y + _loc_1.y);
                for each (_loc_3 in this._aPartyUnit)
                {
                    
                    _loc_3.setTargetPoint(_loc_2, this.MOVE_TIME);
                }
            }
            var _loc_4:* = this;
            var _loc_5:* = this._distance - 1;
            _loc_4._distance = _loc_5;
            return;
        }// end function

        private function controlMove() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = true;
            for each (_loc_2 in this._aPartyUnit)
            {
                
                if (_loc_2.bMoveing)
                {
                    _loc_2.control(0.1);
                    _loc_1 = false;
                }
            }
            if (_loc_1 == true)
            {
                this.setPhase(PHASE_SHOW);
            }
            return;
        }// end function

        private function phaseJoin() : void
        {
            var _loc_2:* = null;
            this._bAnimation = true;
            var _loc_1:* = 0;
            for each (_loc_2 in this._aPartyUnit)
            {
                
                _loc_2.setTargetJump(this._aTargetPoint[_loc_1]);
                _loc_2.mc.transform.matrix = new Matrix();
                _loc_1++;
            }
            return;
        }// end function

        private function controlJoin() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = true;
            for each (_loc_2 in this._aPartyUnit)
            {
                
                if (_loc_2.bMoveing)
                {
                    _loc_2.control(0.1);
                    _loc_1 = false;
                }
            }
            if (_loc_1)
            {
                this._bClosing = true;
                this.setPhase(PHASE_CLOSE);
            }
            return;
        }// end function

        private function phaseWin() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aPartyUnit)
            {
                
                _loc_1.setAnimWin();
            }
            return;
        }// end function

        private function controlWin() : void
        {
            return;
        }// end function

        private function phaseLose() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aPartyUnit)
            {
                
                _loc_1.setAnimCrouch();
            }
            return;
        }// end function

        private function controlLose() : void
        {
            return;
        }// end function

        private function phaseClose() : void
        {
            this._isoUi.setOut(this.cbClose);
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function cbClose() : void
        {
            this._bClosing = false;
            this._bAnimation = false;
            this.setPhase(PHASE_HIDE);
            return;
        }// end function

    }
}
