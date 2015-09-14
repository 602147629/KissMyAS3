package utility
{
    import button.*;
    import develop.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import window.*;

    public class Assert extends Object
    {

        public function Assert()
        {
            return;
        }// end function

        public static function print(param1:String) : void
        {
            var _loc_2:* = new Error(param1);
            DebugLog.print(_loc_2.getStackTrace());
            stopAll(param1);
            return;
        }// end function

        public static function printError(param1:Error, param2:String) : void
        {
            DebugLog.print(param1.getStackTrace());
            stopAll(param2);
            return;
        }// end function

        private static function stopAll(param1:String) : void
        {
            var _loc_2:* = "エラーが発生しました。\n公式TOPからゲームを起動しなおしてください。\n\n" + param1;
            var _loc_3:* = new WindowStyle();
            WindowManager.getInstance().createDialogWindow(Main.GetProcess(), _loc_2, _loc_3, new Point(50, 200), false);
            ButtonManager.getInstance().seal([]);
            InputManager.getInstance().removeEvent();
            if (Main.GetProcess().stage.hasEventListener(Event.ENTER_FRAME))
            {
                Main.GetProcess().stage.removeEventListener(Event.ENTER_FRAME, Main.GetProcess().onEnterFrame);
            }
            return;
        }// end function

    }
}
