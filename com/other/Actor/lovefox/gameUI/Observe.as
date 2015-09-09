package lovefox.gameUI
{
    import flash.events.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class Observe extends Object
    {
        private static var _windowDefines:Object = {};
        public static var _power:int = 0;
        public static var _codeWindowMap:Object = [];
        private static var _windowCodeMap:Dictionary = new Dictionary();
        private static var frameCount:int = 0;
        private static var obString:String = "";
        private static var _preMDX:int;
        private static var _preMDY:int;
        private static var _preMDTime:int;

        public function Observe()
        {
            return;
        }// end function

        public static function init() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_OBSERVE_POWER, handlePower);
            return;
        }// end function

        private static function handlePower(event:SocketEvent)
        {
            var _loc_4:* = undefined;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            _power = _loc_3;
            _codeWindowMap["b"] = Config.ui._bagUI;
            _codeWindowMap["bm"] = Config.ui._blackmarket;
            _codeWindowMap["d"] = Config.ui._dealUI;
            _codeWindowMap["m"] = Config.ui._mailpanel;
            _codeWindowMap["s"] = Config.ui._stallUI;
            for (_loc_4 in _codeWindowMap)
            {
                
                _windowCodeMap[_codeWindowMap[_loc_4]] = _loc_4;
            }
            if (_power == 1)
            {
                obWindow(Config.ui._bagUI);
                obWindow(Config.ui._blackmarket);
                obWindow(Config.ui._dealUI);
                obWindow(Config.ui._mailpanel);
                obWindow(Config.ui._stallUI);
            }
            return;
        }// end function

        public static function obChangeMap(param1:String) : void
        {
            var _loc_2:* = null;
            if (_power == 1)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2B_OBSERVE_UPLOAD);
                _loc_2.addUTF("map");
                _loc_2.addUTF(param1);
                ClientSocket.send(_loc_2);
            }
            return;
        }// end function

        public static function obWindow(param1:Window) : void
        {
            param1.addEventListener("active", handleWindowActive);
            return;
        }// end function

        private static function handleWindowActive(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = Window(event.target);
            _loc_2.removeEventListener(MouseEvent.MOUSE_DOWN, handleWindowMouseDown);
            _loc_2.removeEventListener(MouseEvent.MOUSE_UP, handleWindowMouseUp);
            _loc_2.removeEventListener("obEvent", handleWindowEvent);
            if (_loc_2.active)
            {
                frameCount = 0;
                Config.startLoop(frameloop);
                _loc_2.addEventListener(MouseEvent.MOUSE_DOWN, handleWindowMouseDown);
                _loc_2.addEventListener(MouseEvent.MOUSE_UP, handleWindowMouseUp);
                _loc_2.addEventListener("obEvent", handleWindowEvent);
            }
            else
            {
                _loc_3 = _windowCodeMap[_loc_2];
                trace(Config.player.id, _loc_3, obString);
                _loc_4 = new DataSet();
                _loc_4.addHead(CONST_ENUM.C2B_OBSERVE_UPLOAD);
                _loc_4.addUTF(_loc_3);
                _loc_4.addUTF(obString);
                ClientSocket.send(_loc_4);
                obString = "";
                Config.stopLoop(frameloop);
            }
            return;
        }// end function

        private static function frameloop(param1) : void
        {
            var _loc_3:* = frameCount + 1;
            frameCount = _loc_3;
            return;
        }// end function

        private static function handleWindowMouseUp(event:Event) : void
        {
            var _loc_2:* = Window(event.currentTarget);
            if (getTimer() - _preMDTime > 300 || Math.abs(_loc_2.mouseX - _preMDX) > 5 || Math.abs(_loc_2.mouseY - _preMDY) > 5)
            {
                obString = obString + ("|" + frameCount + "@u:" + _loc_2.mouseX + "," + _loc_2.mouseY);
            }
            return;
        }// end function

        private static function handleWindowMouseDown(event:Event) : void
        {
            var _loc_2:* = Window(event.currentTarget);
            _preMDX = _loc_2.mouseX;
            _preMDY = _loc_2.mouseY;
            _preMDTime = getTimer();
            obString = obString + ("|" + frameCount + "@d:" + _loc_2.mouseX + "," + _loc_2.mouseY);
            return;
        }// end function

        private static function handleWindowEvent(event:ObEvent) : void
        {
            var _loc_2:* = Window(event.currentTarget);
            obString = obString + ("|" + frameCount + "@" + event.value);
            return;
        }// end function

    }
}
