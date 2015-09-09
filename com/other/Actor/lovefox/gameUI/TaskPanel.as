package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class TaskPanel extends Window
    {
        private var mainpanel:Sprite;
        private var newtasktips:TaskNewTips;
        public var taskmate:TaskInfor;
        private var tkinforsp:TaskInforSp;
        public var dayListPanel:TaskDayList;
        private var taskupshow:TaskUpdateTip;
        private var leftlistmc:Sprite;
        private var rightlstmc:CanvasUI;
        private var taskinformc:CanvasUI;
        private var listtabmc:TabNavigatorUI;
        private var menubar:ButtonBar;
        public var _tasktips:TaskTips;
        public var tasklistarr:Array;
        private var taskliparr:Array;
        private var tempTipList:Array;
        private var taskautoarr:Array;
        public var taskdownlist:Object;
        public var taskRecomList:Object;
        private var taskWeekList:Array;
        public var taskdayarr:Array;
        private var _canList:Array;
        private var tasklipflag:int = -1;
        private var tasklipmcarr:Array;
        private var taskbakemcarr:Array;
        private var taskawadmcarr:Array;
        private var _maxlipnum:int = 5;
        private var hideshowbtn:PushButton;
        private var trackbtn:PushButton;
        private var gettaskbtn:PushButton;
        private var listcanvas:SimpleTree;
        private var typecodearr:Array;
        private var temparr:Array;
        public var autobtn:PushButton;
        private var autoflag:Boolean = false;
        private var _daytaskflag:int = 0;
        private var selectitem:Array;
        private var _sflag:int = -1;
        private var _autotaskid:int = -1;
        private var daynum:Label;
        private var dayrefash:Label;
        private var panelbg:Sprite;
        private var tasktimer:Timer;
        private var timeid:int = 0;
        public var _tasksite:int = 1;
        private var toolBtn1:PushButton;
        private var toolBtn2:PushButton;
        private var questAutoList:Object;
        private var questTime:Timer;
        private var questTimeBar:ProgressBar;
        private var questTimeLabel:Label;
        public var _taskFinishListInit:Boolean = false;
        private var _mapNextType:int = 0;
        private var _mapNextValue:int = 0;
        private var _MapNextFlag:Boolean = false;
        private var _leftB:String;
        private var _rightB:String;
        private var _rightSpace:int = 6;
        private var eggpanel:Window;
        private var suregiveggBtn:PushButton;
        private var sloteggArr:Array;
        private var _strtimer:String;
        private var _gathertime:Number;

        public function TaskPanel(param1:DisplayObjectContainer = null)
        {
            this.tempTipList = [];
            this.taskdownlist = {};
            this.taskRecomList = {};
            this.taskWeekList = [];
            this.taskdayarr = new Array();
            this._canList = new Array();
            this.questAutoList = {};
            this.sloteggArr = [];
            super(param1);
            if (Config._switchEnglish)
            {
                this._leftB = "[";
                this._rightB = "]";
            }
            else
            {
                this._leftB = "[";
                this._rightB = "]";
            }
            this.initsocket();
            this.initpanel();
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            if (this.newtasktips != null)
            {
                if (this.newtasktips.parent != null)
                {
                    this.container.removeChild(this.newtasktips);
                }
            }
            var _loc_2:* = true;
            if (this.tkinforsp != null)
            {
                if (this.tkinforsp.parent != null)
                {
                    _loc_2 = false;
                }
            }
            if (_loc_2)
            {
                if (this.menubar.selectpage == 0)
                {
                    this.initsecpage(null, 0);
                }
            }
            if (this.taskmate != null)
            {
                if (this.taskmate.parent != null)
                {
                    this.taskmate.close();
                }
            }
            this.checkQuestTime();
            return;
        }// end function

        override public function close()
        {
            super.close();
            var _loc_1:* = 0;
            while (_loc_1 < this.tasklistarr.length)
            {
                
                if (this.tasklistarr[_loc_1].type == 2)
                {
                    this.opennewtip(3, 2);
                    break;
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_QUEST_UPDATE, this.taskupdate);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_QUEST_LIST, this.backgettasklist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_QUEST_ADD, this.backaddtask);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_QUEST_FINISH, this.finishTask);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_QUEST_DELETE, this.backdeltask);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_QUEST_LIST_FINISHED, this.taskfinish);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_DAY_CHANGE, this.taskdaychange);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_QUEST_LIST_DAILY, this.listDaily);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_QUEST_TRACE, this.getTipList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_WEEKLYQUEST, this.addTaskWeekList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_QUEST_AUTO, this.questAuto);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GATHER_COUNTDOWN, this.strattimer);
            return;
        }// end function

        private function initpanel() : void
        {
            resize(700, 360);
            this.title = Config.language("TaskPanel", 7);
            this.taskmate = new TaskInfor(this.container);
            this.dayListPanel = new TaskDayList(this.container);
            this.tasktimer = new Timer(3000);
            this.tasktimer.addEventListener(TimerEvent.TIMER, this.checktime);
            this.questTime = new Timer(1000);
            this.questTime.addEventListener(TimerEvent.TIMER, this.questRun);
            this.panelbg = new Sprite();
            this.addChild(this.panelbg);
            this.panelbg.graphics.beginFill(16777215, 0.3);
            this.panelbg.graphics.drawRoundRect(10, 25, 255 + 120, 320, 1);
            this.panelbg.graphics.endFill();
            this.panelbg.graphics.lineStyle(2, 12357464, 0.3);
            this.panelbg.graphics.moveTo(270 + 120, 22);
            this.panelbg.graphics.lineTo(270 + 120, 355);
            this.panelbg.graphics.endFill();
            this.mainpanel = new Sprite();
            this.addChild(this.mainpanel);
            this.menubar = new ButtonBar(this, 15, 25, 260 + 120);
            this.menubar.addTab(Config.language("TaskPanel", 8), Config.create(this.initsecpage, 0));
            this.menubar.addTab(Config.language("TaskPanel", 9), Config.create(this.initsecpage, 1));
            this.tasklistarr = new Array();
            this.taskliparr = new Array();
            this.taskautoarr = new Array();
            this.temparr = [Config.language("TaskPanel", 10), Config.language("TaskPanel", 11), Config.language("TaskPanel", 12)];
            this.typecodearr = ["", Config.language("TaskPanel", 13), Config.language("TaskPanel", 14)];
            this._tasktips = new TaskTips();
            this._tasktips.x = -145;
            this._tasktips.y = 170;
            this.taskupshow = new TaskUpdateTip();
            this.autobtn = new PushButton(null, 400, 330, Config.language("TaskPanel", 15), this.autobtnfuc);
            if (this.autoflag)
            {
                this.autobtn.label = Config.language("TaskPanel", 16);
            }
            else
            {
                this.autobtn.label = Config.language("TaskPanel", 17);
            }
            this.autobtn.width = 60;
            this.menubar.selectpage = 0;
            this.trackbtn = new PushButton(this, 480 + 120, 330, Config.language("TaskPanel", 18), this.checktolip);
            this.trackbtn.width = 70;
            this.gettaskbtn = new PushButton(this, 480 + 120, 330, Config.language("TaskPanel", 19), this.gotonpc);
            this.gettaskbtn.width = 70;
            this.toolBtn1 = new PushButton(this, 320 + 120, 330, "", Config.create(this.toolFuc, 1));
            this.toolBtn1.width = 70;
            this.toolBtn2 = new PushButton(this, 400 + 120, 330, "", Config.create(this.toolFuc, 2));
            this.toolBtn2.width = 70;
            this.questTimeBar = new ProgressBar(this, 280, 330);
            this.questTimeBar.height = 15;
            this.questTimeBar.width = 100;
            this.questTimeBar.gradientFillDirection = Math.PI;
            this.questTimeBar.roundCorner = 6;
            this.questTimeBar.color = 15981107;
            this.questTimeBar.subColor = 16750899;
            this.questTimeLabel = new Label(this, 290, 330);
            this.questTimeLabel.filters = [new GlowFilter(Style.WINDOW_FONT, 1, 3, 3, 10, 1)];
            this.questTimeLabel.textColor = 16777215;
            this.initsecpage(null, 0);
            this.daynum = new Label();
            this.dayrefash = new Label();
            return;
        }// end function

        public function tipSwitch(param1:Sprite, param2:Boolean) : void
        {
            if (param2)
            {
                if (this._tasktips.parent != null)
                {
                    this._tasktips.parent.removeChild(this._tasktips);
                }
                else
                {
                    param1.addChild(this._tasktips);
                    if (Config.player != null)
                    {
                        if (Config.player.level >= 20)
                        {
                            this._tasktips._autobtn.mouseEnabled = true;
                        }
                        else
                        {
                            this._tasktips._autobtn.mouseEnabled = false;
                        }
                    }
                }
            }
            else if (this._tasktips.parent != null)
            {
                this._tasktips.parent.removeChild(this._tasktips);
            }
            return;
        }// end function

        public function resetxy(param1:Number, param2:Number) : void
        {
            this.x = (param1 - this.width) / 2;
            this.y = (param2 - this.height) / 2;
            return;
        }// end function

        public function initsecpage(event:MouseEvent = null, param2:int = 0, param3:Boolean = true) : void
        {
            this.trackbtn.label = Config.language("TaskPanel", 24);
            this.tasklipmcarr = [];
            this.taskbakemcarr = [];
            this.taskawadmcarr = [];
            if (param2 > 1)
            {
            }
            else
            {
                if (this.tkinforsp != null && param3)
                {
                    if (this.tkinforsp.parent != null)
                    {
                        this.tkinforsp.parent.removeChild(this.tkinforsp);
                    }
                }
                this.removeallchild(this.mainpanel);
            }
            if (param2 == 0)
            {
                this.toolBtn1.visible = false;
                this.toolBtn2.visible = false;
                this.questTimeBar.visible = false;
                this.questTimeLabel.visible = false;
                this.betasklist(0, param3);
                this.trackbtn.visible = true;
                this.menubar.selectpage = 0;
                this.gettaskbtn.visible = false;
                this.checkQuestTime();
            }
            else if (param2 == 1)
            {
                this.toolBtn1.visible = false;
                this.toolBtn2.visible = false;
                this.questTimeBar.visible = false;
                this.questTimeLabel.visible = false;
                this.everydaytask(param3);
                this.menubar.selectpage = 1;
                this.gettaskbtn.visible = true;
                this.trackbtn.visible = false;
                this.checkQuestTime();
            }
            this.tasklipflag = -1;
            return;
        }// end function

        private function taskliprollout(event:MouseEvent, param2:int) : void
        {
            if (this.tasklipflag != param2 && param2 < 10)
            {
                this.tasklipmcarr[param2].tasklipbg.alpha = 0.5;
            }
            else if (this.tasklipflag != param2 && param2 >= 10)
            {
                this.taskbakemcarr[int(param2 - 10)].tasklipbg.alpha = 0.5;
            }
            return;
        }// end function

        private function taskliprollover(event:MouseEvent, param2:int) : void
        {
            if (param2 < 10)
            {
                this.tasklipmcarr[param2].tasklipbg.alpha = 1;
            }
            else
            {
                this.taskbakemcarr[int(param2 - 10)].tasklipbg.alpha = 1;
            }
            return;
        }// end function

        private function taskliprollclick(event:MouseEvent = null, param2:int = -1, param3:Boolean = true) : void
        {
            var _loc_4:* = false;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = false;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            if (this.tasklipflag > 0)
            {
                _loc_4 = true;
                _loc_5 = 0;
                while (_loc_5 < this.tasklipmcarr.length)
                {
                    
                    if (this.tasklipmcarr[_loc_5].id == this.tasklipflag)
                    {
                        this.tasklipmcarr[_loc_5].select = false;
                        _loc_4 = false;
                        break;
                    }
                    _loc_5 = _loc_5 + 1;
                }
                if (_loc_4)
                {
                    _loc_6 = 0;
                    while (_loc_6 < this.taskbakemcarr.length)
                    {
                        
                        if (this.taskbakemcarr[_loc_6].id == this.tasklipflag)
                        {
                            this.taskbakemcarr[_loc_6].select = false;
                            break;
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                }
            }
            if (param2 > 0)
            {
                _loc_7 = true;
                _loc_8 = 0;
                while (_loc_8 < this.tasklipmcarr.length)
                {
                    
                    if (this.tasklipmcarr[_loc_8].id == param2)
                    {
                        this.tasklipmcarr[_loc_8].select = true;
                        _loc_7 = false;
                        break;
                    }
                    _loc_8 = _loc_8 + 1;
                }
                if (_loc_7)
                {
                    _loc_9 = 0;
                    while (_loc_9 < this.taskbakemcarr.length)
                    {
                        
                        if (this.taskbakemcarr[_loc_9].id == param2)
                        {
                            this.taskbakemcarr[_loc_9].select = true;
                            break;
                        }
                        _loc_9 = _loc_9 + 1;
                    }
                }
            }
            this.tasklipflag = param2;
            if (param3)
            {
                this.opentaskinfor(param2);
            }
            return;
        }// end function

        private function betasklist(param1:int = 0, param2:Boolean = true) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            this.listcanvas = new SimpleTree(this.mainpanel, 10, 50, 250 + 120, 285);
            this.listcanvas.addNode(Config.language("TaskPanel", 25), true);
            this.listcanvas.addNode(Config.language("TaskPanel", 26), true);
            this.listcanvas.addNode(Config.language("TaskPanel", 27), true);
            this.listcanvas.addNode(Config.language("TaskPanel", 28), true);
            this.listcanvas.addNode(Config.language("TaskPanel", 30), true);
            var _loc_3:* = true;
            var _loc_4:* = 0;
            while (_loc_4 < this.tasklistarr.length)
            {
                
                _loc_5 = 1;
                if (Config.player != null)
                {
                    _loc_5 = Config.player.level;
                }
                _loc_6 = 6710886;
                if (_loc_5 - int(Config._taskMap[this.tasklistarr[_loc_4].id].levelReq) <= 2)
                {
                    _loc_6 = 16737792;
                }
                else if (_loc_5 - int(Config._taskMap[this.tasklistarr[_loc_4].id].levelReq) <= 5)
                {
                    _loc_6 = 39168;
                }
                else
                {
                    _loc_6 = 6710886;
                }
                if (int(Config._taskMap[this.tasklistarr[_loc_4].id].levelReq) - _loc_5 >= 4)
                {
                    _loc_6 = 16711680;
                }
                _loc_7 = Config._taskMap[this.tasklistarr[_loc_4].id].title;
                _loc_8 = "";
                if (this.tasklistarr[_loc_4].tracek)
                {
                    _loc_8 = "√";
                }
                if (Config._taskMap[this.tasklistarr[_loc_4].id].type == 0 && this.tasklistarr[_loc_4].type != 2)
                {
                    this.listcanvas.additems([{str:this._leftB + Config._taskMap[this.tasklistarr[_loc_4].id].levelReq + this._rightB, len:30 + this._rightSpace, id:this.tasklistarr[_loc_4].id}, {str:_loc_7, len:130 + 120 - this._rightSpace}, {str:this.typecodearr[this.tasklistarr[_loc_4].type], len:30}], Config.language("TaskPanel", 25), _loc_6, true);
                    if (_loc_3 && this.parent != null && param2)
                    {
                        this.opentaskinfor(this.tasklistarr[_loc_4].id);
                        _loc_3 = false;
                        this.listcanvas.selectid = this.tasklistarr[_loc_4].id;
                        if (this.tasklistarr[_loc_4].tracek)
                        {
                            this.trackbtn.label = Config.language("TaskPanel", 31);
                        }
                        else
                        {
                            this.trackbtn.label = Config.language("TaskPanel", 18);
                        }
                    }
                }
                else if (Config._taskMap[this.tasklistarr[_loc_4].id].type == 1 && this.tasklistarr[_loc_4].type != 2)
                {
                    this.listcanvas.additems([{str:this._leftB + Config._taskMap[this.tasklistarr[_loc_4].id].awardLevel + this._rightB, len:30 + this._rightSpace, id:this.tasklistarr[_loc_4].id}, {str:_loc_7, len:130 + 120 - this._rightSpace}, {str:this.typecodearr[this.tasklistarr[_loc_4].type], len:30}], Config.language("TaskPanel", 26), _loc_6, true);
                }
                else
                {
                    switch(this.tasklistarr[_loc_4].quality)
                    {
                        case 0:
                        {
                            break;
                        }
                        case 1:
                        {
                            break;
                        }
                        case 2:
                        {
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (this.tasklistarr[_loc_4].tracek)
                    {
                    }
                    if (int(Config._taskMap[this.tasklistarr[_loc_4].id].type) == 3 && this.tasklistarr[_loc_4].type != 2)
                    {
                        if (this.tasklistarr[_loc_4].tracek)
                        {
                        }
                    }
                    else if (int(Config._taskMap[this.tasklistarr[_loc_4].id].type) == 4 && this.tasklistarr[_loc_4].type != 2)
                    {
                    }
                    else if ((int(Config._taskMap[this.tasklistarr[_loc_4].id].type) == 5 || int(Config._taskMap[this.tasklistarr[_loc_4].id].week) == 2 && int(Config._taskMap[this.tasklistarr[_loc_4].id].refreshNum) > 0) && this.tasklistarr[_loc_4].type != 2)
                    {
                    }
                }
                _loc_4 = _loc_4 + 1;
            }
            if (param1 == 1)
            {
                this.mainpanel.addChild(this.hideshowbtn);
            }
            this.listcanvas.addEventListener(SimpleTreeEvent.SELECT_ID, this.gettreeevent);
            this.listcanvas.addEventListener(SimpleTreeEvent.CHECK_ID, this.checklip);
            this.listcanvas.checkrefresh(this.taskliparr);
            return;
        }// end function

        private function checklip(event:SimpleTreeEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (event.check)
            {
                if (this.taskliparr.length >= this._maxlipnum)
                {
                    _loc_3 = 0;
                    while (_loc_3 < this.tasklistarr.length)
                    {
                        
                        if (this.tasklistarr[_loc_3].id == this.taskliparr[(this.taskliparr.length - 1)])
                        {
                            this.tasklistarr[_loc_3].tracek = false;
                            break;
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                    this.taskliparr.pop();
                }
                this.taskliparr.push(event.id);
                _loc_2 = 0;
                while (_loc_2 < this.tasklistarr.length)
                {
                    
                    if (this.tasklistarr[_loc_2].id == event.id)
                    {
                        this.tasklistarr[_loc_2].tracek = true;
                        this.trackbtn.label = Config.language("TaskPanel", 31);
                        break;
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                _loc_4 = 0;
                while (_loc_4 < this.taskliparr.length)
                {
                    
                    if (event.id == this.taskliparr[_loc_4])
                    {
                        this.taskliparr.splice(_loc_4, 1);
                        _loc_5 = 0;
                        while (_loc_5 < this.tasklistarr.length)
                        {
                            
                            if (this.tasklistarr[_loc_5].id == event.id)
                            {
                                this.tasklistarr[_loc_5].tracek = false;
                                this.trackbtn.label = Config.language("TaskPanel", 24);
                                break;
                            }
                            _loc_5 = _loc_5 + 1;
                        }
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            this.listcanvas.checkrefresh(this.taskliparr);
            this.opentaskinfor(event.id);
            this.listcanvas.selectid = event.id;
            this._tasktips.uptask(this.tasklistarr, this.taskliparr);
            return;
        }// end function

        private function checktolip(event:MouseEvent = null) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = false;
            var _loc_2:* = this.listcanvas.selectid;
            var _loc_3:* = 0;
            while (_loc_3 < this.tasklistarr.length)
            {
                
                if (this.tasklistarr[_loc_3].id == _loc_2)
                {
                    if (this.tasklistarr[_loc_3].tracek)
                    {
                        this.tasklistarr[_loc_3].tracek = false;
                        _loc_4 = 0;
                        while (_loc_4 < this.taskliparr.length)
                        {
                            
                            if (_loc_2 == this.taskliparr[_loc_4])
                            {
                                this.taskliparr.splice(_loc_4, 1);
                                this.trackbtn.label = Config.language("TaskPanel", 24);
                            }
                            _loc_4 = _loc_4 + 1;
                        }
                    }
                    else
                    {
                        if (this.taskliparr.length >= this._maxlipnum)
                        {
                            this.listcanvas.selectid = this.taskliparr[(this.taskliparr.length - 1)];
                            _loc_4 = 0;
                            while (_loc_4 < this.tasklistarr.length)
                            {
                                
                                if (this.tasklistarr[_loc_4].id == this.taskliparr[(this.taskliparr.length - 1)])
                                {
                                    this.tasklistarr[_loc_4].tracek = false;
                                    break;
                                }
                                _loc_4 = _loc_4 + 1;
                            }
                            this.taskliparr.pop();
                        }
                        _loc_5 = true;
                        _loc_4 = 0;
                        while (_loc_4 < this.taskliparr.length)
                        {
                            
                            if (this.taskliparr[_loc_4] == _loc_2)
                            {
                                _loc_5 = false;
                                break;
                            }
                            _loc_4 = _loc_4 + 1;
                        }
                        this.tasklistarr[_loc_3].tracek = true;
                        this.listcanvas.selectid = _loc_2;
                        this.trackbtn.label = Config.language("TaskPanel", 31);
                        if (_loc_5)
                        {
                            this.taskliparr.push(_loc_2);
                        }
                    }
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            this._tasktips.open();
            this._tasktips.uptask(this.tasklistarr, this.taskliparr);
            this.listcanvas.checkrefresh(this.taskliparr);
            return;
        }// end function

        private function gotonpc(event:MouseEvent) : void
        {
            if (this.listcanvas.selectid > 0)
            {
                Hang.hangNpc(Config._taskMap[this.listcanvas.selectid].startNPC);
            }
            else
            {
                Config.message(Config.language("TaskPanel", 35));
            }
            return;
        }// end function

        private function opentask(event:TextEvent, param2:int) : void
        {
            Config.ui._taskpanel.open();
            Config.ui._taskpanel.opentaskinfor(param2, true);
            return;
        }// end function

        private function opengildpannel(event:TextEvent) : void
        {
            Config.ui._gangs.open();
            return;
        }// end function

        private function everydaytask(param1:Boolean = true) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = false;
            var _loc_5:* = 0;
            var _loc_6:* = false;
            var _loc_7:* = false;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_2:* = new Array();
            for (_loc_3 in Config._taskMap)
            {
                
                _loc_6 = false;
                if (int(Config._taskMap[_loc_3].acceptType) == 1 && int(Config._taskMap[_loc_3].type) != 4 && int(Config._taskMap[_loc_3].startNPC) > 0 && Config.player.level >= Config._taskMap[_loc_3].levelReq && (Config.player.level < Config._taskMap[_loc_3].levelTop || int(Config._taskMap[_loc_3].levelTop) == 0) && (Config.player.job == int(Config._taskMap[_loc_3].jobReq) || int(Config._taskMap[_loc_3].jobReq) == 0))
                {
                    _loc_6 = true;
                    if (this.taskdownlist[Config._taskMap[_loc_3].id] != null)
                    {
                        if (Config._taskMap[Config._taskMap[_loc_3].id].week == 1 && Config._taskMap[Config._taskMap[_loc_3].id].refreshNum > 0 && Config._taskMap[Config._taskMap[_loc_3].id].type != 5 || Config._taskMap[Config._taskMap[_loc_3].id].type == 4)
                        {
                            _loc_6 = true;
                        }
                        else
                        {
                            _loc_6 = false;
                        }
                    }
                    if (Config._taskMap[_loc_3].preTaskId != 0)
                    {
                        _loc_7 = false;
                        if (this.taskdownlist[int(Config._taskMap[_loc_3].preTaskId)] != null)
                        {
                            _loc_7 = true;
                        }
                        if (!_loc_7)
                        {
                            _loc_6 = false;
                        }
                    }
                    if (Config._taskMap[Config._taskMap[_loc_3].id].type == 5)
                    {
                        _loc_6 = false;
                        _loc_8 = 0;
                        while (_loc_8 < this.taskWeekList.length)
                        {
                            
                            if (Config._taskMap[_loc_3].id == this.taskWeekList[_loc_8].id)
                            {
                                _loc_6 = true;
                                break;
                            }
                            _loc_8 = _loc_8 + 1;
                        }
                    }
                    if (_loc_6)
                    {
                        _loc_9 = 0;
                        while (_loc_9 < this.tasklistarr.length)
                        {
                            
                            if (this.tasklistarr[_loc_9].id == Config._taskMap[_loc_3].id)
                            {
                                _loc_6 = false;
                                break;
                            }
                            else if (int(Config._taskMap[_loc_3].type) == 4 && int(Config._taskMap[_loc_3].acceptType) == 1)
                            {
                                if (int(Config._taskMap[int(this.tasklistarr[_loc_9].id)].headTask) == int(Config._taskMap[int(Config._taskMap[_loc_3].id)].headTask))
                                {
                                    _loc_6 = false;
                                    break;
                                }
                            }
                            _loc_9 = _loc_9 + 1;
                        }
                    }
                }
                if (_loc_6)
                {
                    _loc_10 = new Object();
                    _loc_10.id = Config._taskMap[_loc_3].id;
                    _loc_10.type = 4;
                    _loc_10.hadmon1 = 0;
                    _loc_10.hadmon2 = 0;
                    _loc_10.hadmon3 = 0;
                    _loc_10.haditem1 = 0;
                    _loc_10.haditem2 = 0;
                    _loc_10.haditem3 = 0;
                    _loc_10.trash = 0;
                    _loc_10.quality = 0;
                    _loc_10.spnum = 0;
                    _loc_10.daynum = 0;
                    _loc_10.relevel = Config._taskMap[_loc_3].levelReq;
                    _loc_11 = 0;
                    while (_loc_11 < this.taskdayarr.length)
                    {
                        
                        if (this.taskdayarr[_loc_11].id == _loc_10.id)
                        {
                            _loc_10.daynum = this.taskdayarr[_loc_11].daynum;
                            _loc_10.quality = this.taskdayarr[_loc_11].quality;
                        }
                        _loc_11 = _loc_11 + 1;
                    }
                    if (_loc_10.daynum < Config._taskMap[_loc_10.id].refreshNum || Config._taskMap[_loc_10.id].type == 1 || Config._taskMap[_loc_10.id].week == 1 && Config._taskMap[_loc_10.id].refreshNum == 0)
                    {
                        _loc_2.push(_loc_10);
                    }
                }
            }
            _loc_2.sortOn("relevel", Array.DESCENDING | Array.NUMERIC);
            this.listcanvas = new SimpleTree(this.mainpanel, 10, 50, 250 + 120, 285);
            this.listcanvas.addNode(Config.language("TaskPanel", 44), true);
            this.listcanvas.addNode(Config.language("TaskPanel", 45), true);
            this.listcanvas.addNode(Config.language("TaskPanel", 46), true);
            this.listcanvas.addNode(Config.language("TaskPanel", 47), true);
            _loc_4 = true;
            _loc_5 = 0;
            while (_loc_5 < _loc_2.length)
            {
                
                _loc_12 = 1;
                if (Config.player != null)
                {
                    _loc_12 = Config.player.level;
                }
                _loc_13 = 6710886;
                if (_loc_12 - int(Config._taskMap[_loc_2[_loc_5].id].levelReq) <= 2)
                {
                    _loc_13 = 16737792;
                }
                else if (_loc_12 - int(Config._taskMap[_loc_2[_loc_5].id].levelReq) <= 5)
                {
                    _loc_13 = 39168;
                }
                else
                {
                    _loc_13 = 6710886;
                }
                if (int(Config._taskMap[_loc_2[_loc_5].id].levelReq) - _loc_12 >= 4)
                {
                    _loc_13 = 16711680;
                }
                _loc_14 = Config._taskMap[_loc_2[_loc_5].id].title;
                if (Config._taskMap[_loc_2[_loc_5].id].week == 1 && Config._taskMap[_loc_2[_loc_5].id].refreshNum > 0 || Config._taskMap[_loc_2[_loc_5].id].type == 4)
                {
                    if (_loc_2[_loc_5].daynum < Config._taskMap[_loc_2[_loc_5].id].refreshNum)
                    {
                        if (Config.player.gildid == 0 && Config._taskMap[_loc_2[_loc_5].id].type == 3)
                        {
                        }
                        else
                        {
                            this.listcanvas.additems([{str:this._leftB + Config._taskMap[_loc_2[_loc_5].id].levelReq + this._rightB, len:30 + this._rightSpace, id:_loc_2[_loc_5].id}, {str:_loc_14, len:140 + 120 - this._rightSpace}, {str:_loc_2[_loc_5].daynum + "/" + Config._taskMap[_loc_2[_loc_5].id].refreshNum, len:30}], Config.language("TaskPanel", 44), _loc_13, false);
                        }
                    }
                }
                else if (Config._taskMap[_loc_2[_loc_5].id].week == 2)
                {
                    if (_loc_2[_loc_5].daynum < Config._taskMap[_loc_2[_loc_5].id].refreshNum)
                    {
                        this.listcanvas.additems([{str:this._leftB + Config._taskMap[_loc_2[_loc_5].id].levelReq + this._rightB, len:30 + this._rightSpace, id:_loc_2[_loc_5].id}, {str:_loc_14, len:140 + 120 - this._rightSpace}, {str:_loc_2[_loc_5].daynum + "/" + Config._taskMap[_loc_2[_loc_5].id].refreshNum, len:30}], Config.language("TaskPanel", 45), _loc_13, false);
                    }
                }
                else if (Config._taskMap[_loc_2[_loc_5].id].week != 0 && Config._taskMap[_loc_2[_loc_5].id].refreshNum == 0)
                {
                    if (Config.player.level - 10 <= Config._taskMap[_loc_2[_loc_5].id].levelReq)
                    {
                        this.listcanvas.additems([{str:this._leftB + Config._taskMap[_loc_2[_loc_5].id].levelReq + this._rightB, len:30 + this._rightSpace, id:_loc_2[_loc_5].id}, {str:_loc_14, len:130 - this._rightSpace}, {str:" ", len:30}], Config.language("TaskPanel", 46), _loc_13, false);
                    }
                }
                else
                {
                    this.listcanvas.additems([{str:this._leftB + Config._taskMap[_loc_2[_loc_5].id].levelReq + this._rightB, len:30 + this._rightSpace, id:_loc_2[_loc_5].id}, {str:_loc_14, len:130 - this._rightSpace}, {str:" ", len:30}], Config.language("TaskPanel", 47), _loc_13, false);
                }
                if (_loc_4 && this.parent != null && param1 && Config._taskMap[_loc_2[_loc_5].id].startNPC > 0 && _loc_2[_loc_5].daynum < Config._taskMap[_loc_2[_loc_5].id].refreshNum)
                {
                    _loc_4 = false;
                    this.listcanvas.selectid = _loc_2[_loc_5].id;
                    this.openretask();
                }
                _loc_5 = _loc_5 + 1;
            }
            this.listcanvas.addEventListener(SimpleTreeEvent.SELECT_ID, this.openretask);
            return;
        }// end function

        private function handleActiveOver(param1, param2:String)
        {
            Holder.showInfo(param2, new Rectangle(Config.stage.mouseX, Config.stage.mouseY + 10), false, 1, 200);
            return;
        }// end function

        private function handleActiveOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function findNPC(event:TextEvent, param2:int) : void
        {
            Hang.hangNpc(int(param2));
            return;
        }// end function

        private function getTipList(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = _loc_2.readUTFBytes(_loc_3);
            this.tempTipList = _loc_4.split(",");
            return;
        }// end function

        private function addTaskWeekList(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            this.taskWeekList = new Array();
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.groupId = _loc_2.readUnsignedInt();
                _loc_5.id = _loc_2.readUnsignedInt();
                this.taskWeekList.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            this.sendtaskchange();
            return;
        }// end function

        private function backgettasklist(event:SocketEvent) : void
        {
            var _loc_5:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = undefined;
            var _loc_10:* = 0;
            this._tasktips.open();
            var _loc_2:* = true;
            var _loc_3:* = event.data;
            this.tasklistarr = new Array();
            var _loc_4:* = _loc_3.readUnsignedInt();
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = new Object();
                _loc_7.id = _loc_3.readUnsignedInt();
                _loc_7.type = _loc_3.readByte();
                _loc_7.hadmon1 = _loc_3.readUnsignedShort();
                _loc_7.hadmon2 = _loc_3.readUnsignedShort();
                _loc_7.hadmon3 = _loc_3.readUnsignedShort();
                _loc_7.haditem1 = _loc_3.readUnsignedShort();
                _loc_7.haditem2 = _loc_3.readUnsignedShort();
                _loc_7.haditem3 = _loc_3.readUnsignedShort();
                _loc_7.quality = _loc_3.readByte();
                _loc_7.spnum = _loc_3.readByte();
                _loc_7.daynum = _loc_3.readByte();
                _loc_7.random = _loc_3.readByte();
                _loc_7.tracek = false;
                _loc_7.sorttype = int(Config._taskMap[_loc_7.id].type);
                this.deldowntask(_loc_7.id, _loc_7.daynum);
                if (_loc_7.type == 6 || _loc_7.type == 3)
                {
                    this.taskdayarr.push(_loc_7);
                }
                else if (_loc_7.type == 7)
                {
                    _loc_7.type = 1;
                    _loc_8 = 1;
                    while (_loc_8 < 4)
                    {
                        
                        if (Config._taskMap[_loc_7.id]["monNum" + _loc_8] > 0)
                        {
                            _loc_7["hadmon" + _loc_8] = Config._taskMap[_loc_7.id]["monNum" + _loc_8];
                        }
                        if (Config._taskMap[_loc_7.id]["itemNum" + _loc_8] > 0)
                        {
                            _loc_7["haditem" + _loc_8] = Config._taskMap[_loc_7.id]["itemNum" + _loc_8];
                        }
                        _loc_8 = _loc_8 + 1;
                    }
                    this.tasklistarr.push(_loc_7);
                }
                else if (_loc_7.type != 3)
                {
                    this.tasklistarr.push(_loc_7);
                }
                _loc_5 = _loc_5 + 1;
            }
            this.tasklistarr.sortOn(["sorttype", "id"], [Array.NUMERIC, Array.NUMERIC]);
            if (this.menubar.selectpage == 0)
            {
                this.initsecpage(null, 0);
            }
            var _loc_6:* = true;
            this.taskliparr = [];
            if (this.tempTipList.length > 0)
            {
                for (_loc_9 in this.tempTipList)
                {
                    
                    _loc_10 = 0;
                    while (_loc_10 < this.tasklistarr.length)
                    {
                        
                        if (this.tasklistarr[_loc_10].id == this.tempTipList[_loc_9])
                        {
                            if (this.taskliparr.length < 5)
                            {
                                this.tasklistarr[_loc_10].tracek = true;
                                this.taskliparr.push(this.tasklistarr[_loc_10].id);
                            }
                            _loc_6 = false;
                            break;
                        }
                        _loc_10 = _loc_10 + 1;
                    }
                }
                this._tasktips.uptask(this.tasklistarr, this.taskliparr);
            }
            _loc_5 = 0;
            while (_loc_5 < this.tasklistarr.length)
            {
                
                if (this.tasklistarr[_loc_5].id == 1)
                {
                    this.opentaskinfor2(this.tasklistarr[_loc_5].id);
                }
                if (_loc_6)
                {
                    if (Config._taskMap[this.tasklistarr[_loc_5].id].type == 0)
                    {
                        this.tasklistarr[_loc_5].tracek = false;
                        if (this.taskliparr.length < 5)
                        {
                            _loc_7.tracek = true;
                            this.taskliparr.push(this.tasklistarr[_loc_5].id);
                        }
                        this._tasktips.uptask(this.tasklistarr, this.taskliparr);
                    }
                    else if (Config._taskMap[this.tasklistarr[_loc_5].id].type == 1 || Config._taskMap[this.tasklistarr[_loc_5].id].type == 4)
                    {
                        this.tasklistarr[_loc_5].tracek = false;
                        if (this.taskliparr.length < 5)
                        {
                            this.tasklistarr[_loc_5].tracek = true;
                            this.taskliparr.push(this.tasklistarr[_loc_5].id);
                        }
                        this._tasktips.uptask(this.tasklistarr, this.taskliparr);
                    }
                }
                _loc_5 = _loc_5 + 1;
            }
            this.tasklistarr.sortOn(["type", "id"], [Array.DESCENDING | Array.NUMERIC, Array.NUMERIC]);
            this.sendtaskchange();
            return;
        }// end function

        private function deldowntask(param1:int, param2:int) : void
        {
            if (this.taskdownlist == null)
            {
                trace("未收到已做任务");
                return;
            }
            if (int(Config._taskMap[param1].week) > 0)
            {
                if (this.taskdownlist[param1] != null)
                {
                    if (int(Config._taskMap[param1].refreshNum) > param2)
                    {
                        delete this.taskdownlist[param1];
                    }
                    else if (int(Config._taskMap[param1].refreshNum) == 0)
                    {
                        delete this.taskdownlist[param1];
                    }
                }
            }
            return;
        }// end function

        private function taskupdate(event:SocketEvent) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = false;
            var _loc_12:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readByte();
            var _loc_5:* = _loc_2.readByte();
            var _loc_6:* = _loc_2.readByte();
            var _loc_7:* = _loc_2.readUnsignedShort();
            if (_loc_2.readUnsignedShort() > 0)
            {
                _loc_9 = "";
                if (_loc_5 == 1)
                {
                    _loc_9 = Config._monsterMap[Config._taskMap[_loc_3]["mon" + _loc_6]].name + "   " + String(_loc_7 + "/" + Config._taskMap[_loc_3]["monNum" + _loc_6]);
                }
                else if (_loc_5 == 2)
                {
                    _loc_9 = Config._itemMap[Config._taskMap[_loc_3]["item" + _loc_6]].name + "   " + String(_loc_7 + "/" + Config._taskMap[_loc_3]["itemNum" + _loc_6]);
                }
                if (_loc_9 != "")
                {
                    BubbleUI.bubble(String(Config._taskMap[_loc_3].title) + ":" + _loc_9, 16755370);
                }
            }
            var _loc_8:* = 0;
            while (_loc_8 < this.tasklistarr.length)
            {
                
                if (this.tasklistarr[_loc_8].id == _loc_3)
                {
                    _loc_10 = this.tasklistarr[_loc_8].type;
                    this.tasklistarr[_loc_8].type = _loc_4;
                    trace(_loc_3, _loc_10, _loc_4, "task");
                    if (_loc_10 != _loc_4 && _loc_4 == 1)
                    {
                        if (this.taskmate != null)
                        {
                            if (this.taskmate.parent != null)
                            {
                                this.taskmate.changeType(_loc_4);
                            }
                        }
                    }
                    if (_loc_5 == 1)
                    {
                        this.tasklistarr[_loc_8]["hadmon" + _loc_6] = _loc_7;
                    }
                    else if (_loc_5 == 2)
                    {
                        this.tasklistarr[_loc_8]["haditem" + _loc_6] = _loc_7;
                    }
                    else if (_loc_5 == 3)
                    {
                        this.tasklistarr[_loc_8].spnum = _loc_7;
                        if (_loc_10 == _loc_4)
                        {
                            this.sendtaskchange();
                        }
                    }
                    _loc_11 = true;
                    if (_loc_4 == 7)
                    {
                        _loc_12 = 1;
                        while (_loc_12 < 4)
                        {
                            
                            if (Config._taskMap[_loc_3]["monNum" + _loc_12] > 0)
                            {
                                this.tasklistarr[_loc_8]["hadmon" + _loc_12] = Config._taskMap[_loc_3]["monNum" + _loc_12];
                                if (this.taskmate != null)
                                {
                                    if (this.taskmate.parent != null)
                                    {
                                        this.taskmate.changeNum(_loc_3, 1, _loc_12, this.tasklistarr[_loc_8]["hadmon" + _loc_12]);
                                    }
                                }
                                if (this.tkinforsp != null)
                                {
                                    if (this.tkinforsp.parent != null)
                                    {
                                        this.tkinforsp.changeNum(_loc_3, 1, _loc_12, int(this.tasklistarr[_loc_8]["hadmon" + _loc_12]));
                                    }
                                }
                            }
                            if (Config._taskMap[_loc_3]["itemNum" + _loc_12] > 0)
                            {
                                this.tasklistarr[_loc_8]["haditem" + _loc_12] = Config._taskMap[_loc_3]["itemNum" + _loc_12];
                                if (this.taskmate != null)
                                {
                                    if (this.taskmate.parent != null)
                                    {
                                        this.taskmate.changeNum(_loc_3, 2, _loc_12, this.tasklistarr[_loc_8]["haditem" + _loc_12]);
                                    }
                                }
                                if (this.tkinforsp != null)
                                {
                                    if (this.tkinforsp.parent != null)
                                    {
                                        this.tkinforsp.changeNum(_loc_3, 2, _loc_12, this.tasklistarr[_loc_8]["haditem" + _loc_12]);
                                    }
                                }
                            }
                            _loc_12 = _loc_12 + 1;
                        }
                        _loc_4 = 1;
                        this.tasklistarr[_loc_8].type = 1;
                        _loc_11 = false;
                    }
                    this._tasktips.uptask(this.tasklistarr, this.taskliparr);
                    if (_loc_4 == 2)
                    {
                        Billboard.show(Config.language("TaskPanel", 49));
                        this._autotaskid = -1;
                        if (Config.ui._dialogue.parent == null)
                        {
                            this.opentaskinfor(_loc_3);
                        }
                        if (this.taskmate != null)
                        {
                            if (this.taskmate.parent != null)
                            {
                                this.taskmate.close();
                            }
                        }
                    }
                    if (_loc_10 != _loc_4)
                    {
                        if (this.menubar.selectpage == 0)
                        {
                            this.showTaskState(_loc_3, _loc_4);
                        }
                        this.sendtaskchange();
                        if (_loc_4 == 1)
                        {
                            if (_loc_3 == 4)
                            {
                                GuideUI.testDoId(154, Config.ui._taskpanel._tasktips);
                            }
                            Billboard.show(Config.language("TaskPanel", 50));
                            if (int(Config._taskMap[_loc_3].exeType) == 6)
                            {
                                Hang.stop();
                                Config.player.target = null;
                            }
                            if (_loc_3 == 55)
                            {
                                Hang.stop();
                                Config.player.target = null;
                            }
                        }
                        if (this.parent != null)
                        {
                            if (this.menubar.selectpage > 0)
                            {
                                this.opentaskinfor(_loc_3, true);
                            }
                            else
                            {
                                this.opentaskinfor(_loc_3);
                            }
                        }
                        else if (this.taskmate != null)
                        {
                            if (this.taskmate.parent != null)
                            {
                                this.opentaskinfor2(_loc_3);
                            }
                        }
                    }
                    if (_loc_3 == this._autotaskid)
                    {
                        if (int(Config._taskMap[_loc_3].exeType) == 3)
                        {
                            this.timeid = _loc_3;
                            this.tasktimer.start();
                        }
                        else if (_loc_4 != 1 && !Hang.hanging)
                        {
                            this.autodotask(_loc_3, false);
                        }
                    }
                    else if (_loc_4 < 1)
                    {
                        if (int(Config._taskMap[_loc_3].exeType) == 3)
                        {
                            this.timeid = _loc_3;
                            this.tasktimer.start();
                        }
                        else
                        {
                            this.autodotask(_loc_3);
                        }
                    }
                    if (_loc_11)
                    {
                        if (this.taskmate != null)
                        {
                            if (this.taskmate.parent != null)
                            {
                                this.taskmate.changeNum(_loc_3, _loc_5, _loc_6, _loc_7);
                            }
                        }
                        if (this.tkinforsp != null)
                        {
                            if (this.tkinforsp.parent != null)
                            {
                                this.tkinforsp.changeNum(_loc_3, _loc_5, _loc_6, _loc_7);
                            }
                        }
                    }
                    break;
                }
                _loc_8 = _loc_8 + 1;
            }
            return;
        }// end function

        private function showTaskState(param1:int, param2:int) : void
        {
            if (param2 == 0)
            {
                this.listcanvas.changeLabel(param1, " ", 2);
            }
            else
            {
                this.listcanvas.changeLabel(param1, Config.language("TaskPanel", 13), 2);
            }
            this.opentaskinfor(param1);
            return;
        }// end function

        public function autodotask(param1:int, param2:Boolean = true) : void
        {
            var _loc_5:* = false;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_3:* = true;
            if (!param2)
            {
                if (this._autotaskid == -1)
                {
                    return;
                }
            }
            else if (this.taskautoarr.length == 0)
            {
                return;
            }
            if (this._autotaskid == -1 && !this.autoflag)
            {
                return;
            }
            if (this.autoflag)
            {
                _loc_5 = false;
                _loc_6 = 0;
                while (_loc_6 < this.taskautoarr.length)
                {
                    
                    if (this.taskautoarr[_loc_6] == param1)
                    {
                        _loc_5 = true;
                    }
                    _loc_6 = _loc_6 + 1;
                }
                if (!_loc_5)
                {
                    return;
                }
            }
            if (this._autotaskid != -1 && !this.autoflag)
            {
                if (this._autotaskid != param1)
                {
                    return;
                }
            }
            var _loc_4:* = 0;
            while (_loc_4 < this.tasklistarr.length)
            {
                
                if (this.tasklistarr[_loc_4].id == param1)
                {
                    if ((this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1) || this.tasklistarr[_loc_4].haditem2 < int(Config._taskMap[param1].itemNum2)) && int(Config._taskMap[param1].exeType) != 11)
                    {
                        if (int(Config._taskMap[param1].item1) == 60011)
                        {
                            if (this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                            {
                                Hang.hangMonster(10002);
                                return;
                            }
                            if (int(Config._taskMap[param1].item2) == 60013)
                            {
                                Hang.hangGather(5001);
                                return;
                            }
                        }
                        else
                        {
                            if (int(Config._taskMap[param1].item1) == 10009)
                            {
                                Hang.hangGather(1005);
                                return;
                            }
                            if (int(Config._taskMap[param1].item1) == 10048)
                            {
                                _loc_7 = Unit.getTaskUnit(UNIT_TYPE_ENUM.TYPEID_UNIT, 100015);
                                if (_loc_7 == null)
                                {
                                    Hang.hangGather(1021);
                                }
                                Config.stopLoop(this.taskloop);
                                Config.startLoop(this.taskloop);
                                return;
                            }
                            else if (int(Config._taskMap[param1].item1) == 31004 || int(Config._taskMap[param1].item1) == 32004 || int(Config._taskMap[param1].item1) == 33004)
                            {
                                Hang.hangMonster(20048);
                                return;
                            }
                        }
                    }
                    if (this.tasklistarr[_loc_4].hadmon1 < int(Config._taskMap[param1].monNum1))
                    {
                        if (int(Config._taskMap[param1].mon1) == 20005)
                        {
                            Hang.hangMonster(20002);
                            return;
                        }
                    }
                    switch(this.tasklistarr[_loc_4].type)
                    {
                        case 0:
                        {
                            switch(int(Config._taskMap[param1].exeType))
                            {
                                case 0:
                                {
                                    _loc_8 = int(Config._taskMap[param1].eventCdt);
                                    if (_loc_8 == 1)
                                    {
                                        Config.ui._bagUI.open();
                                    }
                                    else if (_loc_8 == 2)
                                    {
                                    }
                                    else if (_loc_8 == 3)
                                    {
                                        Config.ui._skillUI.open();
                                    }
                                    else if (_loc_8 == 4)
                                    {
                                        Config.ui._bagUI.open();
                                    }
                                    else
                                    {
                                        switch(Config.player.job)
                                        {
                                            case 1:
                                            {
                                                break;
                                            }
                                            case 4:
                                            {
                                                break;
                                            }
                                            case 10:
                                            {
                                                break;
                                            }
                                            default:
                                            {
                                                break;
                                            }
                                        }
                                        if (_loc_8 == 10)
                                        {
                                        }
                                        else if (_loc_8 == 16 || _loc_8 == 17 || _loc_8 == 18)
                                        {
                                        }
                                        else if (_loc_8 == 20)
                                        {
                                        }
                                        else if (_loc_8 == 21 || _loc_8 == 22)
                                        {
                                        }
                                        else if (_loc_8 == 23 || _loc_8 == 24)
                                        {
                                        }
                                        else if (_loc_8 == 25)
                                        {
                                        }
                                        else
                                        {
                                        }
                                    }
                                    break;
                                }
                                case 4:
                                case 5:
                                {
                                    if (int(Config._taskMap[param1].mon1) != 0)
                                    {
                                        if (int(Config._taskMap[param1].monNum1) != 0)
                                        {
                                            if (this.tasklistarr[_loc_4].hadmon1 < int(Config._taskMap[param1].monNum1))
                                            {
                                                if (int(Config._taskMap[param1].mon1) == 50009)
                                                {
                                                    Hang.hangMonster(70025);
                                                }
                                                else
                                                {
                                                    _loc_3 = Hang.hangMonster(Config._taskMap[param1].mon1);
                                                    this.findoutopen(param1, _loc_3);
                                                }
                                                if (this._tasksite == 1)
                                                {
                                                    return;
                                                }
                                            }
                                        }
                                        else if (int(Config._taskMap[param1].exeType) == 5)
                                        {
                                            if (this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                            {
                                                if (int(Config._taskMap[param1].mon1) == 50009)
                                                {
                                                    Hang.hangMonster(70025);
                                                }
                                                else
                                                {
                                                    _loc_3 = Hang.hangMonster(Config._taskMap[param1].mon1);
                                                    this.findoutopen(param1, _loc_3);
                                                }
                                                if (this._tasksite == 1)
                                                {
                                                    return;
                                                }
                                            }
                                        }
                                        if (Config._taskMap[param1].mon2 != 0)
                                        {
                                            if (int(Config._taskMap[param1].monNum2) != 0)
                                            {
                                                if (this.tasklistarr[_loc_4].hadmon2 < int(Config._taskMap[param1].monNum2))
                                                {
                                                    _loc_3 = Hang.hangMonster(Config._taskMap[param1].mon2);
                                                    this.findoutopen(param1, _loc_3);
                                                    if (this._tasksite == 2)
                                                    {
                                                        return;
                                                    }
                                                }
                                            }
                                            else if (int(Config._taskMap[param1].exeType) == 5)
                                            {
                                                if (this.tasklistarr[_loc_4].haditem2 < int(Config._taskMap[param1].itemNum2) && int(Config._taskMap[param1].item2) != int(Config._taskMap[param1].item1))
                                                {
                                                    _loc_3 = Hang.hangMonster(Config._taskMap[param1].mon2);
                                                    this.findoutopen(param1, _loc_3);
                                                    if (this._tasksite == 2)
                                                    {
                                                        return;
                                                    }
                                                }
                                            }
                                            if (Config._taskMap[param1].mon3 != 0)
                                            {
                                                if (int(Config._taskMap[param1].monNum3) != 0)
                                                {
                                                    if (this.tasklistarr[_loc_4].hadmon3 < int(Config._taskMap[param1].monNum3))
                                                    {
                                                        _loc_3 = Hang.hangMonster(Config._taskMap[param1].mon3);
                                                        this.findoutopen(param1, _loc_3);
                                                        if (this._tasksite == 3)
                                                        {
                                                            return;
                                                        }
                                                    }
                                                }
                                                else if (int(Config._taskMap[param1].exeType) == 5)
                                                {
                                                    if (this.tasklistarr[_loc_4].haditem3 < int(Config._taskMap[param1].itemNum3) && int(Config._taskMap[param1].item3) != int(Config._taskMap[param1].item2))
                                                    {
                                                        _loc_3 = Hang.hangMonster(Config._taskMap[param1].mon3);
                                                        this.findoutopen(param1, _loc_3);
                                                        if (this._tasksite == 3)
                                                        {
                                                            return;
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    break;
                                }
                                case 1:
                                {
                                    _loc_3 = Hang.hangNpc(Config._taskMap[param1].finishNpc);
                                    this.findoutopen(param1, _loc_3);
                                    break;
                                }
                                case 6:
                                case 8:
                                {
                                    if (int(Config._taskMap[param1].mon1) != 0)
                                    {
                                        if (this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                        {
                                            _loc_3 = Hang.hangGather(Config._taskMap[param1].mon1);
                                            this.findoutopen(param1, _loc_3);
                                            if (this._tasksite == 1)
                                            {
                                                return;
                                            }
                                        }
                                        if (int(Config._taskMap[param1].mon2) != 0)
                                        {
                                            if (this.tasklistarr[_loc_4].haditem2 < int(Config._taskMap[param1].itemNum2))
                                            {
                                                _loc_3 = Hang.hangGather(Config._taskMap[param1].mon2);
                                                this.findoutopen(param1, _loc_3);
                                                if (this._tasksite == 2)
                                                {
                                                    return;
                                                }
                                            }
                                            if (int(Config._taskMap[param1].mon3) != 0)
                                            {
                                                if (this.tasklistarr[_loc_4].haditem3 < int(Config._taskMap[param1].itemNum3))
                                                {
                                                    _loc_3 = Hang.hangGather(Config._taskMap[param1].mon3);
                                                    this.findoutopen(param1, _loc_3);
                                                    if (this._tasksite == 3)
                                                    {
                                                        return;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    this.findoutopen(param1, false);
                                    break;
                                }
                                case 7:
                                {
                                    if (int(Config._taskMap[param1].mon1) != 0)
                                    {
                                        if (int(Config._taskMap[param1].monNum1) != 0)
                                        {
                                            if (this.tasklistarr[_loc_4].hadmon1 < int(Config._taskMap[param1].monNum1))
                                            {
                                                _loc_3 = Hang.hangMonster(Config._taskMap[param1].mon1);
                                                this.findoutopen(param1, _loc_3);
                                                if (this._tasksite == 1)
                                                {
                                                    return;
                                                }
                                            }
                                        }
                                        if (Config._taskMap[param1].mon2 != 0)
                                        {
                                            if (int(Config._taskMap[param1].monNum2) != 0)
                                            {
                                                if (this.tasklistarr[_loc_4].hadmon2 < int(Config._taskMap[param1].monNum2))
                                                {
                                                    Hang.hangMonster(Config._taskMap[param1].mon2);
                                                    _loc_3 = this.findoutopen(param1, _loc_3);
                                                    if (this._tasksite == 2)
                                                    {
                                                        return;
                                                    }
                                                }
                                            }
                                            if (Config._taskMap[param1].mon3 != 0)
                                            {
                                                if (int(Config._taskMap[param1].monNum3) != 0)
                                                {
                                                    if (this.tasklistarr[_loc_4].hadmon3 < int(Config._taskMap[param1].monNum3))
                                                    {
                                                        _loc_3 = Hang.hangMonster(Config._taskMap[param1].mon3);
                                                        this.findoutopen(param1, _loc_3);
                                                        if (this._tasksite == 3)
                                                        {
                                                            return;
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    if (int(Config._taskMap[param1].mon1) != 0)
                                    {
                                        if (this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                        {
                                            _loc_3 = Hang.hangGather(Config._taskMap[param1].mon1);
                                            this.findoutopen(param1, _loc_3);
                                            if (this._tasksite == 1)
                                            {
                                                return;
                                            }
                                        }
                                        if (int(Config._taskMap[param1].mon2) != 0)
                                        {
                                            if (this.tasklistarr[_loc_4].haditem2 < int(Config._taskMap[param1].itemNum2))
                                            {
                                                _loc_3 = Hang.hangGather(Config._taskMap[param1].mon2);
                                                this.findoutopen(param1, _loc_3);
                                                if (this._tasksite == 2)
                                                {
                                                    return;
                                                }
                                            }
                                            if (int(Config._taskMap[param1].mon3) != 0)
                                            {
                                                if (this.tasklistarr[_loc_4].haditem3 < int(Config._taskMap[param1].itemNum3))
                                                {
                                                    _loc_3 = Hang.hangGather(Config._taskMap[param1].mon3);
                                                    this.findoutopen(param1, _loc_3);
                                                    if (this._tasksite == 3)
                                                    {
                                                        return;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    break;
                                }
                                case 3:
                                {
                                    _loc_3 = Hang.hangPosition(param1, Config._taskMap[param1].eventCdt);
                                    this.findoutopen(param1, _loc_3);
                                    return;
                                }
                                case 9:
                                case 10:
                                {
                                    if (int(Config._taskMap[param1].mon1) != 0 && this.tasklistarr[_loc_4].random == 1)
                                    {
                                        if (int(Config._taskMap[param1].monNum1) != 0)
                                        {
                                            if (this.tasklistarr[_loc_4].hadmon1 < int(Config._taskMap[param1].monNum1))
                                            {
                                                if (param1 == 816)
                                                {
                                                    Config.ui._activePanel.open();
                                                    return;
                                                }
                                                _loc_3 = Hang.hangMonster(Config._taskMap[param1].mon1);
                                                this.findoutopen(param1, _loc_3);
                                                if (this._tasksite == 1)
                                                {
                                                    return;
                                                }
                                            }
                                        }
                                        else if (int(Config._taskMap[param1].exeType) == 5)
                                        {
                                            if (this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                            {
                                                _loc_3 = Hang.hangMonster(Config._taskMap[param1].mon1);
                                                this.findoutopen(param1, _loc_3);
                                                if (this._tasksite == 1)
                                                {
                                                    return;
                                                }
                                            }
                                        }
                                    }
                                    if (Config._taskMap[param1].mon2 != 0 && this.tasklistarr[_loc_4].random == 2)
                                    {
                                        if (int(Config._taskMap[param1].monNum2) != 0)
                                        {
                                            if (this.tasklistarr[_loc_4].hadmon2 < int(Config._taskMap[param1].monNum2))
                                            {
                                                _loc_3 = Hang.hangMonster(Config._taskMap[param1].mon2);
                                                this.findoutopen(param1, _loc_3);
                                                if (this._tasksite == 2)
                                                {
                                                    return;
                                                }
                                            }
                                        }
                                        else if (int(Config._taskMap[param1].exeType) == 5)
                                        {
                                            if (this.tasklistarr[_loc_4].haditem2 < int(Config._taskMap[param1].itemNum2) && int(Config._taskMap[param1].item2) != int(Config._taskMap[param1].item1))
                                            {
                                                _loc_3 = Hang.hangMonster(Config._taskMap[param1].mon2);
                                                this.findoutopen(param1, _loc_3);
                                                if (this._tasksite == 2)
                                                {
                                                    return;
                                                }
                                            }
                                        }
                                    }
                                    if (Config._taskMap[param1].mon3 != 0 && this.tasklistarr[_loc_4].random == 3)
                                    {
                                        if (int(Config._taskMap[param1].monNum3) != 0)
                                        {
                                            if (this.tasklistarr[_loc_4].hadmon3 < int(Config._taskMap[param1].monNum3))
                                            {
                                                _loc_3 = Hang.hangMonster(Config._taskMap[param1].mon3);
                                                this.findoutopen(param1, _loc_3);
                                                if (this._tasksite == 3)
                                                {
                                                    return;
                                                }
                                            }
                                        }
                                        else if (int(Config._taskMap[param1].exeType) == 5)
                                        {
                                            if (this.tasklistarr[_loc_4].haditem3 < int(Config._taskMap[param1].itemNum3) && int(Config._taskMap[param1].item3) != int(Config._taskMap[param1].item2))
                                            {
                                                _loc_3 = Hang.hangMonster(Config._taskMap[param1].mon3);
                                                this.findoutopen(param1, _loc_3);
                                                if (this._tasksite == 3)
                                                {
                                                    return;
                                                }
                                            }
                                        }
                                    }
                                    break;
                                }
                                case 11:
                                {
                                    if (int(Config._taskMap[param1].item1) == 29001 && this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                    {
                                        Config.ui._producepanel.showItem(1004);
                                        return;
                                    }
                                    if (int(Config._taskMap[param1].item1) == 26001 && this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                    {
                                        Config.ui._producepanel.showItem(1005);
                                        return;
                                    }
                                    if (int(Config._taskMap[param1].item1) == 25001 && this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                    {
                                        Config.ui._producepanel.showItem(1006);
                                        return;
                                    }
                                    if (int(Config._taskMap[param1].item1) == 27001 && this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                    {
                                        Config.ui._producepanel.showItem(1007);
                                        return;
                                    }
                                    if (int(Config._taskMap[param1].item1) == 23001 && this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                    {
                                        Config.ui._producepanel.showItem(1008);
                                        return;
                                    }
                                    if (int(Config._taskMap[param1].item1) == 24001 && this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                    {
                                        Config.ui._producepanel.showItem(1009);
                                        return;
                                    }
                                    if (int(Config._taskMap[param1].item1) == 22001 && this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                    {
                                        Config.ui._producepanel.showItem(1010);
                                        return;
                                    }
                                    if (int(Config._taskMap[param1].item1) == 28001 && this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                    {
                                        Config.ui._producepanel.showItem(1011);
                                        return;
                                    }
                                    if (int(Config._taskMap[param1].item1) == 63001 && this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                    {
                                        Config.ui._producepanel.showItem(8008);
                                        return;
                                    }
                                    if (int(Config._taskMap[param1].mon1) != 0 && this.tasklistarr[_loc_4].random == 1)
                                    {
                                        if (this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                        {
                                            _loc_3 = Hang.hangGather(Config._taskMap[param1].mon1);
                                            this.findoutopen(param1, _loc_3);
                                            if (this._tasksite == 1)
                                            {
                                                return;
                                            }
                                        }
                                    }
                                    else if (int(Config._taskMap[param1].item1) != 0 && this.tasklistarr[_loc_4].random == 1)
                                    {
                                        if (this.tasklistarr[_loc_4].haditem1 < int(Config._taskMap[param1].itemNum1))
                                        {
                                            this.findoutopen(param1, false);
                                            if (this._tasksite == 1)
                                            {
                                                return;
                                            }
                                        }
                                    }
                                    if (int(Config._taskMap[param1].mon2) != 0 && this.tasklistarr[_loc_4].random == 2)
                                    {
                                        if (this.tasklistarr[_loc_4].haditem2 < int(Config._taskMap[param1].itemNum2))
                                        {
                                            _loc_3 = Hang.hangGather(Config._taskMap[param1].mon2);
                                            this.findoutopen(param1, _loc_3);
                                            if (this._tasksite == 2)
                                            {
                                                return;
                                            }
                                        }
                                    }
                                    else if (int(Config._taskMap[param1].item2) != 0 && this.tasklistarr[_loc_4].random == 2)
                                    {
                                        if (this.tasklistarr[_loc_4].haditem2 < int(Config._taskMap[param1].itemNum2))
                                        {
                                            this.findoutopen(param1, false);
                                            if (this._tasksite == 2)
                                            {
                                                return;
                                            }
                                        }
                                    }
                                    if (int(Config._taskMap[param1].mon3) != 0 && this.tasklistarr[_loc_4].random == 3)
                                    {
                                        if (this.tasklistarr[_loc_4].haditem3 < int(Config._taskMap[param1].itemNum3))
                                        {
                                            _loc_3 = Hang.hangGather(Config._taskMap[param1].mon3);
                                            this.findoutopen(param1, _loc_3);
                                            if (this._tasksite == 3)
                                            {
                                                return;
                                            }
                                        }
                                    }
                                    else if (int(Config._taskMap[param1].item3) != 0 && this.tasklistarr[_loc_4].random == 3)
                                    {
                                        if (this.tasklistarr[_loc_4].haditem3 < int(Config._taskMap[param1].itemNum3))
                                        {
                                            this.findoutopen(param1, false);
                                            if (this._tasksite == 3)
                                            {
                                                return;
                                            }
                                        }
                                    }
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                            break;
                        }
                        case 1:
                        {
                            _loc_3 = Hang.hangNpc(int(Config._taskMap[param1].finishNpc));
                            if (!_loc_3)
                            {
                                this.open();
                                this.opentaskinfor(param1, true);
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        private function findoutopen(param1:int, param2:Boolean = true) : void
        {
            if (!param2)
            {
                switch(int(Config._taskMap[param1]["roadType" + this._tasksite]))
                {
                    case 0:
                    {
                        this.open();
                        this.opentaskinfor(param1, true);
                        return;
                    }
                    case 1:
                    {
                        Hang.hangNpc(Config._taskMap[param1]["road" + this._tasksite]);
                        return;
                    }
                    case 2:
                    {
                        Hang.hangMonster(Config._taskMap[param1]["road" + this._tasksite]);
                        return;
                    }
                    case 3:
                    {
                        Hang.hangGather(Config._taskMap[param1]["road" + this._tasksite]);
                        return;
                    }
                    case 4:
                    {
                        Config.ui._producepanel.showItem(Config._taskMap[param1]["road" + this._tasksite]);
                        return;
                    }
                    case 5:
                    {
                        Hang.hangMap(Config._taskMap[param1]["road" + this._tasksite]);
                        return;
                    }
                    case 6:
                    {
                        Config.ui._blackmarket.openBlackPanel(int(Config._taskMap[param1]["road" + this._tasksite]));
                        return;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function backaddtask(event:SocketEvent) : void
        {
            var _loc_6:* = undefined;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            if (Config.player == null)
            {
                return;
            }
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            if (_loc_3 == 0)
            {
                return;
            }
            var _loc_4:* = true;
            var _loc_5:* = -1;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_3)
            {
                
                _loc_8 = new Object();
                _loc_8.id = _loc_2.readUnsignedInt();
                _loc_8.type = _loc_2.readByte();
                _loc_8.hadmon1 = _loc_2.readUnsignedShort();
                _loc_8.hadmon2 = _loc_2.readUnsignedShort();
                _loc_8.hadmon3 = _loc_2.readUnsignedShort();
                _loc_8.haditem1 = _loc_2.readUnsignedShort();
                _loc_8.haditem2 = _loc_2.readUnsignedShort();
                _loc_8.haditem3 = _loc_2.readUnsignedShort();
                _loc_8.quality = _loc_2.readByte();
                _loc_8.spnum = _loc_2.readByte();
                _loc_8.daynum = _loc_2.readByte();
                _loc_8.random = _loc_2.readByte();
                if (_loc_8.id == 2)
                {
                    GuideUI.testDoId(199, this.taskmate.closebtn);
                }
                else if (_loc_8.id == 3)
                {
                    GuideUI.testDoId(7, Config.ui._systemUI._bagPB, Config.ui._bagUI);
                }
                else if (_loc_8.id == 4)
                {
                    GuideUI.testDoId(165, this.taskmate);
                }
                else if (_loc_8.id == 6)
                {
                    GuideUI.testDoId(85, Config.ui._systemUI._bagPB, Config.ui._bagUI);
                }
                else if (_loc_8.id == 8)
                {
                    GuideUI.testDoId(88, Config.ui._systemUI._bagPB, Config.ui._bagUI);
                }
                else if (_loc_8.id == 9 || _loc_8.id == 10 || _loc_8.id == 11)
                {
                    GuideUI.testDoId(15);
                }
                else if (_loc_8.id == 15)
                {
                    GuideUI.testDoId(19);
                }
                else if (_loc_8.id == 18)
                {
                    GuideUI.testDoId(22, Config.ui._systemUI._producePB, Config.ui._producepanel);
                }
                else if (_loc_8.id == 23)
                {
                    GuideUI.testDoId(28);
                }
                else if (_loc_8.id == 49)
                {
                    GuideUI.testDoId(51, Config.ui._systemUI._bagPB, Config.ui._bagUI);
                }
                else if (_loc_8.id == 48)
                {
                    if (GuideUI.testId(39))
                    {
                        GuideUI.doId(39);
                    }
                    else
                    {
                        GuideUI.testDoId(38, Config.ui._systemUI._skillPB);
                    }
                }
                else if (_loc_8.id == 277 || _loc_8.id == 279)
                {
                    GuideUI.testDoId(38, Config.ui._systemUI._skillPB);
                }
                else if (_loc_8.id == 672)
                {
                    GuideUI.testDoId(102);
                }
                else if (_loc_8.id == 742)
                {
                    GuideUI.testDoId(104, Config.ui._systemUI._guildkPB);
                }
                else if (_loc_8.id == 33)
                {
                    GuideUI.testDoId(124, Config.ui._quickUI._picksoulSlot);
                }
                else if (_loc_8.id == 732)
                {
                    GuideUI.testDoId(128, Config.ui._quickUI._picksoulSlot);
                }
                else if (_loc_8.id == 54)
                {
                    GuideUI.testDoId(137);
                }
                else if (_loc_8.id == 552)
                {
                    GuideUI.testDoId(141, Config.ui._radar._jianBtn, Config.ui._recomPanel);
                }
                else if (_loc_8.id == 22)
                {
                    GuideUI.testDoId(179, Config.ui._chatUI._sayTypePBL.button);
                }
                else if (_loc_8.id == 735)
                {
                    if (GuideUI.testId(187))
                    {
                        GuideUI.testDoId(187, Config.ui._systemUI._bagPB, Config.ui._bagUI);
                    }
                }
                else if (_loc_8.id == 540)
                {
                    GuideUI.testDoId(162, Config.ui._systemUI._taskPB, Config.ui._taskpanel);
                }
                else if (_loc_8.id == 346)
                {
                    GuideUI.testDoId(156, Config.ui._radar._hangPB);
                }
                else if (_loc_8.id == 570)
                {
                    GuideUI.testDoId(203, Config.ui._systemUI._bagPB, Config.ui._bagUI);
                }
                else if (_loc_8.id == 7)
                {
                    GuideUI.testDoId(117, Config.ui._radar._marketBtn, Config.ui._blackmarket);
                }
                else if (_loc_8.id == 802)
                {
                    GuideUI.testDoId(236, Config.ui._radar._fbBtn, Config.ui._fbEntranceUI);
                }
                else if (_loc_8.id == 535 || _loc_8.id == 536 || _loc_8.id == 537 || _loc_8.id == 538 || _loc_8.id == 539)
                {
                    GuideUI.testDoId(97, Config.ui._systemUI._skillPB, Config.ui._skillUI);
                }
                else if (_loc_8.id == 1197)
                {
                    GuideUI.testDoId(67, Config.ui._radar._actBtn);
                }
                else if (_loc_8.id == 1189)
                {
                    GuideUI.testDoId(121, Config.ui._radar._tzBtn);
                }
                else if (_loc_8.id == 1199)
                {
                    GuideUI.testDoId(4, Config.ui._radar._pkBtn);
                }
                if (int(Config._taskMap[_loc_8.id].type) == 0)
                {
                }
                else if (int(Config._taskMap[_loc_8.id].type) == 1)
                {
                    GuideUI.testDoId(27);
                }
                if (int(Config._taskMap[_loc_8.id].type) == 0)
                {
                    _loc_8.tracek = true;
                }
                else
                {
                    _loc_8.tracek = false;
                }
                this.tasklistarr.push(_loc_8);
                if ((int(Config._taskMap[_loc_8.id].type) == 0 && Config._taskMap[_loc_8.id].refreshNum != 1 || int(Config._taskMap[_loc_8.id].type) == 1 || int(Config._taskMap[_loc_8.id].type) == 4) && _loc_4 && !this.autoflag)
                {
                    _loc_5 = _loc_8.id;
                    _loc_4 = false;
                }
                if (Config._taskMap[_loc_8.id].type == 0 && Config._taskMap[_loc_8.id].refreshNum != 1)
                {
                    if (this.taskliparr.length >= this._maxlipnum)
                    {
                        _loc_9 = 0;
                        while (_loc_9 < this.tasklistarr.length)
                        {
                            
                            if (this.tasklistarr[_loc_9].id == this.taskliparr[(this.taskliparr.length - 1)])
                            {
                                this.tasklistarr[_loc_9].tracek = false;
                                break;
                            }
                            _loc_9 = _loc_9 + 1;
                        }
                        this.taskliparr.pop();
                    }
                    this.taskliparr.push(_loc_8.id);
                    this._tasktips.uptask(this.tasklistarr, this.taskliparr);
                }
                else if (int(Config._taskMap[_loc_8.id].type) == 1 || int(Config._taskMap[_loc_8.id].type) == 3 || int(Config._taskMap[_loc_8.id].type) == 4)
                {
                    if (this.taskliparr.length < this._maxlipnum)
                    {
                        _loc_8.tracek = true;
                        this.taskliparr.push(_loc_8.id);
                        this._tasktips.uptask(this.tasklistarr, this.taskliparr);
                    }
                }
                _loc_7 = _loc_7 + 1;
            }
            if (this.menubar.selectpage == 0)
            {
                this.removeallchild(this.mainpanel);
                this.betasklist(0);
            }
            else if (this.menubar.selectpage == 1)
            {
                this.removeallchild(this.mainpanel);
                this.everydaytask();
            }
            this.sendtaskchange();
            if (_loc_5 != -1)
            {
                if (this.parent != null)
                {
                    if (this.menubar.selectpage != 3)
                    {
                        this.opentaskinfor(_loc_5, true);
                    }
                }
                else
                {
                    this.opentaskinfor2(_loc_5);
                }
            }
            return;
        }// end function

        public function autolingshang(param1:int, param2:int) : void
        {
            if (this.autoflag)
            {
                this.lingshang(param2, 1, param1);
            }
            return;
        }// end function

        private function backuptask(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            this.errtip(_loc_3);
            return;
        }// end function

        public function lingshang(param1:int, param2:int = 0, param3:int = 0, param4:int = 1, param5:int = 0) : void
        {
            if (Config._taskMap[param1].awardItemA != 0)
            {
                if (param2 == -1)
                {
                    Config.message(Config.language("TaskPanel", 51));
                    return;
                }
                param2 = param2 + 1;
            }
            else
            {
                param2 = 0;
            }
            if (Config.ui._playerHead.fcmstatus > 0)
            {
                Config.message(Config.language("TaskPanel", 52));
                return;
            }
            if (param1 == 1644)
            {
                this.opengivegg(param1, param2, param3, param4, param5);
                Config.ui._dialogue.close();
                return;
            }
            var _loc_6:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_QUEST_REWARD);
            _loc_6.add32(param1);
            _loc_6.add32(Npc._idIndexMap[param3]);
            _loc_6.add8(param2);
            _loc_6.add8(param4);
            _loc_6.add8(param5);
            ClientSocket.send(_loc_6);
            Config.ui._dialogue.close();
            if (this.newtasktips != null)
            {
                if (this.newtasktips.parent != null)
                {
                    this.container.removeChild(this.newtasktips);
                }
            }
            if (param4 == 2)
            {
                GuideUI.testDoId(161, Config.ui._radar._mallBtn);
            }
            return;
        }// end function

        public function backlingshang(param1:int) : void
        {
            this.errtip(param1);
            this._sflag = -1;
            return;
        }// end function

        private function subGuide92()
        {
            var _loc_3:* = undefined;
            var _loc_1:* = Config.ui._charUI.getOneItem(61011);
            var _loc_2:* = Config.ui._charUI.getOneItem(62011);
            if (_loc_1 != null && _loc_2 != null)
            {
                _loc_3 = Config.ui._quickUI.findBlankSlot(2, 1);
                _loc_3[1].content = _loc_1;
                _loc_3[0].content = _loc_2;
                GuideUI.testDoId(92, _loc_3[1]);
                _loc_3[1].sendAdd();
                _loc_3[0].sendAdd();
            }
            return;
        }// end function

        private function backfash(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 0)
            {
                this._daytaskflag = 1;
            }
            else
            {
                this.errtip(_loc_3);
            }
            return;
        }// end function

        private function backdeltask(event:SocketEvent) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2.readUnsignedInt();
                _loc_6 = 0;
                while (_loc_6 < this.tasklistarr.length)
                {
                    
                    if (_loc_5 == this.tasklistarr[_loc_6].id)
                    {
                        this.delfirsttask(_loc_5);
                        this.tasklistarr.splice(_loc_6, 1);
                        if (this.menubar.selectpage == 0)
                        {
                            this.removeallchild(this.mainpanel);
                            this.betasklist(0);
                        }
                        else if (this.menubar.selectpage == 1)
                        {
                            this.removeallchild(this.mainpanel);
                            this.everydaytask();
                        }
                        break;
                    }
                    _loc_6 = _loc_6 + 1;
                }
                if (this.taskmate != null)
                {
                    if (this.taskmate.parent != null)
                    {
                        if (this.taskmate.taskid == _loc_5)
                        {
                            this.taskmate.close();
                        }
                    }
                }
                if (this.tkinforsp != null)
                {
                    if (this.tkinforsp.parent != null)
                    {
                        if (this.tkinforsp.taskid == _loc_5)
                        {
                            this.tkinforsp.parent.removeChild(this.tkinforsp);
                        }
                    }
                }
                _loc_4 = _loc_4 + 1;
            }
            this._tasktips.uptask(this.tasklistarr, this.taskliparr);
            this.sendtaskchange();
            return;
        }// end function

        private function nextautotask(param1:int = 0) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = true;
            var _loc_3:* = 0;
            while (_loc_3 < this.taskautoarr.length)
            {
                
                _loc_4 = 0;
                while (_loc_4 < this.tasklistarr.length)
                {
                    
                    if (int(Config._taskMap[this.tasklistarr[_loc_4].id].type) >= 2 && this.tasklistarr[_loc_4].id == this.taskautoarr[_loc_3] && this.tasklistarr[_loc_4].type < 1 && this.autoflag && (int(Config._taskMap[this.tasklistarr[_loc_4].id].auto) == 0 || int(Config._taskMap[this.tasklistarr[_loc_4].id].auto) == 1 && this.tasklistarr[_loc_4].type < 1))
                    {
                        _loc_2 = false;
                        break;
                    }
                    else if (this.tasklistarr[_loc_4].id == this.taskautoarr[_loc_3] && this.autoflag && int(Config._taskMap[this.tasklistarr[_loc_4].id].auto) == 1 && this.tasklistarr[_loc_4].type == 0)
                    {
                        Config.message(Config.language("TaskPanel", 53));
                    }
                    _loc_4 = _loc_4 + 1;
                }
                if (!_loc_2)
                {
                    if (Config.ui._dialogue.parent != null)
                    {
                        this.timeid = this.taskautoarr[_loc_3];
                        this.tasktimer.start();
                    }
                    else
                    {
                        this.autodotask(this.taskautoarr[_loc_3]);
                    }
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            if (_loc_2)
            {
                Config.message(Config.language("TaskPanel", 54));
                this.autolabel(Config.language("TaskPanel", 55));
                this.autoflag = false;
            }
            return;
        }// end function

        private function checktime(event:TimerEvent) : void
        {
            this.tasktimer.stop();
            this.autodotask(this.timeid, this.autoflag);
            return;
        }// end function

        private function delfirsttask(param1:int) : void
        {
            if (this.tasklipflag == param1)
            {
                this.tasklipflag = -1;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this.taskliparr.length)
            {
                
                if (param1 == this.taskliparr[_loc_2])
                {
                    this.taskliparr.splice(_loc_2, 1);
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.taskautoarr.length)
            {
                
                if (param1 == this.taskautoarr[_loc_3])
                {
                    this.taskautoarr.splice(_loc_3, 1);
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        private function backhidetask(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readByte();
            delete this.taskdownlist[_loc_4];
            var _loc_6:* = 0;
            while (_loc_6 < this.tasklistarr.length)
            {
                
                if (_loc_4 == this.tasklistarr[_loc_6].id)
                {
                    this.delfirsttask(_loc_4);
                    this.tasklistarr.splice(_loc_6, 1);
                    if (this.menubar.selectpage == 0)
                    {
                        this.removeallchild(this.mainpanel);
                        this.betasklist(0);
                    }
                    else if (this.menubar.selectpage == 1)
                    {
                        this.removeallchild(this.mainpanel);
                        this.everydaytask();
                    }
                    break;
                }
                _loc_6 = _loc_6 + 1;
            }
            if (this.taskmate != null)
            {
                if (this.taskmate.parent != null)
                {
                    if (this.taskmate.taskid == _loc_4)
                    {
                        this.taskmate.close();
                    }
                }
            }
            if (this.tkinforsp != null)
            {
                if (this.tkinforsp.parent != null)
                {
                    if (this.tkinforsp.taskid == _loc_4)
                    {
                        this.tkinforsp.parent.removeChild(this.tkinforsp);
                    }
                }
            }
            this._tasktips.uptask(this.tasklistarr, this.taskliparr);
            this.sendtaskchange();
            return;
        }// end function

        public function autoadd(event:MouseEvent = null) : void
        {
            var _loc_4:* = false;
            var _loc_5:* = 0;
            var _loc_2:* = this.taskliparr.length;
            var _loc_3:* = 0;
            while (_loc_3 < this.tasklistarr.length)
            {
                
                _loc_4 = true;
                _loc_5 = 0;
                while (_loc_5 < this.taskliparr.length)
                {
                    
                    if (this.taskliparr[_loc_5] == this.tasklistarr[_loc_3].id)
                    {
                        _loc_4 = false;
                        break;
                    }
                    _loc_5 = _loc_5 + 1;
                }
                if (this.tasklistarr[_loc_3].type < 2 && this.tasklistarr[_loc_3].trash == 0 && _loc_4 && this.taskliparr.length < this._maxlipnum)
                {
                    this.taskliparr.push(this.tasklistarr[_loc_3].id);
                    _loc_2++;
                    if (_loc_2 == this._maxlipnum)
                    {
                        break;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            this._tasktips.uptask(this.tasklistarr, this.taskliparr);
            if (this.menubar.selectpage == 1)
            {
                this.listcanvas.checkrefresh(this.taskliparr);
            }
            return;
        }// end function

        public function delfromlip(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this.tasklistarr.length)
            {
                
                if (this.tasklistarr[_loc_2].id == param1)
                {
                    this.tasklistarr[_loc_2].tracek = false;
                    _loc_3 = 0;
                    while (_loc_3 < this.taskliparr.length)
                    {
                        
                        if (this.taskliparr[_loc_3] == param1)
                        {
                            this.taskliparr.splice(_loc_3, 1);
                            this.trackbtn.label = Config.language("TaskPanel", 24);
                            this.listcanvas.selectid = param1;
                            break;
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            this._tasktips.uptask(this.tasklistarr, this.taskliparr);
            if (this.menubar.selectpage == 0 || this.menubar.selectpage == 1)
            {
                this.listcanvas.checkrefresh(this.taskliparr);
            }
            return;
        }// end function

        private function gettreeevent(event:SimpleTreeEvent) : void
        {
            this.opentaskinfor(event.id);
            var _loc_2:* = 0;
            while (_loc_2 < this.tasklistarr.length)
            {
                
                if (this.tasklistarr[_loc_2].id == event.id)
                {
                    if (this.tasklistarr[_loc_2].tracek)
                    {
                        this.trackbtn.label = Config.language("TaskPanel", 31);
                    }
                    else
                    {
                        this.trackbtn.label = Config.language("TaskPanel", 24);
                    }
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function awadclick(event:MouseEvent, param2:int) : void
        {
            var _loc_3:* = 0;
            while (_loc_3 < this.taskawadmcarr.length)
            {
                
                if (this.taskawadmcarr[_loc_3].id == param2)
                {
                    this.taskawadmcarr[_loc_3].select = true;
                    this.tasklipflag = _loc_3;
                }
                else
                {
                    this.taskawadmcarr[_loc_3].select = false;
                }
                _loc_3 = _loc_3 + 1;
            }
            this.opentaskinfor(param2);
            return;
        }// end function

        private function childmove(event:Event) : void
        {
            if (this.taskmate != null)
            {
                if (this.taskmate.parent != null)
                {
                    this.taskmate.x = this.x + 320;
                    this.taskmate.y = this.y;
                }
            }
            return;
        }// end function

        private function openretask(event:SimpleTreeEvent = null) : void
        {
            if (this.tkinforsp != null)
            {
                if (this.tkinforsp.parent != null)
                {
                    this.tkinforsp.parent.removeChild(this.tkinforsp);
                    this.tkinforsp = null;
                }
            }
            var _loc_2:* = new Object();
            _loc_2.id = this.listcanvas.selectid;
            _loc_2.type = 6;
            _loc_2.hadmon1 = 0;
            _loc_2.hadmon2 = 0;
            _loc_2.hadmon3 = 0;
            _loc_2.haditem1 = 0;
            _loc_2.haditem2 = 0;
            _loc_2.haditem3 = 0;
            _loc_2.trash = 0;
            _loc_2.quality = 0;
            _loc_2.spnum = 0;
            _loc_2.daynum = 0;
            _loc_2.relevel = Config._taskMap[_loc_2.id].levelReq;
            this.tkinforsp = new TaskInforSp(_loc_2, this);
            this.tkinforsp.x = 280 + 120;
            this.tkinforsp.y = 0;
            if (Config._taskMap[_loc_2.id].type > 0)
            {
                this.toolBtn2.visible = true;
                this.toolBtn2.label = Config.language("TaskPanel", 101);
            }
            return;
        }// end function

        public function opentaskinfor(param1:int, param2:Boolean = false) : void
        {
            var _loc_4:* = 0;
            this.toolBtn1.visible = false;
            this.toolBtn2.visible = false;
            this.questTimeBar.visible = false;
            this.questTimeLabel.visible = false;
            this.questRun();
            if (this.tkinforsp != null)
            {
                if (this.tkinforsp.parent != null)
                {
                    this.tkinforsp.parent.removeChild(this.tkinforsp);
                    this.tkinforsp = null;
                }
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.tasklistarr.length)
            {
                
                if (this.tasklistarr[_loc_3].id == param1)
                {
                    this.tkinforsp = new TaskInforSp(this.tasklistarr[_loc_3], this);
                    this.tkinforsp.x = 280 + 120;
                    this.tkinforsp.y = 0;
                    if (this.tasklistarr[_loc_3].type == 0)
                    {
                        if (Config._taskMap[param1].week == 1 && Config._taskMap[param1].type > 1)
                        {
                            if (this.questAutoList[param1] != null)
                            {
                                this.questTimeBar.visible = true;
                                this.questTimeLabel.visible = true;
                            }
                            this.toolBtn2.visible = true;
                            this.toolBtn2.label = Config.language("TaskPanel", 99);
                        }
                    }
                    else if (this.tasklistarr[_loc_3].type == 1)
                    {
                        if (Config._taskMap[param1].type > 0)
                        {
                            this.toolBtn2.label = Config.language("TaskPanel", 100);
                            this.toolBtn2.visible = true;
                        }
                    }
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            if (param2)
            {
                if (this.tasklistarr[_loc_3].type == 2)
                {
                }
                else
                {
                    _loc_4 = 0;
                    switch(int(Config._taskMap[this.tasklistarr[_loc_3].id].type))
                    {
                        case 0:
                        case 1:
                        {
                            _loc_4 = 0;
                            break;
                        }
                        case 2:
                        case 3:
                        case 4:
                        {
                            _loc_4 = 0;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    this.initsecpage(null, _loc_4, false);
                    this.listcanvas.selectid = param1;
                }
            }
            return;
        }// end function

        public function opentaskinfor2(param1:int) : void
        {
            if (this.parent != null)
            {
                this.opentaskinfor(param1, true);
                return;
            }
            if (this.taskmate != null)
            {
                if (this.taskmate.parent != null)
                {
                    this.taskmate.close();
                }
            }
            var _loc_2:* = 0;
            while (_loc_2 < this.tasklistarr.length)
            {
                
                if (this.tasklistarr[_loc_2].id == param1)
                {
                    this.taskmate.mademate(this.tasklistarr[_loc_2]);
                    if (this.taskmate.x == 0)
                    {
                        this.taskmate.x = Config.ui._width - 500;
                        this.taskmate.y = 100;
                    }
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function opentaskinfor3(param1:Object) : void
        {
            if (this.taskmate != null)
            {
                if (this.taskmate.parent != null)
                {
                    this.taskmate.close();
                }
            }
            param1.type = 6;
            param1.hadmon1 = 0;
            param1.hadmon2 = 0;
            param1.hadmon3 = 0;
            param1.haditem1 = 0;
            param1.haditem2 = 0;
            param1.haditem3 = 0;
            param1.spnum = 0;
            param1.daynum = 0;
            this.taskmate.mademate(param1);
            if (this.dayListPanel.x + this.dayListPanel.width + this.taskmate.width < Config.stage.stageWidth)
            {
                this.taskmate.x = this.dayListPanel.x + this.dayListPanel.width;
            }
            else
            {
                this.taskmate.x = this.dayListPanel.x - this.taskmate.width;
            }
            this.taskmate.y = this.dayListPanel.y;
            return;
        }// end function

        public function opentaskinfor4(param1:Object) : void
        {
            if (this.taskmate != null)
            {
                if (this.taskmate.parent != null)
                {
                    this.taskmate.close();
                }
            }
            param1.type = 4;
            param1.hadmon1 = 0;
            param1.hadmon2 = 0;
            param1.hadmon3 = 0;
            param1.haditem1 = 0;
            param1.haditem2 = 0;
            param1.haditem3 = 0;
            param1.spnum = 0;
            param1.daynum = 0;
            this.taskmate.mademate(param1);
            if (Config.ui._dayGiftPanel.x + Config.ui._dayGiftPanel.width + this.taskmate.width < Config.stage.stageWidth)
            {
                this.taskmate.x = Config.ui._dayGiftPanel.x + Config.ui._dayGiftPanel.width;
            }
            else
            {
                this.taskmate.x = Config.ui._dayGiftPanel.x - this.taskmate.width;
            }
            this.taskmate.y = Config.ui._dayGiftPanel.y;
            return;
        }// end function

        public function opennewtip(param1:int, param2:uint) : void
        {
            if (param2 != 0)
            {
                return;
            }
            if (this.newtasktips != null)
            {
                if (this.newtasktips.parent != null)
                {
                    this.container.removeChild(this.newtasktips);
                }
            }
            this.newtasktips = new TaskNewTips(param1, param2, this.container, 100, 300);
            return;
        }// end function

        public function gatherfind(param1:int) : Boolean
        {
            var _loc_2:* = false;
            var _loc_3:* = 0;
            while (_loc_3 < this.tasklistarr.length)
            {
                
                if (param1 == this.tasklistarr[_loc_3].id && this.tasklistarr[_loc_3].type == 0)
                {
                    _loc_2 = true;
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function buildTaskList() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = undefined;
            var _loc_6:* = false;
            var _loc_7:* = false;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_1:* = new Date();
            if (Config.player == null)
            {
                return;
            }
            var _loc_2:* = new Array();
            _loc_3 = 0;
            while (_loc_3 < this.tasklistarr.length)
            {
                
                _loc_2.push(this.tasklistarr[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            for (_loc_4 in Config._taskMap)
            {
                
                _loc_6 = false;
                if (int(Config._taskMap[_loc_4].acceptType) == 1 && int(Config._taskMap[_loc_4].type) != 4 && Config.player.level >= Config._taskMap[_loc_4].levelReq && (Config.player.level < Config._taskMap[_loc_4].levelTop || int(Config._taskMap[_loc_4].levelTop) == 0) && (Config.player.job == int(Config._taskMap[_loc_4].jobReq) || int(Config._taskMap[_loc_4].jobReq) == 0))
                {
                    _loc_6 = true;
                    if (this.taskdownlist[int(Config._taskMap[_loc_4].id)] != null)
                    {
                        if (Config._taskMap[Config._taskMap[_loc_4].id].week > 0 && Config._taskMap[Config._taskMap[_loc_4].id].refreshNum > 0 && Config._taskMap[Config._taskMap[_loc_4].id].type != 5 || Config._taskMap[Config._taskMap[_loc_4].id].type == 4)
                        {
                            _loc_6 = true;
                        }
                        else
                        {
                            _loc_6 = false;
                        }
                    }
                    if (Config._taskMap[_loc_4].preTaskId != 0)
                    {
                        _loc_7 = false;
                        if (this.taskdownlist[int(Config._taskMap[_loc_4].preTaskId)] != null || Config._taskMap[_loc_4].preTaskId == Config._taskMap[_loc_4].id)
                        {
                            _loc_7 = true;
                        }
                        if (!_loc_7)
                        {
                            _loc_6 = false;
                        }
                    }
                    if (Config._taskMap[Config._taskMap[_loc_4].id].type == 5)
                    {
                        _loc_6 = false;
                        _loc_8 = 0;
                        while (_loc_8 < this.taskWeekList.length)
                        {
                            
                            if (Config._taskMap[_loc_4].id == this.taskWeekList[_loc_8].id)
                            {
                                _loc_6 = true;
                                break;
                            }
                            _loc_8 = _loc_8 + 1;
                        }
                    }
                    if (_loc_6)
                    {
                        _loc_9 = 0;
                        while (_loc_9 < this.taskdayarr.length)
                        {
                            
                            if (this.taskdayarr[_loc_9].id == Config._taskMap[_loc_4].id && this.taskdayarr[_loc_9].daynum >= Config._taskMap[_loc_4].refreshNum && Config._taskMap[_loc_4].refreshNum != 0)
                            {
                                _loc_6 = false;
                                break;
                            }
                            _loc_9 = _loc_9 + 1;
                        }
                    }
                    if (_loc_6)
                    {
                        _loc_10 = 0;
                        while (_loc_10 < this.tasklistarr.length)
                        {
                            
                            if (this.tasklistarr[_loc_10].id == Config._taskMap[_loc_4].id)
                            {
                                _loc_6 = false;
                                break;
                            }
                            else if (int(Config._taskMap[_loc_4].type) == 4 && int(Config._taskMap[_loc_4].acceptType) == 1)
                            {
                                if (int(Config._taskMap[int(this.tasklistarr[_loc_10].id)].headTask) == int(Config._taskMap[int(Config._taskMap[_loc_4].id)].headTask))
                                {
                                    _loc_6 = false;
                                    break;
                                }
                            }
                            _loc_10 = _loc_10 + 1;
                        }
                    }
                }
                if (Config.player.gildid == 0 && int(Config._taskMap[_loc_4].type) == 3)
                {
                    _loc_6 = false;
                }
                if (_loc_6)
                {
                    _loc_11 = new Object();
                    _loc_11.id = Config._taskMap[_loc_4].id;
                    _loc_11.type = 4;
                    _loc_2.push(_loc_11);
                }
            }
            this._canList = new Array();
            _loc_3 = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_12 = new Object();
                if (_loc_2[_loc_3].type == 4)
                {
                    _loc_12.startnpc = Config._taskMap[_loc_2[_loc_3].id].startNPC;
                    _loc_12.state = 4;
                }
                else
                {
                    _loc_12.endnpc = Config._taskMap[_loc_2[_loc_3].id].finishNpc;
                    _loc_12.state = int(_loc_2[_loc_3].type);
                }
                this._canList.push(_loc_12);
                _loc_3 = _loc_3 + 1;
            }
            this._canList.sortOn("state", Array.NUMERIC);
            var _loc_5:* = new Date();
            return;
        }// end function

        public function tasklist() : Array
        {
            return this._canList;
        }// end function

        public function getTaskState(param1:int) : int
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = 4;
            var _loc_3:* = true;
            if (this.taskdownlist[param1] != null)
            {
                _loc_2 = 3;
                _loc_3 = false;
            }
            if (_loc_3)
            {
                _loc_4 = 0;
                while (_loc_4 < this.taskdayarr.length)
                {
                    
                    if (param1 == this.taskdayarr[_loc_4].id && this.taskdayarr[_loc_4].daynum >= Config._taskMap[param1].refreshNum)
                    {
                        _loc_2 = 3;
                        break;
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            if (_loc_3)
            {
                _loc_5 = 0;
                while (_loc_5 < this.tasklistarr.length)
                {
                    
                    if (param1 == this.tasklistarr[_loc_5].id)
                    {
                        _loc_2 = this.tasklistarr[_loc_5].type;
                        break;
                    }
                    _loc_5 = _loc_5 + 1;
                }
            }
            return _loc_2;
        }// end function

        public function tasklip() : Array
        {
            return this.taskliparr;
        }// end function

        public function tasktotal(param1:int, param2:int, param3:int, param4:int) : void
        {
            return;
        }// end function

        private function removeallchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        public function sendendtask(param1:Object) : void
        {
            return;
        }// end function

        public function npctalkarr(param1:int) : Array
        {
            var _loc_4:* = undefined;
            var _loc_5:* = false;
            var _loc_6:* = false;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_2:* = new Array();
            var _loc_3:* = 0;
            while (_loc_3 < this.tasklistarr.length)
            {
                
                if (int(Config._taskMap[this.tasklistarr[_loc_3].id].finishNpc) == param1)
                {
                    _loc_2.push(this.tasklistarr[_loc_3]);
                }
                _loc_3 = _loc_3 + 1;
            }
            for (_loc_4 in Config._taskMap)
            {
                
                _loc_5 = false;
                if (int(Config._taskMap[_loc_4].startNPC) == param1 && int(Config._taskMap[_loc_4].type) != 4 && int(Config._taskMap[_loc_4].acceptType) == 1 && Config.player.level >= Config._taskMap[_loc_4].levelReq && (Config.player.job == int(Config._taskMap[_loc_4].jobReq) || int(Config._taskMap[_loc_4].jobReq) == 0))
                {
                    if (Config._taskMap[_loc_4].levelTop != 0 && Config.player.level < Config._taskMap[_loc_4].levelTop || int(Config._taskMap[_loc_4].levelTop) == 0)
                    {
                        _loc_5 = true;
                        if (this.taskdownlist[int(Config._taskMap[_loc_4].id)] != null)
                        {
                            if (Config._taskMap[Config._taskMap[_loc_4].id].week > 0 && Config._taskMap[Config._taskMap[_loc_4].id].refreshNum > 0 && Config._taskMap[Config._taskMap[_loc_4].id].type != 5 || Config._taskMap[Config._taskMap[_loc_4].id].type == 4)
                            {
                                _loc_5 = true;
                            }
                            else
                            {
                                _loc_5 = false;
                            }
                        }
                        if (Config._taskMap[_loc_4].preTaskId != 0)
                        {
                            _loc_6 = false;
                            if (this.taskdownlist[int(Config._taskMap[_loc_4].preTaskId)] != null)
                            {
                                _loc_6 = true;
                            }
                            if (!_loc_6)
                            {
                                _loc_5 = false;
                            }
                        }
                        if (Config._taskMap[Config._taskMap[_loc_4].id].type == 5)
                        {
                            _loc_5 = false;
                            _loc_7 = 0;
                            while (_loc_7 < this.taskWeekList.length)
                            {
                                
                                if (Config._taskMap[_loc_4].id == this.taskWeekList[_loc_7].id)
                                {
                                    _loc_5 = true;
                                    break;
                                }
                                _loc_7 = _loc_7 + 1;
                            }
                        }
                        if (_loc_5)
                        {
                            _loc_8 = 0;
                            while (_loc_8 < this.taskdayarr.length)
                            {
                                
                                if (this.taskdayarr[_loc_8].id == Config._taskMap[_loc_4].id && this.taskdayarr[_loc_8].daynum >= Config._taskMap[_loc_4].refreshNum && Config._taskMap[_loc_4].refreshNum != 0)
                                {
                                    _loc_5 = false;
                                    break;
                                }
                                _loc_8 = _loc_8 + 1;
                            }
                        }
                        if (_loc_5)
                        {
                            _loc_9 = 0;
                            while (_loc_9 < this.tasklistarr.length)
                            {
                                
                                if (this.tasklistarr[_loc_9].id == Config._taskMap[_loc_4].id)
                                {
                                    _loc_5 = false;
                                    break;
                                }
                                else if (int(Config._taskMap[_loc_4].type) == 4 && int(Config._taskMap[_loc_4].acceptType) == 1)
                                {
                                    if (int(Config._taskMap[int(this.tasklistarr[_loc_9].id)].headTask) == int(Config._taskMap[int(Config._taskMap[_loc_4].id)].headTask))
                                    {
                                        _loc_5 = false;
                                        break;
                                    }
                                }
                                _loc_9 = _loc_9 + 1;
                            }
                        }
                    }
                }
                if (Config.player.gildid == 0 && int(Config._taskMap[_loc_4].type) == 3)
                {
                    _loc_5 = false;
                }
                if (_loc_5)
                {
                    _loc_10 = new Object();
                    _loc_10.id = Config._taskMap[_loc_4].id;
                    _loc_10.type = 4;
                    _loc_2.push(_loc_10);
                }
            }
            _loc_2.sortOn("type", Array.DESCENDING | Array.NUMERIC);
            return _loc_2;
        }// end function

        private function taskfinish(event:SocketEvent) : void
        {
            var _loc_5:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.taskdownlist = {};
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2.readUnsignedInt();
                this.taskdownlist[_loc_5] = {id:_loc_5};
                this.taskRecomList[_loc_5] = {id:_loc_5};
                if (_loc_5 == 68)
                {
                    Config.ui._skillUI.addGiftShow();
                }
                _loc_4 = _loc_4 + 1;
            }
            this._taskFinishListInit = true;
            return;
        }// end function

        public function autobtnfuc(event:MouseEvent = null) : void
        {
            if (this.taskautoarr.length > 0)
            {
                if (this.autoflag)
                {
                    this.autoflag = false;
                    Config.stopAuto();
                    Config.player.stop();
                    this.autolabel(Config.language("TaskPanel", 17));
                    this._tasktips.stopautoicon();
                }
                else
                {
                    this.autoflag = true;
                    this.autolabel(Config.language("TaskPanel", 16));
                    this.nextautotask();
                }
                this.autotaskid = -1;
            }
            return;
        }// end function

        public function stopAuto() : void
        {
            this._tasktips.stopautoicon();
            this.autolabel(Config.language("TaskPanel", 17));
            this.autoflag = false;
            this.autotaskid = -1;
            return;
        }// end function

        private function autolabel(param1:String) : void
        {
            if (this._tasktips != null)
            {
                this._tasktips.autobtnlabel = param1;
            }
            return;
        }// end function

        public function sendtasklist(param1:int = 0, param2:int = 10001) : void
        {
            return;
        }// end function

        public function get autoTask() : Array
        {
            return this.taskautoarr;
        }// end function

        public function get daytaskflag() : int
        {
            return this._daytaskflag;
        }// end function

        public function set daytaskflag(param1:int) : void
        {
            this._daytaskflag = param1;
            this.dayrefash.text = String(param1);
            if (param1 != 0)
            {
                if (this.parent == null && this.newtasktips == null)
                {
                    this.opennewtip(2, 3);
                }
            }
            return;
        }// end function

        public function npctalk(param1:int, param2:int, param3:Function = null, param4:int = 0) : void
        {
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = undefined;
            var _loc_19:* = null;
            var _loc_5:* = true;
            var _loc_6:* = new Sprite();
            var _loc_7:* = new Label(_loc_6, 10, 0, Config._taskMap[param2].title);
            new Label(_loc_6, 10, 0, Config._taskMap[param2].title).textColor = 16776960;
            var _loc_8:* = false;
            var _loc_9:* = 0;
            while (_loc_9 < this.tasklistarr.length)
            {
                
                if (this.tasklistarr[_loc_9].id == param2)
                {
                    if (this.tasklistarr[_loc_9].type == 0)
                    {
                        _loc_10 = [];
                        _loc_11 = this.goalsprite(param2);
                        _loc_6.addChild(_loc_11);
                        _loc_11.y = 20;
                        _loc_12 = this.awardsprite(param2, param3);
                        _loc_12.y = _loc_6.height + 20;
                        _loc_6.addChild(_loc_12);
                        _loc_13 = new PushButton(_loc_12, 220, _loc_12.height, Config.language("TaskPanel", 56), Config.create(this.acceptfuc, 2, param2, param1));
                        _loc_13.width = 60;
                        _loc_14 = new PushButton(_loc_12, 150, _loc_13.y, Config.language("TaskPanel", 117), Config.create(this.acceptfuc, 3, param2, param1));
                        _loc_14.width = 60;
                        Config.ui._dialogue.showdialog(param1, DescriptionTranslate.translate(Config._taskMap[param2].description, null), _loc_10, _loc_6);
                        return;
                    }
                    _loc_10 = [];
                    _loc_12 = this.awardsprite(param2, param3);
                    _loc_12.y = 20;
                    _loc_6.addChild(_loc_12);
                    _loc_15 = _loc_12.height;
                    if (Config._taskMap[param2].doubleItemNUM > 0)
                    {
                        _loc_17 = new PushButton(_loc_12, 180, _loc_15 + 10, Config.language("TaskPanel", 57), Config.create(this.dnpcling, param2, param1, param4));
                        _loc_17.width = 130;
                        if (GuideUI.testId(160))
                        {
                            _loc_8 = true;
                        }
                    }
                    _loc_16 = new PushButton(_loc_12, 100, _loc_15 + 10, Config.language("TaskPanel", 58), Config.create(this.npcling, param2, param1, param4));
                    _loc_16.width = 73;
                    Config.ui._dialogue.showdialog(param1, DescriptionTranslate.translate(Config._taskMap[param2].finishDialog, null), _loc_10, _loc_6);
                    if (_loc_8)
                    {
                        _loc_18 = Config.ui._taskpanel.getTaskState(535);
                        if (_loc_18 == 0 || _loc_18 == 1)
                        {
                            GuideUI.doId(160, _loc_17);
                        }
                    }
                    _loc_5 = false;
                    break;
                }
                _loc_9 = _loc_9 + 1;
            }
            if (_loc_5)
            {
                if (Config._taskMap[param2].type == 2)
                {
                    Config.message(Config.language("TaskPanel", 59));
                    return;
                }
                _loc_10 = [];
                _loc_11 = this.goalsprite(param2);
                _loc_6.addChild(_loc_11);
                _loc_11.y = 20;
                _loc_12 = this.awardsprite(param2, param3);
                _loc_12.y = _loc_6.height + 20;
                _loc_6.addChild(_loc_12);
                _loc_19 = new PushButton(_loc_12, 150, _loc_12.height, Config.language("TaskPanel", 60), Config.create(this.acceptfuc, 1, param2, param1, param4));
                _loc_19.width = 60;
                _loc_13 = new PushButton(_loc_12, 220, _loc_19.y, Config.language("TaskPanel", 61), Config.create(this.acceptfuc, 2, param2, param1, param4));
                _loc_13.width = 60;
                Config.ui._dialogue.showdialog(param1, DescriptionTranslate.translate(Config._taskMap[param2].description, null), _loc_10, _loc_6);
                return;
            }
            return;
        }// end function

        private function acceptfuc(event:MouseEvent, param2:int, param3:int, param4:int, param5:int) : void
        {
            var _loc_6:* = false;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            if (param2 == 1)
            {
                this.sendaccepttask(param3, param4, param5);
                _loc_6 = false;
                _loc_7 = this.npctalkarr(param4);
                _loc_8 = 0;
                while (_loc_8 < _loc_7.length)
                {
                    
                    if (_loc_7[_loc_8].id != param3)
                    {
                        if (_loc_7[_loc_8].type == 1 || _loc_7[_loc_8].type == 2 || _loc_7[_loc_8].type == 4)
                        {
                            this.npctalk(param4, _loc_7[_loc_8].id);
                            _loc_6 = true;
                            break;
                        }
                    }
                    _loc_8++;
                }
                if (!_loc_6)
                {
                    Config.ui._dialogue.close();
                }
            }
            else if (param2 == 2)
            {
                Config.ui._dialogue.close();
            }
            else
            {
                this.opentaskinfor2(param3);
            }
            return;
        }// end function

        private function sendaccepttask(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_QUEST_ACCEPT);
            _loc_4.add32(param1);
            _loc_4.add32(Npc._idIndexMap[param2]);
            _loc_4.add8(param3);
            ClientSocket.send(_loc_4);
            return;
        }// end function

        private function awardsprite(param1:int, param2:Function = null) : Sprite
        {
            var _loc_7:* = 0;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = null;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = null;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = null;
            var _loc_36:* = null;
            var _loc_37:* = null;
            var _loc_38:* = null;
            var _loc_3:* = new Sprite();
            var _loc_4:* = 0;
            var _loc_5:* = new Label(_loc_3, 10, _loc_4, Config.language("TaskPanel", 62));
            new Label(_loc_3, 10, _loc_4, Config.language("TaskPanel", 62)).textColor = 16777215;
            _loc_4 = _loc_4 + 20;
            var _loc_6:* = new Object();
            _loc_7 = 0;
            var _loc_8:* = 1;
            var _loc_9:* = true;
            var _loc_10:* = 0;
            while (_loc_10 < this.taskdayarr.length)
            {
                
                switch(this.taskdayarr[_loc_10].quality)
                {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            _loc_7 = 0;
            while (_loc_7 < this.tasklistarr.length)
            {
                
                switch(this.tasklistarr[_loc_7].quality)
                {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (_loc_9)
            {
                _loc_6 = Config._taskMap[param1];
                _loc_6.daynum = 0;
            }
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            if (Config._taskMap[_loc_6.id].hasOwnProperty("awardData"))
            {
                if (int(Config._taskMap[_loc_6.id].awardData) == 0)
                {
                    if (Config._taskMap[_loc_6.id].awardMoney != 0)
                    {
                        _loc_11 = int(Config._taskMap[_loc_6.id].awardMoney) * _loc_8;
                    }
                    if (Config._taskMap[_loc_6.id].awardMoney2 != 0)
                    {
                        _loc_12 = int(Config._taskMap[_loc_6.id].awardMoney2) * _loc_8;
                    }
                    if (Config._taskMap[_loc_6.id].awardLottery != 0)
                    {
                        _loc_13 = int(Config._taskMap[_loc_6.id].awardLottery) * _loc_8;
                    }
                    if (Config._taskMap[_loc_6.id].awardLottery != 0)
                    {
                        _loc_14 = int(Config._taskMap[_loc_6.id].awardLottery2) * _loc_8;
                    }
                    if (Config._taskMap[_loc_6.id].awardExp != 0)
                    {
                        _loc_15 = int(Config._taskMap[_loc_6.id].awardExp) * _loc_8;
                    }
                    if (Config._taskMap[_loc_6.id].tianfu != 0)
                    {
                        _loc_17 = Config._taskMap[_loc_6.id].tianfu * _loc_8;
                    }
                }
                else
                {
                    switch(int(Config._taskMap[_loc_6.id].type))
                    {
                        case 0:
                        {
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].mtcoin1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].mtcoin2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].mtcoin3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].mtcoin4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].mtexp) != 0)
                            {
                            }
                            break;
                        }
                        case 1:
                        {
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].etcoin1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].etcoin2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].etcoin3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].etcoin4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].etexp) != 0)
                            {
                            }
                            break;
                        }
                        case 2:
                        {
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].dtcoin1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].dtcoin2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].dtcoin3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].dtcoin4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].dtexp) != 0)
                            {
                            }
                            break;
                        }
                        case 3:
                        {
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].dtcoinbag1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].dtcoinbag2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].dtcoinbag3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].dtcoinbag4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config._taskMap[_loc_6.id].awardLevel].dtexpbag) != 0)
                            {
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    switch(int(Config._taskMap[_loc_6.id].type))
                    {
                        case 0:
                        {
                            if (int(Config._ListExp[Config.player.level].mtcoin1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].mtcoin2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].mtcoin3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].mtcoin4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].mtexp) != 0)
                            {
                            }
                            break;
                        }
                        case 1:
                        {
                            if (int(Config._ListExp[Config.player.level].etcoin1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].etcoin2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].etcoin3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].etcoin4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].etexp) != 0)
                            {
                            }
                            break;
                        }
                        case 2:
                        {
                            if (int(Config._ListExp[Config.player.level].dtcoin1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtcoin2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtcoin3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtcoin4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtexp) != 0)
                            {
                            }
                            break;
                        }
                        case 3:
                        {
                            if (int(Config._ListExp[Config.player.level].dtcoinbag1) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtcoinbag2) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtcoin3) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtcoinbag4) != 0)
                            {
                            }
                            if (int(Config._ListExp[Config.player.level].dtexpbag) != 0)
                            {
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            _loc_16 = int(Config._taskMap[_loc_6.id].gHpoint);
            if (_loc_11 != 0)
            {
                _loc_18 = new Label(_loc_3, 30, _loc_4, Config.language("TaskInforSp", 6));
                _loc_18.textColor = 16777215;
                _loc_19 = new Label(_loc_3, 70, _loc_4, String(_loc_11));
                _loc_19.textColor = 16777215;
                _loc_4 = _loc_4 + 20;
            }
            if (_loc_12 != 0)
            {
                _loc_18 = new Label(_loc_3, 30, _loc_4, Config.language("TaskInforSp", 7));
                _loc_18.textColor = 16777215;
                _loc_19 = new Label(_loc_3, 70, _loc_4, String(_loc_12));
                _loc_19.textColor = 16777215;
                _loc_4 = _loc_4 + 20;
            }
            if (_loc_13 != 0)
            {
                _loc_20 = new Label(_loc_3, 30, _loc_4, Config.language("TaskInforSp", 8));
                _loc_20.textColor = 16777215;
                _loc_21 = new Label(_loc_3, 70, _loc_4, String(_loc_13));
                _loc_21.textColor = 16777215;
                _loc_4 = _loc_4 + 20;
            }
            if (_loc_14 != 0)
            {
                _loc_20 = new Label(_loc_3, 30, _loc_4, Config.language("TaskInforSp", 9));
                _loc_20.textColor = 16777215;
                _loc_21 = new Label(_loc_3, 70, _loc_4, String(_loc_14));
                _loc_21.textColor = 16777215;
                _loc_4 = _loc_4 + 20;
            }
            if (_loc_15 != 0)
            {
                _loc_22 = new Label(_loc_3, 30, _loc_4, Config.language("TaskInforSp", 10));
                _loc_22.textColor = 16777215;
                _loc_23 = new Label(_loc_3, 70, _loc_4, String(_loc_15));
                _loc_23.textColor = 16777215;
                _loc_4 = _loc_4 + 20;
                if (_loc_8 != 1 && Config._taskMap[_loc_6.id].type == 2 && Config.player.level >= 70)
                {
                    _loc_24 = new Label(_loc_3, 30, _loc_4, Config.language("TaskInforSp", 67));
                    _loc_24.textColor = 16777215;
                    _loc_24 = new Label(_loc_3, 100, _loc_4, String(_loc_8 * 50));
                    _loc_24.textColor = 16777215;
                    _loc_4 = _loc_4 + 20;
                }
            }
            if (_loc_16 != 0)
            {
                _loc_22 = new Label(_loc_3, 30, _loc_4, Config.language("TaskInforSp", 11));
                _loc_22.textColor = 16777215;
                _loc_23 = new Label(_loc_3, 100, _loc_4, String(_loc_16));
                _loc_23.textColor = 16777215;
                _loc_4 = _loc_4 + 20;
            }
            if (_loc_17 != 0)
            {
                _loc_25 = [1, 1, 0.5, 0.5, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15];
                if (int(Config._taskMap[_loc_6.id].type) == 4)
                {
                    _loc_17 = int(_loc_25[_loc_6.daynum] * _loc_17);
                }
                _loc_26 = new Label(_loc_3, 30, _loc_4, Config.language("TaskInforSp", 12));
                _loc_26.textColor = 16777215;
                _loc_27 = new Label(_loc_3, 130, _loc_4, String(_loc_17));
                _loc_27.textColor = 16777215;
                _loc_4 = _loc_4 + 20;
            }
            _loc_4 = _loc_4 + 10;
            if (Config._taskMap[param1].awardItem1 != 0)
            {
                _loc_28 = new Label(_loc_3, 30, _loc_4, Config.language("TaskInforSp", 13));
                _loc_28.textColor = 16777215;
                _loc_29 = this.awarditempick(Config._taskMap[param1].awardItem1, Config._taskMap[param1].awardItemNum1);
                _loc_3.addChild(_loc_29);
                _loc_29.x = 100;
                _loc_29.y = _loc_4;
                _loc_29.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                _loc_29.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                if (Config._taskMap[param1].awardItem2 != 0)
                {
                    _loc_30 = this.awarditempick(Config._taskMap[param1].awardItem2, Config._taskMap[param1].awardItemNum2);
                    _loc_3.addChild(_loc_30);
                    _loc_30.x = 140;
                    _loc_30.y = _loc_4;
                    _loc_30.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                    _loc_30.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    if (Config._taskMap[param1].awardItem3 != 0)
                    {
                        _loc_31 = this.awarditempick(Config._taskMap[param1].awardItem3, Config._taskMap[param1].awardItemNum3);
                        _loc_3.addChild(_loc_31);
                        _loc_31.x = 180;
                        _loc_31.y = _loc_4;
                        _loc_31.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                        _loc_31.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    }
                }
                _loc_4 = _loc_4 + 40;
            }
            if (int(Config._taskMap[param1].skill) != 0)
            {
                _loc_28 = new Label(_loc_3, 30, _loc_4, Config.language("TaskInforSp", 14));
                _loc_28.textColor = 16777215;
                _loc_32 = this.awardskill(int(Config._taskMap[param1].skill));
                _loc_3.addChild(_loc_32);
                _loc_32.x = 100;
                _loc_32.y = _loc_4;
                _loc_4 = _loc_4 + 40;
            }
            if (Config._taskMap[param1].awardItemA != 0)
            {
                this.selectitem = new Array();
                this._sflag = -1;
                _loc_33 = new Label(_loc_3, 30, _loc_4, Config.language("TaskInforSp", 15));
                _loc_33.textColor = 16777215;
                _loc_34 = this.awarditempick(Config._taskMap[param1].awardItemA, Config._taskMap[param1].awardItemNumA);
                _loc_3.addChild(_loc_34);
                _loc_34.x = 100;
                _loc_34.y = _loc_4;
                this.selectitem.push(_loc_34);
                _loc_34.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                _loc_34.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                if (Config._taskMap[param1].awardItemB != 0)
                {
                    _loc_35 = this.awarditempick(Config._taskMap[param1].awardItemB, Config._taskMap[param1].awardItemNumB);
                    _loc_3.addChild(_loc_35);
                    _loc_35.x = 140;
                    _loc_35.y = _loc_4;
                    this.selectitem.push(_loc_35);
                    _loc_35.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                    _loc_35.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    if (Config._taskMap[param1].awardItemC != 0)
                    {
                        _loc_36 = this.awarditempick(Config._taskMap[param1].awardItemC, Config._taskMap[param1].awardItemNumC);
                        _loc_3.addChild(_loc_36);
                        _loc_36.x = 180;
                        _loc_36.y = _loc_4;
                        this.selectitem.push(_loc_36);
                        _loc_36.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                        _loc_36.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                        if (Config._taskMap[param1].awardItemD != 0)
                        {
                            _loc_37 = this.awarditempick(Config._taskMap[param1].awardItemD, Config._taskMap[param1].awardItemNumD);
                            _loc_3.addChild(_loc_37);
                            _loc_37.x = 220;
                            _loc_37.y = _loc_4;
                            this.selectitem.push(_loc_37);
                            _loc_37.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                            _loc_37.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                            if (Config._taskMap[param1].awardItemE != 0)
                            {
                                _loc_38 = this.awarditempick(Config._taskMap[param1].awardItemE, Config._taskMap[param1].awardItemNumE);
                                _loc_3.addChild(_loc_36);
                                _loc_38.x = 260;
                                _loc_38.y = _loc_4;
                                this.selectitem.push(_loc_38);
                                _loc_38.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                                _loc_38.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                            }
                        }
                    }
                }
                _loc_4 = _loc_4 + 40;
                _loc_7 = 0;
                while (_loc_7 < this.selectitem.length)
                {
                    
                    this.selectitem[_loc_7].addEventListener(MouseEvent.CLICK, Config.create(this.sawitem, _loc_7));
                    _loc_7 = _loc_7 + 1;
                }
            }
            return _loc_3;
        }// end function

        private function goalsprite(param1:int) : Sprite
        {
            var _loc_2:* = new Sprite();
            return _loc_2;
        }// end function

        private function npcling(event:MouseEvent, param2:int, param3:int, param4:int)
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            if (param2 >= 350 && param2 <= 357)
            {
                _loc_5 = new Object();
                _loc_5.taskid = param2;
                _loc_5.npcid = param3;
                _loc_5.shuang = 1;
                _loc_5.far = param4;
                AlertUI.alert(Config.language("TaskPanel", 63), Config.language("TaskPanel", 64) + "<font color=\'#cc0000\'>" + Config._itemMap[Config._taskMap[param2].item1].name + "</font>\n" + Config.language("TaskPanel", 65), [Config.language("TaskPanel", 66), Config.language("TaskPanel", 67)], [this.centerling, null], _loc_5);
            }
            else
            {
                this.lingshang(param2, this._sflag, param3, 1, param4);
                _loc_6 = this.npctalkarr(param3);
                _loc_7 = 0;
                while (_loc_7 < _loc_6.length)
                {
                    
                    if (_loc_6[_loc_7].id != param2)
                    {
                        if (_loc_6[_loc_7].type == 1 || _loc_6[_loc_7].type == 2 || _loc_6[_loc_7].type == 4)
                        {
                            this.npctalk(param3, _loc_6[_loc_7].id);
                            break;
                        }
                    }
                    _loc_7++;
                }
            }
            return;
        }// end function

        private function dnpcling(event:MouseEvent, param2:int, param3:int, param4:int)
        {
            var _loc_5:* = new Object();
            new Object().taskid = param2;
            _loc_5.npcid = param3;
            _loc_5.shuang = 2;
            _loc_5.far = param4;
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                AlertUI.alert(Config.language("TaskPanel", 63), Config.language("TaskPanel", 118, Config._taskMap[param2].doubleItemNUM, Config._itemMap[Config._taskMap[param2].doubleItemID].name, String(Config._taskMap[param2].doubleItemNUM * 2)), [Config.language("TaskPanel", 66), Config.language("TaskPanel", 67)], [this.centerling, null], _loc_5);
            }
            else
            {
                AlertUI.alert(Config.language("TaskPanel", 63), Config.language("TaskPanel", 68, Config._taskMap[param2].doubleItemNUM, Config._itemMap[Config._taskMap[param2].doubleItemID].name, String(Config._taskMap[param2].doubleItemNUM * 2)), [Config.language("TaskPanel", 66), Config.language("TaskPanel", 67)], [this.centerling, null], _loc_5);
            }
            return;
        }// end function

        private function centerling(param1:Object) : void
        {
            this.lingshang(param1.taskid, this._sflag, param1.npcid, param1.shuang, param1.far);
            return;
        }// end function

        private function awarditempick(param1:int, param2:int = 1)
        {
            var _loc_3:* = new CloneSlot(0, 30);
            var _loc_4:* = Item.newItem(Config._itemMap[param1], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
            Item.newItem(Config._itemMap[param1], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0).display();
            _loc_4.amount = param2;
            _loc_3.item = _loc_4;
            return _loc_3;
        }// end function

        private function awardskill(param1:int) : CloneSlot
        {
            var _loc_2:* = new CloneSlot(0, 32);
            _loc_2.skillId = param1;
            _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            return _loc_2;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_2:* = param1.currentTarget;
            var _loc_3:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
            }
            else if (_loc_2.skill != null)
            {
                Holder.showInfo(_loc_2.skill.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
            }
            return;
        }// end function

        private function handleSlotOut(event:MouseEvent) : void
        {
            Holder.closeInfo();
            return;
        }// end function

        private function sawitem(event:MouseEvent, param2:int) : void
        {
            if (this._sflag != param2)
            {
                if (this._sflag != -1)
                {
                    this.selectitem[this._sflag].selected = false;
                }
                this.selectitem[param2].selected = true;
                this._sflag = param2;
            }
            return;
        }// end function

        public function get autotaskid() : int
        {
            return this._autotaskid;
        }// end function

        public function set autotaskid(param1:int) : void
        {
            var _loc_2:* = this._autotaskid;
            this._autotaskid = param1;
            if (_loc_2 != param1)
            {
                this.autodotask(param1, false);
            }
            else if (param1 != 0)
            {
                this.autodotask(param1, false);
            }
            return;
        }// end function

        public function errtip(param1:int) : void
        {
            switch(param1)
            {
                case 0:
                {
                    Billboard.show(Config.language("TaskPanel", 71));
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("TaskPanel", 72));
                    break;
                }
                case 2:
                {
                    Config.message(Config.language("TaskPanel", 73));
                    break;
                }
                case 3:
                {
                    Config.message(Config.language("TaskPanel", 74));
                    break;
                }
                case 4:
                {
                    Config.message(Config.language("TaskPanel", 75));
                    break;
                }
                case 5:
                {
                    Config.message(Config.language("TaskPanel", 76));
                    break;
                }
                case 6:
                {
                    Config.message(Config.language("TaskPanel", 77));
                    break;
                }
                case 7:
                {
                    Config.message(Config.language("TaskPanel", 78));
                    break;
                }
                case 8:
                {
                    Config.message(Config.language("TaskPanel", 79));
                    break;
                }
                case 9:
                {
                    Config.message(Config.language("TaskPanel", 80));
                    break;
                }
                case 10:
                {
                    Config.message(Config.language("TaskPanel", 81));
                    break;
                }
                case 11:
                {
                    Config.message(Config.language("TaskPanel", 82));
                    break;
                }
                case 12:
                {
                    Config.message(Config.language("TaskPanel", 83));
                    break;
                }
                case 13:
                {
                    Config.message(Config.language("TaskPanel", 84));
                    break;
                }
                case 14:
                {
                    Config.message(Config.language("TaskPanel", 85));
                    break;
                }
                case 15:
                {
                    Config.message(Config.language("TaskPanel", 86));
                    break;
                }
                case 16:
                {
                    Config.message(Config.language("TaskPanel", 87));
                    break;
                }
                case 17:
                {
                    Config.message(Config.language("TaskPanel", 88));
                    break;
                }
                case 18:
                {
                    Config.message(Config.language("TaskPanel", 89));
                    break;
                }
                case 19:
                {
                    Config.message(Config.language("TaskPanel", 90));
                    break;
                }
                case 20:
                {
                    Config.message(Config.language("TaskPanel", 91));
                    break;
                }
                case 21:
                {
                    Config.message(Config.language("TaskPanel", 92));
                    break;
                }
                case 22:
                {
                    Config.message(Config.language("TaskPanel", 93));
                    break;
                }
                case 23:
                {
                    Config.message(Config.language("TaskPanel", 94));
                    break;
                }
                case 24:
                {
                    Config.message(Config.language("TaskPanel", 95));
                    break;
                }
                case 25:
                {
                    Config.message(Config.language("TaskPanel", 107));
                    break;
                }
                case 26:
                {
                    Config.message(Config.language("TaskPanel", 108));
                    break;
                }
                case 27:
                {
                    Config.message(Config.language("TaskPanel", 119));
                    break;
                }
                case 28:
                {
                    Config.message(Config.language("TaskPanel", 126));
                    break;
                }
                case 29:
                {
                    Config.message(Config.language("TaskPanel", 127));
                    break;
                }
                case 30:
                {
                    Config.message(Config.language("TaskPanel", 128));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function setdaynum(param1:int = 0) : void
        {
            this.daynum.text = String(param1);
            if (param1 < 10)
            {
                this.daynum.tip = Config.language("TaskPanel", 96);
            }
            else
            {
                this.daynum.tip = Config.language("TaskPanel", 97);
            }
            return;
        }// end function

        private function sendtaskchange() : void
        {
            this.dispatchEvent(new Event("change"));
            return;
        }// end function

        private function tipauto(param1:int) : void
        {
            this._tasktips.autoiconfuc(param1);
            return;
        }// end function

        public function levelupfuc() : void
        {
            var _loc_1:* = 0;
            if (this.menubar.selectpage == 0)
            {
                _loc_1 = this.listcanvas.selectid;
                this.initsecpage(null, 0);
                this.opentaskinfor(_loc_1);
                this.listcanvas.selectid = _loc_1;
            }
            else if (this.menubar.selectpage == 1)
            {
                this.initsecpage(null, 1);
            }
            if (this.tkinforsp != null)
            {
                if (this.tkinforsp.parent != null)
                {
                    this.opentaskinfor(this.listcanvas.selectid);
                }
            }
            Config.ui._activePanel.levelShow();
            this.sendtaskchange();
            Config.ui._recomPanel.reShowRecom();
            return;
        }// end function

        private function taskdaychange(event:SocketEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = undefined;
            var _loc_6:* = false;
            var _loc_7:* = 0;
            var _loc_2:* = event.data.readUnsignedByte();
            if (_loc_2 == 1)
            {
                _loc_3 = 0;
                while (_loc_3 < this.tasklistarr.length)
                {
                    
                    this.tasklistarr[_loc_3].daynum = 0;
                    _loc_3 = _loc_3 + 1;
                }
                _loc_4 = 0;
                while (_loc_4 < this.taskdayarr.length)
                {
                    
                    this.taskdayarr[_loc_4].daynum = 0;
                    _loc_4 = _loc_4 + 1;
                }
                for (_loc_5 in this.taskdownlist)
                {
                    
                    if (Config._taskMap[this.taskdownlist[_loc_5].id].week > 0)
                    {
                        _loc_6 = true;
                        _loc_7 = 0;
                        while (_loc_7 < this.tasklistarr.length)
                        {
                            
                            if (int(Config._taskMap[this.tasklistarr[_loc_7].id].headTask) == this.taskdownlist[_loc_5].id)
                            {
                                _loc_6 = false;
                                break;
                            }
                            _loc_7 = _loc_7 + 1;
                        }
                        if (_loc_6)
                        {
                            delete this.taskdownlist[_loc_5];
                        }
                    }
                }
            }
            else
            {
                _loc_3 = 0;
                while (_loc_3 < this.tasklistarr.length)
                {
                    
                    if (Config._taskMap[this.tasklistarr[_loc_3].id].week == 1)
                    {
                        this.tasklistarr[_loc_3].daynum = 0;
                    }
                    _loc_3 = _loc_3 + 1;
                }
                _loc_4 = 0;
                while (_loc_4 < this.taskdayarr.length)
                {
                    
                    if (Config._taskMap[this.taskdayarr[_loc_4].id].week == 1)
                    {
                        this.taskdayarr[_loc_4].daynum = 0;
                    }
                    _loc_4 = _loc_4 + 1;
                }
                for (_loc_5 in this.taskdownlist)
                {
                    
                    if (Config._taskMap[this.taskdownlist[_loc_5].id].week == 1)
                    {
                        _loc_6 = true;
                        _loc_7 = 0;
                        while (_loc_7 < this.tasklistarr.length)
                        {
                            
                            if (int(Config._taskMap[this.tasklistarr[_loc_7].id].headTask) == this.taskdownlist[_loc_5].id)
                            {
                                _loc_6 = false;
                                break;
                            }
                            _loc_7 = _loc_7 + 1;
                        }
                        if (_loc_6)
                        {
                            delete this.taskdownlist[_loc_5];
                        }
                    }
                }
            }
            Config.ui._charUI.firenum = 0;
            Config.ui._nationalDayPanel.dayReset();
            if (Config.ui._onlineExpn.expnum < 3 && Config.player.level >= 20)
            {
                (Config.ui._onlineExpn.expnum + 1);
                Config.ui._onlineExpn.backexpnum();
            }
            this.sendtaskchange();
            return;
        }// end function

        private function taskloop(param1) : void
        {
            var _loc_2:* = null;
            if (Hang.hanging)
            {
                _loc_2 = Unit.getTaskUnit(UNIT_TYPE_ENUM.TYPEID_UNIT, 100015);
                if (_loc_2 != null)
                {
                    Hang.stop();
                    Config.player.target = _loc_2;
                    Config.stopLoop(this.taskloop);
                }
            }
            else
            {
                Config.stopLoop(this.taskloop);
            }
            Config.ui._gangs.firstgtask();
            return;
        }// end function

        public function guickFinish(param1:int) : void
        {
            switch(param1)
            {
                case 0:
                {
                    this.sendtaskchange();
                    break;
                }
                default:
                {
                    this.errtip(param1);
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function dayAccept(param1:int) : void
        {
            switch(param1)
            {
                case 0:
                {
                    this.dayListPanel.showList([]);
                    if (this.taskmate != null)
                    {
                        if (this.taskmate.parent != null)
                        {
                            this.taskmate.close();
                        }
                    }
                    break;
                }
                default:
                {
                    this.errtip(param1);
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function sendFastDone(param1:int) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_QUEST_SETFINISH);
            _loc_2.add32(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function finishTask(event:SocketEvent) : void
        {
            var _loc_4:* = false;
            var _loc_5:* = false;
            var _loc_6:* = 0;
            var _loc_2:* = event.data.readUnsignedInt();
            this.taskRecomList[_loc_2] = {id:_loc_2};
            Billboard.show(Config.language("TaskPanel", 71));
            if (_loc_2 == 68)
            {
                Config.ui._skillUI.addGiftShow();
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.tasklistarr.length)
            {
                
                if (_loc_2 == this.tasklistarr[_loc_3].id)
                {
                    _loc_4 = true;
                    if (this.taskdownlist[_loc_2] != null)
                    {
                        _loc_4 = false;
                    }
                    if (_loc_4)
                    {
                        this.taskdownlist[_loc_2] = {id:_loc_2};
                    }
                    (this.tasklistarr[_loc_3].daynum + 1);
                    if (int(Config._taskMap[_loc_2].eventTrigger) > 0)
                    {
                        if (this.taskdownlist[int(Config._taskMap[_loc_2].eventTrigger)] != null)
                        {
                            if (int(Config._taskMap[_loc_2].refreshNum) > this.tasklistarr[_loc_3].daynum)
                            {
                                delete this.taskdownlist[int(Config._taskMap[_loc_2].eventTrigger)];
                            }
                            else if (int(Config._taskMap[_loc_2].refreshNum) == 0)
                            {
                                delete this.taskdownlist[int(Config._taskMap[_loc_2].eventTrigger)];
                            }
                        }
                        _loc_5 = true;
                        _loc_6 = 0;
                        while (_loc_6 < this.taskdayarr.length)
                        {
                            
                            if (this.taskdayarr[_loc_6].id == this.tasklistarr[_loc_3].id)
                            {
                                this.taskdayarr[_loc_6].daynum = this.tasklistarr[_loc_3].daynum;
                                _loc_5 = false;
                                break;
                            }
                            else if (this.taskdayarr[_loc_6].id == int(Config._taskMap[_loc_2].headTask) && int(Config._taskMap[_loc_2].eventTrigger) == this.taskdayarr[_loc_6].id)
                            {
                                this.taskdayarr[_loc_6].daynum = this.tasklistarr[_loc_3].daynum;
                                break;
                            }
                            _loc_6 = _loc_6 + 1;
                        }
                        if (_loc_5)
                        {
                            this.taskdayarr.push(this.tasklistarr[_loc_3]);
                        }
                    }
                    this.delfirsttask(_loc_2);
                    this.tasklistarr.splice(_loc_3, 1);
                    if (this.menubar.selectpage == 0)
                    {
                        this.removeallchild(this.mainpanel);
                        this.betasklist(0);
                    }
                    else if (this.menubar.selectpage == 1)
                    {
                        this.removeallchild(this.mainpanel);
                        this.everydaytask();
                    }
                    if (this.taskmate != null)
                    {
                        if (this.taskmate.parent != null)
                        {
                            if (this.taskmate.taskid == _loc_2)
                            {
                                this.taskmate.close();
                            }
                        }
                    }
                    if (this.tkinforsp != null)
                    {
                        if (this.tkinforsp.parent != null)
                        {
                            if (this.tkinforsp.taskid == _loc_2)
                            {
                                this.tkinforsp.parent.removeChild(this.tkinforsp);
                            }
                        }
                    }
                    this._tasktips.uptask(this.tasklistarr, this.taskliparr);
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            if (_loc_2 == 32)
            {
                Skill.picksoulTime = 0;
                Config.ui._quickUI.openPicksoul();
            }
            else if (_loc_2 == 53)
            {
                Config.ui._quickUI.openGoldhand();
            }
            else if (_loc_2 == 101)
            {
                Skill.picksoulTime = Skill.picksoulTime;
                if (Skill.picksoulTime == 0)
                {
                    Config.ui._quickUI.openPicksoul();
                }
                else
                {
                    Config.ui._quickUI.closePicksoul();
                }
            }
            if (_loc_2 == 4)
            {
                if (GuideUI.testId(92))
                {
                    setTimeout(this.subGuide92, 1000);
                }
            }
            else if (_loc_2 == 68)
            {
                GuideUI.testDoId(94, Config.ui._systemUI._skillPB, Config.ui._skillUI);
            }
            else if (_loc_2 == 672)
            {
                GuideUI.testDoId(103);
            }
            else if (_loc_2 == 744)
            {
                GuideUI.testDoId(105);
            }
            else if (_loc_2 == 487)
            {
                GuideUI.testDoId(106);
            }
            else if (_loc_2 == 25 || _loc_2 == 27 || _loc_2 == 29)
            {
                GuideUI.testDoId(167, Config.ui._systemUI._bagPB, Config.ui._bagUI);
            }
            else if (_loc_2 == 244 || _loc_2 == 246 || _loc_2 == 248)
            {
                GuideUI.testDoId(173, Config.ui._systemUI._bagPB, Config.ui._bagUI);
            }
            else if (_loc_2 == 800)
            {
                GuideUI.testDoId(217, Config.ui._systemUI._petPB, Config.ui._petPanel);
            }
            else if (_loc_2 == 101)
            {
                GuideUI.testDoId(232, Config.ui._quickUI._picksoulSlot);
            }
            else if (_loc_2 == 802)
            {
                GuideUI.testDoId(242, Config.ui._systemUI._bagPB, Config.ui._bagUI);
            }
            else if (_loc_2 == 818)
            {
                GuideUI.testDoId(244, Config.ui._systemUI._bagPB, Config.ui._bagUI);
            }
            else if (_loc_2 == 571)
            {
                GuideUI.testDoId(93);
            }
            else if (_loc_2 == 743)
            {
                GuideUI.testDoId(77);
            }
            else if (_loc_2 == 1359)
            {
                GuideUI.testDoId(30, Config.ui._systemUI._charPB);
            }
            else if (_loc_2 == 1388)
            {
                GuideUI.testDoId(80, Config.ui._systemUI._charPB);
            }
            else if (_loc_2 == 1530)
            {
                GuideUI.testDoId(248, Config.ui._systemUI._godPB);
            }
            this.sendtaskchange();
            return;
        }// end function

        public function dayListNpcTalk(param1:int, param2:Array, param3:Function = null) : void
        {
            param2.push({label:Config.language("TaskPanel", 98), handler:this.dayTaskFind, closeflag:true});
            return;
        }// end function

        private function dayTaskFind(event:TextEvent) : void
        {
            this.dayListPanel.open();
            return;
        }// end function

        private function listDaily(event:SocketEvent) : void
        {
            var _loc_6:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = new Array();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = new Object();
                _loc_6.id = _loc_2.readUnsignedInt();
                _loc_6.quality = _loc_2.readByte();
                _loc_4.push(_loc_6);
                _loc_5 = _loc_5 + 1;
            }
            this.dayListPanel.showList(_loc_4);
            GuideUI.testDoId(145, Config.ui._systemUI._taskPB, Config.ui._taskpanel);
            return;
        }// end function

        private function questAuto(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            this.questAutoList = {};
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = {};
                _loc_5.id = _loc_2.readUnsignedInt();
                _loc_5.time = _loc_2.readUnsignedInt() * 1000;
                this.questAutoList[_loc_5.id] = _loc_5;
                _loc_4 = _loc_4 + 1;
            }
            if (this.menubar.selectpage == 0 && this.listcanvas != null)
            {
                if (this.listcanvas.selectid > 0)
                {
                    this.opentaskinfor(this.listcanvas.selectid);
                }
            }
            this.checkQuestTime();
            return;
        }// end function

        private function toolFuc(param1, param2:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            switch(param2)
            {
                case 1:
                {
                    _loc_3 = new Object();
                    _loc_3.id = this.listcanvas.selectid;
                    AlertUI.alert(Config.language("TaskPanel", 63), Config.language("TaskPanel", 104), [Config.language("TaskPanel", 66), Config.language("TaskPanel", 67)], [this.sendquest, null], _loc_3);
                    break;
                }
                case 2:
                {
                    if (this.menubar.selectpage == 0)
                    {
                        _loc_4 = 0;
                        while (_loc_4 < this.tasklistarr.length)
                        {
                            
                            if (this.tasklistarr[_loc_4].id == this.listcanvas.selectid)
                            {
                                if (this.tasklistarr[_loc_4].type == 0)
                                {
                                    _loc_3 = new Object();
                                    _loc_3.id = this.listcanvas.selectid;
                                    AlertUI.alert(Config.language("TaskPanel", 63), Config.language("TaskInforSp", 59), [Config.language("TaskPanel", 66), Config.language("TaskPanel", 67)], [this.enterfast], _loc_3);
                                }
                                else
                                {
                                    _loc_3 = new Object();
                                    _loc_3.id = this.listcanvas.selectid;
                                    AlertUI.alert(Config.language("TaskPanel", 63), Config.language("TaskPanel", 105, this.getPayCoin()), [Config.language("TaskPanel", 66), Config.language("TaskPanel", 67)], [this.openLingPanel], _loc_3);
                                }
                                break;
                            }
                            _loc_4 = _loc_4 + 1;
                        }
                    }
                    else
                    {
                        _loc_3 = new Object();
                        _loc_3.id = this.listcanvas.selectid;
                        AlertUI.alert(Config.language("TaskPanel", 63), Config.language("TaskPanel", 106, this.getPayCoin()), [Config.language("TaskPanel", 66), Config.language("TaskPanel", 67)], [this.openLingPanel], _loc_3);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getPayCoin() : int
        {
            var _loc_1:* = 0;
            if (Config.player.level < 10)
            {
                _loc_1 = 500;
            }
            else if (Config.player.level < 20 && Config.player.level >= 10)
            {
                _loc_1 = 850;
            }
            else if (Config.player.level < 30 && Config.player.level >= 20)
            {
                _loc_1 = 1425;
            }
            else if (Config.player.level < 40 && Config.player.level >= 30)
            {
                _loc_1 = 2450;
            }
            else if (Config.player.level < 50 && Config.player.level >= 40)
            {
                _loc_1 = 4175;
            }
            else if (Config.player.level < 60 && Config.player.level >= 50)
            {
                _loc_1 = 7100;
            }
            else if (Config.player.level < 70 && Config.player.level >= 60)
            {
                _loc_1 = 12050;
            }
            else
            {
                _loc_1 = 20500;
            }
            return _loc_1;
        }// end function

        public function opengetTaskPanel(param1) : void
        {
            this.npctalk(Config._taskMap[param1.id].startNPC, param1.id, null, 1);
            return;
        }// end function

        public function openLingPanel(param1) : void
        {
            this.npctalk(Config._taskMap[param1.id].finishNpc, param1.id, null, 1);
            return;
        }// end function

        private function enterfast(param1) : void
        {
            this.sendFastDone(param1.id);
            return;
        }// end function

        private function sendquest(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_QUEST_AUTO);
            _loc_2.add32(param1.id);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function checktool(param1) : void
        {
            return;
        }// end function

        private function checkQuestTime() : void
        {
            var _loc_2:* = undefined;
            var _loc_1:* = false;
            for (_loc_2 in this.questAutoList)
            {
                
                if (this.questAutoList[_loc_2].time > Config.now.getTime() && this.questAutoList[_loc_2].id > 0)
                {
                    _loc_1 = true;
                    break;
                }
            }
            if (_loc_1)
            {
                this.questRun();
                this.questTime.start();
            }
            else
            {
                this.questTime.stop();
            }
            return;
        }// end function

        public function questRun(event:TimerEvent = null) : void
        {
            var _loc_2:* = undefined;
            if (this._opening && this.menubar.selectpage == 0)
            {
                for (_loc_2 in this.questAutoList)
                {
                    
                    if (this.questAutoList[_loc_2].time >= Config.now.getTime())
                    {
                        this.listcanvas.changeLabel(this.questAutoList[_loc_2].id, Config.timePoint(int(this.questAutoList[_loc_2].time / 1000), 1), 2);
                    }
                    if (this.questAutoList[_loc_2].id == this.listcanvas.selectid)
                    {
                        this.questTimeBar.maximum = 12 * 60 * 1000;
                        this.questTimeBar.value = 12 * 60 * 1000 - (this.questAutoList[_loc_2].time - Config.now.getTime());
                        this.questTimeLabel.text = Config.timePoint(int(this.questAutoList[_loc_2].time / 1000), 1) + Config.language("TaskPanel", 103);
                    }
                }
            }
            else
            {
                this.questTime.stop();
            }
            return;
        }// end function

        public function taskIsDwon(param1:int) : Boolean
        {
            var _loc_2:* = false;
            if (this.taskdownlist[param1] != null)
            {
                _loc_2 = true;
            }
            return _loc_2;
        }// end function

        public function setMapNext(param1:int, param2:int) : void
        {
            this._mapNextType = param1;
            this._mapNextValue = param2;
            return;
        }// end function

        public function mapNextGo() : void
        {
            if (this._MapNextFlag)
            {
                switch(this._mapNextType)
                {
                    case 1:
                    {
                        Hang.hangNpc(this._mapNextValue);
                        break;
                    }
                    case 2:
                    {
                        Hang.hangMonster(this._mapNextValue);
                        break;
                    }
                    case 3:
                    {
                        Hang.hangGather(this._mapNextValue);
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                    case 5:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            this._MapNextFlag = false;
            this._mapNextType = 0;
            this._mapNextValue = 0;
            return;
        }// end function

        public function get MapNextFlag() : Boolean
        {
            return this._MapNextFlag;
        }// end function

        public function set MapNextFlag(param1:Boolean) : void
        {
            this._MapNextFlag = param1;
            return;
        }// end function

        public function opendaytask(param1:Number)
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (param1 == 17)
            {
                _loc_3 = 0;
                while (_loc_3 < this.tasklistarr.length)
                {
                    
                    if (int(Config._taskMap[this.tasklistarr[_loc_3].id].type) == 3 && this.tasklistarr[_loc_3].type == 0)
                    {
                        _loc_2 = int(Config._taskMap[this.tasklistarr[_loc_3].id].id);
                        break;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            else if (param1 == 18)
            {
                _loc_3 = 0;
                while (_loc_3 < this.tasklistarr.length)
                {
                    
                    if (int(Config._taskMap[this.tasklistarr[_loc_3].id].type) == 2 && this.tasklistarr[_loc_3].type == 0)
                    {
                        _loc_2 = int(Config._taskMap[this.tasklistarr[_loc_3].id].id);
                        break;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            else if (param1 == 470)
            {
                _loc_2 = 470;
            }
            else if (param1 == 471)
            {
                _loc_2 = 471;
            }
            this.open();
            this.opentaskinfor(_loc_2, true);
            return;
        }// end function

        private function opengivegg(param1:int, param2:int = 0, param3:int = 0, param4:int = 1, param5:int = 0)
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            if (this.eggpanel == null)
            {
                this.sloteggArr = [];
                this.eggpanel = new Window(this.container, 150, 100);
                this.eggpanel.resize(190, 150);
                this.eggpanel.title = Config.language("TaskPanel", 120);
                _loc_6 = new Label(this.eggpanel, 20, 40, Config.language("TaskPanel", 121));
                _loc_7 = 0;
                while (_loc_7 < 3)
                {
                    
                    _loc_8 = new CloneSlot(0, 30);
                    this.eggpanel.addChild(_loc_8);
                    _loc_8.x = 30 + _loc_7 * 50;
                    _loc_8.y = 70;
                    _loc_8.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                    _loc_8.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    _loc_8.addEventListener(MouseEvent.CLICK, this.handleSlotClick);
                    this.sloteggArr.push(_loc_8);
                    _loc_7++;
                }
                this.suregiveggBtn = new PushButton(this.eggpanel, 65, 115, Config.language("TaskPanel", 122), Config.create(this.sendrquestreward, param1, param2, param3, param4, param5));
                this.suregiveggBtn.width = 60;
                this.suregiveggBtn.enabled = false;
                this.eggpanel.open();
            }
            else if (!this.eggpanel._opening)
            {
                this.eggpanel.open();
                _loc_7 = 0;
                while (_loc_7 < this.sloteggArr.length)
                {
                    
                    if (this.sloteggArr[_loc_7].item != null)
                    {
                        this.sloteggArr[_loc_7].item.destroy();
                        this.sloteggArr[_loc_7].item = null;
                    }
                    _loc_7++;
                }
            }
            return;
        }// end function

        private function handleSlotClick(event:MouseEvent)
        {
            var _loc_4:* = null;
            var _loc_2:* = event.currentTarget;
            if (Holder.item != null)
            {
                if (Holder.item._itemData.type == 10 && Holder.item._itemData.subType == 2)
                {
                    if (_loc_2.item != null)
                    {
                        _loc_2.item.destroy();
                        _loc_2.item = null;
                    }
                    _loc_4 = Item.newItem(Config._itemMap[Holder.item._itemData.id], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                    _loc_4.display();
                    _loc_2.item = _loc_4;
                }
                else
                {
                    Config.message(Config.language("TaskPanel", 123));
                }
                Holder.item._drawer[Holder.item._position].item = Holder.item;
                Holder.item = null;
            }
            else if (_loc_2.item != null)
            {
                _loc_2.item.destroy();
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.sloteggArr.length)
            {
                
                if (this.sloteggArr[_loc_3].item != null)
                {
                    if (_loc_3 == 2)
                    {
                        this.suregiveggBtn.enabled = true;
                    }
                }
                else
                {
                    this.suregiveggBtn.enabled = false;
                    break;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function sendrquestreward(event:MouseEvent, param2:int, param3:int = 0, param4:int = 0, param5:int = 1, param6:int = 0)
        {
            AlertUI.alert(Config.language("TaskPanel", 63), Config.language("TaskPanel", 124), [Config.language("TaskPanel", 66), Config.language("TaskPanel", 67)], [Config.create(this.suresend, param2, param3, param4, param5, param6)]);
            return;
        }// end function

        private function suresend(event:MouseEvent, param2:int, param3:int = 0, param4:int = 0, param5:int = 1, param6:int = 0)
        {
            var _loc_7:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_QUEST_REWARD1);
            _loc_7.add32(param2);
            _loc_7.add32(Npc._idIndexMap[param4]);
            _loc_7.add8(param3);
            _loc_7.add8(param5);
            _loc_7.add8(param6);
            _loc_7.add8(3);
            var _loc_8:* = 0;
            while (_loc_8 < this.sloteggArr.length)
            {
                
                if (this.sloteggArr[_loc_8].item != null)
                {
                    _loc_7.add32(this.sloteggArr[_loc_8].item._itemData.id);
                }
                _loc_8++;
            }
            ClientSocket.send(_loc_7);
            if (this.eggpanel != null)
            {
                this.eggpanel.close();
            }
            return;
        }// end function

        private function strattimer(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this._gathertime = _loc_2.readUnsignedInt();
            this.strtimer = Config.timeShow(this._gathertime);
            trace(this._gathertime, _loc_3);
            return;
        }// end function

        public function set strtimer(param1:String) : void
        {
            this._strtimer = param1;
            return;
        }// end function

        public function get strtimer() : String
        {
            return this._strtimer;
        }// end function

    }
}
