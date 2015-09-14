package quest
{
    import flash.display.*;
    import flash.events.*;
    import message.*;
    import utility.*;

    public class QuestEnding extends Object
    {
        private var _mc:MovieClip;
        private var _bmpBack:Bitmap;
        private var _isoMain:InStayOut;
        private var _bEnd:Boolean;

        public function QuestEnding(param1:MovieClip, param2:Bitmap)
        {
            this._mc = param1;
            this._bmpBack = param2;
            this._mc.questEndingBG.addChild(this._bmpBack);
            TextControl.setText(this._mc.questEndingTextMc.textMc.textDt, "あああああああああああああ\nいいいいいいいいいい\nううう");
            this._isoMain = new InStayOut(this._mc);
            this._isoMain.setIn(this.cbIn);
            this._bEnd = false;
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            if (this._mc.hasEventListener(MouseEvent.CLICK))
            {
                this._mc.removeEventListener(MouseEvent.CLICK, this.mcClick);
            }
            if (this._bmpBack.parent)
            {
                this._bmpBack.parent.removeChild(this._bmpBack);
            }
            this._bmpBack = null;
            if (this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            this._isoMain.release();
            this._isoMain = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            return;
        }// end function

        private function cbIn() : void
        {
            this._mc.addEventListener(MouseEvent.CLICK, this.mcClick);
            return;
        }// end function

        private function cbOut() : void
        {
            this._bEnd = true;
            return;
        }// end function

        private function mcClick(event:MouseEvent) : void
        {
            this._mc.removeEventListener(MouseEvent.CLICK, this.mcClick);
            this._isoMain.setOut(this.cbOut);
            return;
        }// end function

    }
}
