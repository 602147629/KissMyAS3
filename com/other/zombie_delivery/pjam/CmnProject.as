class pjam.CmnProject
{
    var root, pdata, next, status, sound, help, onEnterFrame, edata;
    function CmnProject(root)
    {
        Stage.scaleMode = "noScale";
        Stage.showMenu = false;
        this.root = root;
        pdata = new pjam.PlayerData(root);
        next = new pjam.NextStage(root);
        status = new pjam.head.Status(root, pdata);
        sound = new pjam.head.SoundControl(root);
        help = new pjam.head.Help(root, sound);
        root.statusMC._visible = false;
        root.musicMC._visible = false;
        root.rankMC._visible = false;
        root.loadMC._visible = false;
        root.helpMC._visible = false;
        if (pjam.IllegalUserList.checkIllegal(pdata.getID(), pdata.getName()) == true)
        {
            return;
        } // end if
        if (pdata.checkCode() == false)
        {
            return;
        } // end if
        var sc = this;
        root.onEnterFrame = function ()
        {
            delete this.onEnterFrame;
            sc.checkFPlayer();
        };
    } // End of the function
    static function main(ref)
    {
    } // End of the function
    function checkFPlayer()
    {
        if (System.capabilities.version.split(" ")[1].split(",")[0] < 8)
        {
            var sc = this;
            root.gotoAndStop("fplayer");
            root.playerBtn.onPress = function ()
            {
                getURL(sc.FP_URL, "_blank");
            };
        }
        else
        {
            this.loadOpen();
        } // end else if
    } // End of the function
    function loadOpen()
    {
        var sc = this;
        var _loc2 = new pjam.LoadCheck(root);
        _loc2.openEnd = function ()
        {
            sc.loadSwf();
        };
        _loc2.open();
    } // End of the function
    function loadSwf()
    {
        var sc = this;
        var _loc2 = new pjam.LoadCheck(root);
        _loc2.loadEnd = function ()
        {
            sc.getCharData();
        };
        _loc2.main();
    } // End of the function
    function getCharData()
    {
        var sc = this;
        var _loc2 = {result: function (ev)
        {
            if (sc.pdata.checkKey() == true)
            {
                sc.getedata();
            }
            else
            {
                sc.charCreate();
            } // end else if
        }};
        root.charXML.addEventListener("result", _loc2);
        root.charXML.trigger();
    } // End of the function
    function charCreate()
    {
        var sc = this;
        var _loc2 = new pjam.scene.CharCreate(root, pdata, mode);
        _loc2.createEnd = function ()
        {
            sc.getedata();
        };
        _loc2.start();
        sound.playSound("songSound");
    } // End of the function
    function getedata()
    {
        var sc = this;
        root.gotoAndStop("menu");
        root.closeBtn._visible = false;
        edata = new pjam.EnemyData(root, pdata);
        edata.getEnd = function ()
        {
            sc.checkFake();
        };
        edata.getNetEnemy();
    } // End of the function
    function checkFake()
    {
        if (pdata.checkFakeFlg() == false)
        {
            this.initMain();
            return;
        } // end if
        var sc = this;
        next.end = function ()
        {
            var _loc1 = new pjam.scene.FakeDisp(sc.root);
            _loc1.end = function ()
            {
                sc.initMain();
            };
            _loc1.main();
        };
        next.start("fakeMC", -1);
    } // End of the function
    function initMain()
    {
        var sc = this;
        root.statusBtn.onPress = function ()
        {
            var _loc1 = pjam.Charactor.getCharData(sc.root, sc.pdata.createRegistData());
            sc.status.start(_loc1, pjam.head.Status.MY_DISP);
        };
        root.musicBtn.onPress = function ()
        {
            sc.sound.dispControl();
        };
        root.helpBtn.onPress = function ()
        {
            sc.help.start();
        };
        root.statusBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "ステータスを表示します。");
        };
        root.musicBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "ゲームの音量を調整できます。");
        };
        root.helpBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "ヘルプを表示します。");
        };
        root.closeBtn._visible = false;
        sound.playSound("mainSound");
        this.mainMenu(-1);
    } // End of the function
    function mainMenu(vec)
    {
        var sc = this;
        next.end = function ()
        {
            var _loc1 = new pjam.scene.MainMenu(sc.root);
            _loc1.selectGame = function ()
            {
                sc.gameMenu(-1);
            };
            _loc1.selectRank = function ()
            {
                sc.dispRank();
            };
            _loc1.selectRegist = function ()
            {
                sc.dataRegist();
            };
            _loc1.selectDelete = function ()
            {
                sc.dataDelete();
            };
            _loc1.start(sc.pdata);
        };
        next.start("mainMenuMC", vec);
    } // End of the function
    function dispRank()
    {
        var sc = this;
        var _loc2 = new pjam.scene.Ranking(root, pdata);
        _loc2.end = function ()
        {
            sc.mainMenu();
        };
        _loc2.start();
    } // End of the function
    function dataRegist()
    {
        var sc = this;
        next.end = function ()
        {
            var _loc1 = new pjam.scene.Regist(sc.root, sc.pdata, sc.edata);
            _loc1.registEnd = function ()
            {
                sc.mainMenu(1);
            };
            _loc1.start();
        };
        next.start("registMC", -1);
    } // End of the function
    function dataDelete()
    {
        var sc = this;
        next.end = function ()
        {
            var _loc1 = new pjam.scene.Delete(sc.root, sc.pdata);
            _loc1.deleteEnd = function ()
            {
                sc.mainMenu(1);
            };
            _loc1.start();
        };
        next.start("deleteMC", -1);
    } // End of the function
    function gameMenu(vec)
    {
        var sc = this;
        next.end = function ()
        {
            var _loc1 = new pjam.scene.GameMenu(sc.root, sc.pdata);
            _loc1.selectFight = function ()
            {
                sc.encount(-1);
            };
            _loc1.selectStatus = sc.root.statusBtn.onPress;
            _loc1.selectItem = function ()
            {
                sc.itemUse();
            };
            _loc1.selectShop = function ()
            {
                sc.shop();
            };
            _loc1.selectHelp = sc.root.helpBtn.onPress;
            _loc1.selectEnd = function ()
            {
                sc.mainMenu(1);
            };
            _loc1.start();
        };
        next.start("gameMenuMC", vec);
    } // End of the function
    function itemUse()
    {
        var sc = this;
        next.end = function ()
        {
            var _loc1 = new pjam.scene.ItemUse(sc.root, sc.pdata);
            _loc1.end = function (n)
            {
                sc.gameMenu(1);
            };
            _loc1.start();
        };
        next.start("itemMC", -1);
    } // End of the function
    function shop()
    {
        var sc = this;
        next.end = function ()
        {
            var _loc1 = new pjam.scene.Shop(sc.root, sc.pdata);
            _loc1.end = function (n)
            {
                sc.gameMenu(1);
            };
            _loc1.start();
        };
        next.start("shopMC", -1);
    } // End of the function
    function encount(vec)
    {
        var sc = this;
        next.end = function ()
        {
            var _loc1 = new pjam.scene.Encount(sc.root, sc.edata, sc.pdata);
            _loc1.selectFight = function (n)
            {
                sc.fight(n);
            };
            _loc1.selectMenu = function ()
            {
                sc.gameMenu(1);
            };
            _loc1.start();
        };
        next.start("encountMC", vec);
    } // End of the function
    function fight(fdata)
    {
        var sc = this;
        next.end = function ()
        {
            var _loc2 = new pjam.fight.Fight(sc.root, sc.pdata, fdata, sc.mode, this);
            _loc2.end = function ()
            {
                sc.encount(1);
            };
            _loc2.start();
        };
        next.start("fightMC", -1);
    } // End of the function
    function testExe()
    {
        root.gotoAndStop("test");
        root.testMC._visible = true;
        root.statusMC._visible = false;
        var _loc2 = new pjam.fight.Fight(root, root.fightMC);
        _loc2.start();
    } // End of the function
    static var DOMAIN = "http://www.dango-itimi.com/jam/cgi/";
    static var CGI_URL = pjam.CmnProject.DOMAIN + "rank.cgi";
    static var RANK_NUM = 500;
    var FP_URL = "http://www.macromedia.com/shockwave/download/download.cgi?P5_Language=Japanese&Lang=Japanese&P1_Prod_Version=ShockwaveFlash&Lang=Japanese";
    static var LOADEND_TIME = 1000;
    static var NORMAL_MODE = 0;
    static var TEST_MODE = 1;
    var mode = 0;
} // End of Class
