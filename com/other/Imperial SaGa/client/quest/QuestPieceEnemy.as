package quest
{
    import enemy.*;
    import flash.display.*;
    import resource.*;

    public class QuestPieceEnemy extends QuestPiece
    {
        private const _SCALE_BOSS:Number = 2;
        private const _SCALE_NORMAL:Number = 1.5;
        private var _squareId:int;
        private var _displayMc:MovieClip;
        private var _enemyInfo:EnemyInformation;
        private var _rank:int;
        private var _bBossBattle:Boolean;
        private static const RANK_EASY:String = "rank1";
        private static const RANK_NORMAL:String = "rank2";
        private static const RANK_HARD:String = "rank3";
        private static const BOUNDARY_EASY:int = 1;
        private static const BOUNDARY_NORMAL:int = 71;
        private static const BOUNDARY_HARD:int = 150;

        public function QuestPieceEnemy(param1:DisplayObjectContainer, param2:int, param3:EnemyInformation, param4:int)
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            this._enemyInfo = param3;
            this._rank = param4;
            if (param2 == QuestConstant.SQUARE_ATTR1_BOSSBATTLE)
            {
                this._displayMc = ResourceManager.getInstance().createMovieClip(getResource(), "BossMonsterSymbolMc");
                this._displayMc.scaleX = this._SCALE_BOSS;
                this._displayMc.scaleY = this._SCALE_BOSS;
                this._bBossBattle = true;
            }
            else
            {
                this._displayMc = ResourceManager.getInstance().createMovieClip(getResource(), "MonsterSymbolMc");
                this._displayMc.scaleX = this._SCALE_NORMAL;
                this._displayMc.scaleY = this._SCALE_NORMAL;
                this._bBossBattle = false;
                if (this._enemyInfo.symbolType == Constant.EMPTY_ID)
                {
                    this._displayMc.monster.monsSymbolMc.monsTypeMc.visible = false;
                }
                else
                {
                    this._displayMc.monster.monsSymbolMc.monsTypeMc.visible = true;
                    this._displayMc.monster.monsSymbolMc.monsTypeMc.gotoAndStop(this._enemyInfo.symbolType);
                }
                _loc_6 = this.getEnemyRankLabel(this._rank);
                this._displayMc.monster.monsSymbolMc.gotoAndStop(_loc_6);
            }
            this._displayMc.gotoAndPlay("stay");
            super(param1, this._displayMc);
            setPieceShadow(false);
            return;
        }// end function

        public function get squareId() : int
        {
            return this._squareId;
        }// end function

        public function set squareId(param1:int) : void
        {
            this._squareId = param1;
            return;
        }// end function

        public function setFrame(param1:int) : void
        {
            this._displayMc.monster.gotoAndPlay(param1);
            return;
        }// end function

        override protected function disappear() : void
        {
            var _loc_1:* = null;
            if (_bVanish)
            {
                if (this._displayMc.currentLabel != "disappear")
                {
                    this._displayMc.gotoAndPlay("disappear");
                    if (this._bBossBattle == false)
                    {
                        if (this._enemyInfo.symbolType == Constant.EMPTY_ID)
                        {
                            this._displayMc.monster.monsSymbolMc.monsTypeMc.visible = false;
                        }
                        else
                        {
                            this._displayMc.monster.monsSymbolMc.monsTypeMc.visible = true;
                            this._displayMc.monster.monsSymbolMc.monsTypeMc.gotoAndStop(this._enemyInfo.symbolType);
                        }
                        _loc_1 = this.getEnemyRankLabel(this._rank);
                        this._displayMc.monster.monsSymbolMc.gotoAndStop(_loc_1);
                    }
                }
                if (this._displayMc.monster.currentLabel == "end")
                {
                    this.visible = false;
                }
            }
            return;
        }// end function

        private function getEnemyRankLabel(param1:int) : String
        {
            var _loc_2:* = RANK_HARD;
            if (param1 < BOUNDARY_NORMAL)
            {
                _loc_2 = RANK_EASY;
            }
            else if (param1 < BOUNDARY_HARD)
            {
                _loc_2 = RANK_NORMAL;
            }
            return _loc_2;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.QUEST_PATH + "MonsterSymbol.swf";
        }// end function

    }
}
