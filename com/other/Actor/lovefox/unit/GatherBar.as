package lovefox.unit
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class GatherBar extends Sprite
    {
        private var gatherbar:Sprite;
        private var timebar:Sprite;
        private var butime:int = 0;
        private var needtime:int = 0;
        private var gatime:Timer;

        public function GatherBar()
        {
            this.initpanel();
            this.gatime = new Timer(33);
            this.gatime.addEventListener(TimerEvent.TIMER, this.gathering);
            return;
        }// end function

        private function initpanel() : void
        {
            this.gatherbar = new Sprite();
            this.gatherbar.graphics.beginFill(6710886, 0.8);
            this.gatherbar.graphics.drawRoundRect(0, 0, 150, 25, 5);
            this.gatherbar.graphics.endFill();
            this.gatherbar.graphics.beginFill(6710784, 0.8);
            this.gatherbar.graphics.drawRoundRect(5, 5, 140, 15, 0);
            this.gatherbar.graphics.endFill();
            this.timebar = new Sprite();
            this.timebar.graphics.beginFill(6697728, 0.7);
            this.timebar.graphics.drawRoundRect(5, 5, 1, 15, 0);
            this.timebar.graphics.endFill();
            this.gatherbar.addChild(this.timebar);
            return;
        }// end function

        public function startgather(param1:int) : void
        {
            this.needtime = param1 * Config._fps;
            this.gatime.start();
            Config.ui.addChild(this.gatherbar);
            this.gatherbar.x = 200;
            this.gatherbar.y = 100;
            return;
        }// end function

        public function stopgather() : void
        {
            if (this.gatherbar.parent != null)
            {
                Config.ui.removeChild(this.gatherbar);
            }
            this.gatime.stop();
            this.butime = 0;
            return;
        }// end function

        private function gathering(event:TimerEvent) : void
        {
            if (this.butime <= this.needtime)
            {
                var _loc_2:* = this;
                var _loc_3:* = this.butime + 1;
                _loc_2.butime = _loc_3;
                this.gatherload(this.butime, this.needtime);
            }
            else
            {
                this.stopgather();
            }
            return;
        }// end function

        private function gatherload(param1:int, param2:int) : void
        {
            this.timebar.graphics.clear();
            this.timebar.graphics.beginFill(6697728, 0.7);
            this.timebar.graphics.drawRoundRect(5, 5, 140 * param1 / param2, 15, 0);
            this.timebar.graphics.endFill();
            return;
        }// end function

    }
}
