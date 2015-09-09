package lovefox.gameUI
{
    import flash.display.*;
    import flash.events.*;
    import lovefox.component.*;

    public class CheckBoxUI extends Sprite
    {
        private var selectflag:Boolean = false;
        private var checklabel:LabelUI;
        private var selectmc:Sprite;
        private var selectevent:Boolean = false;
        private var enabledflag:Boolean = true;

        public function CheckBoxUI()
        {
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            this.graphics.lineStyle(1, 16777215);
            this.graphics.beginFill(16777215, 0.1);
            this.graphics.drawRect(0, 0, 14, 14);
            this.graphics.endFill();
            this.addEventListener(MouseEvent.CLICK, this.changeselect);
            this.selectmc = new Sprite();
            this.addChild(this.selectmc);
            this.selectmc.graphics.lineStyle(2, 16766720);
            this.selectmc.graphics.moveTo(2, 7);
            this.selectmc.graphics.lineTo(7, 13);
            this.selectmc.graphics.lineTo(14, 0);
            this.selectmc.visible = false;
            this.checklabel = new LabelUI();
            this.addChild(this.checklabel);
            this.checklabel.x = 20;
            this.checklabel.selectable = false;
            return;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            this.selectflag = param1;
            this.selectmc.visible = param1;
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this.selectflag;
        }// end function

        public function set label(param1:String) : void
        {
            this.checklabel.text = param1;
            return;
        }// end function

        public function get label() : String
        {
            return this.checklabel.text;
        }// end function

        public function set upevent(param1:Boolean) : void
        {
            this.selectevent = param1;
            return;
        }// end function

        public function set enabled(param1:Boolean) : void
        {
            this.enabledflag = param1;
            return;
        }// end function

        public function get enabled() : Boolean
        {
            return this.enabledflag;
        }// end function

        private function changeselect(event:MouseEvent) : void
        {
            if (this.enabledflag)
            {
                if (this.selectflag)
                {
                    this.selectflag = false;
                    this.selectmc.visible = false;
                }
                else
                {
                    this.selectflag = true;
                    this.selectmc.visible = true;
                }
                if (this.selectevent)
                {
                    this.dispatchEvent(new Event("change"));
                }
            }
            return;
        }// end function

        public function set truncateToFit(param1:uint) : void
        {
            this.checklabel.truncateToFit = param1;
            return;
        }// end function

    }
}
