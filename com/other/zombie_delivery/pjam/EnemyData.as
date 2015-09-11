class pjam.EnemyData
{
    var root, pdata, enemyList;
    function EnemyData(root, pdata)
    {
        this.root = root;
        this.pdata = pdata;
        enemyList = new Object();
    } // End of the function
    function getNetEnemy()
    {
        root.loadMC._visible = true;
        root.loadMC.gotoAndStop(1);
        root.loadMC.maruMC.gotoAndPlay(1);
        var sc = this;
        var num = 0;
        var func = function ()
        {
            sc.pdata.setRegistTime();
            sc.root.loadMC._visible = false;
            clearInterval(num);
            sc.getEnd();
        };
        var _loc4 = {mode: 5, rank: "", data: ""};
        var _loc2 = new net.LinkCGI();
        _loc2.suc = function (data)
        {
            sc.root.loadMC.gotoAndStop("end");
            sc.enemyList = data;
            sc.enemyList.min = Number(data.min);
            sc.enemyList.max = Number(data.max);
            num = setInterval(func, pjam.CmnProject.LOADEND_TIME);
        };
        _loc2.mis = function ()
        {
            sc.root.loadMC.gotoAndStop("end");
            sc.enemyList.max = 0;
            num = setInterval(func, pjam.CmnProject.LOADEND_TIME);
        };
        _loc2.sendAndLoad(pjam.CmnProject.CGI_URL, "POST", _loc4);
    } // End of the function
    function encountPlayer(lv)
    {
        if (enemyList.max <= 0)
        {
            return (null);
        } // end if
        var _loc3 = Math.floor(Math.random() * enemyList.max) + enemyList.min;
        var _loc2 = pjam.Charactor.getCharData(root, enemyList["data" + _loc3]);
        if (_loc2.name == undefined)
        {
            _loc2 = this.encountPlayer();
        } // end if
        if (_loc2.lv > pjam.fight.LvUp.getPlayerBestLv(lv))
        {
            return (null);
        } // end if
        if (pjam.IllegalUserList.checkIllegal(_loc2.uid, _loc2.name) == true)
        {
            return (null);
        } // end if
        _loc2.sp = 0;
        return (_loc2);
    } // End of the function
    function destroy()
    {
    } // End of the function
} // End of Class
