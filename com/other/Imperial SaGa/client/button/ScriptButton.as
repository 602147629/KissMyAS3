package button
{
    import flash.display.*;
    import sound.*;

    public class ScriptButton extends ButtonBase
    {

        public function ScriptButton(param1:MovieClip, param2:Function, param3:Function = null, param4:Function = null)
        {
            super(param1, param2, param3, param4);
            return;
        }// end function

        override public function setClick() : void
        {
            _mc.gotoAndPlay(_LABEL_CLICK);
            SoundManager.getInstance().playSe(_enterSeId);
            if (_cbClickFunc != null)
            {
                _cbClickFunc(_id);
            }
            return;
        }// end function

    }
}
