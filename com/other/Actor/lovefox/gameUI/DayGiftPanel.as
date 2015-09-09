package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class DayGiftPanel extends Window
    {
        private var giftTaskObj:Object;
        private var listcanvas:SimpleTree;
        private var taskList:Array;
        private var titleText:Label;
        private var getBtn:PushButton;

        public function DayGiftPanel(param1:DisplayObjectContainer = null)
        {
            this.giftTaskObj = {};
            this.taskList = [];
            super(param1);
            this.initpanel();
            return;
        }// end function

        override public function switchOpen() : void
        {
            super.switchOpen();
            if (this.stage != null)
            {
                this.showPanel();
            }
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_2:* = undefined;
            resize(220, 230);
            this.title = Config.language("DayGiftPanel", 1);
            var _loc_1:* = new Shape();
            this.addChild(_loc_1);
            _loc_1.graphics.beginFill(12564362, 0.4);
            _loc_1.graphics.drawRoundRect(5, 50, 205, 130, 3);
            _loc_1.graphics.endFill();
            this.listcanvas = new SimpleTree(this, 5, 55, 200, 155);
            this.listcanvas.expandItem = true;
            this.listcanvas.addEventListener(SimpleTreeEvent.SELECT_ID, this.gettreeevent);
            for (_loc_2 in Config._taskMap)
            {
                
                if (int(Config._taskMap[_loc_2].type) == 4)
                {
                    this.giftTaskObj[int(Config._taskMap[_loc_2].id)] = Config._taskMap[_loc_2];
                }
            }
            this.titleText = new Label(this, 10, 25);
            this.getBtn = new PushButton(this, 70, 190, Config.language("DayGiftPanel", 2), this.getFuc);
            this.getBtn.width = 80;
            return;
        }// end function

        private function showPanel() : void
        {
            var _loc_1:* = undefined;
            var _loc_2:* = false;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            this.listcanvas.clearTree();
            this.listcanvas.addNode(Config.language("DayGiftPanel", 3), true);
            this.taskList.length = 0;
            if (Config.ui._taskpanel.taskIsDwon(68))
            {
                for (_loc_1 in this.giftTaskObj)
                {
                    
                    if (Config.player.level >= this.giftTaskObj[_loc_1].levelReq && (Config.player.level < this.giftTaskObj[_loc_1].levelTop || int(this.giftTaskObj[_loc_1].levelTop) == 0))
                    {
                        _loc_2 = true;
                        if (Config.ui._taskpanel.taskIsDwon(int(this.giftTaskObj[_loc_1].id)))
                        {
                            _loc_2 = false;
                        }
                        if (_loc_2)
                        {
                            _loc_3 = 0;
                            while (_loc_3 < Config.ui._taskpanel.tasklistarr.length)
                            {
                                
                                if (int(this.giftTaskObj[_loc_1].id) == int(Config.ui._taskpanel.tasklistarr[_loc_3].id))
                                {
                                    _loc_2 = false;
                                    break;
                                }
                                _loc_3 = _loc_3 + 1;
                            }
                        }
                        if (_loc_2)
                        {
                            this.taskList.push(this.giftTaskObj[_loc_1].id);
                            _loc_4 = this.giftTaskObj[_loc_1].title;
                            _loc_5 = 6710886;
                            _loc_6 = "";
                            this.listcanvas.additems([{str:_loc_4, len:120, id:this.giftTaskObj[_loc_1].id}], Config.language("DayGiftPanel", 3), _loc_5, false);
                        }
                    }
                }
            }
            if (this.taskList.length > 0)
            {
                this.titleText.text = Config.language("DayGiftPanel", 4);
                this.getBtn.enabled = true;
            }
            else
            {
                this.titleText.text = Config.language("DayGiftPanel", 5);
                this.getBtn.enabled = false;
            }
            return;
        }// end function

        private function gettreeevent(event:SimpleTreeEvent) : void
        {
            Config.ui._taskpanel.opentaskinfor4(this.giftTaskObj[event.id]);
            return;
        }// end function

        private function getFuc(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this.taskList.length)
            {
                
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_QUEST_ACCEPT);
                _loc_3.add32(this.taskList[_loc_2]);
                _loc_3.add32(0);
                _loc_3.add8(0);
                ClientSocket.send(_loc_3);
                _loc_2 = _loc_2 + 1;
            }
            this.close();
            return;
        }// end function

        public function dayListNpcTalk(param1:int, param2:Array, param3:Function = null) : void
        {
            param2.push({label:Config.language("DayGiftPanel", 6), handler:this.dayTaskFind, closeflag:true});
            return;
        }// end function

        private function dayTaskFind(event:TextEvent) : void
        {
            this.switchOpen();
            return;
        }// end function

    }
}
