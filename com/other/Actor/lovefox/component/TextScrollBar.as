package lovefox.component
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class TextScrollBar extends Sprite
    {
        var Text:TextField;
        var upBtn:SimpleButton;
        var bottonBtn:SimpleButton;
        var bgMc:MovieClip;
        var slipMc:MovieClip;
        var ScrollBarMc:Sprite;
        var ScrollBarHeight:Number;
        var slipVar:Number;
        var slipHeight:Number;
        var putTime:uint;

        public function TextScrollBar(param1:TextField, ... args)
        {
            this.Text = param1;
            if (args.length > 0)
            {
                if (args[0] is Class)
                {
                    if (args[1] == undefined)
                    {
                        this.styleModeInit(args[0]);
                    }
                    else
                    {
                        this.styleModeInit(args[0], args[1]);
                    }
                }
                else if (args[0] is Number)
                {
                    this.nudityModeInit(args[0]);
                }
                else
                {
                    trace("mdTextScrollBar使用非法参数,启动无皮肤模式");
                    this.nudityModeInit();
                }
            }
            else
            {
                this.nudityModeInit();
            }
            return;
        }// end function

        private function styleModeInit(... args)
        {
            this.ScrollBarMc = new args[0];
            addChild(this.ScrollBarMc);
            this.upBtn = this.ScrollBarMc.getChildByName("upBtn") as SimpleButton;
            this.bottonBtn = this.ScrollBarMc.getChildByName("bottonBtn") as SimpleButton;
            this.bgMc = this.ScrollBarMc.getChildByName("bgMc") as MovieClip;
            this.slipMc = this.ScrollBarMc.getChildByName("slipMc") as MovieClip;
            if (args[1] != undefined)
            {
                this.ScrollBarHeight = args[1];
            }
            else
            {
                this.ScrollBarHeight = 100;
            }
            this.upBtn.y = 0;
            this.upBtn.x = 0;
            this.bgMc.x = 0;
            this.bgMc.y = this.upBtn.height;
            this.bgMc.height = this.ScrollBarHeight - this.upBtn.height - this.bottonBtn.height;
            this.bottonBtn.x = 0;
            this.bottonBtn.y = this.upBtn.height + this.bgMc.height;
            this.slipMc.x = 0;
            this.slipMc.y = this.upBtn.height;
            this.slipHeight = this.bgMc.height - this.slipMc.height;
            this.ScrollBarMc.visible = false;
            addEventListener(Event.ENTER_FRAME, this.addStageEvent);
            return;
        }// end function

        private function nudityModeInit(... args)
        {
            if (args[0] != undefined)
            {
                this.ScrollBarHeight = args[0];
            }
            else
            {
                this.ScrollBarHeight = 100;
            }
            this.ScrollBarMc = new Sprite();
            this.upBtn = new directionButton(15, 1);
            this.bottonBtn = new directionButton(15, 2);
            this.bottonBtn.y = this.ScrollBarHeight - this.bottonBtn.height;
            this.bgMc = new MovieClip();
            this.bgMc.graphics.beginFill(13421772);
            this.bgMc.graphics.drawRect(0, 0, 15, this.ScrollBarHeight - this.upBtn.height - this.bottonBtn.height);
            this.bgMc.y = this.upBtn.height;
            this.slipMc = new MovieClip();
            this.slipMc.graphics.beginFill(10066329, 0);
            this.slipMc.graphics.drawRect(0, 0, 15, 30);
            this.slipMc.graphics.beginFill(15658734);
            this.slipMc.graphics.drawRoundRect((15 - 10) / 2, 0, 10, 30, 5, 5);
            this.slipMc.y = this.upBtn.height;
            this.slipHeight = this.bgMc.height - this.slipMc.height;
            addChild(this.ScrollBarMc);
            this.ScrollBarMc.addChild(this.bgMc);
            this.ScrollBarMc.addChild(this.upBtn);
            this.ScrollBarMc.addChild(this.bottonBtn);
            this.ScrollBarMc.addChild(this.slipMc);
            addEventListener(Event.ENTER_FRAME, this.addStageEvent);
            return;
        }// end function

        private function addStageEvent(event:Event) : void
        {
            if (this.ScrollBarMc.stage != null)
            {
                this.Text.addEventListener(Event.SCROLL, this.textScroll);
                this.upBtn.addEventListener(MouseEvent.MOUSE_DOWN, this.upBtnDown);
                this.bottonBtn.addEventListener(MouseEvent.MOUSE_DOWN, this.bottonBtnDown);
                this.slipMc.addEventListener(MouseEvent.MOUSE_DOWN, this.slipDown);
                event.target.removeEventListener(Event.ENTER_FRAME, this.addStageEvent);
            }
            if (this.Text.maxScrollV != 1)
            {
                this.ScrollBarMc.visible = true;
            }
            else
            {
                this.ScrollBarMc.visible = false;
            }
            return;
        }// end function

        private function textScroll(event:Event)
        {
            if (this.Text.maxScrollV != 1)
            {
                this.ScrollBarMc.visible = true;
                this.slipVar = this.Text.scrollV / this.Text.maxScrollV;
                if (this.Text.scrollV != 1)
                {
                    this.slipMc.y = this.bgMc.y + this.slipHeight * this.slipVar;
                }
                else
                {
                    this.slipMc.y = this.bgMc.y;
                }
            }
            else
            {
                this.ScrollBarMc.visible = false;
            }
            return;
        }// end function

        private function slipDown(event:MouseEvent) : void
        {
            this.Text.removeEventListener(Event.SCROLL, this.textScroll);
            var _loc_2:* = new Rectangle(this.slipMc.x, this.bgMc.y, 0, this.slipHeight);
            this.slipMc.startDrag(false, _loc_2);
            this.ScrollBarMc.addEventListener(Event.ENTER_FRAME, this.slipMcDownTime);
            this.slipMc.stage.addEventListener(MouseEvent.MOUSE_UP, this.slipUp);
            return;
        }// end function

        private function slipMcDownTime(event:Event) : void
        {
            this.Text.scrollV = Math.round((this.slipMc.y - this.upBtn.height) / this.slipHeight * this.Text.maxScrollV);
            return;
        }// end function

        private function slipUp(event:MouseEvent) : void
        {
            this.Text.addEventListener(Event.SCROLL, this.textScroll);
            this.slipMc.stopDrag();
            this.slipMc.stage.removeEventListener(MouseEvent.MOUSE_UP, this.slipUp);
            return;
        }// end function

        private function upBtnDown(event:MouseEvent) : void
        {
            var _loc_2:* = this.Text;
            var _loc_3:* = this.Text.scrollV - 1;
            _loc_2.scrollV = _loc_3;
            if (this.Text.scrollV > 1)
            {
                this.slipMc.y = this.bgMc.y + this.slipHeight * (this.Text.scrollV / this.Text.maxScrollV);
            }
            else
            {
                this.slipMc.y = this.bgMc.y;
            }
            this.putTime = getTimer();
            this.ScrollBarMc.addEventListener(Event.ENTER_FRAME, this.upBtnDownTime);
            this.upBtn.stage.addEventListener(MouseEvent.MOUSE_UP, this.upBtnUp);
            return;
        }// end function

        private function upBtnDownTime(event:Event) : void
        {
            if (getTimer() - this.putTime > 500)
            {
                var _loc_2:* = this.Text;
                var _loc_3:* = this.Text.scrollV - 1;
                _loc_2.scrollV = _loc_3;
                if (this.Text.scrollV > 1)
                {
                    this.slipMc.y = this.bgMc.y + this.slipHeight * (this.Text.scrollV / this.Text.maxScrollV);
                }
                else
                {
                    this.slipMc.y = this.bgMc.y;
                }
            }
            return;
        }// end function

        private function upBtnUp(event:MouseEvent) : void
        {
            this.ScrollBarMc.removeEventListener(Event.ENTER_FRAME, this.upBtnDownTime);
            this.upBtn.stage.removeEventListener(MouseEvent.MOUSE_UP, this.upBtnUp);
            return;
        }// end function

        private function bottonBtnDown(event:MouseEvent) : void
        {
            var _loc_2:* = this.Text;
            var _loc_3:* = this.Text.scrollV + 1;
            _loc_2.scrollV = _loc_3;
            this.slipMc.y = this.bgMc.y + this.slipHeight * (this.Text.scrollV / this.Text.maxScrollV);
            this.putTime = getTimer();
            this.ScrollBarMc.addEventListener(Event.ENTER_FRAME, this.bottonBtnTime);
            this.bottonBtn.stage.addEventListener(MouseEvent.MOUSE_UP, this.bottonBtnUp);
            return;
        }// end function

        private function bottonBtnTime(event:Event) : void
        {
            if (getTimer() - this.putTime > 500)
            {
                var _loc_2:* = this.Text;
                var _loc_3:* = this.Text.scrollV + 1;
                _loc_2.scrollV = _loc_3;
                this.slipMc.y = this.bgMc.y + this.slipHeight * (this.Text.scrollV / this.Text.maxScrollV);
            }
            return;
        }// end function

        private function bottonBtnUp(event:MouseEvent) : void
        {
            this.ScrollBarMc.removeEventListener(Event.ENTER_FRAME, this.bottonBtnTime);
            this.bottonBtn.stage.removeEventListener(MouseEvent.MOUSE_UP, this.bottonBtnUp);
            return;
        }// end function

    }
}
