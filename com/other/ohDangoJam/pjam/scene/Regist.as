class pjam.scene.Regist
{
    var root, pdata, edata, scene;
    function Regist(root, pdata, edata)
    {
        this.root = root;
        this.pdata = pdata;
        this.edata = edata;
        scene = root.stageMC.registMC;
    } // End of the function
    function start()
    {
        var _loc2 = pdata.checkRegistTime();
        if (_loc2 == 0)
        {
            this.dataRegist();
        }
        else
        {
            this.nonRegist(_loc2);
        } // end else if
    } // End of the function
    function nonRegist(rest)
    {
        var sc = this;
        scene.nextFrame();
        scene.timeTxt.text = Math.floor(rest / 1000) + "秒後に";
        scene.backBtn.onPress = function ()
        {
            sc.registEnd();
        };
    } // End of the function
    function dataRegist()
    {
        root.loadMC._visible = true;
        root.loadMC.gotoAndStop(1);
        root.loadMC.maruMC.gotoAndPlay(1);
        var _loc8 = root.charSet.currentItem;
        var id = pdata.getID();
        var _loc3 = null;
        if (id == -1)
        {
            _loc3 = {mode: 1, rank: pjam.CmnProject.RANK_NUM, data: pdata.firstRegistData()};
        }
        else
        {
            _loc3 = {mode: 2, rank: pjam.CmnProject.RANK_NUM, data: pdata.createRegistData()};
        } // end else if
        var sc = this;
        var _loc6 = 0;
        var _loc2 = new net.LinkCGI();
        _loc2.suc = function (data)
        {
            if (id == -1)
            {
                sc.pdata.setID(data.id);
            } // end if
            sc.pdata.setRegistTime();
            sc.getNetEnemy();
        };
        _loc2.mis = function ()
        {
            sc.root.loadMC.gotoAndStop("err");
        };
        _loc2.sendAndLoad(pjam.CmnProject.CGI_URL, "POST", _loc3);
    } // End of the function
    function getNetEnemy()
    {
        var sc = this;
        edata.getEnd = function ()
        {
            sc.root.loadMC._visible = true;
            sc.root.loadMC.gotoAndStop("msg");
            sc.root.loadMC.msgTxt.text = "データ登録完了！";
            sc.root.loadMC.okBtn.onPress = function ()
            {
                sc.root.loadMC._visible = false;
                sc.registEnd();
            };
        };
        edata.getNetEnemy();
    } // End of the function
} // End of Class
