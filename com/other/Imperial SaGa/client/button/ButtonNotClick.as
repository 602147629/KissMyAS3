package button
{
    import flash.display.*;

    public class ButtonNotClick extends ButtonBase
    {

        public function ButtonNotClick(param1:MovieClip, param2:Function = null, param3:Function = null)
        {
            super(param1, null, param2, param3);
            return;
        }// end function

        override public function setClick() : void
        {
            return;
        }// end function

    }
}
