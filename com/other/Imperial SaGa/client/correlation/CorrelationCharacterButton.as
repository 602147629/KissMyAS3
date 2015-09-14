package correlation
{
    import button.*;
    import flash.display.*;
    import sound.*;

    public class CorrelationCharacterButton extends ButtonBase
    {

        public function CorrelationCharacterButton(param1:MovieClip, param2:Function, param3:int)
        {
            super(param1, param2);
            _bDragBlock = false;
            if (param3 != Constant.UNDECIDED)
            {
                setId(param3);
            }
            enterSeId = SoundId.SE_CHARA_SELECT;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override public function setClick() : void
        {
            return;
        }// end function

        override public function setMouseUp() : void
        {
            super.setClick();
            return;
        }// end function

    }
}
