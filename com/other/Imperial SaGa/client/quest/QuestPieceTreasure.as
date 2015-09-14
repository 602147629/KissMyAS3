package quest
{
    import flash.display.*;
    import resource.*;

    public class QuestPieceTreasure extends QuestSprite
    {
        private var _squareId:int;
        private var _displayMc:MovieClip;
        private var _treasureRank:int;
        private static const MAP_MC_GOLD_BOX:String = "QuestMapTreasureIcon02";
        private static const MAP_MC_SILVER_BOX:String = "QuestMapTreasureIcon01";
        private static const MAP_MC_WOOD_BOX:String = "QuestMapTreasureIcon00";
        private static const DIVIDE_MC_GOLD_BOX:String = "QuestMapTreasureDivideIcon02";
        private static const DIVIDE_MC_SILVER_BOX:String = "QuestMapTreasureDivideIcon01";
        private static const DIVIDE_MC_WOOD_BOX:String = "QuestMapTreasureDivideIcon00";

        public function QuestPieceTreasure(param1:DisplayObjectContainer, param2:QuestSquare, param3:int)
        {
            super(QuestConstant.PIECE_PRIORITY_TREASURE, param2.y);
            param1.addChild(this);
            this._squareId = param2.id;
            this._treasureRank = param3;
            this._displayMc = createMapMc(this._treasureRank);
            this._displayMc.x = param2.x;
            this._displayMc.y = param2.y;
            this._displayMc.mcIcon.gotoAndPlay("stop");
            this.addChild(this._displayMc);
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

        public function release() : void
        {
            if (this._displayMc && this._displayMc.parent)
            {
                this._displayMc.parent.removeChild(this._displayMc);
            }
            this._displayMc = null;
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

        public function openBox() : void
        {
            setSortPriority(QuestConstant.PIECE_PRIORITY_TREASURE_OPEN);
            this._displayMc.mcIcon.gotoAndPlay("start");
            return;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.QUEST_PATH + "UI_QuestMap.swf";
        }// end function

        public static function createMapMc(param1:int) : MovieClip
        {
            var _loc_2:* = null;
            switch(param1)
            {
                case QuestConstant.TREASURE_RANK_GOLD:
                {
                    _loc_2 = MAP_MC_GOLD_BOX;
                    break;
                }
                case QuestConstant.TREASURE_RANK_SILVER:
                {
                    _loc_2 = MAP_MC_SILVER_BOX;
                    break;
                }
                case QuestConstant.TREASURE_RANK_BRONZE:
                {
                }
                default:
                {
                    _loc_2 = MAP_MC_WOOD_BOX;
                    break;
                    break;
                }
            }
            return ResourceManager.getInstance().createMovieClip(getResource(), _loc_2);
        }// end function

        public static function createDivideMc(param1:int) : MovieClip
        {
            var _loc_2:* = null;
            switch(param1)
            {
                case QuestConstant.TREASURE_RANK_GOLD:
                {
                    _loc_2 = DIVIDE_MC_GOLD_BOX;
                    break;
                }
                case QuestConstant.TREASURE_RANK_SILVER:
                {
                    _loc_2 = DIVIDE_MC_SILVER_BOX;
                    break;
                }
                case QuestConstant.TREASURE_RANK_BRONZE:
                {
                }
                default:
                {
                    _loc_2 = DIVIDE_MC_WOOD_BOX;
                    break;
                    break;
                }
            }
            return ResourceManager.getInstance().createMovieClip(getResource(), _loc_2);
        }// end function

    }
}
