package script
{
    import resource.*;
    import sound.*;

    public class ScriptComLoadWait extends ScriptComBase
    {

        public function ScriptComLoadWait()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_WAIT);
            return;
        }// end function

        override public function commandSkip() : int
        {
            if (ResourceManager.getInstance().isLoaded() == false)
            {
                return ScriptComConstant.COMMAND_SKIP_RESULT_WAIT;
            }
            if (SoundManager.getInstance().isLoaded() == false)
            {
                return ScriptComConstant.COMMAND_SKIP_RESULT_WAIT;
            }
            _bCommandEnd = true;
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            if (ResourceManager.getInstance().isLoaded() == false)
            {
                return;
            }
            if (SoundManager.getInstance().isLoaded() == false)
            {
                return;
            }
            _bCommandEnd = true;
            return;
        }// end function

    }
}
