package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;

    public class TaskNewTips extends Sprite
    {
        private var _type:int;

        public function TaskNewTips(param1:int, param2:uint, param3:DisplayObjectContainer = null, param4:Number = 0, param5:Number = 0)
        {
            if (param3 != null)
            {
                param3.addChild(this);
            }
            x = param4;
            y = param5;
            this._type = param1;
            this.initpanel(param2);
            return;
        }// end function

        private function initpanel(param1:uint) : void
        {
            this.graphics.lineStyle(1, 3355443, 0.5);
            this.graphics.beginFill(0, 0.6);
            this.graphics.drawRoundRect(0, 0, 32, 32, 5);
            this.graphics.endFill();
            var _loc_2:* = new Label(this, 3, 7);
            _loc_2.textColor = 16777215;
            if (param1 == 1)
            {
                _loc_2.text = Config.language("TaskNewTips", 1);
            }
            else if (param1 == 2)
            {
                _loc_2.text = Config.language("TaskNewTips", 2);
            }
            else
            {
                _loc_2.text = Config.language("TaskNewTips", 3);
            }
            this.addEventListener(MouseEvent.CLICK, this.opentaskpanel);
            return;
        }// end function

        private function opentaskpanel(event:MouseEvent) : void
        {
            this.dispatchEvent(new Event("opentask"));
            this.parent.removeChild(this);
            Config.ui._taskpanel.open();
            Config.ui._taskpanel.initsecpage(null, this._type);
            return;
        }// end function

    }
}
