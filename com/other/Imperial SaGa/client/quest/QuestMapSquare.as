package quest
{
    import flash.display.*;
    import resource.*;

    public class QuestMapSquare extends Object
    {
        private var _mc:MovieClip;
        private var _dividePiece:QuestPieceDivide;
        private var _joinPiece:QuestPieceJoin;
        private var _squareId:int;
        private var _bCheck:Boolean;
        private static const _STATUS_NO_CHECK:String = "normal";
        private static const _STATUS_CHECK:String = "check";

        public function QuestMapSquare(param1:DisplayObjectContainer, param2:DisplayObjectContainer, param3:int)
        {
            var _loc_4:* = QuestManager.getInstance().getSquare(param3);
            this._squareId = param3;
            var _loc_5:* = _loc_4.attribute1;
            if (_loc_4.attribute1 == QuestConstant.SQUARE_ATTR1_START || _loc_5 == QuestConstant.SQUARE_ATTR1_DIVIDE || _loc_5 == QuestConstant.SQUARE_ATTR1_JOIN || _loc_5 == QuestConstant.SQUARE_ATTR1_BOSSBATTLE || _loc_5 == QuestConstant.SQUARE_ATTR1_TREASURE_1 || _loc_5 == QuestConstant.SQUARE_ATTR1_TREASURE_2 || _loc_5 == QuestConstant.SQUARE_ATTR1_TREASURE_3 || _loc_5 == QuestConstant.SQUARE_ATTR1_TREASURE_4 || _loc_5 == QuestConstant.SQUARE_ATTR1_TREASURE_5 || _loc_4.isTreasure())
            {
                this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + "UI_QuestMap.swf", "QuestMapMass_Big");
            }
            else
            {
                this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + "UI_QuestMap.swf", "QuestMapMass");
            }
            this._mc.x = _loc_4.x;
            this._mc.y = _loc_4.y;
            this._mc.gotoAndStop(_STATUS_NO_CHECK);
            if (_loc_4.attribute1 == QuestConstant.SQUARE_ATTR1_DIVIDE && _loc_4.aConnectionId.length > 1)
            {
                this._dividePiece = new QuestPieceDivide(param2, _loc_4);
            }
            else if (_loc_4.attribute1 == QuestConstant.SQUARE_ATTR1_JOIN)
            {
                this._joinPiece = new QuestPieceJoin(param2, _loc_4);
            }
            param1.addChild(this._mc);
            return;
        }// end function

        public function get mc() : MovieClip
        {
            return this._mc;
        }// end function

        public function get squareId() : int
        {
            return this._squareId;
        }// end function

        public function get bCheck() : Boolean
        {
            return this._bCheck;
        }// end function

        public function release() : void
        {
            if (this._joinPiece)
            {
                this._joinPiece.release();
            }
            this._joinPiece = null;
            if (this._dividePiece)
            {
                this._dividePiece.release();
            }
            this._dividePiece = null;
            if (this._mc.parent != null)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            return;
        }// end function

        private function setNoCheck() : void
        {
            this._bCheck = false;
            this._mc.gotoAndStop(_STATUS_NO_CHECK);
            return;
        }// end function

        public function setCheck() : void
        {
            this._bCheck = true;
            this._mc.gotoAndStop(_STATUS_CHECK);
            return;
        }// end function

        public function setCheckWithJunctionCount() : void
        {
            if (this._bCheck == false)
            {
                QuestManager.getInstance().addJunctionCount();
                QuestManager.getInstance().addFeverCount();
            }
            this._bCheck = true;
            this._mc.gotoAndStop(_STATUS_CHECK);
            return;
        }// end function

    }
}
