package lovefox.gameUI
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class FollowFight extends Sprite
    {
        private var _timer:Timer;
        private var _sectime:int = 10;
        private var _flag:Boolean = false;
        private var _iteminfor:String = "";

        public function FollowFight()
        {
            this.initsocket();
            this._timer = new Timer(1000);
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ACCGUARD_END, this.getprize);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ACCGUARD_FAIL, this.getfailinfor);
            return;
        }// end function

        private function getprize(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            this._iteminfor = "      奖励: " + Config._itemMap[_loc_3].name + " * " + _loc_4;
            AlertUI.alert("确认框", "        恭喜完成本次随从关卡\n\n\n\n", ["退出"], [this.leaverfollowmap]);
            this._flag = true;
            this._timer.addEventListener(TimerEvent.TIMER, this.quiktimer);
            this._timer.start();
            return;
        }// end function

        private function getfailinfor(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            AlertUI.alert("确认框", "        你未能完成本次随从关卡\n\n", ["退出"], [this.leaverfollowmap]);
            this._flag = false;
            this._timer.addEventListener(TimerEvent.TIMER, this.quiktimer);
            this._timer.start();
            return;
        }// end function

        private function leaverfollowmap(event:MouseEvent)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LEAVE_ACCGUARD);
            ClientSocket.send(_loc_2);
            this._sectime = 10;
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.quiktimer);
            return;
        }// end function

        private function quiktimer(event:TimerEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._sectime - 1;
            _loc_2._sectime = _loc_3;
            if (this._sectime == 0)
            {
                this._sectime = 10;
                this._timer.stop();
                this._timer.removeEventListener(TimerEvent.TIMER, this.quiktimer);
                AlertUI.close();
            }
            else if (this._flag)
            {
                AlertUI.msg = "        恭喜完成本次随从关卡\n\n        " + this._iteminfor + "\n\n              退出倒计时: " + this._sectime + "秒";
            }
            else
            {
                AlertUI.msg = "        你未能完成本次随从关卡\n\n            退出倒计时: " + this._sectime + "秒";
            }
            return;
        }// end function

    }
}
