package quest
{
    import flash.display.*;
    import resource.*;

    public class QuestPieceDivide extends QuestSprite
    {
        private var _squareId:int;
        private var _divideMc:MovieClip;

        public function QuestPieceDivide(param1:DisplayObjectContainer, param2:QuestSquare)
        {
            super(QuestConstant.PIECE_PRIORITY_DIVIDE, param2.y);
            param1.addChild(this);
            this._squareId = param2.id;
            this._divideMc = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + "UI_QuestMap.swf", "QuestMapDivideIcon");
            var _loc_3:* = QuestManager.getInstance().getSquare(param2.aConnectionId[0]);
            var _loc_4:* = QuestManager.getInstance().getSquare(param2.aConnectionId[1]);
            if (_loc_3 != null && _loc_4 != null)
            {
                this._divideMc.x = param2.x;
                this._divideMc.y = param2.y;
                this.addChild(this._divideMc);
            }
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
            if (this._divideMc && this._divideMc.parent)
            {
                this._divideMc.parent.removeChild(this._divideMc);
            }
            this._divideMc = null;
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

    }
}
