package lovefox.gameUI
{
    import flash.display.*;
    import lovefox.activeUI.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class GameUI extends Sprite
    {
        public var _width:uint;
        public var _height:uint;
        public var _cardUI:CardUI;
        public var _chatUI:ChatUI;
        public var _noticeUI:NoticeUI;
        public var _charUI:CharUI;
        public var _bagUI:BagPanel;
        public var _bagware:BagWare;
        public var _stallUI:StallUI;
        public var _boothUI:BoothUI;
        public var _skillUI:SkillUI;
        public var _shopUI:ShopPanel;
        public var _dealUI:DealUI;
        public var _monsterIndexUI:MonsterIndexUI;
        public var _quickUI:QuickUI;
        public var _systemUI:SystemUI;
        public var _onlineExpn:OnlineExpression;
        public var _nationalDayPanel:NationalDayPanel;
        public var _wishPool:WishPool;
        public var _farmpanel:FarmPanel;
        public var _friendUI:FriendUI;
        public var _teamUI:TeamPanel;
        public var _alertUI:AlertUI;
        public var _guideUI:GuideUI;
        public var _fbDetailUI:FbDetailUI;
        public var _fbEntranceUI:FbEntranceUI;
        public var _bigWar:BigWar;
        public var _bwscorepanel:BigwarScorePanel;
        public var _billboardpanel:BillboardPanel;
        public var _activeprize:ActivPrize;
        public var _yabiao:YabiaoTime;
        public var _numericUI:NumericUI;
        public var _mailpanel:MailPanel;
        public var _taskpanel:TaskPanel;
        public var _recomPanel:RecomPanel;
        public var _activePanel:activePanel;
        public var _giftDare:GiftDarePanel;
        public var _dayGiftPanel:DayGiftPanel;
        public var _mesHistoryPanel:MesHistoryPanel;
        public var _gangs:GildPanel;
        public var _gildwar:GildWar;
        public var _messagetips:MessageTips;
        public var _equippanel:EquipMentPanel;
        public var _pkmode:CombatMode;
        public var _shopmail:ShopMall;
        public var _shopbuy:ShopBuy;
        public var _blackmarket:BlackMarket;
        public var _equiomadepanel:EquipMadePanel;
        public var _dialogue:DialoguePanel;
        public var _expball:ExpBall;
        public var _listtip:ListTip;
        public var _gamesystem:GameSystem;
        public var _zoommap:ZoomMap;
        public var _producepanel:ProducePanel;
        public var _mousepointer:MousePointer;
        public var _wolfactive:WolfActive;
        public var _elitehall:EliteHall;
        public var _gildwarauction:GildWarAuction;
        public var _petPanel:petPanel;
        public var _mbbPanel:MBBPanel;
        public var _easyShop:EasyShop;
        public var _pkUI:PkUI;
        public var _answerUI:AnswerUI;
        public var _cclUI:CclUI;
        public var _moraUI:MoraUI;
        public var _suitFit:Suitfit;
        public var _autoDrug:AutoDrug;
        public var _energyPanel:EnergyPanel;
        public var _toAirPanel:ToAirPanel;
        public var _landGravePanel:LandGravePanel;
        public var _interPkPanel:InterPkPanel;
        public var _npcUI:Object;
        public var _mixUI:Object;
        public var _layer1:Sprite;
        public var _layer2:Sprite;
        public var _layer3:Sprite;
        public var _layer4:Sprite;
        public var _layer5:Sprite;
        public var _layer6:Sprite;
        public var _rendererStopTimer:Number;
        public var _rendererEmitterArray:Array;
        public var _holder:Holder;
        public var _jewelCompound:JewelCompound;
        public var _windowStack:Object;
        private var _menuArray:Array;
        public var _targetHead:TargetUI;
        public var _playerHead:HeadUI;
        public var _radar:Radar;
        private var _mouseDown:Boolean = false;
        public var _gildWarStraction:Window;
        public var _pkrace:PKrace;
        public var _pkraceinfo:PKraceinfoPanel;
        public var _pkraceUI:PkraceUI;
        public var _transport:Transport;
        public var _lookmapanel:Lookmapanel;
        public var _blessings:Blessings;
        public var _elementUI:ElementUI;
        public var _qqVipPanel:QQVipPanel;
        public var _vipPanel:VipPanel;
        public var _toAir2prize:ToAir2Prize;
        public var _interBigwar:InterBigWar;
        public var _sellCultivation:SellCultivation;
        public var _godmade:GodMade;
        public var _seniorcopy:SeniorCopy;
        public var _followcharui:FollowCharUI;
        public var _followupui:FollowUpUI;
        public var _serveracebill:ServerRacebill;
        public var _serverinteracebill:ServerInterRacebill;
        public var _manyplayertoair:ManyPlayerToair;
        public var _followfight:FollowFight;
        public var _giveflower:GiveFlower;
        public var _randompetegg:RandomPetegg;

        public function GameUI()
        {
            this._rendererEmitterArray = [];
            this._windowStack = [];
            this._menuArray = [];
            this._width = Config.map._mapWidth;
            this._height = Config.map._mapHeight;
            return;
        }// end function

        public function resize(param1, param2)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_6:* = 0;
            var _loc_5:* = this._height;
            if (Config.chatMode)
            {
                if (Config._switchEnglish)
                {
                    Config._chatWidth = Math.max(int(param1 / 3), 305);
                }
                this._width = param1 - Config.chatWidth;
            }
            else
            {
                this._width = param1;
            }
            this._height = param2;
            AlertUI.resize(this._width, param2);
            GuideUI.resize(this._width, param2);
            Billboard.resize();
            KitBardUI.resize();
            RollNotice.resize();
            this._radar.changresizey();
            this._radar.changresizecultivate();
            this._seniorcopy.resizeposx();
            this._manyplayertoair.resizeposx();
            _loc_3 = 0;
            while (_loc_3 < this._windowStack.length)
            {
                
                _loc_4 = this._windowStack[_loc_3];
                _loc_4.x = Math.max(0, Math.min(_loc_4.x, Config.map._mapWidth - _loc_4.width));
                _loc_4.y = Math.max(0, Math.min(_loc_4.y, Config.map._mapHeight - _loc_4.height));
                _loc_3 = _loc_3 + 1;
            }
            this._gamesystem.x = (this._width - this._gamesystem.width) / 2;
            this._gamesystem.y = (this._height - this._gamesystem.height) / 2;
            if (Config.chatMode)
            {
                this._chatUI.x = this._width;
                this._chatUI.width = Config.chatWidth;
                this._chatUI.height = this._height - 27;
                this._chatUI.y = this._height - 27;
                if (this._width >= 755)
                {
                    this._quickUI.y = this._height;
                    this._quickUI.x = 0;
                    this._systemUI.y = this._height;
                    this._systemUI.bg.scaleX = 1;
                    this._systemUI.bg.x = 0;
                    this._systemUI.x = this._width - this._systemUI.width;
                }
                else
                {
                    this._quickUI.y = this._height;
                    this._quickUI.x = this._width - this._quickUI.width + 13;
                    this._systemUI.y = this._height - 44;
                    this._systemUI.bg.scaleX = 1;
                    this._systemUI.bg.x = 0;
                    this._systemUI.x = this._width - this._systemUI.width;
                }
            }
            else
            {
                this._chatUI.x = 0;
                this._chatUI.height = this._chatUI._preHeight;
                if (Config._switchEnglish)
                {
                    _loc_6 = 500;
                }
                else
                {
                    _loc_6 = 300;
                }
                if (this._width >= 1100)
                {
                    this._quickUI.y = this._height;
                    this._quickUI.x = (this._width - this._quickUI.width) / 2 - int(Math.max(0, 1000 - this._width) / 3);
                    this._systemUI.y = this._height;
                    this._systemUI.bg.scaleX = 1;
                    this._systemUI.bg.x = 0;
                    this._systemUI.x = this._width - this._systemUI.width;
                    this._chatUI.width = Math.min(this._quickUI.x - 10, _loc_6);
                    this._chatUI.y = this._height - 27;
                }
                else
                {
                    this._quickUI.y = this._height;
                    this._quickUI.x = this._width - this._quickUI.width + 13;
                    this._systemUI.y = this._height;
                    this._systemUI.bg.scaleX = -1;
                    this._systemUI.bg.x = this._systemUI.bg._width + 10;
                    this._systemUI.x = -10;
                    this._chatUI.width = Math.min(this._quickUI.x - 10, _loc_6);
                    this._chatUI.y = this._height - 27 - 48;
                }
            }
            this._messagetips.resize(this._width, param2);
            this._radar.x = this._width;
            this._targetHead.x = this._width / 2;
            this._mesHistoryPanel.resetXY(this._width, param2);
            this._wolfactive.reSetXY(param1, param2);
            if (Config.player != null)
            {
                Config.player.reSizeBtn();
            }
            this._yabiao.x = (this._width - this._yabiao.width) / 2 - 20;
            this._yabiao.y = 20;
            this._bwscorepanel.x = (this._width - this._bwscorepanel.width) / 2 - 20;
            this._bwscorepanel.y = 20;
            this._dialogue.x = (this._width - this._dialogue.width) / 2 + 50;
            this._dialogue.y = (this._height - this._dialogue.height) / 2 - 50;
            this._listtip.setsize(this._width - 70, param2 - 100);
            this._zoommap.resize(this._width, param2);
            return;
        }// end function

        public function alertToLayer4()
        {
            this._alertUI.container = this._layer4;
            return;
        }// end function

        public function init()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            this._layer2 = new Sprite();
            addChild(this._layer2);
            this._layer2.mouseEnabled = false;
            this._layer1 = new Sprite();
            addChild(this._layer1);
            this._layer3 = new Sprite();
            addChild(this._layer3);
            this._layer4 = new Sprite();
            addChild(this._layer4);
            this._layer5 = new Sprite();
            addChild(this._layer5);
            this._layer5.mouseEnabled = false;
            this._layer5.mouseChildren = false;
            this._layer6 = new Sprite();
            addChild(this._layer6);
            this._layer6.mouseEnabled = false;
            this._layer6.mouseChildren = false;
            trace("ui start", getTimer());
            this._playerHead = new HeadUI();
            this._playerHead.x = 0;
            this._playerHead.y = 0;
            this._layer2.addChild(this._playerHead);
            this._targetHead = new TargetUI();
            this._targetHead.x = 400;
            this._targetHead.y = 0;
            this._targetHead.visible = false;
            this._layer2.addChild(this._targetHead);
            this._zoommap = new ZoomMap(this._layer3);
            this._alertUI = AlertUI._ui;
            this._guideUI = new GuideUI(Config.stage);
            var _loc_3:* = new NumericUI(this._layer3);
            this._numericUI = new NumericUI(this._layer3);
            this._windowStack.push(_loc_3);
            var _loc_3:* = new CardUI(this._layer1);
            this._cardUI = new CardUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._cardUI.x = 140;
            this._cardUI.y = 90;
            var _loc_3:* = new CharUI(this._layer1);
            this._charUI = new CharUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._charUI.x = Config.map._mapWidth - 800;
            this._charUI.y = 65;
            var _loc_3:* = new FollowCharUI(this._layer1);
            this._followcharui = new FollowCharUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._followcharui.x = Config.map._mapWidth - 800;
            this._followcharui.y = 65;
            var _loc_3:* = new ShopMall(this._layer1);
            this._shopmail = new ShopMall(this._layer1);
            this._windowStack.push(_loc_3);
            this._shopmail.x = 130;
            this._shopmail.y = 50;
            var _loc_3:* = new petPanel(this._layer1);
            this._petPanel = new petPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._petPanel.x = 130;
            this._petPanel.y = 80;
            var _loc_3:* = new MBBPanel(this._layer1);
            this._mbbPanel = new MBBPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._mbbPanel.x = 130;
            this._mbbPanel.y = 80;
            var _loc_3:* = new BagPanel(this._layer1);
            this._bagUI = new BagPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._bagUI.x = Config.map._mapWidth - 450;
            this._bagUI.y = 80;
            var _loc_3:* = new AnswerUI(this._layer1);
            this._answerUI = new AnswerUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._answerUI.x = 120;
            this._answerUI.y = 80;
            var _loc_3:* = new CclUI(this._layer1);
            this._cclUI = new CclUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._cclUI.x = 120;
            this._cclUI.y = 80;
            var _loc_3:* = new MoraUI(this._layer1);
            this._moraUI = new MoraUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._moraUI.x = 120;
            this._moraUI.y = 80;
            var _loc_3:* = new BagWare(this._layer1);
            this._bagware = new BagWare(this._layer1);
            this._windowStack.push(_loc_3);
            this._bagware.x = 100;
            this._bagware.y = 80;
            var _loc_3:* = new StallUI(this._layer1);
            this._stallUI = new StallUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._stallUI.x = 140;
            this._stallUI.y = 80;
            var _loc_3:* = new BoothUI(this._layer1);
            this._boothUI = new BoothUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._boothUI.x = 140;
            this._boothUI.y = 80;
            var _loc_3:* = new SkillUI(this._layer1);
            this._skillUI = new SkillUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._skillUI.x = 200;
            this._skillUI.y = 65;
            var _loc_3:* = new ShopPanel(this._layer1);
            this._shopUI = new ShopPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._shopUI.x = 80;
            this._shopUI.y = 80;
            var _loc_3:* = new EasyShop(this._layer1);
            this._easyShop = new EasyShop(this._layer1);
            this._windowStack.push(_loc_3);
            this._easyShop.x = 130;
            this._easyShop.y = 80;
            var _loc_3:* = new Suitfit(this._layer1);
            this._suitFit = new Suitfit(this._layer1);
            this._windowStack.push(_loc_3);
            this._suitFit.x = 130;
            this._suitFit.y = 80;
            var _loc_3:* = new AutoDrug(this._layer1);
            this._autoDrug = new AutoDrug(this._layer1);
            this._windowStack.push(_loc_3);
            this._autoDrug.x = 130;
            this._autoDrug.y = 80;
            var _loc_3:* = new EnergyPanel(this._layer1);
            this._energyPanel = new EnergyPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._energyPanel.x = 130;
            this._energyPanel.y = 80;
            var _loc_3:* = new ToAirPanel(this._layer1);
            this._toAirPanel = new ToAirPanel(this._layer1);
            this._windowStack.push(_loc_3);
            var _loc_3:* = new ToAir2Prize(this._layer1);
            this._toAir2prize = new ToAir2Prize(this._layer1);
            this._windowStack.push(_loc_3);
            this._toAirPanel.x = 130;
            this._toAirPanel.x = 50;
            var _loc_3:* = new SellCultivation(this._layer1);
            this._sellCultivation = new SellCultivation(this._layer1);
            this._windowStack.push(_loc_3);
            var _loc_3:* = new GodMade(this._layer1);
            this._godmade = new GodMade(this._layer1);
            this._windowStack.push(_loc_3);
            this._godmade.x = Config.map._mapWidth - 800;
            this._godmade.y = 65;
            var _loc_3:* = new SeniorCopy(this._layer1);
            this._seniorcopy = new SeniorCopy(this._layer1);
            this._windowStack.push(_loc_3);
            this._seniorcopy.x = Config.map._mapWidth - 800;
            this._seniorcopy.y = 65;
            var _loc_3:* = new InterBigWar(this._layer1);
            this._interBigwar = new InterBigWar(this._layer1);
            this._windowStack.push(_loc_3);
            var _loc_3:* = new LandGravePanel(this._layer1);
            this._landGravePanel = new LandGravePanel(this._layer1);
            this._windowStack.push(_loc_3);
            var _loc_3:* = new InterPkPanel(this._layer1);
            this._interPkPanel = new InterPkPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._interPkPanel.x = 220;
            this._interPkPanel.y = 40;
            var _loc_3:* = new DealUI(this._layer1);
            this._dealUI = new DealUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._dealUI.x = 40;
            this._dealUI.y = 40;
            var _loc_3:* = new EquipMentPanel(this._layer1);
            this._equippanel = new EquipMentPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._equippanel.x = 130;
            this._equippanel.y = 50;
            var _loc_3:* = new OnlineExpression(this._layer1);
            this._onlineExpn = new OnlineExpression(this._layer1);
            this._windowStack.push(_loc_3);
            this._onlineExpn.x = 300;
            this._onlineExpn.y = 260;
            var _loc_3:* = new WishPool();
            this._wishPool = new WishPool();
            this._windowStack.push(_loc_3);
            var _loc_3:* = new NationalDayPanel(this._layer1);
            this._nationalDayPanel = new NationalDayPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._nationalDayPanel.x = 200;
            this._nationalDayPanel.y = 70;
            var _loc_3:* = new WolfActive(this._layer1);
            this._wolfactive = new WolfActive(this._layer1);
            this._windowStack.push(_loc_3);
            this._farmpanel = new FarmPanel();
            this._elitehall = new EliteHall();
            var _loc_3:* = new GildWarAuction(this._layer1);
            this._gildwarauction = new GildWarAuction(this._layer1);
            this._windowStack.push(_loc_3);
            var _loc_3:* = new ProducePanel(this._layer1);
            this._producepanel = new ProducePanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._producepanel.x = 130;
            this._producepanel.y = 50;
            var _loc_3:* = new GildWarStraction(this._layer1);
            this._gildWarStraction = new GildWarStraction(this._layer1);
            this._windowStack.push(_loc_3);
            var _loc_3:* = new FriendUI(this._layer1);
            this._friendUI = new FriendUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._friendUI.x = 550;
            this._friendUI.y = 50;
            var _loc_3:* = new ShopBuy(this._layer1);
            this._shopbuy = new ShopBuy(this._layer1);
            this._windowStack.push(_loc_3);
            this._shopbuy.x = 230;
            this._shopbuy.y = 50;
            var _loc_3:* = new BlackMarket(this._layer1);
            this._blackmarket = new BlackMarket(this._layer1);
            this._windowStack.push(_loc_3);
            this._blackmarket.x = 230;
            this._blackmarket.y = 50;
            var _loc_3:* = new FbDetailUI(this._layer1);
            this._fbDetailUI = new FbDetailUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._fbDetailUI.x = 130;
            this._fbDetailUI.y = 50;
            var _loc_3:* = new DialoguePanel(this._layer1);
            this._dialogue = new DialoguePanel(this._layer1);
            this._windowStack.push(_loc_3);
            var _loc_3:* = new TeamPanel(this._layer1);
            this._teamUI = new TeamPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._teamUI.x = 230;
            this._teamUI.y = 50;
            var _loc_3:* = new FbEntranceUI(this._layer1);
            this._fbEntranceUI = new FbEntranceUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._fbEntranceUI.x = 200;
            this._fbEntranceUI.y = 100;
            this._gildwar = new GildWar(this._layer1);
            var _loc_3:* = new MailPanel(this._layer1);
            this._mailpanel = new MailPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._mailpanel.x = 130;
            this._mailpanel.y = 50;
            var _loc_3:* = new GiftDarePanel(this._layer1);
            this._giftDare = new GiftDarePanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._giftDare.x = 130;
            this._giftDare.y = 50;
            var _loc_3:* = new DayGiftPanel(this._layer1);
            this._dayGiftPanel = new DayGiftPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._dayGiftPanel.x = 130;
            this._dayGiftPanel.y = 50;
            var _loc_3:* = new MesHistoryPanel(this._layer1);
            this._mesHistoryPanel = new MesHistoryPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._mesHistoryPanel.x = 200;
            this._mesHistoryPanel.y = 50;
            var _loc_3:* = new RecomPanel(this._layer1);
            this._recomPanel = new RecomPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._recomPanel.x = 130;
            this._recomPanel.y = 50;
            var _loc_3:* = new activePanel(this._layer1);
            this._activePanel = new activePanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._activePanel.x = 130;
            this._activePanel.y = 50;
            var _loc_3:* = new TaskPanel(this._layer1);
            this._taskpanel = new TaskPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._taskpanel.x = 130;
            this._taskpanel.y = 50;
            this._taskpanel.addEventListener("change", this.handleTaskChange);
            var _loc_3:* = new BigWar(this._layer1);
            this._bigWar = new BigWar(this._layer1);
            this._windowStack.push(_loc_3);
            this._bigWar.x = 220;
            this._bigWar.y = 200;
            var _loc_3:* = new BigwarScorePanel(this._layer1);
            this._bwscorepanel = new BigwarScorePanel(this._layer1);
            this._windowStack.push(_loc_3);
            var _loc_3:* = new PKrace(this._layer3);
            this._pkrace = new PKrace(this._layer3);
            this._windowStack.push(_loc_3);
            this._pkrace.x = 220;
            this._pkrace.y = 200;
            var _loc_3:* = new PKraceinfoPanel(this._layer1);
            this._pkraceinfo = new PKraceinfoPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._pkraceinfo.x = 220;
            this._pkraceinfo.y = 200;
            var _loc_3:* = new YabiaoTime(this._layer1);
            this._yabiao = new YabiaoTime(this._layer1);
            this._windowStack.push(_loc_3);
            var _loc_3:* = new BillboardPanel(this._layer1);
            this._billboardpanel = new BillboardPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._billboardpanel.x = 150;
            this._billboardpanel.y = 50;
            var _loc_3:* = new ActivPrize(this._layer1);
            this._activeprize = new ActivPrize(this._layer1);
            this._windowStack.push(_loc_3);
            this._activeprize.x = 280;
            this._activeprize.y = 80;
            var _loc_3:* = new GildPanel(this._layer1);
            this._gangs = new GildPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._gangs.x = 130;
            this._gangs.y = 20;
            var _loc_3:* = new GameSystem(this._layer3);
            this._gamesystem = new GameSystem(this._layer3);
            this._windowStack.push(_loc_3);
            this._gamesystem.x = 130;
            this._gamesystem.y = 50;
            var _loc_3:* = new MonsterIndexUI(this._layer1);
            this._monsterIndexUI = new MonsterIndexUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._monsterIndexUI.x = 130;
            this._monsterIndexUI.y = 50;
            var _loc_3:* = new EquipMadePanel(this._layer1);
            this._equiomadepanel = new EquipMadePanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._equiomadepanel.x = 130;
            this._equiomadepanel.y = 50;
            this._expball = new ExpBall();
            var _loc_3:* = new JewelCompound(this._layer3);
            this._jewelCompound = new JewelCompound(this._layer3);
            this._windowStack.push(_loc_3);
            this._jewelCompound.x = 230;
            this._jewelCompound.y = 50;
            this._systemUI = new SystemUI();
            this._systemUI.x = 0;
            this._systemUI.y = Config.map._mapHeight;
            this._layer2.addChild(this._systemUI);
            this._quickUI = new QuickUI();
            this._quickUI.x = 0;
            this._quickUI.y = Config.map._mapHeight;
            this._layer2.addChild(this._quickUI);
            this._pkmode = new CombatMode();
            this._pkmode.x = 260;
            this._pkmode.y = 10;
            this._layer2.addChild(this._pkmode);
            this._radar = new Radar(Config.map);
            this._layer2.addChild(this._radar);
            this._radar.x = this._width;
            this._holder = new Holder();
            this._layer5.addChild(this._holder);
            var _loc_3:* = new ChatUI();
            this._chatUI = new ChatUI();
            this._windowStack.push(_loc_3);
            this._layer2.addChild(this._chatUI);
            this._noticeUI = new NoticeUI();
            this._mousepointer = new MousePointer();
            this._layer6.addChild(this._mousepointer);
            this._messagetips = new MessageTips();
            this._layer2.addChildAt(this._messagetips, 0);
            this._listtip = new ListTip();
            this._layer2.addChild(this._listtip);
            this._pkUI = new PkUI();
            this._pkUI.x = -230;
            this._pkUI.y = 60;
            this._pkraceUI = new PkraceUI();
            this._pkraceUI.x = -230;
            this._pkraceUI.y = 60;
            trace("ui end", getTimer());
            mouseEnabled = false;
            var _loc_3:* = new Transport(this._layer1);
            this._transport = new Transport(this._layer1);
            this._windowStack.push(_loc_3);
            this._transport.x = 230;
            this._transport.y = 50;
            var _loc_3:* = new Lookmapanel(this._layer1);
            this._lookmapanel = new Lookmapanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._lookmapanel.x = 180;
            this._lookmapanel.y = 10;
            this._blessings = new Blessings();
            this._blessings.x = -5;
            this._blessings.y = -20;
            this._elementUI = new ElementUI();
            this._elementUI.x = 0;
            this._elementUI.y = 0;
            var _loc_3:* = new QQVipPanel(this._layer1);
            this._qqVipPanel = new QQVipPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._qqVipPanel.x = 180;
            this._qqVipPanel.y = 20;
            var _loc_3:* = new VipPanel(this._layer1);
            this._vipPanel = new VipPanel(this._layer1);
            this._windowStack.push(_loc_3);
            this._vipPanel.x = 260;
            this._vipPanel.y = 50;
            var _loc_3:* = new FollowUpUI(this._layer1);
            this._followupui = new FollowUpUI(this._layer1);
            this._windowStack.push(_loc_3);
            this._followupui.x = 100;
            this._followupui.y = 50;
            var _loc_3:* = new ServerRacebill(this._layer1);
            this._serveracebill = new ServerRacebill(this._layer1);
            this._windowStack.push(_loc_3);
            this._serveracebill.x = 260;
            this._serveracebill.y = 65;
            var _loc_3:* = new ServerInterRacebill(this._layer1);
            this._serverinteracebill = new ServerInterRacebill(this._layer1);
            this._windowStack.push(_loc_3);
            this._serverinteracebill.x = 260;
            this._serverinteracebill.y = 35;
            var _loc_3:* = new ManyPlayerToair(this._layer1);
            this._manyplayertoair = new ManyPlayerToair(this._layer1);
            this._windowStack.push(_loc_3);
            this._manyplayertoair.x = 260;
            this._manyplayertoair.y = 60;
            var _loc_3:* = new FollowFight();
            this._followfight = new FollowFight();
            this._windowStack.push(_loc_3);
            var _loc_3:* = new GiveFlower(this._layer1);
            this._giveflower = new GiveFlower(this._layer1);
            this._windowStack.push(_loc_3);
            this._giveflower.x = 150;
            this._giveflower.y = 60;
            var _loc_3:* = new RandomPetegg(this._layer1);
            this._randompetegg = new RandomPetegg(this._layer1);
            this._windowStack.push(_loc_3);
            this._randompetegg.x = 120;
            this._randompetegg.y = 60;
            return;
        }// end function

        private function drawMenu(param1)
        {
            var _loc_2:* = undefined;
            var _loc_5:* = undefined;
            var _loc_3:* = param1;
            var _loc_4:* = 0;
            _loc_2 = 0;
            while (_loc_2 < (this._menuArray.length - 1))
            {
                
                _loc_5 = Math.floor(this._menuArray[_loc_2].perWidth * _loc_3);
                this._menuArray[_loc_2].pb.x = _loc_4 + 2;
                this._menuArray[_loc_2].pb.width = _loc_5 - 4;
                _loc_4 = _loc_4 + _loc_5;
                _loc_2 = _loc_2 + 1;
            }
            this._menuArray[(this._menuArray.length - 1)].pb.x = _loc_4 + 2;
            this._menuArray[(this._menuArray.length - 1)].pb.width = _loc_3 - _loc_4 - 4;
            return;
        }// end function

        public function handleTaskChange(param1 = null) : void
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            this._taskpanel.buildTaskList();
            this._recomPanel.reShowRecom();
            Config.ui._giftDare.reshowPanel();
            var _loc_2:* = this._taskpanel.tasklist();
            var _loc_3:* = Unit.getNpclist();
            for (_loc_6 in _loc_3)
            {
                
                _loc_3[_loc_6].taskState = 5;
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                for (_loc_5 in _loc_3)
                {
                    
                    if (_loc_2[_loc_4].state == 4)
                    {
                        if (int(_loc_2[_loc_4].startnpc) == int(_loc_3[_loc_5]._data.id) && (_loc_3[_loc_5].taskState == 5 || _loc_3[_loc_5].taskState == 0))
                        {
                            _loc_3[_loc_5].taskState = 4;
                            break;
                        }
                        continue;
                    }
                    if (_loc_2[_loc_4].state == 0)
                    {
                        if (int(_loc_2[_loc_4].endnpc) == int(_loc_3[_loc_5]._data.id))
                        {
                            if (_loc_3[_loc_5].taskState != 1 && _loc_3[_loc_5].taskState != 4)
                            {
                                _loc_3[_loc_5].taskState = 0;
                            }
                            break;
                        }
                        continue;
                    }
                    if (int(_loc_2[_loc_4].endnpc) == int(_loc_3[_loc_5]._data.id))
                    {
                        if (_loc_3[_loc_5].taskState == 4 || _loc_3[_loc_5].taskState == 5)
                        {
                            _loc_3[_loc_5].taskState = _loc_2[_loc_4].state;
                        }
                        else
                        {
                            _loc_3[_loc_5].taskState = Math.max(_loc_3[_loc_5].taskState, _loc_2[_loc_4].state);
                        }
                        break;
                    }
                }
                _loc_4 = _loc_4 + 1;
            }
            Npc.checkAll();
            return;
        }// end function

        private function itemdrop(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_ITEM_DESTROY);
            _loc_2.add16(param1.pos);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function itemdropcancel(param1) : void
        {
            return;
        }// end function

        private function switchOpenUI(param1, param2)
        {
            param2.switchOpen();
            return;
        }// end function

        public function stopRenderer(param1)
        {
            this._rendererEmitterArray.push(param1);
            clearTimeout(this._rendererStopTimer);
            this._rendererStopTimer = setTimeout(this.subStopRenderer, 1000);
            return;
        }// end function

        public function subStopRenderer()
        {
            clearTimeout(this._rendererStopTimer);
            var _loc_1:* = 0;
            while (_loc_1 < this._rendererEmitterArray.length)
            {
                
                this._rendererEmitterArray[_loc_1].stop();
                _loc_1 = _loc_1 + 1;
            }
            this._rendererEmitterArray = [];
            return;
        }// end function

    }
}
