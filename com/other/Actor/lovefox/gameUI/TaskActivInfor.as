package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import lovefox.component.*;

    public class TaskActivInfor extends Sprite
    {
        private var _canvas:CanvasUI;
        private var _activobj:Object;
        private var bcolor:int = 39168;
        private var _bg:Sprite;
        private var activtitle:Label;
        private var activ1:Label;
        private var activ2:Label;
        private var activ3:Label;
        private var ta1:TextAreaUI;
        private var ta2:TextAreaUI;
        private var ta3:TextAreaUI;

        public function TaskActivInfor()
        {
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            this._canvas = new CanvasUI(this, 5, 45, 285, 280);
            this._bg = new Sprite();
            this._canvas.addChildUI(this._bg);
            this.activtitle = new Label(this, 5, 25);
            this.activ1 = new Label(null, 10, 25, Config.language("TaskActivInfor", 1));
            this._canvas.addChildUI(this.activ1);
            this.activ2 = new Label(null, 10, 25, Config.language("TaskActivInfor", 2));
            this._canvas.addChildUI(this.activ2);
            this.activ3 = new Label(null, 10, 25, Config.language("TaskActivInfor", 3));
            this._canvas.addChildUI(this.activ3);
            this.ta1 = new TextAreaUI(null, 10, 0, 260, 200);
            this.ta1.autoHeight = true;
            this.ta1.textColor = 39423;
            this._canvas.addChildUI(this.ta1);
            this.ta2 = new TextAreaUI(null, 10, 0, 260, 200);
            this.ta2.autoHeight = true;
            this._canvas.addChildUI(this.ta2);
            this.ta3 = new TextAreaUI(null, 10, 0, 260, 200);
            this.ta3.autoHeight = true;
            this._canvas.addChildUI(this.ta3);
            return;
        }// end function

        public function showActiv(param1:Object) : void
        {
            var _loc_2:* = 0;
            this.activtitle.text = param1.name;
            this._bg.graphics.clear();
            this._bg.graphics.beginFill(16314584, 1);
            this._bg.graphics.lineStyle(1, 16777215);
            _loc_2 = 0;
            var _loc_3:* = _loc_2;
            _loc_2 = _loc_2 + 5;
            this.activ1.y = _loc_2;
            _loc_2 = _loc_2 + 20;
            this.ta1.text = DescriptionTranslate.translate(param1.award, this.ta1.mytext);
            this.ta1.y = _loc_2;
            _loc_2 = _loc_2 + (this.ta1.height + 10);
            this._bg.graphics.drawRoundRect(0, _loc_3, 280, _loc_2 - _loc_3 - 5, 10);
            _loc_3 = _loc_2;
            this.activ2.y = _loc_2;
            _loc_2 = _loc_2 + 20;
            this.ta2.text = DescriptionTranslate.translate(param1.lim, this.ta2.mytext);
            this.ta2.y = _loc_2;
            _loc_2 = _loc_2 + (this.ta2.height + 10);
            this._bg.graphics.drawRoundRect(0, _loc_3, 280, _loc_2 - _loc_3 - 5, 10);
            _loc_3 = _loc_2;
            this.activ3.y = _loc_2;
            _loc_2 = _loc_2 + 20;
            this.ta3.text = DescriptionTranslate.translate(param1.infor, this.ta3.mytext);
            this.ta3.y = _loc_2;
            _loc_2 = _loc_2 + (this.ta3.height + 10);
            if (_loc_2 < 270)
            {
                _loc_2 = 270;
            }
            this._bg.graphics.drawRoundRect(0, _loc_3, 280, _loc_2 - _loc_3 - 5, 10);
            this._bg.graphics.endFill();
            this._canvas.reFresh();
            return;
        }// end function

    }
}
