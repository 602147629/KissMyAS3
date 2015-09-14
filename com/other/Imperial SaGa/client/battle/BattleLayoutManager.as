package battle
{

    public class BattleLayoutManager extends Object
    {
        private var _layout:int;
        private var _nextPhase:int;
        private var _controlFunc:Function;
        private var _battleManager:BattleManager;
        private var _battleScroll:BattleScroll;
        public static const LAYOUT_NORMAL:int = 0;
        public static const LAYOUT_REPLENISH:int = 1;
        public static const LAYOUT_JOIN:int = 2;
        public static const LAYOUT_UNIT:int = 3;
        public static const LAYOUT_WIN:int = 4;

        public function BattleLayoutManager(param1:BattleManager, param2:BattleScroll)
        {
            this._layout = LAYOUT_NORMAL;
            this._nextPhase = Constant.UNDECIDED;
            this._controlFunc = null;
            this._battleManager = param1;
            this._battleScroll = param2;
            return;
        }// end function

        public function get layout() : int
        {
            return this._layout;
        }// end function

        public function get nextPhase() : int
        {
            return this._nextPhase;
        }// end function

        public function get bBusy() : Boolean
        {
            return this._controlFunc != null;
        }// end function

        public function release() : void
        {
            this._battleScroll = null;
            this._battleManager = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._controlFunc != null)
            {
                this._controlFunc(param1);
            }
            return;
        }// end function

        public function changeLayout(param1:int, param2:int) : void
        {
            this._nextPhase = param2;
            if (this._layout != param1)
            {
                this._layout = param1;
                switch(this._layout)
                {
                    case LAYOUT_NORMAL:
                    {
                        this.changeNormal();
                        break;
                    }
                    case LAYOUT_REPLENISH:
                    {
                        this.changeReplenish();
                        break;
                    }
                    case LAYOUT_JOIN:
                    {
                        this.changeJoin();
                        break;
                    }
                    case LAYOUT_UNIT:
                    {
                        this.changeUnit();
                        break;
                    }
                    case LAYOUT_WIN:
                    {
                        this.changeWin();
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

        private function changeNormal() : void
        {
            this._controlFunc = this.controlNormal;
            this._battleScroll.changeScroll(BattleScroll.SCROLL_NOMAL);
            return;
        }// end function

        private function controlNormal(param1:Number) : void
        {
            this._battleScroll.control();
            if (this._battleScroll.isBusy() == false)
            {
                this._controlFunc = null;
            }
            return;
        }// end function

        private function changeReplenish() : void
        {
            this._controlFunc = this.controlReplenish;
            this._battleScroll.changeScroll(BattleScroll.SCROLL_NOMAL);
            return;
        }// end function

        private function controlReplenish(param1:Number) : void
        {
            this._battleScroll.control();
            if (this._battleScroll.isBusy() == false)
            {
                this._controlFunc = null;
            }
            return;
        }// end function

        private function changeJoin() : void
        {
            this._controlFunc = this.controlJoin;
            return;
        }// end function

        private function controlJoin(param1:Number) : void
        {
            this._controlFunc = null;
            return;
        }// end function

        private function changeUnit() : void
        {
            this._controlFunc = this.controlUnit;
            return;
        }// end function

        private function controlUnit(param1:Number) : void
        {
            this._controlFunc = null;
            return;
        }// end function

        private function changeWin() : void
        {
            this._controlFunc = this.controlWin;
            if (this._battleManager.commanderPlayer)
            {
                this._battleScroll.changeScroll(BattleScroll.SCROLL_COMMANDER_FOCUS);
            }
            else
            {
                this._battleScroll.changeScroll(BattleScroll.SCROLL_NOMAL);
            }
            return;
        }// end function

        private function controlWin(param1:Number) : void
        {
            this._battleScroll.control();
            if (this._battleScroll.isBusy() == false)
            {
                this._controlFunc = null;
            }
            return;
        }// end function

    }
}
