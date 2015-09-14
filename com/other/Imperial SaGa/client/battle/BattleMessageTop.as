package battle
{
    import flash.display.*;
    import message.*;

    public class BattleMessageTop extends BattleMessageBase
    {

        public function BattleMessageTop(param1:MovieClip, param2:String)
        {
            super(param1);
            _aMessageColumn = ["1Calum", "2Calum", "3Calum", "4Calum", "5Calum", "6Calum", "7Calum", "8Calum", "9Calum", "10Calum", "11Calum", "12Calum", "13Calum", "14Calum", "15Calum", "16Calum", "17Calum", "18Calum", "19Calum", "20Calum"];
            TextControl.setText(_mc.skillWindowsMc.textMc.textDt, param2);
            setMessageColumn(_mc.skillWindowsMc.skillWindowColorMc, param2.length);
            _isoMain.setIn();
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            _mc = null;
            return;
        }// end function

    }
}
