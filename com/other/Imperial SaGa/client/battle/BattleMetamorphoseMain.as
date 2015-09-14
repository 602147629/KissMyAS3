package battle
{

    public class BattleMetamorphoseMain extends Object
    {
        private const _PHASE_METAMORPHOSE_START:int = 1;
        private const _PHASE_METAMORPHOSE_END:int = 2;
        private const _PHASE_END:int = 999;
        private var _phase:int;
        private var _battleManager:BattleManager;
        private var _metamorphoseEnemy:BattleEnemyMetamorphoseBase;

        public function BattleMetamorphoseMain(param1:BattleManager)
        {
            var _loc_3:* = null;
            this._battleManager = param1;
            this._metamorphoseEnemy = null;
            var _loc_2:* = false;
            for each (_loc_3 in this._battleManager.getEntryEnemyMetamorphose())
            {
                
                _loc_3.checkMetamorphose();
                if (_loc_3.bMetamorphose)
                {
                    _loc_2 = true;
                }
            }
            if (_loc_2 == false)
            {
                this.setPhase(this._PHASE_END);
                return;
            }
            this.setPhase(this._PHASE_METAMORPHOSE_START);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._phase == this._PHASE_END;
        }// end function

        public function release() : void
        {
            this._battleManager = null;
            this._metamorphoseEnemy = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_METAMORPHOSE_START:
                {
                    this.controlMetamorphoseStart(param1);
                    break;
                }
                case this._PHASE_METAMORPHOSE_END:
                {
                    this.controlMetamorphoseEnd(param1);
                    break;
                }
                case this._PHASE_END:
                {
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
            this._phase = param1;
            switch(this._phase)
            {
                case this._PHASE_METAMORPHOSE_START:
                {
                    this.phaseMetamorphoseStart();
                    break;
                }
                case this._PHASE_METAMORPHOSE_END:
                {
                    this.phaseMetamorphoseEnd();
                    break;
                }
                case this._PHASE_END:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function phaseMetamorphoseStart() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._battleManager.getEntryEnemyMetamorphose())
            {
                
                if (_loc_1.bMetamorphose)
                {
                    this._metamorphoseEnemy = _loc_1;
                    _loc_2 = this._metamorphoseEnemy.characterAction as BattleActionEnemy;
                    _loc_2.setActionMetamorphoseStart();
                    break;
                }
            }
            return;
        }// end function

        private function controlMetamorphoseStart(param1:Number) : void
        {
            if (this._metamorphoseEnemy != null)
            {
                if (this._metamorphoseEnemy.characterAction.bActionEnd)
                {
                    this.setPhase(this._PHASE_METAMORPHOSE_END);
                }
            }
            return;
        }// end function

        private function phaseMetamorphoseEnd() : void
        {
            this._metamorphoseEnemy.setMetamorphose();
            return;
        }// end function

        private function controlMetamorphoseEnd(param1:Number) : void
        {
            if (this._metamorphoseEnemy != null)
            {
                if (this._metamorphoseEnemy.characterAction.isStay())
                {
                    this.setPhase(this._PHASE_END);
                }
            }
            return;
        }// end function

    }
}
