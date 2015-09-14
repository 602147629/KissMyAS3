package makeEquip
{
    import flash.display.*;
    import message.*;

    public class MakeEquipMessageWindow extends MakeEquipBase
    {

        public function MakeEquipMessageWindow(param1:DisplayObjectContainer)
        {
            super(param1, "CaptionWindMc", false);
            return;
        }// end function

        public function get bOpened() : Boolean
        {
            return _isoMain.bOpened;
        }// end function

        public function get bClosed() : Boolean
        {
            return _isoMain.bClosed;
        }// end function

        public function setMessage(param1:String) : void
        {
            TextControl.setText(_mc.captionMc.textMc.textDt, param1);
            return;
        }// end function

        public function setMessageId(param1:int) : void
        {
            TextControl.setIdText(_mc.captionMc.textMc.textDt, param1);
            if (_isoMain.bClosed)
            {
                open();
            }
            return;
        }// end function

    }
}
