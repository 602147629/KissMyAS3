package quest
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;

    public class QuestScrollInput extends Object
    {
        private var _scrollBar:QuestScrollBar;
        private var _bScroll:Boolean;
        private var _InputDrag:InputDrag;
        private var _startPos:Point;

        public function QuestScrollInput(param1:MovieClip, param2:MovieClip, param3:QuestScrollBar)
        {
            this._scrollBar = param3;
            this._InputDrag = new InputDrag(this, param1, this.cbDrag, this.cbMove, null);
            this._InputDrag.addMaskObject(param2);
            InputManager.getInstance().addDrag(this._InputDrag);
            return;
        }// end function

        public function release() : void
        {
            if (this._InputDrag)
            {
                InputManager.getInstance().delDrag(this._InputDrag);
                this._InputDrag.release();
                this._InputDrag = null;
            }
            return;
        }// end function

        public function control() : void
        {
            return;
        }// end function

        public function setButtonDisable(param1:Boolean) : void
        {
            this._InputDrag.enable(!param1);
            this._bScroll = param1;
            return;
        }// end function

        private function cbDrag(event:MouseEvent) : void
        {
            this._startPos = new Point(this._scrollBar.scrollPos.x, this._scrollBar.scrollPos.y);
            return;
        }// end function

        private function cbMove(event:MouseEvent) : void
        {
            var _loc_2:* = new Point(event.stageX - this._InputDrag.startPos.x, event.stageY - this._InputDrag.startPos.y);
            var _loc_3:* = new Point(this._scrollBar.scrollPos.x, this._startPos.y - _loc_2.y);
            this._scrollBar.SetScrollPos(_loc_3);
            return;
        }// end function

    }
}
