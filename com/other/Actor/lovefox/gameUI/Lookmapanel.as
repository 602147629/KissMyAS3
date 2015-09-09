package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import lovefox.component.*;

    public class Lookmapanel extends Window
    {
        private var icon:Bitmap;
        private var ptnbar:ButtonBar;
        private var txt:Label;
        private var check:CheckBox;

        public function Lookmapanel(param1:DisplayObjectContainer = null)
        {
            super(param1);
            resize(542, 450);
            this.ptnbar = new ButtonBar(this, 20, 25, 520);
            this.ptnbar.addTab(Config.language("Lookmapanel", 1), this.lookmaplv);
            this.ptnbar.addTab(Config.language("Lookmapanel", 2), this.lookmaplv);
            this.ptnbar.addTab(Config.language("Lookmapanel", 3), this.lookmaplv);
            this.ptnbar.addTab(Config.language("Lookmapanel", 4), this.lookmaplv);
            this.ptnbar.addTab(Config.language("Lookmapanel", 12), this.lookmaplv);
            this.ptnbar.addTab(Config.language("Lookmapanel", 13), this.lookmaplv);
            this.txt = new Label(this, 20, 405);
            this.txt.html = true;
            this.check = new CheckBox(this, 400, 30, Config.language("Lookmapanel", 9), this.setSelected);
            this.check.selected = true;
            return;
        }// end function

        private function setSelected(event:MouseEvent)
        {
            trace(this.check.selected);
            Config.ui._radar.visiblelookmapBtn(this.check.selected);
            return;
        }// end function

        private function lookmaplv(param1)
        {
            var _loc_2:* = String(int(this.ptnbar.selectpage + 4) * 10);
            if (_loc_2 == "90")
            {
                _loc_2 = "100";
            }
            this.lookmap(_loc_2);
            return;
        }// end function

        override public function close()
        {
            if (this.icon != null)
            {
                if (this.icon.hasOwnProperty("bitmapData"))
                {
                    this.icon.bitmapData.dispose();
                    this.icon = null;
                }
            }
            super.close();
            return;
        }// end function

        public function lookmap(param1:String)
        {
            super.open();
            if (this.icon != null)
            {
                if (this.icon.hasOwnProperty("bitmapData"))
                {
                    this.icon.bitmapData.dispose();
                    this.icon = null;
                }
            }
            this.icon = new Bitmap();
            this.addChild(this.icon);
            this.icon.bitmapData = Config.findsysUI("headui/" + param1, 534, 340, ".jpg");
            this.icon.x = 4;
            this.icon.y = 55;
            if (param1 == "40")
            {
                this.ptnbar.selectpage = 0;
                this.txt.text = Config.language("Lookmapanel", 5);
            }
            else if (param1 == "50")
            {
                this.ptnbar.selectpage = 1;
                this.txt.text = Config.language("Lookmapanel", 6);
            }
            else if (param1 == "60")
            {
                this.ptnbar.selectpage = 2;
                this.txt.text = Config.language("Lookmapanel", 7);
            }
            else if (param1 == "70")
            {
                this.ptnbar.selectpage = 3;
                this.txt.text = Config.language("Lookmapanel", 8);
            }
            else if (param1 == "80" || param1 == "90")
            {
                this.ptnbar.selectpage = 4;
                this.txt.text = Config.language("Lookmapanel", 10);
            }
            else if (param1 == "100")
            {
                this.ptnbar.selectpage = 5;
                this.txt.text = Config.language("Lookmapanel", 11);
            }
            return;
        }// end function

    }
}
