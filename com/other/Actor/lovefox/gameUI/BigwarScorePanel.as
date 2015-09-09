package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class BigwarScorePanel extends Sprite
    {
        private var container:Sprite;
        private var namelabel:Label;
        private var enterTime:Label;
        private var shape:Sprite;
        private var timerr:Timer;
        private var sec:int = 0;
        private var loginTime1:Number = 0;
        private var relifeTime:Number = 30;
        private var relifetimer:Timer;

        public function BigwarScorePanel(param1:Sprite)
        {
            this.container = param1;
            this.init();
            return;
        }// end function

        public function openscPanel(param1:Number = 0)
        {
            if (this.parent == null)
            {
                this.loginTime1 = param1 * 1000;
                this.addbwpanel();
                this.container.addChild(this);
                this.timerr.removeEventListener(TimerEvent.TIMER, this.enterremaintime);
                this.timerr.addEventListener(TimerEvent.TIMER, this.enterremaintime);
                this.timerr.start();
            }
            return;
        }// end function

        public function addbwpanel(param1:uint = 1, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0) : void
        {
            this.namelabel.html = true;
            if (param1 == 1)
            {
                this.namelabel.text = "<FONT color=\'#ffcb00\' SIZE=\'12\'><b>" + Config.language("BigwarScorePanel", 1) + param2 + "   " + param3 + Config.language("BigwarScorePanel", 2) + param4 + "   " + param5 + "/2000" + "</b></FONT>";
            }
            else if (param1 == 2)
            {
                this.namelabel.text = "<FONT color=\'#ffcb00\' SIZE=\'12\'><b>" + Config.language("BigwarScorePanel", 1) + param4 + "   " + param5 + Config.language("BigwarScorePanel", 2) + param2 + "   " + param3 + "/2000" + "</b></FONT>";
            }
            return;
        }// end function

        private function enterremaintime(event:TimerEvent)
        {
            var _loc_2:* = "";
            if (Config.now.getTime() < this.loginTime1)
            {
                _loc_2 = Config.timePoint(this.loginTime1 / 1000, 2);
                this.enterTime.text = "<FONT color=\'#ffcb00\' SIZE=\'12\'><b>" + Config.language("BigwarScorePanel", 3) + _loc_2 + "</b></FONT>";
            }
            else
            {
                this.timerr.stop();
                this.timerr.removeEventListener(TimerEvent.TIMER, this.enterremaintime);
                this.enterTime.text = "";
            }
            return;
        }// end function

        public function socketrelife()
        {
            this.relifeTime = 30;
            this.relifetimer.removeEventListener(TimerEvent.TIMER, this.relife);
            this.relifetimer.addEventListener(TimerEvent.TIMER, this.relife);
            this.relifetimer.start();
            return;
        }// end function

        private function relife(event:TimerEvent)
        {
            var _loc_2:* = this;
            var _loc_3:* = this.relifeTime - 1;
            _loc_2.relifeTime = _loc_3;
            if (this.relifeTime <= 0)
            {
                this.relifetimer.stop();
                this.enterTime.text = "<FONT color=\'#ffcb00\' SIZE=\'12\'><b>" + Config.language("BigwarScorePanel", 4) + "</b></FONT>";
            }
            else
            {
                this.enterTime.text = "<FONT color=\'#ffcb00\' SIZE=\'12\'><b>" + Config.language("BigwarScorePanel", 5) + this.relifeTime + Config.language("BigwarScorePanel", 6) + "</b></FONT>";
            }
            return;
        }// end function

        public function close() : void
        {
            if (this.parent != null)
            {
                this.enterTime.text = "";
                this.relifetimer.removeEventListener(TimerEvent.TIMER, this.relife);
                this.parent.removeChild(this);
            }
            return;
        }// end function

        private function init()
        {
            this.shape = new Sprite();
            this.addChild(this.shape);
            this.shape.x = 10;
            this.shape.y = 10;
            this.shape.graphics.beginFill(0, 0.5);
            this.shape.graphics.drawRoundRect(10, 0, 220, 55, 5);
            this.shape.graphics.endFill();
            this.namelabel = new Label(this, 50, 15);
            this.enterTime = new Label(this, 50, 45);
            this.enterTime.html = true;
            this.timerr = new Timer(1000);
            this.relifetimer = new Timer(1000);
            return;
        }// end function

    }
}
