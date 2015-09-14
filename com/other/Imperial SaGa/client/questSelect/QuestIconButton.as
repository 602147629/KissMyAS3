package questSelect
{
    import button.*;
    import flash.display.*;

    public class QuestIconButton extends ButtonBase
    {
        private var _parent:MovieClip;

        public function QuestIconButton(param1:MovieClip, param2:MovieClip, param3:Function, param4:Function = null, param5:Function = null)
        {
            this._parent = param1;
            super(param2, param3, param4, param5);
            return;
        }// end function

        override public function release() : void
        {
            if (this._parent)
            {
                if (this._parent.parent != null)
                {
                    this._parent.parent.removeChild(this._parent);
                }
            }
            super.release();
            return;
        }// end function

        public function setMouseOverDisplay() : void
        {
            labelChange(_LABEL_MOUSE_OVER);
            return;
        }// end function

        public function setMouseOutDisplay() : void
        {
            labelChange(_LABEL_MOUSE_OUT);
            return;
        }// end function

    }
}
