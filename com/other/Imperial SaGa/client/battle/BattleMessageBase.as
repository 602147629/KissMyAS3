package battle
{
    import flash.display.*;
    import utility.*;

    public class BattleMessageBase extends Object
    {
        protected var _aMessageColumn:Array;
        protected var _mc:MovieClip;
        protected var _isoMain:InStayOut;

        public function BattleMessageBase(param1:MovieClip)
        {
            this._mc = param1;
            this._isoMain = new InStayOut(this._mc);
            this._aMessageColumn = [];
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoMain == null || this._isoMain.bEnd;
        }// end function

        public function release() : void
        {
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            return;
        }// end function

        protected function setMessageColumn(param1:MovieClip, param2:int) : void
        {
            var _loc_3:* = 0;
            if (param2 > 0)
            {
                if (param2 <= this._aMessageColumn.length)
                {
                    _loc_3 = param2 - 1;
                }
                else
                {
                    _loc_3 = this._aMessageColumn.length - 1;
                }
            }
            param1.gotoAndStop(this._aMessageColumn[_loc_3]);
            return;
        }// end function

        public function setClose() : void
        {
            this._isoMain.setOut(this.cbClose);
            return;
        }// end function

        protected function cbClose() : void
        {
            this.release();
            return;
        }// end function

    }
}
